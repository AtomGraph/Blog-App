Blog web application
====================

Sample Linked Data application that uses [AtomGraph Web-Node](https://github.com/AtomGraph/Web-Node) and [AtomGraph Client](https://github.com/AtomGraph/Web-Client).

No permanent storage!
---------------------

AtomGraph Processor does *not* include a permanent RDF storage! Therefore creating/updating data will have no effect.

In order to store data permanently, you need to set up a [triplestore](http://en.wikipedia.org/wiki/Triplestore) and configure the webapp with its SPARQL endpoint.
For open-source, we recommend trying Jena's [TDB](http://jena.apache.org/documentation/tdb/); for commercial, see [Dydra](http://dydra.com).

Components
----------

* [Application subclass](../../blob/master/src/main/java/com/atomgraph/blog/Application.java) that registers JAX-RS resources and providers
* [ResourceBase subclass](../../blob/master/src/main/java/com/atomgraph/blog/ResourceBase.java) that works as a JAX-RS and RDF resource at the same time. It can be further extended by Resource classes with specific `@Path`
* [application dataset](../../blob/master/src/main/resources/com/atomgraph/blog/dataset.trig) that contains instance data of the application (including containers) and is aligned with the sitemap
* [application sitemap](../../blob/master/src/main/resources/com/atomgraph/blog/ns.ttl) that lays out the webapp structure and imports:
    * [domain ontology](../../blob/master/src/main/resources/com/atomgraph/blog/domain.ttl) which defines blog domain classes and properties such as Post and Category
    * [LDT templates](../../blob/master/src/main/resources/com/atomgraph/blog/templates.ttl) which defines application operations binding URI templates to SPIN SPARQL templates
* [layout stylesheet](../../blob/master/src/main/webapp/static/com/atomgraph/blog/xsl/layout-xhtml.xsl) that overrides the imported default XHTML layout
* [configuration](../../blob/master/src/main/webapp/WEB-INF/web.xml) that contains [Processor configuration properties](https://github.com/AtomGraph/Processor/wiki/Cofiguration) and [Client configuration properties](https://github.com/AtomGraph/Web-Client/wiki/Cofiguration)

More information: [Using AtomGraph Processor in your application](https://github.com/AtomGraph/Processor/wiki/Installation#using-processor-in-your-application)

Dependencies
------------

SNAPSHOT artifacts are not available on Maven, so you will have to check out and build the following dependencies as well:
* [AtomGraph Web-Node](https://github.com/AtomGraph/Web-Node)
    * [AtomGraph Processor](https://github.com/AtomGraph/Processor)
        * [AtomGraph Core](https://github.com/AtomGraph/Core)
    * [AtomGraph Client](https://github.com/AtomGraph/Web-Client) (needs to be [built as a WAR](https://github.com/AtomGraph/Web-Client/wiki/Installation))
        * [AtomGraph Core](https://github.com/AtomGraph/Core)