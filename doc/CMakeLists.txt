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

find_file(DB_MANPAGES_STYLESHEET "docbook.xsl"
          PATHS "/usr/share/xml/docbook/stylesheet/docbook-xsl/manpages"
                "/usr/share/sgml/docbook/xsl-stylesheets/manpages")
if( NOT DB_MANPAGES_STYLESHEET )
    message(FATAL_ERROR "Cannot find stylesheet for man pages")
endif( NOT DB_MANPAGES_STYLESHEET )

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/glite_cream_load_monitor.1.gz
                   DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/glite_cream_load_monitor.xml
                   COMMAND xsltproc -o ${CMAKE_CURRENT_BINARY_DIR}/glite_cream_load_monitor.1
                                    ${DB_MANPAGES_STYLESHEET} 
                                    ${CMAKE_CURRENT_SOURCE_DIR}/glite_cream_load_monitor.xml
                   COMMAND gzip -f ${CMAKE_CURRENT_BINARY_DIR}/glite_cream_load_monitor.1)

add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/glite-ce-cream-purge-proxy.1.gz
                   DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/glite-ce-cream-purge-proxy.xml
                   COMMAND xsltproc -o ${CMAKE_CURRENT_BINARY_DIR}/glite-ce-cream-purge-proxy.1
                                    ${DB_MANPAGES_STYLESHEET} 
                                    ${CMAKE_CURRENT_SOURCE_DIR}/glite-ce-cream-purge-proxy.xml
                   COMMAND gzip -f ${CMAKE_CURRENT_BINARY_DIR}/glite-ce-cream-purge-proxy.1)
                   
add_custom_target(manpages ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/glite_cream_load_monitor.1.gz
                                       ${CMAKE_CURRENT_BINARY_DIR}/glite-ce-cream-purge-proxy.1.gz)


install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/
        DESTINATION usr/share/man/man1
        FILES_MATCHING PATTERN "*.1.gz"
        PATTERN "CMakeFiles" EXCLUDE)



