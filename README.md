Sample Graphity web application
===============================

Sample Linked Data application extending [Graphity Client]().

Components
----------

* [Application subclass](../../blob/master/src/main/java/com/sample/Application.java) that registers JAX-RS resources and providers
* [ResourceBase subclass](../../blob/master/src/main/java/com/sample/ResourceBase.java) that works as a JAX-RS and RDF resource at the same time. It can be further extended by Resource classes with specific `@Path`
* [sitemap ontology](../../blob/master/src/main/resources/com/sample/ontology/sitemap.ttl) that lays out the webapp structure by defining containers and binding URI templates to SPIN SPARQL templates
* [layout stylesheet](../../blob/master/src/main/resources/com/sample/writer/layout-xhtml.xsl) that overrides the imported default XHTML layout
* [configuration](../../blob/master/src/main/webapp/WEB-INF/web.xml) that contains [configuration properties](https://github.com/Graphity/graphity-browser/wiki/Cofiguration)

More information: [Extending Graphity](https://github.com/Graphity/graphity-browser/wiki/Extending-Graphity)

Dependencies
------------

Graphity artifacts are not available on Maven yet, so you will have to check out and build the following dependencies as well:
* [Graphity Client](https://github.com/Graphity/graphity-browser) (needs to be [built as a JAR](https://github.com/Graphity/graphity-browser/wiki/Installation#using-client-in-your-maven-web-application))
* [Graphity Server](https://github.com/Graphity/graphity-ldp)