Blog web application
====================

Sample Linked Data application extending [Graphity Client](https://github.com/Graphity/graphity-client).

No permanent storage!
---------------------

Graphity Client does *not* include a permanent RDF storage! Therefore creating/updating data will have no effect.

In order to store data permanently, you need to set up a [triplestore](http://en.wikipedia.org/wiki/Triplestore) and configure the webapp with its SPARQL endpoint.
For open-source, we recommend trying Jena's [TDB](http://jena.apache.org/documentation/tdb/); for commercial, see [Dydra](http://dydra.com).

Components
----------

* [Application subclass](../../blob/master/src/main/java/org/graphity/blog/Application.java) that registers JAX-RS resources and providers
* [ResourceBase subclass](../../blob/master/src/main/java/org/graphity/blog/ResourceBase.java) that works as a JAX-RS and RDF resource at the same time. It can be further extended by Resource classes with specific `@Path`
* [application dataset](../../blob/master/src/main/resources/org/graphity/blog/dataset/dataset.trig) that contains instance data of the application (including containers) and is aligned with the sitemap
* [application sitemap](../../blob/master/src/main/resources/org/graphity/blog/vocabulary/blog.ttl) that lays out the webapp structure by defining containers and binding URI templates to SPIN SPARQL templates
* [layout stylesheet](../../blob/master/src/main/webapp/static/org/graphity/blog/xsl/layout-xhtml.xsl) that overrides the imported default XHTML layout
* [configuration](../../blob/master/src/main/webapp/WEB-INF/web.xml) that contains [configuration properties](https://github.com/Graphity/graphity-client/wiki/Cofiguration)

More information: [Extending Graphity](https://github.com/Graphity/graphity-client/wiki/Extending-Graphity)

Dependencies
------------

Graphity artifacts are not available on Maven yet, so you will have to check out and build the following dependencies as well:
* [Graphity Client](https://github.com/Graphity/graphity-client) (needs to be [built as a JAR](https://github.com/Graphity/graphity-client/wiki/Installation#using-client-in-your-maven-web-application))
* [Graphity Server](https://github.com/Graphity/graphity-server)