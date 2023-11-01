#import "utils/template.typ": *

#let declaration_of_originality = [
  I declare to be responsible for the content I'm presenting in order to obtain
  the final degree, not to have plagiarized in all or part of, the work produced
  by others and having cited original sources in consistent way with current
  plagiarism regulations and copyright. I am also aware that in case of false
  declaration, I could incur in law penalties and my admission to final exam could
  be denied
]

#let acknowledgments = [
  I would like to thank my supervisor, prof. Ferruccio Damiani, and the team at
  the research laboratory in Oslo, in particular the prof. Einar Broch Johnsen,
  dr. Rudolf Schlatte and dr. Eduard Kamburjan, for grating me the opportunity to
  work on this project and for the support they provided me during the internship.
  A special note of appeciation goes to Chinmayi Baramashetru for always being
  available to help us during the internship to figure out the electronics and
  Gianluca Barmina and Marco Amato with whom I collaborated closely on this
  project.
  
  I express my gratitude to all the friends who shared this journey and many long
  study sessions over these three years with me. I am sure a big part of my
  achievements is to be attributed to them. In particular Miriam Lamari, that has
  been and still is always inviting us to study together, Marco Molica that I had
  great pleasure studying and working with in several assignments, and Dennis
  Gobbi that always pushed me to do my best and has always been available to
  explain concepts I had trouble with. I would also like to thank the friends from
  Oslo that really contributed in making my last semester at UniTO memorable.
  
  Finally I give an heartfelt thanks to my mother for always supporting me
  throughout the studies.
]

#let abstract = [
  In this thesis we will talk about what digital twins are and how they can be
  used in a range of scenarios, we will introduce some concepts of the Semantic
  Web that will serve as a basis for our work. We will also introduce a novel
  programming language, SMOL, developed to facilitate the way to interface with
  digital twins. We will talk about the work of myself and my colleagues in the
  process of building the physical twin with a focus on the structure and the way
  the responsibilities of the different components are modularized. Finally, we
  will talk about the software components that we wrote as part of this project,
  including the code to interact with the sensors and the actuators - with a focus
  on the Python code and the way it's structured - and the SMOL code that serves
  as a proof of concept for the automation of the greenhouse.
]

#show: project.with(
  title: "Design and Development of the Digital Twin of a Greenhouse",
  subtitle: "Bachelor's Thesis",
  abstract: abstract,
  keywords: [
    Digital Twins, Raspberry Pi, SMOL, Python
  ],
  acknowledgments: acknowledgments,
  declaration-of-originality: declaration_of_originality,
  affiliation: (
    university: "Università degli Studi di Torino",
    school: "SCUOLA DI SCIENZE DELLA NATURA",
    degree: "Corso di Laurea Triennale in Informatica",
  ),
  candidate: (name: "Occhipinti Eduard Antonovic", id: "947847"),
  supervisor: "Prof. Damiani Ferruccio",
  cosupervisor: [
    Prof. Johnsen Einar Broch\
    Dr. Schlatte Rudolf\
    Dr. Kamburjan Eduard
  ],
  date: "Academic Year 2022/2023",
  logo: "../img/logo.svg",
  bibliography-file: "../works.yml",
)

#show link: underline
#counter(page).update(1)

#include "chapters/introduction.typ"

#include "chapters/tools-and-technologies.typ"

#include "chapters/digital-twins.typ"

#include "chapters/smol.typ"

#include "chapters/overview-of-the-greenhouse.typ"

#include "chapters/raspberries-responsabilities-and-physical-setup.typ"

#include "chapters/software-components.typ"

#include "chapters/conclusions.typ"

#pagebreak()
