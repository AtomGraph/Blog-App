/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sample;

import java.util.HashSet;
import java.util.Set;
import org.graphity.client.ApplicationBase;
import org.graphity.client.model.SPARQLResourceBase;
import org.graphity.client.provider.DoesNotExistExceptionMapper;
import org.graphity.client.provider.NotFoundExceptionMapper;
import org.graphity.client.provider.QueryExceptionHTTPMapper;
import org.graphity.client.reader.RDFPostReader;
import org.graphity.client.util.DataManager;
import org.graphity.client.writer.ModelXSLTWriter;
import org.graphity.processor.provider.OntologyProvider;
import org.graphity.processor.provider.SPARQLEndpointProvider;
import org.graphity.server.auth.AuthenticationExceptionMapper;

/**
 *
 * @author Martynas Jusevičius <martynas@graphity.org>
 */
public class Application extends ApplicationBase
{
    private Set<Class<?>> classes = new HashSet<Class<?>>();
    private Set<Object> singletons = new HashSet<Object>();

    public Application()
    {
	classes.add(ResourceBase.class);
	classes.add(SPARQLResourceBase.class); // handles /sparql queries

	singletons.addAll(super.getSingletons());
	singletons.add(new RDFPostReader());
	singletons.add(new OntologyProvider());
	singletons.add(new SPARQLEndpointProvider());
	singletons.add(new DoesNotExistExceptionMapper());
	singletons.add(new NotFoundExceptionMapper());
	singletons.add(new QueryExceptionHTTPMapper());
	
	singletons.add(new AuthenticationExceptionMapper());

	singletons.add(new ModelXSLTWriter(DataManager.get())); // writes XHTML responses
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

}