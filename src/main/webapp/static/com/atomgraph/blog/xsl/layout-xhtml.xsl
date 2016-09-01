<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright 2014 Martynas Jusevičius <martynas@atomgraph.com>

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
    <!ENTITY g      "http://atomgraph.com/core/ns#">
    <!ENTITY gc     "http://atomgraph.com/client/ns#">
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
xmlns:g="&g;"
xmlns:rdf="&rdf;"
xmlns:rdfs="&rdfs;"
xmlns:owl="&owl;"
xmlns:sparql="&sparql;"
xmlns:skos="&skos;"
xmlns:dct="&dct;"
xmlns:foaf="&foaf;"
xmlns:sioc="&sioc;"
xmlns:sp="&sp;"
xmlns:list="&list;"
xmlns:bs2="http://graphity.org/xsl/bootstrap/2.3.2"
exclude-result-prefixes="#all">

    <xsl:import href="../../../../com/atomgraph/client/xsl/bootstrap/2.3.2/layout.xsl"/>

    <xsl:preserve-space elements="sioc:content skos:prefLabel"/>

    <rdf:Description rdf:about="">
	<dct:created rdf:datatype="&xsd;dateTime">2014-10-09T23:35:00+01:00</dct:created>
    </rdf:Description>

    <xsl:template match="sioc:content/text() | sioc:content/@rdf:nodeID[key('resources', .)/rdf:type/@rdf:resource = '&xsd;string']" mode="bs2:FormControl">
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

    <xsl:template match="dct:subject/@rdf:resource | dct:subject/@rdf:nodeID" mode="bs2:FormControl">
        <select name="ou" id="{generate-id(..)}" multiple="multiple" size="8">
            <xsl:apply-templates select="key('resources-by-type', '&skos;Concept', document(resolve-uri('categories?limit=100', $g:baseUri)))" mode="gc:OptionMode">
                <xsl:sort select="gc:label(.)" order="ascending"/>
                <xsl:with-param name="selected" select="../@rdf:resource"/>
            </xsl:apply-templates>
        </select>

        <span class="help-inline">Resource</span>
    </xsl:template>
    
</xsl:stylesheet>