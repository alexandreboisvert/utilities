#!/usr/bin/env bash

######################################################################
# Constants and global variables (default values)

# the VeraCrypt file
input_vc_container=''

# directory where to attempt the mount
target_mount_dir=''

# the password list
password_file=''

######################################################################
# Utility functions

write_msg(){
    # $1: message to write
    date_log=$(date "+%Y-%m-%d %H:%M:%S")
    echo "${date_log} $1"
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

USE SUDO

VeraCrypt Crack: try a password list on a VC volume.

Usage: $0 [-h] -i input_vc -m mount_dir -p password_list

Options:
- h: display this help message and exit.
- i: The input VeraCrypt file
- m: The target mount point (directory)
- p: The passwords file to try (one word per line)

Make sure to use with sudo!

EOF
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hi:m:p:" OPTION
do
    case ${OPTION} in
        h)
            usage
            exit 0
            ;;
        i)
            input_vc_container="${OPTARG}"
            ;;
        m)
            target_mount_dir="${OPTARG}"
            ;;
        p)
            password_file="${OPTARG}"
            ;;
        # Handling the incorrect arguments
        *)
            usage
            exit 1
            ;;
    esac
done

write_msg "VeraCrypt Crack: Begin"

# Args validation
valid_input_vc_container=0
valid_target_mount_dir=0
valid_password_file=0

if [ -f "${input_vc_container}" ] &&  [ -r "${input_vc_container}" ]
then
    valid_input_vc_container=1
fi

if [ -d "${target_mount_dir}" ]
then
    valid_target_mount_dir=1
fi

if [ -f "${password_file}" ] && [ -r "${password_file}" ]
then
    valid_password_file=1
fi

write_msg "Paramters validation, 1 = YES"
write_msg "Input container is valid:        ${valid_input_vc_container}"
write_msg "Target mount directory is valid: ${valid_target_mount_dir}"
write_msg "Password file is valid:          ${valid_password_file}"

if [ "${valid_input_vc_container}" -eq "0" ] || \
   [ "${valid_target_mount_dir}" -eq "0" ] || \
   [ "${valid_password_file}" -eq "0" ]
then
    usage
    exit 1
fi

write_msg "Starting password list:"

while read -r current_password
do
    #echo "Password = $current_password"
    if veracrypt -t --non-interactive --protect-hidden=no --password="${current_password}" "${input_vc_container}" "${target_mount_dir}" 2>/dev/null
    then
        write_msg "OK: ${current_password}"
        write_msg "Drive mounted at ${target_mount_dir}"
        break
    else
        write_msg "FAIL: ${current_password}"
    fi

done < "${password_file}"

write_msg "VeraCrypt Crack: End"

exit 0
