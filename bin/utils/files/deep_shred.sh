#!/usr/bin/env bash

######################################################################
# Global variables and constants
input_dir=""

######################################################################
# Utility functions

write_msg(){
    # $1: message to write
    date_log=$(date --rfc-3339=second)
    echo "${date_log} $1"
}

######################################################################
# Argument parsing

usage(){
    # Displays the short help message
    # EOF placement is important
    cat << EOF

Deep Shred: shred all the files found in a subdirectory
then remove the complete directory tree.

Usage: $0 [-h] -d input_dir

Options:
- h: display this help message and exit.
- d: the directory to delete

Typical use:
$0 -d ~/data_to_delete/

EOF
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hd:" OPTION
do
    case ${OPTION} in
        h)
            usage
            exit 0
            ;;
        d)
            input_dir="${OPTARG}"
            ;;
        # Handling the incorrect arguments
        *)
            usage
            exit 1
            ;;
    esac
done

if [ -z "${input_dir}" ]
then
    write_msg "Directory required"
    usage
    exit 1
fi

if ! [ -d "${input_dir}" ]
then
    write_msg "The input ${input_dir} is not a directory"
    usage
    exit 1
fi

write_msg "Processing directory: ${input_dir}"

find  "${input_dir}" -type f -print -exec shred --iterations=1 --remove --zero {} \;

write_msg "Files processing done"

rm -vrf "${input_dir}"

write_msg "Directory structure deleted"

write_msg "Syncing"

sync

write_msg "Syncing done"

write_msg "Processing done"
