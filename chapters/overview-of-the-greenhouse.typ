#import "../utils/common.typ": *

= Overview of the Greenhouse

The specific greenhouse we're working on has the following characteristics:
- It is divided into two shelves
- Each shelf is composed of two groups of plants
- Each group of plants is watered by a single water pump
- Each group of plants is composed of two plants
- Each plant is associated with a pot

#_content(
  [
    == Assets
    === Sensors
    The following sensors, each associated with a specific asset, are used to monitor the environmental conditions of the greenhouse and the plants:
    
    #set par(justify: true, first-line-indent: 0em) // FIXME: workaround for https://github.com/typst/typst/issues/1050
    / Greenhouse: one webcam used to measure the light level, can be replaced with a light sensor that would also provide an accurate lux measurement.

    / Shelves: one `DHT22` sensor is used to measure the temperature and humidity.

    / Pots: each pot has one capacitive soil moisture sensor used to measure the moisture of the soil.

    / Plants: a `Raspberry Pi Camera Module v2 NoIR` is used to take pictures of the plants and measure their growth by calculating the `NDVI` (see @ndvi).
    #set par(justify: true, first-line-indent: 1em)

    === Actuators

    There is one pump for watering but a second bucket is also present as it enables us to add a second pump for liquid fertilizers.

    #figure(
      image("../img/greenhouse.jpeg"),
      caption: [
        the bottom shelf of our greenhouse, not in the picture the router, host, and lights
      ]
    )
  ]
)
