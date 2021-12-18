#!/usr/bin/env bash

usage() {
  cat << EOF

Check for Non-ASCII characters in file or STDIN

Useful for source code files.

All characters outside the range [0-127] will be spotted

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
    grep --line-number --color=always --perl-regexp '[^\x00-\x7F]'
    ;;
  files)
    shift
    for filename in "$@"
    do
      grep --with-filename --line-number --color=always --perl-regexp '[^\x00-\x7F]' "$filename"
    done
    ;;
  # Handling the incorrect arguments
  *)
    usage
    exit 1
    ;;
esac
