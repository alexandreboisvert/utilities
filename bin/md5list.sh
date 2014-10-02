#!/bin/bash

# TODO handle -h argument

######################################################################
# Utility functions

write_msg(){
    # $1: message to write
    date_log=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$date_log $1"
}

stop_on_error(){
    # $1: $? the return code from the preceding statement
    [ "$1" -ne "0" ] && write_msg "Error occured ($1), exiting" && exit "$1"
}

######################################################################

usage(){
    # Displays the short help message
    # EOF placement is important
    cat << EOF

MD5 sum for individual files

Usage: $0 <files>

Options:
<files>: list of files to process.

The md5sum program creates a big list of all the sums,
this script produces one .md5 file per input file.

Typical use:
$0 file1.txt file2.jpg *.pdf

EOF
}

######################################################################
# Main program

# show help on empty arguments
[ -z "$1" ] && usage && exit 0

for file_name in "$@"
do
    write_msg "processing ${file_name}.md5"
    md5sum -b "$file_name" > "${file_name}.md5"
    stop_on_error "$?"
done

exit 0
