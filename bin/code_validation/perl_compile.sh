#!/usr/bin/env bash

usage(){
  cat <<EOF

Perl checks and compilation

Dependencies:
- perlcritic
- perltdiy

Usage:
$0 file_to_check.pl

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

echo "Perl checks"
perl -w -W -t -T -c "$1"

echo "Perl Critic (Default Level = 5)"
# perlcritic -1 is way too hard
perlcritic --verbose 11 "$1"

echo "Perl formatting (tidy)"
# using -b to get a backup file
perltidy -b "$1"
