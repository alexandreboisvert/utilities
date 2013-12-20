#!/bin/bash

######################################################################
# Constants and global variables

# Where to store the logs
LOG_FILE="/tmp/template_boilerplate.txt"

# Change this to 0 to only write to the log file
verbose_mode=0

######################################################################
# Utility functions

write_msg(){
    # $1: message to write
    date_log=$(date "+%Y-%m-%d %H:%M:%S")
    [ "$verbose_mode" -ne "0" ] && echo "$date_log $1"
    echo "$date_log $1" >> $LOG_FILE
}

stop_on_error(){
    # $1: $? the return code from the preceding statement
    [ "$1" -ne "0" ] && write_msg "Error occured, exiting" && exit "$1"
}


######################################################################
# Argument parsing

# TODO

usage(){
echo ""
#cat EOF <<
#
#BLA
#
#EOF
}

# TODO

######################################################################
# Main program

# Initialising the empty log file
echo "" > $LOG_FILE

write_msg "first line"

write_msg "valid operation"
true
stop_on_error "$?"

#write_msg "invalid operation"
#false
#stop_on_error "$?"


write_msg "End process"

exit 0