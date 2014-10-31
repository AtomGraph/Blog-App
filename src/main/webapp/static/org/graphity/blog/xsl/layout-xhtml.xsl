<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright 2014 Martynas Jusevičius <martynas@graphity.org>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY java   "http://xml.apache.org/xalan/java/">
    <!ENTITY gc     "http://graphity.org/gc#">
    <!ENTITY gp     "http://graphity.org/gp#">
    <!ENTITY rdf    "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <!ENTITY rdfs   "http://www.w3.org/2000/01/rdf-schema#">
    <!ENTITY xsd    "http://www.w3.org/2001/XMLSchema#">
    <!ENTITY owl    "http://www.w3.org/2002/07/owl#">
    <!ENTITY skos   "http://www.w3.org/2004/02/skos/core#">
    <!ENTITY sparql "http://www.w3.org/2005/sparql-results#">
    <!ENTITY ldp    "http://www.w3.org/ns/ldp#">
    <!ENTITY dct    "http://purl.org/dc/terms/">
    <!ENTITY foaf   "http://xmlns.com/foaf/0.1/">
    <!ENTITY sioc   "http://rdfs.org/sioc/ns#">
    <!ENTITY sp     "http://spinrdf.org/sp#">
    <!ENTITY spin   "http://spinrdf.org/spin#">
    <!ENTITY list   "http://jena.hpl.hp.com/ARQ/list#">
]>
<xsl:stylesheet version="2.0"
xmlns="http://www.w3.org/1999/xhtml"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xhtml="http://www.w3.org/1999/xhtml"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:gc="&gc;"
xmlns:gp="&gp;"
xmlns:rdf="&rdf;"
xmlns:rdfs="&rdfs;"
xmlns:owl="&owl;"
xmlns:sparql="&sparql;"
xmlns:skos="&skos;"
xmlns:dct="&dct;"
xmlns:foaf="&foaf;"
xmlns:sioc="&sioc;"
xmlns:sp="&sp;"
xmlns:ldp="&ldp;"
xmlns:list="&list;"
exclude-result-prefixes="#all">

    <xsl:import href="../../client/xsl/functions.xsl"/>
    <xsl:import href="../../client/xsl/group-sort-triples.xsl"/>
    <xsl:import href="../../client/xsl/local-xhtml.xsl"/>

    <xsl:preserve-space elements="sioc:content skos:prefLabel"/>

    <rdf:Description rdf:about="">
	<dct:created rdf:datatype="&xsd;dateTime">2014-10-09T23:35:00+01:00</dct:created>
    </rdf:Description>
    
    <xsl:template match="sioc:content/text()" mode="gc:EditMode">
        <textarea name="ol" id="{generate-id(..)}" rows="10" style="font-family: monospace;">
            <xsl:value-of select="normalize-space(.)"/>
        </textarea>
        
        <xsl:choose>
            <xsl:when test="../@rdf:datatype">
                <xsl:apply-templates select="../@rdf:datatype" mode="gc:InlineMode"/>
            </xsl:when>
            <xsl:otherwise>
                <span class="help-inline">Literal</span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="dct:subject/@rdf:resource | dct:subject/@rdf:nodeID" mode="gc:EditMode">
        <select name="ou" id="{generate-id(..)}" multiple="multiple" size="8">
            <xsl:apply-templates select="key('resources-by-type', '&skos;Concept', document(resolve-uri('categories?limit=100', $base-uri)))" mode="gc:OptionMode">
                <xsl:sort select="gc:label(.)" order="ascending"/>
                <xsl:with-param name="selected" select="../@rdf:resource"/>
            </xsl:apply-templates>
        </select>

        <span class="help-inline">Resource</span>
    </xsl:template>
    
</xsl:stylesheet>