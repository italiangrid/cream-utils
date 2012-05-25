/*
  Copyright (c) Members of the EGEE Collaboration. 2004. 
  See http://www.eu-egee.org/partners/ for details on the copyright
  holders.  
  
  Licensed under the Apache License, Version 2.0 (the "License"); 
  you may not use this file except in compliance with the License. 
  You may obtain a copy of the License at 
  
      http://www.apache.org/licenses/LICENSE-2.0 
  
  Unless required by applicable law or agreed to in writing, software 
  distributed under the License is distributed on an "AS IS" BASIS, 
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
  See the License for the specific language governing permissions and 
  limitations under the License.
*/

#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdbool.h>
#include <sys/types.h>
#include <unistd.h>

/* -------------------------------------------------------------------------------------------------------
Author: L. Zangrando

glite-ce-cream-purge-proxy.c

EXAMPLE DIRECTORY TO PURGE: 
/opt/glite/var/cream_sandbox/<VO>/<DN>/proxy/<proxy_name>

THIS IS A SIPLE COMMAND TO BE INVOKED WHENEVER THE DELEGATION IS EXPIRED.

To Compile you can siple type from a shell:
 
shell>  cc glite-ce-cream-purge-proxy.c -o glite-ce-cream-purge-proxy

TO DO AS root:
shell> chown root.tomcat glite-ce-cream-purge-proxy
shell> chmod 4550 glite-ce-cream-purge-proxy


#####################################################################
INPUT 
--- the proxy path
#####################################################################
   
------------------------------------------------------------------------------------------------------------------ */

main (int argc, char *argv[]) {
    const char *prefix="/proxy/";
    const char *command = "/bin/rm";

    if (argc != 2) {
        fprintf(stderr, "wrong argument, use: glite-ce-cream-purge-proxy path\n");
        exit(1);
    }

    char *path = argv[1];

    if (path == NULL) {
        fprintf(stderr, "wrong argument: the path must be NOT NULL!\n");
        exit(1);
    }

    char *c = strstr(path, prefix);

    if (c == NULL) {
        fprintf(stderr, "wrong path (%s)!\n", path);
        exit(1);
    }

    const char* args[4];
    args[0] = ""; //command;
    args[1] = "-rf";
    args[2] = path;
    args[3] = (char*)0;

    setuid(0);
    int returnCommand = execv(command, (char *const*)args);

    if (returnCommand == -1) {
        printf("Error: %s\n", strerror(errno));
    }

    exit(0);
}
