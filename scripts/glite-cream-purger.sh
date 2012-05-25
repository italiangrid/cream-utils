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

$JAVA_HOME/bin/java -classpath \
$GLITE_LOCATION/share/java/glite-ce-cream.jar:\
$GLITE_LOCATION/share/java/glite-ce-cream-api-java-common.jar:\
$GLITE_LOCATION/share/java/glite-ce-common-java-jndi.jar:\
$GLITE_LOCATION/share/java/log4j-1.2.8.jar:\
$CATALINA_HOME/webapps/ce-cream/WEB-INF/lib/glite-ce-cream-api-java.jar:\
$CATALINA_HOME/webapps/ce-cream/WEB-INF/lib/glite-ce-common-java.jar:\
$GLITE_LOCATION/share/java/classad.jar:\
$GLITE_LOCATION/share/java/glite-jdl-api-java.jar:\
$CATALINA_HOME/webapps/ce-cream/WEB-INF/lib/axis.jar \
org.glite.ce.cream.listener.JobCleaner  $1


