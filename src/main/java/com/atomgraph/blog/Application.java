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

package com.atomgraph.blog;

import org.apache.jena.util.FileManager;
import org.apache.jena.util.LocationMapper;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletConfig;
import javax.ws.rs.core.Context;
import org.graphity.client.provider.DataManagerProvider;
import org.graphity.client.provider.MediaTypesProvider;
import org.graphity.client.provider.TemplatesProvider;
import org.graphity.client.writer.ModelXSLTWriter;
import org.graphity.core.provider.ClientProvider;
import org.graphity.core.provider.QueryParamProvider;
import org.graphity.core.provider.ResultSetProvider;
import org.graphity.core.provider.UpdateRequestReader;
import org.graphity.core.util.jena.DataManager;
import org.graphity.core.vocabulary.G;
import org.graphity.server.mapper.ClientExceptionMapper;
import org.graphity.server.mapper.ConfigurationExceptionMapper;
import org.graphity.server.mapper.ModelExceptionMapper;
import org.graphity.server.mapper.NotFoundExceptionMapper;
import org.graphity.server.mapper.SPINArgumentExceptionMapper;
import org.graphity.server.mapper.jena.DatatypeFormatExceptionMapper;
import org.graphity.server.mapper.jena.QueryParseExceptionMapper;
import org.graphity.server.mapper.jena.RiotExceptionMapper;
import org.graphity.server.provider.DatasetProvider;
import org.graphity.server.provider.GraphStoreOriginProvider;
import org.graphity.server.provider.GraphStoreProvider;
import org.graphity.server.provider.OntologyProvider;
import org.graphity.server.provider.SPARQLEndpointOriginProvider;
import org.graphity.server.provider.SPARQLEndpointProvider;
import org.graphity.server.provider.SkolemizingModelProvider;
import org.graphity.server.provider.TemplateCallProvider;

/**
 * JAX-RS application class of the Blog app.
 * 
 * @author Martynas Jusevičius <martynas@graphity.org>
 */
public class Application extends org.graphity.server.Application
{
    private final Set<Class<?>> classes = new HashSet<>();
    private final Set<Object> singletons = new HashSet<>();
    
    public Application(@Context ServletConfig servletConfig)
    {
        super(servletConfig);
        
	classes.add(ResourceBase.class);

        singletons.add(new org.graphity.core.provider.DataManagerProvider());        
        // Server singletons
	singletons.add(new SkolemizingModelProvider());
	singletons.add(new ResultSetProvider());
	singletons.add(new QueryParamProvider());
	singletons.add(new UpdateRequestReader());
        singletons.add(new org.graphity.core.provider.DataManagerProvider());
        singletons.add(new DatasetProvider());
        singletons.add(new ClientProvider());
        singletons.add(new OntologyProvider(servletConfig));
        singletons.add(new TemplateCallProvider());
	singletons.add(new SPARQLEndpointProvider());
	singletons.add(new SPARQLEndpointOriginProvider());
        singletons.add(new GraphStoreProvider());
        singletons.add(new GraphStoreOriginProvider());
        singletons.add(new RiotExceptionMapper());
	singletons.add(new ModelExceptionMapper());
	singletons.add(new DatatypeFormatExceptionMapper());
        singletons.add(new NotFoundExceptionMapper());
        singletons.add(new ClientExceptionMapper());        
        singletons.add(new ConfigurationExceptionMapper());
        singletons.add(new SPINArgumentExceptionMapper());
	singletons.add(new QueryParseExceptionMapper());
        // Client singletons
        singletons.add(new MediaTypesProvider());
        singletons.add(new org.graphity.client.provider.DataManagerProvider());
	singletons.add(new ModelXSLTWriter()); // writes XHTML responses
	singletons.add(new TemplatesProvider(servletConfig)); // loads XSLT stylesheet
    }
    
    @Override
    public Set<Class<?>> getClasses()
    {
	return classes;
    }

    @Override
    public Set<Object> getSingletons()
    {
	return singletons;
    }

    @Override
    public FileManager getFileManager()
    {
        DataManager manager = new DataManager(LocationMapper.get(), new MediaTypesProvider().getMediaTypes(),
                getBooleanParam(getServletConfig(), G.cacheModelLoads),
                getBooleanParam(getServletConfig(), G.preemptiveAuth));
        FileManager.setStdLocators(manager);
        return manager;
    }
    
}