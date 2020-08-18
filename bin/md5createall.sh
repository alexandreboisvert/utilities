#!/bin/bash

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

process_md5(){
    # $1: the filename
    md5sum -b "${1}" > "${1}.md5"
    sed -i 's/\.\///' "${1}.md5"
}
export -f process_md5

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

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "h" OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        # Handling the incorrect arguments
        *)
            usage
            exit 1
            ;;
    esac
done

for file_name in "$@"
do
    write_msg "Processing ${file_name}"
    find "${file_name}" -execdir bash -c 'process_md5 "$1"' _ {} \;
    stop_on_error "$?"
done

exit 0
