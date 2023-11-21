#!/usr/bin/env bash

# DESCRIPTION
# http://bash.org/ is a website dedicated to IRC funny quotes.
# This script fetches somes quotes for your amusement.
# See the usage() function code below for more details.

# DEPENDENCIES
# - curl: for web interaction
# - html2text: usually available in the repos, but could require
#   a compilation.

set -e pipefail

######################################################################
# Constants and global variables (default values)

# The search string is optional
search_string=""

######################################################################
# Utility functions

write_msg(){
    # $1: message to write
    date_log=$(date '+%Y-%m-%d %H:%M:%S')
    echo "${date_log} $1"
}

######################################################################
# Argument parsing

usage(){
    # Displays the short help message
    # EOF placement is important
    cat << EOF

bash_dot_org: random or custom bash.org page.

Usage: $0 [-h] [-s "search string goes here"]

Options:
  - h: display this help message and exit.
  - s: search for a given string

Without a search parameter, fetch the random page.

EOF
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hs:" OPTION
do
    case ${OPTION} in
        h)
            usage
            exit 0
            ;;
        s)
            search_string="${OPTARG}"
            ;;
        # Handling the incorrect arguments
        *)
            usage
            exit 1
            ;;
    esac
done

write_msg "bash_dot_org - BEGIN"

if [[ -z "${search_string}" ]]
then
  curl --silent --user-agent "Mozilla" 'http://bash.org/?random1' \
    | html2text -utf8
else
  curl --silent --user-agent "Mozilla" --data-urlencode "search=${search_string}" 'http://bash.org/' \
    | html2text -utf8
fi

write_msg "bash_dot_org - END"
