<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright 2012 Martynas Jusevičius <martynas@graphity.org>

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
    <!ENTITY owl    "http://www.w3.org/2002/07/owl#">
    <!ENTITY sparql "http://www.w3.org/2005/sparql-results#">
    <!ENTITY xsd    "http://www.w3.org/2001/XMLSchema#">
    <!ENTITY dct    "http://purl.org/dc/terms/">
    <!ENTITY foaf   "http://xmlns.com/foaf/0.1/">
    <!ENTITY sioc   "http://rdfs.org/sioc/ns#">
    <!ENTITY sp     "http://spinrdf.org/sp#">
    <!ENTITY ldp    "http://www.w3.org/ns/ldp#">
    <!ENTITY void   "http://rdfs.org/ns/void#">
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
xmlns:dct="&dct;"
xmlns:foaf="&foaf;"
xmlns:sioc="&sioc;"
xmlns:sp="&sp;"
xmlns:ldp="&ldp;"
xmlns:void="&void;"
xmlns:list="&list;"
exclude-result-prefixes="#all">

    <xsl:import href="../../client/xsl/functions.xsl"/>
    <xsl:import href="../../client/xsl/group-sort-triples.xsl"/>
    <xsl:import href="../../client/xsl/local-xhtml.xsl"/>

    <xsl:preserve-space elements="sioc:content"/>

    <rdf:Description rdf:about="">
	<dct:created rdf:datatype="&xsd;dateTime">2014-10-09T23:35:00+01:00</dct:created>
    </rdf:Description>

    <xsl:template match="*[starts-with(@rdf:about, $base-uri)]" mode="gc:ModeToggleMode" priority="1">
        <!-- <xsl:apply-imports/> -->
        
        <xsl:if test="not($mode = '&gc;CreateMode') and rdf:type/@rdf:resource = '&sioc;Container'">
            <div class="pull-right">
                <a class="btn btn-primary" href="{gc:document-uri(@rdf:about)}{gc:query-string((), xs:anyURI('&gc;CreateMode'))}">
                    <xsl:apply-templates select="key('resources', '&gc;CreateMode', document('&gc;'))" mode="gc:LabelMode"/>
                </a>
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="rdf:RDF[$absolute-path = resolve-uri('posts', $base-uri)]" mode="gc:CreateMode" priority="1">
        <form class="form-horizontal" method="post" action="{$absolute-path}?mode={encode-for-uri($mode)}" accept-charset="UTF-8">
	    <xsl:comment>This form uses RDF/POST encoding: http://www.lsrn.org/semweb/rdfpost.html</xsl:comment>
	    <xsl:call-template name="gc:InputTemplate">
		<xsl:with-param name="name" select="'rdf'"/>
		<xsl:with-param name="type" select="'hidden'"/>
	    </xsl:call-template>
            
            <xsl:apply-templates mode="#current"/>
            
	    <div class="form-actions">
		<button type="submit" class="btn btn-primary">Save</button>
	    </div>
	</form>
    </xsl:template>

    <xsl:template match="*[rdf:type/@rdf:resource = ('&sioc;Space', '&sioc;Container')]" mode="gc:CreateMode" priority="1">
        <xsl:param name="path" select="substring-after($absolute-path, $base-uri)" as="xs:string"/>
        <xsl:param name="template-uri" select="if (rdf:type/@rdf:resource = '&sioc;Container') then concat($path, '/', 'template.rdf') else 'template.rdf'" as="xs:string"/>

        <xsl:apply-imports>
            <xsl:with-param name="template" select="document($template-uri)" as="document-node()"/>
        </xsl:apply-imports>
    </xsl:template>
    
    <xsl:template match="sioc:content/text()" mode="gc:EditMode">
        <textarea name="ol" id="{generate-id(..)}" rows="10" style="font-family: monospace;">
            <xsl:value-of select="."/>
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

</xsl:stylesheet>