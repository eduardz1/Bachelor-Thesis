#import "../utils/common.typ": *

= Tools and Technologies <tools-and-technologies>

In this chapter, we will explore the tools and technologies used in the project, in particular the concepts of the Semantic Web that serve as the underlying foundation of the project.

#_content(
  [
    == InfluxDB

    #link("https://www.influxdata.com/products/influxdb-overview/")[InfluxDB] is a powerful open-source time-series database that is used to store the data collected by the _data collectors_. It is designed to handle high volume and high frequency time-stamped data. Being a NoSQL database, it is schemaless and it allows for a flexible data model.
    
    It serves as the main data storage for the greenhouse.

    It's organized in _buckets_ that are used to store the _measurements_. Each _measurement_ is composed of:

    - _measurement name_
    - _tag set_
      - Used as keys to index the data
    - _field set_
      - Used to store the actual data
    - _timestamp_

    For example, the following query will return the last moisture measurement, given a measurement range of 30 days, from the bucket named `greenhouse`:

    ```SQL
from(bucket: "greenhouse")
  |> range(start: -30d)
  |> filter(fn: (r) => r["_measurement"] == "ast:pot")
  |> filter(fn: (r) => r["_field"] == "moisture")
  |> filter(fn: (r) => r["plant_id"] == %1)
  |> keep(columns: ["_value"])
  |> last()
    ```

    Chronograf is included in the InfluxDB 2.0 package, it is the tool that we chose to visualize the data stored in the database and to create dashboards.
    
    // TODO: use a screenshot from the project instead of a generic one
    #figure(
      image("../img/chronograf.png"),
      caption: [
        An example of the visualization tools offered by the Chronograf Dashboard
      ]
    )

    == Python

    When working with the Raspberry Pi 4 the obvious choice for a programming language is Python, it is the most widely used language for the Raspberry Pi and it has a lot of support and libraries available.

    The goal was to make it extremely modular to be able to add new sensors and actuators with ease.

    // TODO: add code snippets, continue writing stuff

    == SMOL
    
    `SMOL` is an OO programming language in its early development stages, it allows us to:
    - Interact with the `InfluxDB` and read data from the database, directly without the need for third-party libraries
    - Read and query the knowledge graph, mapping the data to objects in the heap
    - Map the program state to a knowledge graph through semantic lifting, the program state can be then queried to extract information about the state of the system
    - Represent and run the simulation and interact with `Modelica`
    
    It will be treated in more detail in its dedicated section.

    SMOL programs are compiled to Java bytecode and run on the JVM.

    == Java

    We use Java to interface with the SMOL program by making use of the Kotlin classes that are the building blocks of the REPL (Read-Evel-Print-Loop) interactive interpreter for SMOL @semanticobjects. The REPL is used to query the lifted state of the SMOL program.

    The Java program is also responsible for sending commands to the Raspberry Pi through SSH by using the `JSch` library.

    == RDF

    RDF is a standard model for data interchange on the Web.
    The acronym stands for Resource Description Framework, RDF has features that facilitate data merging even when the underlying schemas differ and it specifically supports the evolution of schemas over time without requiring all the data consumers to be changed @rdf.

    Each RDF statement represents knowledge graphs as a set of triples in the form _\<subject\> \<predicate\> \<object\>_ @ksosu. 
    
    More specifically the triplets are composed of three basic elements @rdfandowl:
    - *Resources* - the thing described
    - *Properties* - the relationship between things
    - *Classes* - the bucket used to group the things

    An example related to our knowledge graph is the formalization of the ideal moisture for the Basilicum plant number 1:

    `<basilicum1> <hasIdealMoisture> <50>`

    The three-part structure consists of resources identified by a URI. RDF extends the linking structure of the Web by using URIs to name the relationship between things, this method allows the mixing of structured and semi-structured data.
    These characteristics make RDF a flexible and efficient way to represent knowledge, on a large scale data can be read quickly due to it not being linear like a traditional database and not being hierarchical like XML.

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

    at the top of the `.ttl` file.

    == OWL

    The W3C Web Ontology Language (OWL) is a Semantic Web language designed to represent rich and complex knowledge about things, groups of things, and relations between things @owl.
    OWL is based on RDF and extends it with more vocabulary for describing properties and classes.

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

    Protégé fully supports the OWL 2 Web Ontology Language and RDF specifications and that made it the tool of choice for the project, the following is an image of the interface in which we can see details about the Basilicum class and related instances.

    #figure(
      image("../img/protege.png")
    )
  ]
)

