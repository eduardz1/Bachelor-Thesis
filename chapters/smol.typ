#import "../utils/common.typ": *

= SMOL <smol-heading>

SMOL (Semantic Micro Object Language) is an imperative, object-oriented language with integrated semantic state access. It can be used as a framework for creating digital twins. The interpreter can be used to examine the state of the system with SPARQL, SHACL, and OWL queries. It can be seen conceptually as a subset of Java.

SMOL uses _Functional Mock-Up Objects_ (FMOs) as a programming layer to encapsulate simulators compliant with the #link("https://fmi-standard.org")[FMI standard] into object-oriented structures @smol. One of the key features of SMOL is the choice to treat FMUs as first-order concepts and integrate them into its type system.

The project is in its early stages of development, during our internship one of our objectives was to demonstrate the capabilities of the language and help with its development by being some of the first users and submitting issues (and eventually fixes) when they arise on the main repository.

Details on our usage of the language can be found in @smol-twinning-program.

#_content(
  [
    == A Functional Mock-Up Object Language

    To develop cyber-physical systems, it's imperative to have language and tool support for the core technologies involved, in particular simulators (integrated as FMUs) and knowledge graphs. To achieve this, one needs to leverage a language that encompasses both of those technologies. SMOL, as presented by Kamburjan et al. in 2021, is a syntactically standard, statically typed, object-oriented language that achieves support for both @ksosu.

    SMOL goes beyond what would be achievable by extending any traditional language with packages or libraries by incorporating FMUs as Functional Mock-Up Objects in its runtime and treating them as first-order types.

    In an FMO the in and out ports of the corresponding FMI become the fields of the object and the functions are converted in class methods, for example, the $mono("doStep")$ operation @fmi-section is translated to a method that accepts a floating point number as parameter (the time). For instance, to initialize an FMO `gr` in SMOL that accepts a Boolean as input and returns a Double as output, one would write:

    ```smol
    FMO[in Boolean i, out Double o] gr = simulate(
      "Greenhouse.fmu", 
      i = True
    );
    ```

    The number of inputs and outputs is not limited and their name has to match the name of the corresponding variable in the FMU. Each one has a `tick` method that accepts a floating point number as a parameter to advance the simulation by a given time.

    == Semantical Lifting <semantical-lifting>
  
    Semantical Lifting maps a program state to a knowledge graph, to see the program state through the lens of domain knowledge @ksosu.#v(600pt) /* FIXME: remove once issue #466 is implemented */ At any point at runtime, the state of the program can be queried and lifted states can be used to check the consistency of the program with the domain constraints.

  ]
)