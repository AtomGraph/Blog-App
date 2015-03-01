/**
 *  Copyright 2014 Martynas Jusevičius <martynas@graphity.org>
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

package org.graphity.blog;

import com.hp.hpl.jena.ontology.OntClass;
import com.hp.hpl.jena.rdf.model.Model;
import com.sun.jersey.api.core.ResourceContext;
import javax.servlet.ServletConfig;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.UriInfo;
import org.graphity.core.model.GraphStore;
import org.graphity.core.model.SPARQLEndpoint;

/**
 * Base class of all Blog app resources.
 * 
 * @author Martynas Jusevičius <martynas@graphity.org>
 */
@Path("/")
public class ResourceBase extends org.graphity.client.model.impl.ResourceBase
{

    public ResourceBase(@Context UriInfo uriInfo, @Context Request request, @Context ServletConfig servletConfig,
            @Context SPARQLEndpoint endpoint, @Context GraphStore graphStore,
            @Context OntClass matchedOntClass, @Context HttpHeaders httpHeaders, @Context ResourceContext resourceContext)
    {
	super(uriInfo, request, servletConfig,
                endpoint, graphStore,
                matchedOntClass, httpHeaders, resourceContext);
    }
    
    @Override
    public ResponseBuilder getResponseBuilder(Model model)
    {
	return super.getResponseBuilder(model).header("X-Powered-By", "http://graphityhq.com");
    }

}