#!/bin/bash

# Python compilation
# Check the syntax of the given file for PEP8 compliance and pyflakes
# errors then create a pyc file.

# Dependencies: pep8 (pip install pep8)
# Dependencies: pyflakes (apt-get install pyflakes)

# Minimal parameters validation
if [ "$1" == "" ] ;
then
    echo "Usage: $0 file_to_check.py" >  /dev/stderr
    exit 1
fi

echo "PEP 8 Validation"
pep8 "$1"

echo "pyflakes Validation"
pyflakes "$1"

echo "Python Compilation"
python -m py_compile "$1"

