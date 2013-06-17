<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) 2012 Martynas Jusevičius <martynas@graphity.org>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY java "http://xml.apache.org/xalan/java/">
    <!ENTITY gc "http://client.graphity.org/ontology#">
    <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
    <!ENTITY owl "http://www.w3.org/2002/07/owl#">
    <!ENTITY sparql "http://www.w3.org/2005/sparql-results#">
    <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
    <!ENTITY dct "http://purl.org/dc/terms/">
    <!ENTITY foaf "http://xmlns.com/foaf/0.1/">
    <!ENTITY sioc "http://rdfs.org/sioc/ns#">
    <!ENTITY sp "http://spinrdf.org/sp#">
    <!ENTITY ldp "http://www.w3.org/ns/ldp#">
    <!ENTITY void "http://rdfs.org/ns/void#">
    <!ENTITY list "http://jena.hpl.hp.com/ARQ/list#">
]>
<xsl:stylesheet version="2.0"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xhtml="http://www.w3.org/1999/xhtml"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:gc="&gc;"
xmlns:rdf="&rdf;"
xmlns:rdfs="&rdfs;"
xmlns:owl="&owl;"
xmlns:sparql="&sparql;"
xmlns:dct="&dct;"
xmlns:foaf="&foaf;"
xmlns:sioc="&sioc;"
xmlns:sp="&sp;"
xmlns:ldp="&ldp;"
xmlns:void="&void;"
xmlns:list="&list;"
exclude-result-prefixes="#all">

    <xsl:import href="../../../org/graphity/client/writer/functions.xsl"/>
    <xsl:import href="../../../org/graphity/client/writer/group-sort-triples.xsl"/>
    <xsl:import href="../../../org/graphity/client/writer/local-xhtml.xsl"/>

    <rdf:Description rdf:about="">
	<dct:created rdf:datatype="&xsd;dateTime">2013-06-17T15:25:00+02:00</dct:created>
    </rdf:Description>

    <xsl:template match="/" mode="gc:HeaderMode">
	<button class="btn btn-navbar" onclick="if ($('#collapsing-navbar').hasClass('in')) $('#collapsing-navbar').removeClass('collapse in').height(0); else $('#collapsing-navbar').addClass('collapse in').height('auto');">
	    <span class="icon-bar"></span>
	    <span class="icon-bar"></span>
	    <span class="icon-bar"></span>
	</button>

	<a class="brand" href="{$base-uri}">
	    <xsl:apply-templates select="key('resources', $base-uri, $ont-model)/@rdf:about"/>
	</a>

	<div id="collapsing-navbar" class="nav-collapse collapse">
	    <ul class="nav">
		<!-- make menu links for all resources in the ontology, except base URI -->
		<xsl:for-each select="key('resources-by-space', $base-uri, $ont-model)/@rdf:about[not(. = $base-uri)]">
		    <xsl:sort select="gc:label(., /, $lang)" data-type="text" order="ascending" lang="{$lang}"/>
		    <li>
			<xsl:if test=". = $absolute-path">
			    <xsl:attribute name="class">active</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="."/>
		    </li>
		</xsl:for-each>
	    </ul>

	    <xsl:if test="key('resources', $base-uri, $ont-model)/rdfs:isDefinedBy/@rdf:resource | key('resources', key('resources', $base-uri, $ont-model)/void:inDataset/@rdf:resource, $ont-model)/void:sparqlEndpoint/@rdf:resource">
		<ul class="nav pull-right">
		    <xsl:for-each select="key('resources', $base-uri, $ont-model)/rdfs:isDefinedBy/@rdf:resource | key('resources', key('resources', $base-uri, $ont-model)/void:inDataset/@rdf:resource, $ont-model)/void:sparqlEndpoint/@rdf:resource">
			<xsl:sort select="gc:label(., /, $lang)" data-type="text" order="ascending" lang="{$lang}"/>
			<li>
			    <xsl:if test=". = $absolute-path">
				<xsl:attribute name="class">active</xsl:attribute>
			    </xsl:if>
			    <xsl:apply-templates select="."/>
			</li>
		    </xsl:for-each>
		</ul>
	    </xsl:if>
	</div>
    </xsl:template>

</xsl:stylesheet>