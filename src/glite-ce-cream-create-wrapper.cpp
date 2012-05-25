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

/**
 C++ STL includes
*/
#include <iostream>
#include <fstream>
#include <cerrno>
#include <cstdlib>
#include <cstring>

#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>

using namespace std;

void checkErrno(const int errorNum) {
   if(errorNum != 0) {
      int saveerr = errno;
      if(saveerr != EEXIST) {
         cerr << strerror(errno) << endl;
         exit(1);
      }
   }
}

int main(int argc, char* argv[]) {
    if(argc<1) {
        cerr << "invalid argument!" << endl;
        return 1;
    }

    char *wrapperPath = argv[1];

    if(wrapperPath == NULL || strlen(wrapperPath) == 0) {
        cerr << "wrong path" << endl;
        return 1;
    }   

    int c;
    FILE *output = fopen(wrapperPath, "w");
    if(!output) {
        cerr << strerror(errno) << endl;
        return 1;
    }

    while((c=getc(stdin)) != EOF) {
        if(fputc(c, output) == EOF) {
            cerr << strerror(errno) << endl;
            return 1;
       }
    }

    fclose(output);
    chmod(wrapperPath, 0700);

    return 0;
} 
