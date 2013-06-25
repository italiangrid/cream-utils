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

if [ -z "${CATALINA_HOME}" ]; then
  echo "CATALINA_HOME must be set!"
  exit -1
fi

tomcat_version=""
for i in /etc/tomcat*; do
  if [ -d "$i" ]; then
     tomcat_version=`echo $i | sed -e 's/\/etc\///'`
     break
  fi
done

classPath=/usr/share/java/glite-ce-cream-clients.jar
classPath=${classPath}:/usr/share/java/glite-ce-common-java.jar
classPath=${classPath}:/usr/share/java/glite-ce-cream-api-java.jar
classPath=${classPath}:/usr/share/java/glite-ce-cream-blahExecutor.jar
classPath=${classPath}:/usr/share/java/glite-ce-cream-core.jar
classPath=${classPath}:/usr/share/java/argus-pep-api-java.jar
classPath=${classPath}:/usr/share/java/argus-pep-common.jar
classPath=${classPath}:/usr/share/java/voms-api-java3.jar
classPath=${classPath}:/usr/share/java/jakarta-commons-httpclient.jar
classPath=${classPath}:/usr/share/java/mysql-connector-java.jar
classPath=${classPath}:/usr/share/java/servlet.jar

if [ $tomcat_version == "tomcat6" ];then
    classPath_Tomcat=/usr/share/java/commons-logging.jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/lib/commons-dbcp.jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/lib/commons-pool.jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/lib/log4j.jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/lib/bcprov.jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/lib/canl.jar
else
    classPath_Tomcat=$CATALINA_HOME/common/lib/[commons-dbcp].jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/common/lib/[commons-pool].jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/server/lib/[commons-logging].jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/server/lib/[log4j].jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/server/lib/[bcprov].jar
    classPath_Tomcat=${classPath_Tomcat}:$CATALINA_HOME/server/lib/canl.jar
fi

classPath=$classPath:$classPath_Tomcat

if [ -e /etc/glite-ce-cream/log4j.properties ] ; then
    java -cp $classPath -Dlog4j.configuration=/etc/glite-ce-cream/log4j.properties org.glite.ce.cream.client.JobDBAdminPurger $@
else
    java -cp $classPath org.glite.ce.cream.client.JobDBAdminPurger $@
fi




