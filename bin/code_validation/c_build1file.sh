#!/usr/bin/env bash

# Dependencies
# clang: formatting C code
# gcc: compilation


# Simple script to compile a C executable from a single file.
# Typically use for "Hello World" programs.

# stop on any error
set -e

if [ -z "${1}" ]
then
    echo "argument required"
    exit 1
fi

src_file_name="${1}"
echo "compile and build"
clang-format -i "${src_file_name}"

output_filename="${src_file_name//.c/}"
echo "output = ${output_filename}"
gcc -Wall -o "${output_filename}" "${src_file_name}" -lm -static

echo "done"
