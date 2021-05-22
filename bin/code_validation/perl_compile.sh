#!/usr/bin/env bash

# Perl checks and compilation

# Dependencies: perlcritic and perltdiy modules

# Minimal parameters validation
if [ "$1" == "" ] ;
then
    echo "Usage: $0 file_to_check.pl" >  /dev/stderr
    exit 1
fi

if ! [ -r "$1" ]
then
    echo "Usage: $0 file_to_check.pl" >  /dev/stderr
    exit 1
fi

# stop on any error
set -e

echo "Perl checks"
perl -w -W -t -T -c "$1"

echo "Perl Critic (Default Level = 5)"
# perlcritic -1 is way too hard
perlcritic --verbose 11 "$1"

echo "Perl formatting (tidy)"
# using -b to get a backup file
perltidy -b "$1"
