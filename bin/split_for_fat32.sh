#!/bin/bash

######################################################################
# Constants and global variables (default values)

# the large file to split
input_file=""

# 500 MB files are OK for FAT32
split_size=500000000

######################################################################
# Utility functions

write_msg(){
    # $1: message to write
    date_log=$(date "+%Y-%m-%d %H:%M:%S")
    echo "$date_log $1"
}

stop_on_error(){
    # $1: $? the return code from the preceding statement
    [ "$1" -ne "0" ] && echo "Error occured ($1), exiting" > /dev/stderr && exit "$1"
}

######################################################################
# Argument parsing

usage(){
    # Displays the short help message
    # EOF placement is important
    cat << EOF

Split a large file to fit on a FAT32 filesystem (e.g. USB stick)
Creates the splitted files with their MD5.

Usage: $0 [-h] -i input_file

Options:
- h: display this help message and exit.
- i: input file to split in volumes

Typical use:
$0 -i big_file.txt

EOF
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hi:" OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        i)
            input_file="${OPTARG}"
            ;;
        # Handling the incorrect arguments
        *)
            usage
            exit 1
            ;;
    esac
done

write_msg "Splitting into volumes - BEGIN"

# the input file is absolutely required
if [ -z "${input_file}" ]
then
    usage
    exit 1
fi

write_msg "MD5 of input file - BEGIN"
md5sum -b "${input_file}" > "${input_file}.md5"
write_msg "MD5 of input file - END"

write_msg "Split the input file - BEGIN"
split --bytes="${split_size}" --numeric-suffixes "${input_file}" "${input_file}_PART_"
stop_on_error "$?"
write_msg "Split the input file - END"

write_msg "MD5 the splitted files - BEGIN"

# this code looks ugly, but it works
# ShellCheck does not complain about any issue

process_md5(){
    # $1 = filename
    write_msg "MD5 file: $1"
    md5sum -b "${1}" > "${1}.md5"
}
export -f process_md5
export -f write_msg

find . -type f -iname "${input_file}_PART_*" -exec bash -c 'process_md5 "$1"' _ {} \;
stop_on_error "$?"

write_msg "MD5 the splitted files - END"

write_msg "Splitting into volumes - END"

exit 0

