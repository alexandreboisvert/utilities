#!/usr/bin/env bash

# Batch Size: defaulting to 10 hosts is usually a conservative choice
batch_size=10

# Timemout: on a LAN, 1 second is generous
ping_timeout=1

# file name required to proceed
host_list_filename=""

usage(){
  # Displays the short help message
  # EOF placement is important
  cat << EOF

Ping a list of hosts in parallel.

One ICMP ping per host. Timeout = ${ping_timeout} sec.

Usage: $0 [-h] [-b BATCH_SIZE] [-t TIMEOUT] -l HOST_LIST

Options:
- h: display this help message and exit.
- b: how many hosts to ping in parallel, defaulting to ${batch_size},
     use 0 to ping all at once (risky).
- t: timeout in seconds (${ping_timeout} s if not provided),
     must be a positive integer.
- l: list of hosts to ping (one per line) [REQUIRED].

Typical use:
$0 -b 50 -l hosts_list.txt > ping_results.txt

EOF
}

write_message(){
  # write to stderr, leaving stdout for the results
  echo "$(date '+%Y-%m-%d %H:%M:%S.%N') $1" >> /dev/stderr 
}

######################################################################
# Main program

# while loop over the arguments
# x: ==> argument x requires a value
while getopts "hb:t:l:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 0
      ;;
    b)
      batch_size="$OPTARG"
      ;;
    l)
      host_list_filename="$OPTARG"
      ;;
    t)
      ping_timeout="$OPTARG"
      ;;
    # Handling the incorrect arguments
    *)
      usage
      exit 1
      ;;
  esac
done

# validate inputs

# the list is required
if [ -z "${host_list_filename}" ]
then
  write_message "host list required, see help, option -h"
  exit 1
fi

# the list must be a file and readable
if [ -f "${host_list_filename}" ] && [ -r "${host_list_filename}" ]
then
  write_message "host list readable"
else
  write_message "can't read host list"
  exit 1
fi

# timeout must be a integer value >= 1
if echo "${ping_timeout}" | grep -q -E '^[0-9]+$'
then
  write_message "timeout looks ok"
else
  write_message "timeout is not numeric"
  exit 1
fi

# batch size must be a integer value
if echo "${batch_size}" | grep -q -E '^[0-9]+$'
then
  write_message "batch size looks ok"
else
  write_message "batch size is not numeric"
  exit 1
fi

# exporting ping_timeout for xargs
export ping_timeout

# exporting a function to reuse with xargs
ping_ip(){
  ip="$1"
  if ping -c 1 -W "${ping_timeout}" "${ip}" &>/dev/null
  then
    echo "[  OK  ] ${ip}"
  else
    echo "[ FAIL ] ${ip}"
  fi
}

export -f ping_ip

# replacing a useless cat
# cat filename.txt | xargs ...
<"${host_list_filename}" xargs -P "${batch_size}" -I{} bash -c 'ping_ip "{}"'

write_message "end"
