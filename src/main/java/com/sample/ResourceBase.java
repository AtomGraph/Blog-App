/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sample;

import com.hp.hpl.jena.ontology.OntModel;
import com.sun.jersey.api.core.ResourceConfig;
import javax.ws.rs.DefaultValue;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.UriInfo;
import org.graphity.server.model.SPARQLEndpoint;

/**
 *
 * @author Martynas Jusevičius <martynas@graphity.org>
 */
public class ResourceBase extends org.graphity.client.model.ResourceBase
{

    public ResourceBase(@Context UriInfo uriInfo, @Context Request request, @Context HttpHeaders httpHeaders, @Context ResourceConfig resourceConfig,
	    @Context OntModel sitemap, @Context SPARQLEndpoint endpoint,
	    @QueryParam("limit") @DefaultValue("20") Long limit,
	    @QueryParam("offset") @DefaultValue("0") Long offset,
	    @QueryParam("order-by") String orderBy,
	    @QueryParam("desc") @DefaultValue("false") Boolean desc)
    {
	super(uriInfo, request, httpHeaders, resourceConfig, sitemap, endpoint, limit, offset, orderBy, desc);
    }
    
}
