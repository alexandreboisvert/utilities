#!/usr/bin/env bash

usage() {
  cat << EOF

Check for Non-ASCII characters in file or STDIN

Useful for source code files.

All characters outside the range below will be spotted
decimal values:
9, 10, 13, 32, 33, 34, 35, 36, 37, 38, 39, 40,
41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76,
77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88,
89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
121, 122, 123, 124, 125, 126

Options

help                    : display this help and exit
stdin                   : process the content of STDIN (to be used in pipes)
files a.txt b.txt c.txt : process all the files a.txt, b.txt and c.txt.

EOF
}

if [ -z "$1" ]
then
 usage
 exit 1
fi

case "$1" in
  help)
    usage
    exit 0
    ;;
  stdin)
    grep --line-number --color=always --perl-regexp '[^\x09\x0A\x0D\x20-\x7E]'
    ;;
  files)
    shift
    for filename in "$@"
    do
      grep --with-filename --line-number --color=always --perl-regexp '[^\x09\x0A\x0D\x20-\x7E]' "${filename}"
    done
    ;;
  # Handling the incorrect arguments
  *)
    usage
    exit 1
    ;;
esac
