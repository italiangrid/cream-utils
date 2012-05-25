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

/**
 OS includes
*/
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <pwd.h>
#include <grp.h>
#include <sys/time.h>

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
    //time_t sinceEpoch = time(0); 

    if(argc<5) {
        cerr << "invalid argument!" << endl;
        return 1;
    }

    char *baseDir      = argv[1];
    char *userDN       = argv[2];
    char *jobId        = argv[3];
    char *createSubDir = argv[4];

    if(strlen(jobId) != 14) {
        cerr << "wrong jobId" << endl;
        return 1;
    }   

    struct passwd *pwbuf = getpwuid(getuid());

    if(!pwbuf) {
        cerr << strerror(errno) << endl;
        return 1;
    }

    string user      = pwbuf->pw_name;
    //gid_t  userGid   = pwbuf->pw_gid;
    struct group *gr = getgrgid(pwbuf->pw_gid);

    if(!gr) {
        cerr << strerror(errno) << endl;
        return 1;
    }

    char *userGroup = gr->gr_name;
    // allocate the memory fot the string containing the Directory Path to remove 
    char *directoryToCreate = (char *)calloc(strlen(baseDir) + strlen(userGroup) + strlen(userDN) + strlen(user.c_str()) + strlen(jobId) + 10, sizeof(char));

    strcat(directoryToCreate, baseDir);
    strcat(directoryToCreate, "/");

    /**
      It doesn't exist the "-p" behaviour, so must create all
      intermediate dirs.
    */
    int errOccurred=0;


    strcat(directoryToCreate, userGroup);
    strcat(directoryToCreate, "/");


    strcat(directoryToCreate, userDN);
    strcat(directoryToCreate, "_");
    strcat(directoryToCreate, user.c_str());
    strcat(directoryToCreate, "/");

    errOccurred = mkdir(directoryToCreate, 0700);
    checkErrno(errOccurred);

    if(strcmp(createSubDir, "true") == 0) {
        char *first2charJobId = (char*)calloc(3,sizeof(char));
        strncpy(first2charJobId, jobId+5,2);

        strcat(directoryToCreate, first2charJobId);
        strcat(directoryToCreate, "/");

        errOccurred = mkdir(directoryToCreate, 0700);
        checkErrno(errOccurred);
    }

    strcat(directoryToCreate, jobId);

    errOccurred = mkdir(directoryToCreate, 0700);
    checkErrno(errOccurred);

    string jobDir = directoryToCreate;

    errOccurred = mkdir((jobDir + "/ISB").c_str(), 0700);
    checkErrno(errOccurred);

    errOccurred = mkdir((jobDir + "/OSB").c_str(), 0700);
    checkErrno(errOccurred);

    cout << jobDir << endl;
    cout << user << endl;
    //cout << ctime(&sinceEpoch) << endl; 


    char *c = strstr(jobId, "CREAM");

    if (c != NULL) {
        FILE *output = fopen((jobDir + "/" + jobId + "_jobWrapper.sh").c_str(), "w");
        if(!output) {
            cerr << strerror(errno) << endl;
            return 1;
        }

        int x = 0;

        while((x=getc(stdin)) != EOF) {
            if(fputc(x, output) == EOF) {
                cerr << strerror(errno) << endl;
                return 1;
           }
        }

        fclose(output);
        chmod((jobDir + "/" + jobId + "_jobWrapper.sh").c_str(), 0700);
    }

    return 0;
} 
