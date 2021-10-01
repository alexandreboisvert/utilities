#!/usr/bin/env bash

cat << EOF

##############
# Find Notes #
##############

# find files by name (insensitive)
find /tmp -type f -iname '*report*.txt'

# find latest file in all sub directories
find . -type f -iname '*.deb'  -printf '%C@ %p\n' | sort -n

# find files newer than a given date
find . -type f -iname '*.deb' -newermt '1999-12-31'

# git pull on all git directories
# execdir: excute the command in the directory (cd into directory)
# execdir: the \; is important
find . -type d -name '.git' -print -execdir git pull --verbose --all --tags \;

EOF
