#import "../utils/common.typ": *

= Raspberry Pi's Responsibilities and Physical Setup <raspberry-responsabilities-and-physical-setup>

In our greenhouse, we use a total of 4 Raspberry Pi 4 but in theory, only one is
strictly necessary. The responsibility that each PC has is as follows:

- a #link(<controller-setup>)[_Controller_]
- an #link(<actuator-setup>)[_Actuator_]
- a #link(<router-setup>)[Router]
- a #link(<host-setup>)[Host]

We will refer to the _Controller_ also as _Data Collector_ because its
responsibility is to collect data using sensors attached to the board and send
the measurements to the time series database.

In case one wants to replicate our setup, any computer can be used as the host
machine, these paragraphs will assume the host runs a Debian-based Linux
distribution but any major OS should work with minimal changes.

The _Controller_ and _Actuator_ can be run on the same Raspberry with minimal
changes.

A more in-depth guide to exactly replicate our setup was published at
https://github.com/N-essuno/greenhouse_twin_project/tree/main/physical-setup.

To make it easier to configure the Raspberry Pis we wrote some bash scripts that
make it easy to install the necessary dependencies with one click. For example
to configure the host (see @host-setup) we can just run the following script
that is written to be architecture-independent, given that the host computer
does not need to interface with any sensor directly:

```bash
#!/bin/bash

git clone https://www.github.com/N-essuno/smol_scheduler

influxdbversion="2.7.3"
arch=$(dpkg --print-architecture)

# Checks the architecture and continues the setup only if arch is
# either arm64 or amd64
case "$arch" in
amd64)
  wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-$influxdbversion-linux-amd64.tar.gz
  tar xvzf influxdb2-client-$influxdbversion-linux-amd64.tar.gz
  sudo cp influxdb2-client-$influxdbversion-linux-amd64/influx /usr/local/bin
  ;;
arm64)
  wget https://dl.influxdata.com/influxdb/releases/influxdb2-client-$influxdbversion-linux-arm64.tar.gz
  tar xvzf influxdb2-client-$influxdbversion-linux-arm64.tar.gz
  sudo cp influxdb2-client-$influxdbversion-linux-arm64/influx /usr/local/bin
  ;;
*)
  echo "Unsupported architecture: $arch"
  exit 1
  ;;
esac

# Sets up influxdb with the standard config tool
influx setup

exit 0
```

// TODO: check if the info commented is still relevant
// / The Server: The host runs an `InfluxDB` instance that holds the data retried from the clients (_data collectors_) and a `Java` program that periodically runs the #link(<smol-twinning-program>)[`SMOL Twinning program`] which is responsible for creating the digital twin and running the FMI simulators.

// / The Router: The Raspberry was configured with `hostapd` and `dnsmasq` to act as a router and provide a wireless network for the clients to connect to. The local network is used to access the client via `SSH` and to send data to the server via `HTTP` requests.

#_content(
  [
  == OS Choice
  
  We used the, at the time, latest distribution of `Raspberry Pi OS 64bit`. Any
  compatible operating system will work in practice, but it's necessary to use a
  64-bit distribution at least for the host computer. It is also recommended to
  have a desktop environment on the host computer for simpler data analysis.
  
  We used, and recommend using the #link("https://www.raspberrypi.com/software")[Raspberry Pi Imager] to
  mount the OS image on the microSD card.
  
  == Host Setup <host-setup>
  
  The only thing that is necessary to install and configure on the host computer
  is an instance of InfluxDB, after that, it's sufficient to clone the repository
  containing the #link("https://www.github.com/N-essuno/smol-scheduler")[SMOL scheduler].
  
  == Router Setup <router-setup>
  
  We used a separate Raspberry Pi 4 as a router but that's not strictly necessary,
  one could simply use an off-the-shelf router for this purpose or give the host
  the responsibility of being the wireless access point. The local network is used
  to enable communication through SSH and send data to the server through HTTP
  requests. For our purpose we used the `hostapd` and `dnsmasq` softwares but it can also be 
  done via GUI on Raspberry Pi OS very easily, nonetheless, in the guide aforementioned,
  we provide a step-by-step tutorial.
  
  == Controller Setup <controller-setup>
  
  The data points from the sensors that the controller needs to manage are the
  following:
  
  - #link(<dht22>)[Temperature]
  - #link(<dht22>)[Humidity]
  - #link(<moisture>)[Moisture]
  - #link(<light-level>)[Light Level]
  - #link(<ndvi>)[NDVI]
  
  For the temperature and moisture, we used a `DHT22` sensor, which is very common
  and that is reflected in very good software support.
  
  === DHT22 <dht22>
  
  The following schematics mirror what we did the connect the sensor to the board
  
  #image("../img/dht22-schematics.jpeg")
  
  We used the #link(
    "https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/raspi-blinka.py",
  )[circuitpython] libraries, which provide a more modern implementation compared
  to the standard adafruit libraries.
  
  The following is a minimal script that illustrates how we read the data from the
  sensor.
  
  ```python
      import time
      import board
      import adafruit_dht
  
      # Initialize the dht device, pass the GPIO pin 
      # it's connected to as an argument
      dhtDevice = adafruit_dht.DHT22(board.D4)
  
      try:
        temperature_c = dhtDevice.temperature
        humidity = dhtDevice.humidity
  
        # Print the values to the console
        print(
          "Temp: {:.1f} C    Humidity: {}% ".format(
            temperature_c, humidity
          )
        )
  
      except RuntimeError as error:
        # Errors happen fairly often
        # DHT's are hard to read
        print(error.args[0])
      except Exception as error:
        dhtDevice.exit()
        raise error
  
      dhtDevice.exit()
      ```
  
  === Moisture <moisture>
  
  We used a generic capacitive soil moisture sensor, to convert the analog signal
  we need to use an analog-to-digital converter. For our purpose, we used the
  `MCP3008` ADC which features eight channels, thus making it possible to extend
  our setup with a decent number of other sensors (for example a PH-meter or a
  LUX-meter). The following schematics illustrate how we connected the ADC to the
  board and the moisture sensor to the ADC.
  
  #image("../img/mcp3008-moisture-schematics.jpeg")
  
  We used `SpiDev` as the library of choice to communicate with the ADC, the
  following class aids in the readout of the connected sensor:
  
  // TODO: understand all the bitwise fuckery
  
  ```python
  from spidev import SpiDev
  
  
  class MCP3008:
    """
    Uses the SPI protocol to communicate
    with the Raspberry Pi.
    """
  
    def __init__(self, bus=0, device=0) -> None:
      self.bus, self.device = bus, device
      self.spi = SpiDev()
      self.open()
  
      # The default value of 125MHz is not 
      # sustainable on a Raspberry Pi
      self.spi.max_speed_hz = 1000000  # 1MHz
  
    def open(self):
      self.spi.open(self.bus, self.device)
      self.spi.max_speed_hz = 1000000  # 1MHz
  
    def read(self, channel=0) -> float:
      adc = self.spi.xfer2([
        1, # speed in hertz
        (8 + channel) << 4, # delay in μs
        0 # bits per word
      ])
  
      data = ((adc[1] & 3) << 8) + adc[2]
      return data / 1023.0 * 3.3
  
    def close(self):
      self.spi.close()
  
      ```
  
  A minimal example of how one would go about reading from an ADC is the
  following:
  
  ```python
      from MCP3008 import MCP3008
  
      adc = MCP3008()
      value = adc.read(channel = 0)
      print("Applied voltage: %.2f" % value)
      ```
  
  === Light Level <light-level>
  
  The unavailability of a LUX meter meant we had to get creative and use a webcam
  to approximate the light level readings. This means that the data is only
  meaningful when compared to the first measurement. We used the `OpenCV` library
  to interface with the USB webcam due to it being better supported compared to
  `picamera2`, another popular library used for similar contexts.
  
  A minimal example of the scripts we used is the following:
  
  ```python
  import cv2
  
  from time import sleep
  
  cap = cv2.VideoCapture(0)
  
  sleep(2) #lets the webcam adjust its exposure
  
  # Turn off automatic exposure compensation, 
  # this means that the measurements are only
  # significant when compared to the first one, 
  # to get proper lux reading one should use a
  # proper light sensor
  cap.set(cv2.CAP_PROP_AUTO_EXPOSURE, 0)
  
  while True:
    ret, frame = cap.read()
    grey = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
    avg_light_level = cv2.mean(grey)[0]
    print(avg_light_level)

    if cv2.waitKey(1) & 0xFF == ord('q'):
      break

    sleep(1)
  
  cap.release()
  cv2.destroyAllWindows()
      ```
  
  === NDVI <ndvi>
  
  #_block(
    title: "What is NDVI?",
    text: [
      The Landsat Normalized Difference Vegetation Index (NDVI) is used to quantify
      vegetation greenness and is useful in understanding vegetation density and
      assessing changes in plant health. NDVI is calculated as a ratio between the red
      (R) and near-infrared (NIR) values in traditional fashion: @ndvidef
      
      $ ("NIR" - "R") / ("NIR" + "R") $
    ],
  )
  
  To better understand how healthy our plants were we decided to use an infrared
  camera to quantify the NDVI. In our small-scale application, the data were not
  too helpful because of the color noise surrounding the plants but it will work
  very well if used on a camera mounted on top of the plants and focussed in an
  area large enough that the image is filled with only vegetation.
  
  Connecting the camera is very straightforward given that we used the 
  `Raspberry Pi NoIR` module.
  
  The following is an excerpt of the class we use to calculate the index:
  
  ```python
  import cv2
  import numpy as np
  from picamera2 import Picamera2
  
  
  class NDVI:
    def __init__(
      self, format: str = "RGB888"
    ) -> None:
    """Initializes the camera, a config can be 
        passed as a dictionary

    Args:
      config (str, optional): refer to 
      https://datasheets.raspberrypi.com/camera/picamera2-manual.pdf
      for all possible values, the default is 
      RGB888 which is mapped to an array of 
      pixels [B,G,R]"

      transform (libcamera.Transform, optional): 
      useful to flip the camera if needed.
      Defaults to Transform(vflip=True).
    """
  
      self.camera = Picamera2()
      self.camera.still_configuration.main.format = (format)
      self.camera.configure("still")
      self.camera.start()
  
    def contrast_stretch(self, image):
      """Increases contrast of the image to facilitate 
         NDVI calculation
      """
  
      # Find top 5% and bottom 5% of pixel values
      in_min = np.percentile(image, 5)
      in_max = np.percentile(image, 95)
  
      # Defines min and max brightness values
      out_min = 0
      out_max = 255
  
      out = image - in_min
      out *= (out_min - out_max) / (
        in_min - in_max
      )
      out += in_min
  
      return out
  
    def calculate_ndvi(self, image):
      b, g, r = cv2.split(image)
      bottom = r.astype(float) + b.astype(float)
      bottom[
        bottom == 0
      ] = 0.01  # Make not to divide by zero!
      ndvi = (r.astype(float) - b) / bottom
  
      return ndvi
  
    def read(self):
      return np.mean(
        self.calculate_ndvi(
          self.contrast_stretch(
            self.camera.capture_array()
          )
        )
      )
  
    def stop(self):
      self.camera.stop()
      self.camera.close()
      ```
  
  == Actuator Setup <actuator-setup>
  
  In general, to connect actuators (like pumps, light switches, or fans) we can
  rely on a relay. To connect the relay we can refer to the following schematics:
  
  #image("../img/relay-pump-schematics.jpeg")
  #v(600pt) /* FIXME: remove once issue #466 is implemented */
  
  The relay enables us to control modules with a voltage higher than the 5V tolerated by the Raspberry Pi.
  In our project, we just connected one pump but it's trivial to extend the
  configuration to multiple pumps (for example we plan to add one dedicated to pumping
  fertilized water) or other devices, especially with the kind of relay that we used. 
  An example of the code used to interact with the pump is the following:
  
  
  ```python
  import RPi.GPIO as GPIO
  from time import sleep
  
  
  def pump_water(sec, pump_pin):
    print(
      "Pumping water for {} seconds..."
      .format(sec)
    )
  
    # set GPIO mode and set up the pump pin
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(pump_pin, GPIO.OUT)
  
    try:
      # turn the pump off for 0.25 seconds
      GPIO.output(pump_pin, GPIO.LOW)
      sleep(0.25)
  
      # turn the pump on for the given time
      GPIO.output(pump_pin, GPIO.HIGH)
      sleep(sec)
  
      # turn the pump off
      GPIO.cleanup()
  
      print("Done pumping water.")
  
    except KeyboardInterrupt:
      # stop pump when ctrl-c is pressed
      GPIO.cleanup()
  ```
  ],
)