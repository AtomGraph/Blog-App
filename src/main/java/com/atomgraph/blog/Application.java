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

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.ServletConfig;
import javax.ws.rs.core.Context;

/**
 *
 * @author Martynas Jusevičius <martynas@atomgraph.com>
 */
public class Application extends com.atomgraph.node.Application
{
    
    private final Set<Class<?>> classes = new HashSet<>();
    
    public Application(@Context ServletConfig servletConfig) throws URISyntaxException, IOException
    {
        super(servletConfig);
        
        classes.add(ResourceBase.class);
    }
    
    @Override
    public Set<Class<?>> getClasses()
    {
        return classes;
    }
    
}
