#!/usr/bin/env bash

# Clean trailing spaces
# Mostly used in source code files

# if the first option is "-h", display quick help
if [ "$1" == "-h" ]
then
  cat << EOF

Clean trailing spaces
Mostly used in source code files

Will not alter a file that is OK

Can be used on files:
  $0 file1.txt file2.txt

Can be used in a stream:
  command1 | $0 | command2

Can be used in vim:
  :% ! $0

EOF
  exit 0
fi

if [ -n "$1" ]
then
  # if there are arguments, treat them as files
  for item in "$@"
  do
    if grep -q -E ' +$' "${item}"
    then
      sed --follow-symlinks --in-place --expression 's/ \+$//' "${item}"
    else
      echo "${item} does not have trailing spaces"
    fi
  done
else
  # else process STDIN and output to STDOUT
  sed --expression 's/ \+$//'
fi

