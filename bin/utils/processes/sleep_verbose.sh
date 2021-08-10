#!/usr/bin/env bash

usage(){
  cat <<EOF
Verbose sleep command.

Like sleep, but with a visible countdown.

Useful in interactive scripts.

Usage:

$0 N

Where N is the number of seconds to sleep.

Will display the countdown like this:

7/10 seconds

EOF
}

if [ -z "$1" ]
then
  usage
  exit 1
fi

# a numeric value is only numbers, no other characters
numeric_value=$(echo "$1" | awk '/^[0-9]+$/{print $1}')

if [ -z "${numeric_value}" ]
then
  echo "ERROR: Argument is not an integer"
  usage
  exit 1
fi

# The loop is using seq instead of a bash expansion {1..N}
for count in $(seq 1 "${numeric_value}")
do
  sleep 1
  printf '%d/%d seconds\r' "${count}" "${numeric_value}"
done

# To have proper final line return
printf '\n'

