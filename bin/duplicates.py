#!/usr/bin/env python

# Purpose: find the duplicate files with diffrent name but same 
# MD5 sum.

# Operation: for each file, store the MD5 as a key and the file name
# as value in a hash table. On collision, print the both file names 
# with the same MD5.

# Usage: python script_name.py /tmp/dir/where/to/find/stuff

# TODO: Python 3!!! Could be using the real print function instead of
#       "print chevron"

# History:
# 2010-03-07: First version. Needs improvements for subfolders. See 
#             TODO notes.
# 2012-08-09: Improved the behavior for subfolders. Now it goes into the
#             subfolder and adds the files to the list.
# 2012-08-10: Adding command line arguments to get the directory (really 
#             basic, should use proper getopts)
# 2012-08-11: replacing #!/usr/bin/python by #!/usr/bin/env python for
#             portability best practices.
# 2012-08-13: writing to stderr on error. Checking each single file (not 
#             just the parent directory) for readability.
# 

## since 2.5, import md5 is deprecated, use hashlib instead
##import md5

import os
import hashlib
import sys

if (len(sys.argv) < 2):
    print "USAGE: python " + sys.argv[0] + " /tmp/dir/where/to/find/stuff"
else:
    
    # important: check if the directory exists (F_OK) and is readable (R_OK)
    if (os.access(sys.argv[1], os.F_OK) and os.access(sys.argv[1], os.R_OK)):
        hashTable = {"md5hash":"filename"}
        os.chdir(sys.argv[1])
        
        for dirpath, subdirs, fileNameList in os.walk(os.getcwd()):
            
            for fileName in fileNameList:
                full_name = os.path.join(dirpath, fileName)
                # checking the specific file
                if (os.access(full_name, os.F_OK) and os.access(full_name, os.R_OK)):
                    f = file(full_name, "rb")
                    cksum = hashlib.md5()
                    cksum.update(f.read())
                    f.close()
                    if cksum.hexdigest() in hashTable:
                        print full_name, ", ", hashTable[cksum.hexdigest()]
                    else:
                        #print "add"
                        hashTable[cksum.hexdigest()] = full_name
                else:
                    print >> sys.stdout, full_name, "is not readable"
    else:
        print >> sys.stdout, sys.argv[1], "is not readable"
