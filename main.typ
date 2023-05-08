#import "template.typ": *

#let dichiarazione_di_originalità = "\"Dichiaro di essere responsabile del contenuto dell’elaborato che presento al fine del conseguimento del titolo, di non avere plagiato in tutto o in parte il lavoro prodotto da altri e di aver citato le fonti originali in modo congruente alle normative vigenti in materia di plagio e di diritto d’autore. Sono inoltre consapevole che nel caso la mia dichiarazione risultasse mendace, potrei incorrere nelle sanzioni previste dalla legge e la mia ammissione alla prova finale potrebbe essere negata.\""

#let aknowlegements = "Special thanks to prof. Einar Broch Jhonson, Rudolf TODO, Eduard TODO and my collegues from UniTO, Gianluca Barmina and Marco Amato for TODO" + "\n\n" + smallcaps("Declaration of originality:") + "\n" + text(style: "italic", dichiarazione_di_originalità)

#let _block(text) = block(fill: luma(230), inset: 8pt, radius: 4pt, text)

#show: project.with(
  title: "Eduard's Thesis :)",
  abstract: "In this thesis we'll see how digital twins can be used and applied in a range of scenarios, we'll introduce the language 'SMOL', created specifically for this purpose, and talk about the work of me and my collegues",
  aknowlegements: aknowlegements,
  affiliation: (
    university: "Università degli Studi di Torino",
    department: "DIPARTIMENTO DI INFORMATICA",
    degree: "Corso di Laurea Triennale in Informatica"
  ),
  authors: (
    (role: "candidate", name: "Eduard Antonovic Occhipinti", id: "matricola: 947847"),
    (role: "supervisor", name: "Prof. Ferruccio Damiani", id: ""),
  ),
  date: "Anno Accademico 2022/2023",
  logo: "img/logo.svg",
  bibliography-file: "works.yml"
)

#show: rest => columns(2, rest)

= Introduction to Digital Twins

#_block(underline[NASA's definition of digital twin] + "\n" + "\"An integrated multiphysics, multiscale, probabilistic simulation of a veichle or system that uses the best available physical models, sensor updates, fleet history, etc., to mirror the life of its flying twin. It is ultra-realistic, and may consider one or more important and interdependant veichle systems\"")

A digital twin is a live replica of a Pysical System and is connected to it in real time, application. Digital Twins are meant to understand and control assets in nature, industry or society at large, they are meant to adapt as the underlying assets evolve with time. @smol

== Applications
Digital Twins are already exensively used in a wide range of fields, ranging from power generation equipment - like large engines, power generation turbines - to establish timeframes for regularly scheduled maintenance, to the health industry where they can be used profile patients and help tracking a variety of health indicators. @dtibm

= SMOL

SMOL (Semantic Micro Object Language) is an imperative, object-oriented language with integrated semantic state access. It can be used served as a framework for creating digital twins. The interpreter can be used to examine the state of the system with SPARQL, SHACL and OWL queries. 

== Co-Simulation
SMOL uses _Functional Mock-Up Objects_ (FMOs) as a programming layer to encapsulate simulators compliant with the #link("https://fmi-standard.org")[FMI standard] into object oriented structures @smol

The project is in its early stages of developement, during our internship one of our objectives was to demonstrate the capabilities of the language and help with its developement by being the first users. 

= The Project

The project was realized in collaboration with the #link("https://www.uio.no/")[University of Oslo] and the #link("https://sirius-labs.no/")[Sirius Research Center].
The project consists in the creation of a greenhouse and program the corresponding digital twin of it. The greenhouse consists in a series of shelves with plants, each plant in its own pot, we then control the environmental conditions such as temperature, humidity, moisture and light level with a series of sensors connected to a fleet of Rapsberry Pi 4. The only actuator present in the project is a water pump but it could be expanded to include more actuators such as a heater or a fan.

== The Goal
The creation of a digital twin of the greenhouse and the optimization of the environmental conditions for maximum growth. Using SMOL we can predict when to water the plants and how much water to use.

= The Greenhouse

// TODO: add image of the greenhouse, add scheme with specifics
#lorem(200)

= The Role of each Raspberry Pi

There are in total 5 Raspberry Pi 4 used in this project. The division in roles and the usage of the same hardware makes it very scalable and easy to replicate. As follows: // FIXME: weird sentence
- 1 Raspberry Pi 4 is used as a server, it hosts the digital twin and the FMI simulators, the server is also used to host the database in which all the data is stored and accessed.
- 3 Raspberry Pi 4 are used as clients, they are connected to the sensors and the actuators and are responsible for sending the data to the server.
- 1 Raspberry Pi 4 is used as a router and serves to connect clients and server wirelessly.

== The Server
// TODO:

== The Clients
// TODO: add circuitry and wiring diagram

== The Router
The Raspberry was configured with `hostapd` and `dnsmasq` to act as a router and provide a wireless network for the clients to connect to.
The local network is used to access the client via `SSH` and to send data to the server via `HTTP` requests.

= Developing a library to interface with the sensors

When working with the Raspberry Pi 4 the obvious choice for a programming language is Python, it is the most widely used language for the Raspberry Pi and it has a lot of support and libraries available.

The goal was to make it extremely modular to be able to add new sensors and actuators with ease.

// TODO: add code snippets, continue writing stuff

= The Digital Twin

// TODO: add stuff about modelica and semantic objects and stuff
