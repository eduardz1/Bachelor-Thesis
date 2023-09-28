#import "../utils/common.typ": *

= SMOL <smol-heading>

SMOL (Semantic Micro Object Language) is an imperative, object-oriented language with integrated semantic state access. It can be used served as a framework for creating digital twins. The interpreter can be used to examine the state of the system with SPARQL, SHACL and OWL queries.

SMOL uses _Functional Mock-Up Objects_ (FMOs) as a programming layer to encapsulate simulators compliant with the #link("https://fmi-standard.org")[FMI standard] into object oriented structures @smol.

The project is in its early stages of developement, during our internship one of our objectives was to demonstrate the capabilities of the language and help with its developement by being the first users.

#_content(
  [
    == A Functional Mock-Up Object Language
    To develop cyber-physical systems, it's imperative to have language and tool support for the core technologies involved, in particular simulators (integrated as FMUs) and knowledge graphs. To achieve this one needs to leverage a language that encompasses both of those technologies. SMOL, as presented by Kamburjan et al. in 2021, is a syntactically standard, statically typed, object-oriented language @ksosu.
    SMOL goes beyond what would be achievable by extending any tradional language by incorporating FMUs as Functional Mock-Up Objects in its runtime.

    == Co-Simulation <co-simulation>
    // TODO: 
   
    == Semantical Lifting
    Semantical Lifting maps a program state to a knowledge graph, to see the program state through the lense of domain knowledge @ksosu. 

  ]
)