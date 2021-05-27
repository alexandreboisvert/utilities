#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "provide the URL for the website to check"
    exit 1
fi

if ! echo "$1" | grep --quiet --extended-regexp '^https://'
then
    echo 'provide the URL starting with "https://..."'
    exit 1
fi

# stop on any error
set -e

echo "Fetching the website: $1"

# --no-keepalive: Disables the use of keepalive messages on the TCP connection
expiration_date=$(curl \
    --connect-timeout 5 \
    --silent \
    --no-keepalive \
    --user-agent mozilla \
    --verbose \
    "$1" \
    2>&1 \
| awk 'BEGIN{ FS="date: "}
    /expire date/ {print $2}
    END{}')

echo "Expiration Date Found = ${expiration_date}"

expiration_ts=$(date -d "${expiration_date}" +%s)

current_ts=$(date +%s)

# 2 weeks in seconds =  1209600
max_delay=1209600
max_delay_text="2 weeks"

(( diff_ts="${expiration_ts}"-"${current_ts}" ))

if [ "${diff_ts}" -lt "${max_delay}" ]
then
    echo "expiration in less than ${max_delay_text}"
else
    echo "ok for now (more than ${max_delay_text})"
fi

