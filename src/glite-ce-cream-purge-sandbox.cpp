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
#include <unistd.h>

/* -------------------------------------------------------------------------------------------------------
Author: Sergio Traldi, Luigi Zangrando

glite-ce-cream-purge-sandbox.c

EXAMPLE DIRECTORY TO PURGE: 
/opt/glite/var/cream_sandbox/<VO>/<DN>/<First2JobID>/<JobID>

THIS IS A SIPLE COMMAND TO DELETE THE CREAM SANDBOX LEAVE THERE BECAUSE THE DELEGATION WAS EXPIRED.

To Compile you can siple type from a shell:
 
shell>  cc glite-ce-cream-purge-sandbox.c -o glite-ce-cream-purge-sandbox

TO DO AS root:
shell> chown root.tomcat glite-ce-cream-purge-sandbox
shell> chmod 4550 glite-ce-cream-purge-sandbox


#####################################################################
INPUT 
--- the SANDBOX dir path
#####################################################################
   
------------------------------------------------------------------------------------------------------------------ */

main (int argc, char *argv[]) {
    const char *creamPrefix="CREAM";
    const char *creamEsPrefix="CR_ES";
    const char *command = "/bin/rm";

    if (argc != 2) {
        fprintf(stderr, "wrong argument, use: glite-ce-cream-purge-sandbox path\n");
        exit(1);
    }

    char *path = argv[1];

    if (path == NULL) {
        fprintf(stderr, "wrong argument: the path must be NOT NULL!\n");
        exit(1);
    }

    char *c = strstr(path, creamPrefix);

    if (c == NULL || strlen(c) != 14) {
       c = strstr(path, creamEsPrefix);

       if (c == NULL || strlen(c) != 14) {
          fprintf(stderr, "wrong path (%s)!\n", path);
          exit(1);
       }
    }

  //  char *commandExe = (char *)calloc(strlen(command) + strlen(path) + 1, sizeof(char));

  //  strcat(commandExe, command);
  //  strcat(commandExe, path);

  //  system(commandExe);

    const char* args[4];
    args[0] = "";//command;
    args[1] = "-rf";
    args[2] = path;
    args[3] = (char*)0;

    int returnCommand = execv( command, (char *const*)args );

    if (returnCommand == -1) {
       printf("Error: %s\n", strerror(errno));
    }

    exit(0);
}
