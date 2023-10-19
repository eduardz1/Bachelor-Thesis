#import "utils/template.typ": *

#let declaration_of_originality = "I declare to be responsible for the content I'm presenting in order to obtain the final degree, not to have plagiarized in all or part of, the work produced by others and having cited original sources in consistent way with current plagiarism regulations and copyright. I am also aware that in case of false declaration, I could incur in law penalties and my admission to final exam could be denied"

#let aknowlegements = "Special thanks to Chinmayi Bp for always being available to help us figure out the electronics and Gianluca Barmina and Marco Amato with whom I worked together on the project"

#show: project.with(
  title: "Design and Development of the Digital Twin of a Greenhouse",
  abstract: "We will see how digital twins can be used and applied in a range of scenarios, we'll introduce the language 'SMOL', created specifically for this purpose, and talk about the work of me and my colleagues in the process of designing and implementing a digital twin of a greenhouse.",
  aknowlegements: aknowlegements,
  declaration-of-originality: declaration_of_originality,
  affiliation: (
    university: "Università degli Studi di Torino",
    department: "DIPARTIMENTO DI INFORMATICA",
    degree: "Corso di Laurea Triennale in Informatica"
  ),
  authors: (
    (role: "candidate", name: "Eduard Antonovic Occhipinti", id: "947847"),
    (role: "supervisor", name: "Prof. Ferruccio Damiani", id: ""),
    (role: "co-supervisors", name: "Prof. Einar Broch Johnsen\n\nProf. Rudolf Schlatte\n\nProf. Eduard Kamburjan", id: "")
  ),
  date: "Academic Year 2022/2023",
  logo: "../img/logo.svg",
  bibliography-file: "../works.yml"
)

#show link: underline

// TODO: check every link to avoid them pointing to one of our personal repositories

#include "chapters/introduction.typ"

#include "chapters/tools-and-technologies.typ"

#include "chapters/digital-twins.typ"

#include "chapters/overview-of-the-greenhouse.typ"

#include "chapters/raspberries-responsabilities-and-physical-setup.typ"

#include "chapters/smol.typ"

#include "chapters/semantic-lifting.typ"

#include "chapters/software-components.typ"

#include "chapters/conclusions.typ"
