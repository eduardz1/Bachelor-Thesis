#import "../utils/common.typ": *

= Introduction 
// TODO: find a synonim of project

The following project was realized as an internship project during my Erasmus semester abroad in Oslo, Norway. The project was realized in collaboration with the #link("https://www.uio.no/")[University of Oslo] and the #link("https://sirius-labs.no/")[Sirius Research Center].

The project consists of the creation of a digital twin of a greenhouse and the optimization of the environmental conditions for maximum growth. Using SMOL we can interface with a simulation to predict when to water the plants and how much water to use.

#_content(
  [
    == Learning Outcome
    
    The internship required several theoretical and practical competencies to be acquired, such as:
    - Understanding the concept of digital twins.
    - Learning the syntax and semantics of SMOL, a programming language designed by a research group at the University of Oslo to more easily interface with semantic technologies.
    - Learning in depth the concept of semantic technologies (in particular RDF, OWL, SPARQL) and their usage in the context of digital twins.
    - Learning the basics of the FMI standard.
    - Learning basic electronics to connect sensors and actuators to a Raspberry Pi.

    The project also required the usage of several tools such as:
    - Raspberry Pi and how to work with them on both a software and hardware level.
    - InfluxDB for data storage.
    - Python, Java, and SMOL as programming languages.

    By modeling a small-scale model of a digital twin we were able to build the basis for the analysis of a larger-scale problem. Other than the competencies listed above, it was also important to be able to work in a team by dividing tasks and efficiently managing the codebases of the various subprojects (by setting up build tools and CI pipelines in the best way possible, for example). Documentation was also important given that the project is still ongoing and currently being picked up by another student.

    Electronic prototyping was also a big part of the project. We had to learn how to connect sensors and actuators to a Raspberry Pi (which required the use of breadboards, analog-to-digital converters, and relays for some of them) and how to translate the signal in a way that could be used as data.

    == My Contribution

    As a team we split our roles but worked together on most tasks, my involvement was mainly in the following areas:
    - Hardware side of the project and the setup and configuration of the Linux environment.
    - The Python side of the codebase, in particular the code for the communication with the sensors.

    == Results

    A functioning prototype was built with the potential to be easily scaled both in terms of size and complexity. Adding new shelves with new plants is as easy as adding a new component to the model and connecting the sensors and actuators to the Raspberry Pi. The model is easily extendable to add new components and functionalities such as actuators for the control of the temperature and humidity or separate pumps dedicated to the dosage of fertilizer. Sensors are also easily added (a PH sensor would prove useful for certain plants) both in terms of the asset model and in terms of code, each sensor/actuator is represented as a class and they are all being read independently from each other.

    == Thesis Contents

    The thesis from a theorical point of view focuses on the concept of digital twins in @digital-twins and the way they are linked with the SMOL language in @smol-heading. In @tools-and-technologies we will discuss notions regarding semantic technologies.

    In @raspberry-responsabilities-and-physical-setup we will threat the hardware side of the project and how the sensors interface on the software side. In @software-components we will deep dive into the codebase and take a look on the implementation and structure of the various programs.

  ]
)