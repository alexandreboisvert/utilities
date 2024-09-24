#!/usr/bin/env bash

# general note for bash scripting: use https://www.shellcheck.net/

# useful Bash options
# set -e: stop on any error
# set -x: display the command before executing it

######################################################################
# Constants and global variables (default values)

# Where to store the logs
log_file="/tmp/template_boilerplate.txt"

# Change this to 0 to only write to the log file
verbose_mode=0

######################################################################
# Utility functions

write_msg(){
    # Writing a message in a proper log format (date-time-message)
    # $1: message to write
    date_log=$(date "+%Y-%m-%d %H:%M:%S")
    [[ "${verbose_mode}" -ne "0" ]] && echo "${date_log} $1"
    echo "${date_log} $1" >> "${log_file}"
}

######################################################################
# Argument parsing

usage(){
    # Displays the short help message
    # EOF placement is important
    cat << EOF

Usage: $0 [-h] [-v] [-l log_file]

Options:
- h: display this help message and exit.
- v: the script becomes more verbose.
- l: specify the log file name (default = ${log_file})

Typical use:
$0 -v -l ~/log.txt

EOF
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hl:v" OPTION
do
    case ${OPTION} in
        h)
            usage
            exit 0
            ;;
        l)
            log_file="${OPTARG}"
            ;;
        v)
            verbose_mode=1
            ;;
        # Handling the incorrect arguments
        *)
            usage
            exit 1
            ;;
    esac
done

[[ "${verbose_mode}" -eq "1" ]] && write_msg "Verbose mode activated"

write_msg "log file location = ${log_file}"

write_msg "End process"

exit 0
