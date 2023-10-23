#import "utils/template.typ": *

#let declaration_of_originality = "I declare to be responsible for the content I'm presenting in order to obtain the final degree, not to have plagiarized in all or part of, the work produced by others and having cited original sources in consistent way with current plagiarism regulations and copyright. I am also aware that in case of false declaration, I could incur in law penalties and my admission to final exam could be denied"

#let acknowledgments = "I would like to express my gratitude to all the friends with whom I shared this journey and many long study sessions during these three years. Special thanks to Chinmayi Bp for always being available to help us during the internship to figure out the electronics and Gianluca Barmina and Marco Amato with whom I worked together on the project"

#show: project.with(
  title: "Design and Development of the Digital Twin of a Greenhouse",
  abstract: "We will see how digital twins can be used and applied in a range of scenarios, we'll introduce the language 'SMOL', created specifically for this purpose, and talk about the work of me and my colleagues in the process of designing and implementing a digital twin of a greenhouse.",
  acknowledgments: acknowledgments,
  declaration-of-originality: declaration_of_originality,
  affiliation: (
    university: "Università degli Studi di Torino",
    department: "DIPARTIMENTO DI INFORMATICA",
    degree: "Corso di Laurea Triennale in Informatica"
  ),
  authors: (
    (role: "candidate", name: "Eduard Antonovic Occhipinti", id: "947847"),
    (role: "supervisor", name: "Prof. Ferruccio Damiani", id: ""),
    (role: "co-supervisors", name: "Prof. Einar Broch Johnsen\n\nDr. Rudolf Schlatte\n\nDr. Eduard Kamburjan", id: "")
  ),
  date: "Academic Year 2022/2023",
  logo: "../img/logo.svg",
  bibliography-file: "../works.yml"
)

#show link: underline

// TODO: check every link to avoid them pointing to one of our personal repositories

#include "chapters/introduction.typ"
#pagebreak()

#include "chapters/tools-and-technologies.typ"
#pagebreak()

#include "chapters/digital-twins.typ"
#pagebreak()

#include "chapters/smol.typ"
#pagebreak()

#include "chapters/overview-of-the-greenhouse.typ"
#pagebreak()

#include "chapters/raspberries-responsabilities-and-physical-setup.typ"
#pagebreak()

//#include "chapters/semantic-lifting.typ"

#include "chapters/software-components.typ"
#pagebreak()

#include "chapters/conclusions.typ"
#pagebreak()
