#
#  Copyright (c) Members of the EGEE Collaboration. 2010.
#  See http://www.eu-egee.org/partners/ for details on the copyright
#  holders.
#  
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#  
#     http://www.apache.org/licenses/LICENSE-2.0
#  
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#  implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#  

install(FILES ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-computingservice-static
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-endpoint-static
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-endpoint-dynamic
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-executionenvironment-static
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-manager-static
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-share-static
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-benchmark-static
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-tostorageservice-static
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-glue2-applicationenvironment-dynamic
              ${CMAKE_SOURCE_DIR}/scripts/glite-ce-check-submission-state
              ${CMAKE_SOURCE_DIR}/scripts/lcg-info-dynamic-software
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE
                    GROUP_READ GROUP_EXECUTE
                    WORLD_READ WORLD_EXECUTE
        DESTINATION usr/libexec)

install(FILES ${CMAKE_SOURCE_DIR}/scripts/glite_cream_load_monitor
              ${CMAKE_SOURCE_DIR}/scripts/glite-cream-copyProxyToSandboxDir.sh
              ${CMAKE_SOURCE_DIR}/scripts/glite-cream-purger.sh
              ${CMAKE_SOURCE_DIR}/scripts/createAndPopulateDB.sh
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE
                    GROUP_READ GROUP_EXECUTE
                    WORLD_READ WORLD_EXECUTE
        DESTINATION usr/bin)

install(FILES ${CMAKE_SOURCE_DIR}/scripts/JobDBAdminPurger.sh
        PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE
                    GROUP_READ GROUP_EXECUTE
                    WORLD_READ WORLD_EXECUTE
        DESTINATION usr/sbin)

