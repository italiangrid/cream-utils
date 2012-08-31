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

   if [ $# -lt 7 -o $# -gt 8 ]; then
         echo 1>&2 "Usage: $0 userDB pswDB DBName version isStoredProcedures creationScript hostDB [sandboxPath]"
         echo 1>&2 "isStoredProcedures must be 'S' or 'N'."
         echo 1>&2 "[sandboxPath] is an optional parameter. It must be ONLY used to remove the sandbox directory." 
         exit -1
    fi

if [ "$5" != 'S' -a "$5" != 'N' ] ; then
   echo 1>&2 "isStoredProcedures must be 'S' or 'N'."
   exit -1
fi

versionMustBe="$4"
echo "$3 version requested by the service is $versionMustBe"
isStoredProcedures="$5"
creationScript="$6"
hostDB="$7"
sandboxPath="$8"

object="database"
dbField="version"
if [ $isStoredProcedures == 'S' ] ; then
  object="stored procedures"
  dbField="stored_proc_version"
fi

versionFromDb=`mysql -N -B --host $hostDB --user="$1" --password="$2" -D "$3" -e "select $dbField from db_info;" 2>&1`
exitCode=$?
if [ "$exitCode" -ne 0 ]
then 
  echo "Impossible to retrieve the version of $3 $object. $object will be created from scratch."
  versionFromDb=0
else
  echo "The version retrieved from the $3 database is $versionFromDb"
fi

if [ "$exitCode" -ne 0 -o X"$versionMustBe" != X"$versionFromDb" ]
then
  echo "Creating/Updating $3 $object ..."
  mysql --host $hostDB --user="$1" --password="$2" < "$creationScript"
  exitCode=$?
  if [  "$exitCode" -ne 0 ]
  then
    echo "An error occurred on the creation of the $object"
    exit -1
  fi
  echo "$3 $object created!"
  if [ $sandboxPath -a -d $sandboxPath ] ; then
    # remove sandbox directory
    echo "Removing sandbox directory ..."
    mv $sandboxPath ${sandboxPath}_old
    rm -rf ${sandboxPath}_old &
  fi
else
  echo "The $3 $object is synchronized with the one requested by the service"
fi

