/**
 *  Copyright 2014 Martynas Jusevičius <martynas@atomgraph.com>
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

package com.atomgraph.blog;

import org.apache.jena.ontology.Ontology;
import org.apache.jena.rdf.model.Model;
import com.sun.jersey.api.core.ResourceContext;
import javax.servlet.ServletConfig;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.Request;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.UriInfo;
import com.atomgraph.core.MediaTypes;
import com.atomgraph.core.model.GraphStore;
import com.atomgraph.core.model.SPARQLEndpoint;
import com.atomgraph.processor.model.TemplateCall;

/**
 * Base class of all Blog app resources.
 * 
 * @author Martynas Jusevičius <martynas@atomgraph.com>
 */
@Path("/")
public class ResourceBase extends com.atomgraph.server.model.impl.ResourceBase
{

    public ResourceBase(@Context UriInfo uriInfo, @Context Request request, @Context ServletConfig servletConfig,
            @Context MediaTypes mediaTypes, @Context SPARQLEndpoint endpoint, @Context GraphStore graphStore,
            @Context Ontology ontology, @Context TemplateCall templateCall,
            @Context HttpHeaders httpHeaders, @Context ResourceContext resourceContext)
    {
	super(uriInfo, request, servletConfig,
                mediaTypes, endpoint, graphStore,
                ontology, templateCall,
                httpHeaders, resourceContext);
    }
    
    @Override
    public ResponseBuilder getResponseBuilder(Model model)
    {
	return super.getResponseBuilder(model).header("X-Powered-By", "http://atomgraph.com");
    }

}