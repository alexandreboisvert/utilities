#!/usr/bin/env bash

usage() {
  cat << EOF

Simple rot13 encoder/decoder

See: https://en.wikipedia.org/wiki/ROT13

Can be used on files or STDIN.

Options:

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
    tr 'a-zA-Z' 'n-za-mN-ZA-M'
    ;;
  files)
    shift
    for filename in "$@"
    do
      echo "$filename"
      tr 'a-zA-Z' 'n-za-mN-ZA-M' < "$filename"
    done
    ;;
  # Handling the incorrect arguments
  *)
    usage
    exit 1
    ;;
esac
