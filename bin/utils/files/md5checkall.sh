#!/usr/bin/env bash

######################################################################
# Constants and global variables (default values)

# recursively look for files in this directory
dir_to_process=""

######################################################################
# Utility functions

write_msg(){
    # $1: message to write
    date_log=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$date_log $1"
}

# We need to export this function to use in "find".
export -f write_msg

process_md5calc(){
    # $1 = MD5 file name
    if md5sum --quiet -c  "$1" > /dev/null 2>&1
    then
        write_msg "[  OK  ] $1"
    else
        write_msg "[ FAIL ] $1 "
    fi
}

# We need to export this function to use in "find".
export -f process_md5calc

######################################################################
# Argument parsing

usage(){
    # Displays the short help message
    # EOF placement is important
    cat << EOF

Compute all the MD5 checksums in the specified directory

Usage: $0 [-h] [-d dir_name]

Options:
- h: display this help message and exit.
- d: the directory to search (defaults to current directory)

Typical use:
$0 -d ~/data_files/

cd ~/my_files/
$0

EOF
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hd:" OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        d)
            dir_to_process="$OPTARG"
            ;;
        # Handling the incorrect arguments
        *)
            usage
            exit 1
            ;;
    esac
done

if [ -z "${dir_to_process}" ]
then
    write_msg "No directory specified, defaulting to '.'"
    dir_to_process='.'
fi

write_msg "Checking MD5 for: '${dir_to_process}'"

find "${dir_to_process}" -type f -iname '*.md5' -execdir bash -c 'process_md5calc "$1"' _ {} \;

write_msg "End process, see above if any error message"
