#import "../utils/funcs.typ": *

= Software Components

The following is an overview of the software components it was necessary to write to achieve our goals.

#_content(
  [
    == Data Collector Program

    To collect data from the sensors connected to the greenhouse we wrote a python program that retrieves the data and uploads them to InfluxDB.

    The repo can be found at https://github.com/N-essuno/greenhouse-data-collector. What follows is an overview of the program

    == Greenhouse Asset Model <asset-model>

    #lorem(30) // TODO:

    == SMOL Twinning program <smol-twinning-program>

    The `SMOL` program is run periodically by the server and is responsible for creating the digital twin and running the FMI simulators. It achieves this in the following steps:
    + It reads the #link(<asset-model>)[`asset model`] from the `OWL` file
    + It generates `SMOL` objects from the asset model individuals
    + For each asset object it retrieves the sensor data associated with that specific asset from the database
    + After retrieving the data it performs the semantic lifting of the program state, creating a knowledge grappph that represents the state of the assets in the greenhouse
  ]
)