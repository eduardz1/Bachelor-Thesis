#import "../utils/common.typ": *

= Tools and Technologies <tools-and-technologies>

In this chapter, we will explore the tools and technologies used in the project. In particular, in @influxdb-section we will introduce InfluxDB and after that, we will touch on the three main programming languages that we had to work with. After that, we'll briefly touch on the concepts of the Semantic Web @semanticweb from @rdf-section onwards, which is an extension of the World Wide Web through standards that aim to make internet data machine-readable. These concepts serve as the underlying foundation for our project.

#_content(
  [
    == InfluxDB <influxdb-section>

    InfluxDB @influxdb is a powerful open-source time-series database that in our context is used to store the data collected by the _data collectors_ (see @influx-python). It is designed to handle high volume and high frequency time-stamped data and provides a SQL-like language with specific time-centric functions useful for querying a data structure primarily composed of measurements, streams of data, and points @influxdb-wiki. Being a NoSQL database, it is schemaless and it allows for a flexible data model.

    InfluxDB is also directly integrated with the SMOL language, in the `access` expression (see @smol-twinning-program for an example of how we use it in practice), an InfluxDB query with a single answer variable can be directly executed on an external database without the need for external tooling. 

    The way our data is organized is in structures called _buckets_ that are used to store the _measurements_. Each _measurement_ is composed of: #v(600pt) /* FIXME: remove once issue #466 is implemented */

    - _measurement name_
    - _tag set_
      - Used as keys to index the data
    - _field set_
      - Used to store the actual data
    - _timestamp_

    For example, the following query will return the last moisture measurement, given a measurement range of 30 days, from the bucket named _greenhouse_:

    ```SQL
  from(bucket: "greenhouse")
    |> range(start: -30d)
    |> filter(fn: (r) => r["_measurement"] == "ast:pot")
    |> filter(fn: (r) => r["_field"] == "moisture")
    |> filter(fn: (r) => r["plant_id"] == %1)
    |> keep(columns: ["_value"])
    |> last()
    ```

    Chronograf @chronograf is a web application included in the InfluxDB 2.0 package, it is the tool that we chose to visualize the data stored in the database and to create dashboards. It can be also used to create alerts and automation rules.
    
    #figure(
      image("../img/chronograf.png"),
      caption: [
        An example of the visualization tools offered by the Chronograf Dashboard @chronograf-img
      ]
    )

    == Raspberry Pi

    Every part of the system is either managed by or communicates with a Raspberry Pi, in particular, we used a series of Raspberry Pi 4, small single-board computers that are extremely versatile due to their open design, low cost and modularity. The integrated J8 header provides a standard pin pinout for interfacing with sensors and such @raspberry-pi-wiki.

    == Python

    When working with the Raspberry Pi 4 the obvious choice for a programming language is Python as it is the most widely used language for the Raspberry Pi due to the amount of libraries available for it and the wide community support. We will talk more in detail in @software-components about the specifics of the code.

    The goal was to make it extremely modular allowing for easy integration of new sensors and actuators, the field of digital twins is modular by nature.

    == SMOL

    SMOL is an Object Oriented programming language in its early development stages, it allows us to:
    - Interact with the Influx Database and read data from it, directly without the need for third-party libraries.
    - Read and query the asset model (that we discuss in @asset-model), mapping the data to objects in the heap.
    - Map the program state to a knowledge graph through semantic lifting (a concept that will be further discussed in @semantical-lifting), the program state can be then queried to extract information about the state of the system.
    - Represent and run the simulation and interact with FMU simulation files, something that we didn't cover in this project but is the next logical step that should be taken. In @fmi-section we briefly will cover the theory behind FMUs.

    SMOL programs are compiled to Java bytecode and can be run natively on the JVM.

    == Java

    We use Java to interface with the SMOL program by making use of the Kotlin (a language designed to fully interoperate with Java) classes that are the building blocks of the REPL (Read-Evel-Print-Loop) interactive interpreter for SMOL @semanticobjects. The REPL is used to query the lifted state of the SMOL program.

    The Java program is also responsible for sending commands to the Raspberry Pi through SSH in the local network we set up by using the `JSch` library.

    == RDF <rdf-section>

    RDF is a standard model for data interchange on the Web. The acronym stands for Resource Description Framework, RDF has features that facilitate data merging even when the underlying schemas differ and it specifically supports the evolution of schemas over time without requiring all the data consumers to be changed @rdf.

    Each RDF statement represents knowledge graphs as a set of triples in the form _\<subject\> \<predicate\> \<object\>_ @ksosu. 
    
    More specifically the triplets are composed of three basic elements @rdfandowl:
    - *Resources* - the thing described
    - *Properties* - the relationship between things
    - *Classes* - the bucket used to group the things

    An example related to our knowledge graph is the formalization of the value `50` as ideal moisture for the individual encoded as `basilicum1`:

    ```turtle
    <basilicum1> <hasIdealMoisture> <50>
    ```

    The three-part structure consists of resources identified by a URI (Universal Resource Identifier). RDF extends the linking structure of the Web by using URIs to name the relationship between things, this method allows the mixing of structured and semi-structured data.

    These characteristics make RDF a flexible and efficient way to represent knowledge. When thinking about large-scale applications, data can be read quickly due to its structure not being linear like a traditional database and not being hierarchical like XML.

    === Namespaces

    Namespaces are used to define a set of short strings to represent long URIs (Uniform Resource Identifiers) that are used in RDF data.

    For example instead of:
    
    ```turtle
    <http://www.w3.org/2002/07/owl#ObjectProperty>
    ```

    we can more concisely write `<owl:ObjectProperty>` and define the namespace `owl` as:

    ```turtle
    @prefix owl: <http://www.w3.org/2002/07/owl#> .`
    ```

    by defining it at the top of the Turtle document, #v(600pt) /* FIXME: remove once issue #466 is implemented */the aforementioned is a language used to write down RDF graphs in a compact textual form @turtle.

    == OWL

    The W3C Web Ontology Language (OWL) is a Semantic Web language designed to represent rich and complex knowledge about things, groups of things, and relations between things @owl.
    OWL is based on RDF and extends it with more vocabulary for the description of properties and classes.

    We use OWL in the asset model of the greenhouse to create a formal description of its physical structure and formalize the relationships between the different components.

    === Ontologies

    In the context of RDF and OWL, an ontology is a formal description providing users with a shared understanding of a given domain @webdam. They define the concepts and entities that exist in a domain and the relationships between them.

    == SPARQL

    After having understood the basics of RDF and OWL, we can now talk about SPARQL, which is the query language for RDF @sparql. For example, the following query will return the ideal moisture for each plant:

    ```sparql
    PREFIX ast: <http://www.semanticweb.org/gianl/ontologies/2023/1/sirius-greenhouse#>
        
    SELECT ?plantId ?idealMoisture
    WHERE {
        ?plant rdf:type ast:Plant ;
            ast:hasPlantId ?plantId ;
            ast:hasIdealMoisture ?idealMoisture .
    }
    ```

    In the query, we prefix variables with a question mark `?`.

    == Protégé

    Protégé is a free and open-source ontology editor and framework for building intelligent systems @protege.

    It is developed by a team from Stanford University and it provides a suite of tools to construct domain models and knowledge-based applications with ontologies. 

    Protégé fully supports the OWL 2 Web Ontology Language and RDF specifications and that made it the tool of choice for the project, #v(600pt) /* FIXME: remove once issue #466 is implemented */the following is an image of the interface in which we can see details about the Basilicum class and related instances.

    #figure(
      image("../img/protege.png")
    )
  ]
)

