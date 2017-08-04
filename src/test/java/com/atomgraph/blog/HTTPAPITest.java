/**
 *  Copyright 2017 Martynas Jusevičius <martynas@atomgraph.com>
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

import com.atomgraph.client.MediaTypes;
import com.atomgraph.server.Application;
import com.sun.jersey.api.client.config.DefaultClientConfig;
import com.sun.jersey.api.container.grizzly2.GrizzlyServerFactory;
import com.sun.jersey.api.core.ApplicationAdapter;
import com.sun.jersey.api.core.ResourceConfig;
import java.io.IOException;
import java.net.URI;
import javax.ws.rs.core.UriBuilder;
import org.apache.jena.query.Dataset;
import org.apache.jena.query.DatasetFactory;
import org.apache.jena.rdf.model.Model;
import org.apache.jena.rdf.model.ModelFactory;
import org.apache.jena.riot.Lang;
import org.apache.jena.riot.RDFDataMgr;
import org.apache.jena.util.LocationMapper;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 *
 * @author Martynas Jusevičius <martynas@atomgraph.com>
 */
public class HTTPAPITest
{

    private final static String RULES = "[inh:   (?class rdf:type <http://www.w3.org/2000/01/rdf-schema#Class>), (?class ?p ?o), (?p rdf:type <https://www.w3.org/ns/ldt#InheritedProperty>), (?subClass rdfs:subClassOf ?class), (?subClass rdf:type <http://www.w3.org/2000/01/rdf-schema#Class>), noValue(?subClass ?p) -> (?subClass ?p ?o) ]\n" +
"[rdfs9: (?x rdfs:subClassOf ?y), (?a rdf:type ?x) -> (?a rdf:type ?y)]";
    
    private static URI getBaseURI()
    {
        return UriBuilder.fromUri("http://localhost/").port(9998).build();
    }

    @BeforeClass
    public static void startServer() throws IOException
    {
        Dataset dataset = DatasetFactory.createTxnMem();
        // no base URI at this point, dataset URIs must be absolute            
        RDFDataMgr.read(dataset, HTTPAPITest.class.getResourceAsStream("dataset.trig"), Lang.TRIG);
            
        Model mapping = ModelFactory.createDefaultModel();
        RDFDataMgr.read(mapping, HTTPAPITest.class.getResourceAsStream("/location-mapping.n3"), Lang.N3);
        
        Application app = new Application(dataset, null, null, null, null,
            new MediaTypes(), Application.getClient(new DefaultClientConfig()), null, false,
                Application.getFileManager(new LocationMapper(mapping)),
        "http://atomgraph.com/blog/ns#", RULES, true);
        app.init();
        ResourceConfig rc = new ApplicationAdapter(app);
        GrizzlyServerFactory.createHttpServer(getBaseURI(), rc);
    }
    
    @Test
    public void testGETOK()
    {
        
    }
}
