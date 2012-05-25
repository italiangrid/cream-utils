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

classPath=/usr/share/java/glite-ce-cream-clients.jar:/usr/share/java/glite-ce-common-java.jar:/usr/share/java/glite-ce-cream-api-java.jar:/usr/share/java/glite-ce-cream-blahExecutor.jar:/usr/share/java/glite-ce-cream-core.jar:/usr/share/java/argus-pep-api-java.jar:/usr/share/java/argus-pep-common.jar:/usr/share/java/voms-api-java.jar:/usr/share/java/jakarta-commons-httpclient.jar:/usr/share/java/mysql-connector-java.jar:/usr/share/java/servlet.jar

if [ $tomcat_version == "tomcat6" ];then
   classPath_Tomcat=$CATALINA_HOME/lib/commons-dbcp.jar:$CATALINA_HOME/lib/commons-pool.jar:$CATALINA_HOME/lib/commons-logging.jar:$CATALINA_HOME/lib/log4j.jar:$CATALINA_HOME/lib/[bcprov].jar:$CATALINA_HOME/lib/[trustmanager].jar
else
   classPath_Tomcat=$CATALINA_HOME/common/lib/[commons-dbcp].jar:$CATALINA_HOME/common/lib/[commons-pool].jar:$CATALINA_HOME/server/lib/[commons-logging].jar:$CATALINA_HOME/server/lib/[log4j].jar:$CATALINA_HOME/server/lib/[bcprov].jar:$CATALINA_HOME/server/lib/[trustmanager].jar
fi

classPath=$classPath:$classPath_Tomcat

java -cp $classPath org.glite.ce.cream.client.JobDBAdminPurger $@



