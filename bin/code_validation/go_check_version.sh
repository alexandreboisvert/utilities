#!/usr/bin/env bash

# Script to compare the locally installed version to the current
# version on the website.

# using go full path for the executable
# makes the script more portable
local_go_version=$(/usr/local/go/bin/go version | grep --only-matching --extended-regexp '[0-9]+\.[0-9]+(\.[0-9]+)*')

current_go_version=$(curl --max-time 5 --silent --user-agent "mozilla" 'https://go.dev/dl/' \
  | grep --extended-regexp '<span class="filename">.*src.*' \
  | grep --only-matching --extended-regexp '[0-9]+\.[0-9]+(\.[0-9]+)*')

if [[ "${local_go_version}" = "${current_go_version}" ]]
then
    echo "[  OK  ] golang version: local ($local_go_version) == current ($current_go_version)"
else
    echo "[ FAIL ] golang version NOT UP TO DATE: local ($local_go_version) != current ($current_go_version)"
    exit 1
fi
