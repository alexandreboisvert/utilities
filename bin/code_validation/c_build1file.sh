#!/usr/bin/env bash

usage(){
  cat <<EOF

Compile a C executable from a single file.
Typically used for "Hello World" programs.

Usage:
$0 program_name.c

Dependencies:
clang-format: formatting C code
gcc: compilation

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

src_file_name="${1}"
echo "Formatting code"
clang-format -i "${src_file_name}"

output_filename="${src_file_name//.c/}"
echo "Compile and build"
echo "Output = ${output_filename}"
gcc -Wall -o "${output_filename}" "${src_file_name}" -lm -static

echo "Done"
