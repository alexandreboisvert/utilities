#!/usr/bin/env bash

######################################################################
# Constants and global variables (default values)

# delay for the loop: 10 seconds is usually OK
loop_delay=10

# 1 is verbose, 0 is silent
verbose_mode=0

# The target PID
pid=""

# The command to run
cmd=""

######################################################################
# Utility functions

write_msg(){
    # Writing a message in a proper log format (date-time-message)
    # $1: message to write
    date_log=$(date "+%Y-%m-%d %H:%M:%S")
    [ "$verbose_mode" -ne "0" ] && echo "$date_log $1"
}

######################################################################

usage(){
    # Displays the short help message
    # EOF placement is important
    cat << EOF

Start a command after the execution of a currently running program.

Usage: $0 [-h] [-v] -p PID -c CMD

Options:
- h: display this help message and exit.
- v: the script becomes more verbose.
- p: (REQUIRED) The Process ID that will terminate
- c: (REQUIRED) The command to run when PID terminates

Typical use:
$0 -v -p 00000 -c 'ls -l > /tmp/files.txt'

EOF
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hp:c:v" OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        p)
            pid="$OPTARG"
            ;;
        c)
            cmd="$OPTARG"
            ;;
        v)
            verbose_mode=1
            ;;
        # Handling the incorrect arguments
        ?)
            usage
            exit 1
            ;;
    esac
done

[ "$verbose_mode" -eq "1" ] && write_msg "Verbose mode activated"

# arguments validation:
# PID must be numeric, CMD must be non-empty

if ! [[ "${pid}" =~ ^[0-9]+$ ]]
# http://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
then
    echo "ERROR: PID must be numeric"
    usage
    exit 1
fi

if [ -z "${cmd}" ]
then
    echo "ERROR: CMD must be provided"
    usage
    exit 1
fi

# The process is running as long a the directory exits in /proc
while true
do
    if [ -e "/proc/${pid}" ]
    then
        write_msg "Still waiting for PID ${pid} to complete"
        sleep "${loop_delay}"
    else
        write_msg "PID ${pid} completed, proceed"
        break
    fi
done

# Waiting is over, process the command
bash -c "${cmd}"
