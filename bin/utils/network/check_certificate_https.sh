#!/usr/bin/env bash

url="$1"

if [[ -z "${url}" ]]
then
    echo "[ FAIL ] provide the URL for the website to check"
    exit 1
fi

if ! echo "${url}" | grep --quiet --extended-regexp '^https://'
then
    echo '[ FAIL ] provide the URL starting with "https://..."'
    exit 1
fi

# stop on any error
set -e

# --no-keepalive: Disables the use of keepalive messages on the TCP connection
expiration_date=$(curl \
    --connect-timeout 5 \
    --silent \
    --no-keepalive \
    --user-agent mozilla \
    --verbose \
    "${url}" \
    2>&1 \
| awk 'BEGIN{ FS="date: "}
    /expire date/ {print $2}
    END{}')

if [[ -z "${expiration_date}" ]]
then
  echo "[ FAIL ] unable to fetch date from ${url}"
  exit 1
fi

expiration_ts=$(date -d "${expiration_date}" +%s)

current_ts=$(date +%s)

# 2 weeks in seconds =  1209600
max_delay=1209600
max_delay_text="2 weeks"

(( diff_ts="${expiration_ts}"-"${current_ts}" ))

if [[ "${diff_ts}" -lt "${max_delay}" ]]
then
    echo "[ FAIL ] expiration for $1 in less than ${max_delay_text}"
else
    echo "[  OK  ] expiration for $1 is more than ${max_delay_text}"
fi

