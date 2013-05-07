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

set(CMAKE_CXX_FLAGS_DEBUG "-g -Wall")

add_executable(glite-ce-cream-purge-proxy glite-ce-cream-purge-proxy.cpp)

add_executable(glite-ce-cream-purge-sandbox glite-ce-cream-purge-sandbox.cpp)

add_executable(glite-cream-createsandboxdir glite-cream-createsandboxdir.cpp)

add_executable(glite-ce-cream-create-wrapper glite-ce-cream-create-wrapper.cpp)


install(TARGETS glite-ce-cream-purge-sandbox
                glite-cream-createsandboxdir
                glite-ce-cream-create-wrapper
                glite-ce-cream-purge-proxy
        RUNTIME DESTINATION usr/bin)


