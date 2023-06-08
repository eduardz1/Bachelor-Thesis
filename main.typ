#import "utils/template.typ": *

#let dichiarazione_di_originalità = "Dichiaro di essere responsabile del contenuto dell’elaborato che presento al fine del conseguimento del titolo, di non avere plagiato in tutto o in parte il lavoro prodotto da altri e di aver citato le fonti originali in modo congruente alle normative vigenti in materia di plagio e di diritto d’autore. Sono inoltre consapevole che nel caso la mia dichiarazione risultasse mendace, potrei incorrere nelle sanzioni previste dalla legge e la mia ammissione alla prova finale potrebbe essere negata."

#let aknowlegements = "Special thanks to Chinmayi Bp for always being available to help us figure out the electronics and Gianluca Barmina and Marco Amato with whom I worked together on the project"

#show: project.with(
  title: "Design and Development of the Digital Twin of a Greenhouse",
  abstract: "We will see how digital twins can be used and applied in a range of scenarios, we'll introduce the language 'SMOL', created specifically for this purpose, and talk about the work of me and my collegues in the process of designing and implementing a digital twin of a greenhouse.",
  aknowlegements: aknowlegements,
  declaration-of-originality: dichiarazione_di_originalità,
  affiliation: (
    university: "Università degli Studi di Torino",
    department: "DIPARTIMENTO DI INFORMATICA",
    degree: "Corso di Laurea Triennale in Informatica"
  ),
  authors: (
    (role: "candidate", name: "Eduard Antonovic Occhipinti", id: "947847"),
    (role: "supervisor", name: "Prof. Ferruccio Damiani", id: ""),
    (role: "co-supervisors", name: "Prof. Einar Broch Johnsen\n\nRudolf Schlatte\n\nEduard Kamburjan", id: "")
  ),
  date: "Academic Year 2022/2023",
  logo: "../img/logo.svg",
  bibliography-file: "../works.yml"
)

#show link: underline

#include "chapters/introduction.typ"

#include "chapters/tools-and-technologies.typ"

#include "chapters/digital-twins.typ"

#include "chapters/smol.typ"

#include "chapters/the-project.typ"


= The Greenhouse

The specific greenhouse we're working on has the following characteristics:
- It is divided in two shelves
- Each shelf is composed by two groups of plants
- Each group of plants is watered by a single water pump
- Each group of plants is composed by two plants
- Each plant is associated with a pot

== Assets - Sensors
The following sensors are used to monitor the environmental conditions of the greenhouse and the plants:

/ Greenhouse:
- 1 webcam used to measure the light level, can be replaced with a light sensor that would also provide an accurate lux measurement
/ Shelves:
- 1 `DHT22` sensor used to measure the temperature and humidity
/ Pots:
- 1 capacitive soil moisture sensor used to measure the moisture of the soil
/ Plants:
- 1 `Raspberry Pi Camera Module v2 NoIR` used to take pictures of the plants and measure their growth by calculating the `NDVI`


= The Role of each Raspberry Pi

There are in total 5 Raspberry Pi 4 used in this project. The division in roles and the usage of the same hardware makes it very scalable and easy to replicate. As follows: // FIXME: weird sentence
- 1 Raspberry Pi 4 is used as a server, it hosts the digital twin and the FMI simulators, the server is also used to host the database in which all the data is stored and accessed.
- 3 Raspberry Pi 4 are used as clients, they are connected to the sensors and the actuators and are responsible for sending the data to the server.
- 1 Raspberry Pi 4 is used as a router and serves to connect clients and server wirelessly.

/ The Server: The host runs an `InfluxDB` instance that holds the data retried from the clients (_data collectors_) and a `Java` program that periodically runs the #link(<smol-twinning-program>)[`SMOL Twinning program`] which is responsible for creating the digital twin and running the FMI simulators.

/ The Clients: We also refer to them as _data collectors_

/ The Router: The Raspberry was configured with `hostapd` and `dnsmasq` to act as a router and provide a wireless network for the clients to connect to. The local network is used to access the client via `SSH` and to send data to the server via `HTTP` requests.

= The Digital Twin

// TODO: add stuff about modelica and semantic objects and stuff

= Greenhouse Asset Model <asset-model>

#lorem(30)

= SMOL Twinning program <smol-twinning-program>

The `SMOL` program is run periodically by the server and is responsible for creating the digital twin and running the FMI simulators. It achieves this in the following steps:
+ It reads the #link(<asset-model>)[`asset model`] from the `OWL` file
+ It generates `SMOL` objects from the asset model individuals
+ For each asset object it retrieves the sensor data associated with that specific asset from the database
+ After retrieving the data it performs the #link(<semantic-lifting>)[semantic lifting] of the program state, creating a knowledge grappph that represents the state of the assets in the greenhouse

= Semantic Lifting <semantic-lifting>
