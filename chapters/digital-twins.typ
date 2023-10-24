#import "../utils/common.typ": *

= Digital Twins <digital-twins>

#_block(
  [
  #underline[NASA's definition of digital twin]
    
  \"An integrated multiphysics, multiscale, probabilistic simulation of a vehicle or system that uses the best available physical models, sensor updates, fleet history, etc., to mirror the life of its flying twin. It is ultra-realistic and may consider one or more important and interdependent vehicle systems\"@dtnasa
  ]
  )

A digital twin is a live replica of a Physical System and is connected to it in real-time, application. Digital Twins are meant to understand and control assets in nature, industry, or society at large, they are meant to adapt as the underlying assets evolve with time. @smol
They are categorized into distinct definitions depending on their level of integration @fmi:

#set par(justify: true, first-line-indent: 0em) // FIXME: workaround for https://github.com/typst/typst/issues/1050
/ Digital Model: acts as a digital copy of an existing model or system, changes in the digital copy do not affect the physical system.

/ Digital Shadow: extends the digital copy by automatic the exchange of data from the physical system to the digital shadow, but not the opposite.

/ Digital Twin: defines the highest level of integration in which the exchange of data is bidirectional with both systems affecting one another.
#set par(justify: true, first-line-indent: 1em)

NASA was one of the first to introduce the concept of digital twins, however, this research field still lacks any form of standardization, NASA's approach is a monolithic one, what we're trying to do with SMOL is provide a more flexible approach and the basis for a standard way to approach this kind of problems.

#_content(
  [
    == Applications
    Digital Twins are already extensively used in a wide range of fields, ranging from power generation equipment - like large engines, and power generation turbines - to establish timeframes for regularly scheduled maintenance, to the health industry where they can be used to profile patients and help tracking a variety of health indicators. @dtibm

    == FMI

    FMI stands for Functional Mockup Interface, it's a standard created to standardize the model exchange and the co-simulation format in the field of digital twins @fmi. The interface encapsulates simulators in FMUs (Functional Mock-up Units) which are software components that are used for exchanging and simulating dynamic system models. As formalized by Gomes, Lúcio, and Vangheluwe @cosim, simulation units are a tuple $(S, U, Y, mono("set"), mono("get"), mono("doStep"))$ with $S$ as the domain of internal states, $U$ the set of inputs, $Y$ the set of outputs, $mono("set"): S times U times cal(V) -> S$ the function to set the values of the inputs to some values of domain $cal(V)$, $mono("get"): S times Y -> cal(V)$ the function to get the results and $mono("doStep"): S times RR^+ -> RR$ the function to perform the simulation for a given amount of time @ksosu.

    == Twinning by Construction
    // TODO:
    Digital twins that mirror a structure that does not change over time, also referred to as static digital twins, are said to be _twinned-by-construction_ if the initialization of the digital system ensures the twinning property @tbc. 

  ]
)