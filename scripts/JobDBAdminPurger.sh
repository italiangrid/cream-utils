#!/bin/sh

#  Copyright (c) Members of the EGEE Collaboration. 2004. 
#  See http://www.eu-egee.org/partners/ for details on the copyright
#  holders.  
#  
#  Licensed under the Apache License, Version 2.0 (the "License"); 
#  you may not use this file except in compliance with the License. 
#  You may obtain a copy of the License at 
#  
#      http://www.apache.org/licenses/LICENSE-2.0 
#  
#  Unless required by applicable law or agreed to in writing, software 
#  distributed under the License is distributed on an "AS IS" BASIS, 
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
#  See the License for the specific language governing permissions and 
#  limitations under the License.

classPath=/usr/share/java/glite-ce-cream-clients.jar
classPath=${classPath}:/usr/share/java/glite-ce-common-java.jar
classPath=${classPath}:/usr/share/java/glite-ce-cream-api-java.jar
classPath=${classPath}:/usr/share/java/glite-ce-cream-blahExecutor.jar
classPath=${classPath}:/usr/share/java/glite-ce-cream-core.jar
classPath=${classPath}:/usr/share/java/argus-pep-api-java.jar
classPath=${classPath}:/usr/share/java/argus-pep-common.jar
if [ -e /usr/share/java/voms-api-java/voms-api-java.jar ] ; then
    classPath=${classPath}:/usr/share/java/voms-api-java/voms-api-java.jar
fi
if [ -e /usr/share/java/voms-api-java3.jar ] ; then
    classPath=${classPath}:/usr/share/java/voms-api-java3.jar
fi
if [ -e /usr/share/java/canl.jar ] ; then
    classPath=${classPath}:/usr/share/java/canl.jar
fi
if [ -e /usr/share/java/canl-java/canl.jar ] ; then
    classPath=${classPath}:/usr/share/java/canl-java/canl.jar
fi
if [ -e /usr/share/java/jakarta-commons-httpclient.jar ] ; then
    classPath=${classPath}:/usr/share/java/jakarta-commons-httpclient.jar
fi
classPath=${classPath}:/usr/share/java/mysql-connector-java.jar
classPath=${classPath}:/usr/share/java/servlet.jar
classPath=${classPath}:/usr/share/java/commons-logging.jar
if [ -e /usr/share/java/apache-commons-dbcp.jar ] ; then
    classPath=${classPath}:/usr/share/java/apache-commons-dbcp.jar
fi
if [ -e /usr/share/java/commons-dbcp.jar ] ; then
    classPath=${classPath}:/usr/share/java/commons-dbcp.jar
fi
if [ -e /usr/share/java/apache-commons-pool.jar ] ; then
    classPath=${classPath}:/usr/share/java/apache-commons-pool.jar
fi
if [ -e /usr/share/java/commons-pool.jar ] ; then
    classPath=${classPath}:/usr/share/java/commons-pool.jar
fi
classPath=${classPath}:/usr/share/java/log4j.jar
classPath=${classPath}:/usr/share/java/bcprov.jar

if [ -e /etc/glite-ce-cream/log4j.properties ] ; then
    java -cp $classPath -Dlog4j.configuration=/etc/glite-ce-cream/log4j.properties org.glite.ce.cream.client.JobDBAdminPurger $@
else
    java -cp $classPath org.glite.ce.cream.client.JobDBAdminPurger $@
fi




