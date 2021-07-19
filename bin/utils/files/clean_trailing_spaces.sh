#!/usr/bin/env bash

for item in "$@"
do
  # A simple sed command like this:
  # sed -i -e 's/ \+$//' "${item}"
  # will modify the file every time.

  # Add a check before.

  # If needed: perform the sed command
  # do not alter a correct file
  if grep -q -E ' +$' "${item}"
  then
    sed -i -e 's/ \+$//' "${item}"
  else
    echo "${item} does not have trailing spaces"
  fi
done
