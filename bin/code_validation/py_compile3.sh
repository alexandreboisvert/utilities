#!/usr/bin/env bash

usage(){
  cat <<EOF

Python compilation
Check the syntax of the given file for PEP8 compliance and pyflakes
errors then create a pyc file.

Dependencies:
flake8 (uses pep8 and flake)

Usage:
$0 program1.py promgram2.py ...

EOF
}

# stop on any error
set -e

if [ -z "${1}" ]
then
    echo "ERROR: argument required"
    usage
    exit 1
fi

for filename in "$@"
do
  echo "flake8 validation and python compilation "
  # E501: line too long
  # This error can be ignored for all practical purposes
  flake8 --ignore='E501' "${filename}"

  python3 -m py_compile "${filename}"
done
