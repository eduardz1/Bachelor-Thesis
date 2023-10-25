#import "../utils/common.typ": *

= Digital Twins <digital-twins>

#_block(
  [
  #underline[NASA's definition of digital twin]
    
  \"An integrated multiphysics, multiscale, probabilistic simulation of a vehicle or system that uses the best available physical models, sensor updates, fleet history, etc., to mirror the life of its flying twin. It is ultra-realistic and may consider one or more important and interdependent vehicle systems\"@dtnasa
  ]
)

A digital twin is a live replica of a Physical System and is connected to it in real-time, application. An ontology based asset model is often used to connect the state of the DT with the PT (see @dtschema). Digital Twins are meant to understand and control assets in nature, industry, or society at large, they are meant to adapt as the underlying assets evolve with time @smol. They are categorized into distinct definitions depending on their level of integration @fmi:

#set par(justify: true, first-line-indent: 0em) // FIXME: workaround for https://github.com/typst/typst/issues/1050
/ Digital Model: acts as a digital copy of an existing model or system, changes in the digital copy do not affect the physical system.

/ Digital Shadow: extends the digital copy by automatic the exchange of data from the physical system to the digital shadow, but not the opposite.

/ Digital Twin: defines the highest level of integration in which the exchange of data is bidirectional with both systems affecting one another.
#set par(justify: true, first-line-indent: 1em)

NASA was one of the first to introduce the concept of digital twins, however, this research field still lacks any form of standardization, NASA's approach is a monolithic one, what we're trying to do with #link(<smol-heading>)[SMOL] is provide a more flexible approach and the basis for a standard way to approach this kind of problems.

#_content(
  [

  #figure(
    image("../img/dtschema.svg"),
    caption: [
      High-level representation of a typical digital twin achitecture @tbc.
    ]
  ) <dtschema>

    == Applications
    Digital Twins are already extensively used in a wide range of fields, ranging from power generation equipment - like large engines, and power generation turbines - to establish timeframes for regularly scheduled maintenance, to the health industry where they can be used to profile patients and help tracking a variety of health indicators. @dtibm

    For example M. Wiens, T. Meyer and P. Thomas describe @fmi, in the context of introducing the FMI (@fmi-chapter) standard due to the need of a full-system simulation model, a digital twin of a hydrogen generator based on wind-turbine energy, a field where an high degree of modularity is observed. In this case the digital twins allows for operational optimizations and error detection.

    == Twinning by Construction
    Digital twins that mirror a structure that does not change over time, also referred to as static digital twins, are said to be _twinned-by-construction_ if the initialization of the digital system ensures the twinning property @tbc. When the PT evolves over time, self-adaptation will play a crucial role in ensuring the twinning property.

    More specifically the asset model can be used as the base to construct the digital twin, we see our implementation later on in @asset-model, this kind of DTs are what we define as _twinned-by-construction_ and the process of establishing a connection between PT and DT via the asset model is what we call _twinning-by-construction_.

    == Self-Adaptation and MAPE-K

    Self-adaptation is the process that is triggered when we observe a deviation of the DT from the PT and/or when the asset model changes. In trying to standardize the self-adaptation process the MAPE-K process was introduced.
    
    MAPE-K loops are feedback control loops that are used in self adaptive systems to organize their behavior @mapek, the acronym summarizes the steps needed and stands for:

    #set par(justify: true, first-line-indent: 0em) // FIXME: workaround for https://github.com/typst/typst/issues/1050
    / Monitor: the step in which streams of data are collected from the physical and digital system.
    / Analyze: the step in which we process the data and express expectation on the data stream that is being fed for the digital twin to work correctly, an error might be raised if an unexpected value is registered or if the difference between the collected and simulated data surpasses a certain threshold.
    / Plan: the step in which model search techniques are used to tune the parameters to realign the DT with the PT.
    / Execute based on Knowledge: the step in which the DT is reset with the updated parameters that where computed in the preceding step.
    #set par(justify: true, first-line-indent: 1em)

    == FMI <fmi-chapter>

    FMI stands for Functional Mockup Interface, it's a standard created to standardize the model exchange and the co-simulation format in the field of digital twins @fmi. The interface encapsulates simulators in FMUs (Functional Mock-up Units) which are software components that are used for exchanging and simulating dynamic system models. As formalized by Gomes, Lúcio, and Vangheluwe @cosim, simulation units are a tuple $(S, U, Y, mono("set"), mono("get"), mono("doStep"))$ with $S$ as the domain of internal states, $U$ the set of inputs, $Y$ the set of outputs, $mono("set"): S times U times cal(V) -> S$ the function to set the values of the inputs to some values of domain $cal(V)$, $mono("get"): S times Y -> cal(V)$ the function to get the results and $mono("doStep"): S times RR^+ -> RR$ the function to perform the simulation for a given amount of time @ksosu.
  ]
)