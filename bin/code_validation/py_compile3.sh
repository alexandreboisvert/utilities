#!/usr/bin/env bash

# Python compilation
# Check the syntax of the given file for PEP8 compliance and pyflakes
# errors then create a pyc file.

# Dependencies: flake8 (uses pep8 and flake)

# Minimal parameters validation
if [ "$1" == "" ] ;
then
    echo "Usage: $0 file_to_check.py" >  /dev/stderr
    exit 1
fi

echo "flake8 validation and python compilation "
# E501: line too long
# This error can be ignored for all practical purposes
flake8 --ignore='E501' "$1" && python3 -m py_compile "$1"

