#import "../utils/common.typ": *

= SMOL <smol-heading>

SMOL (Semantic Micro Object Language) is an imperative, object-oriented language with integrated semantic state access. It can be used as a framework for creating digital twins. The interpreter can be used to examine the state of the system with SPARQL, SHACL, and OWL queries.

SMOL uses _Functional Mock-Up Objects_ (FMOs) as a programming layer to encapsulate simulators compliant with the #link("https://fmi-standard.org")[FMI standard] into object-oriented structures @smol. One of the key features of SMOL is the choice to treat FMUs as first-order concepts and integrate them into its type system.

The project is in its early stages of development, during our internship one of our objectives was to demonstrate the capabilities of the language and help with its development by being some of the first users.

Details on the implementation can be found in the #link(<smol-twinning-program>)[SMOL Twinning Program] section.

#_content(
  [
    == A Functional Mock-Up Object Language

    To develop cyber-physical systems, it's imperative to have language and tool support for the core technologies involved, in particular simulators (integrated as FMUs) and knowledge graphs. To achieve this one needs to leverage a language that encompasses both of those technologies. SMOL, as presented by Kamburjan et al. in 2021, is a syntactically standard, statically typed, object-oriented language @ksosu.
    SMOL goes beyond what would be achievable by extending any traditional language by incorporating FMUs as Functional Mock-Up Objects in its runtime.

    == Co-Simulation <co-simulation>
    


    == MAPE-K

  
    == Semantical Lifting
    
    Semantical Lifting maps a program state to a knowledge graph, to see the program state through the lens of domain knowledge @ksosu.

  ]
)