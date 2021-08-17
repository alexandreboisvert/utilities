#!/usr/bin/env bash

# Script to compare the locally installed version to the current
# version on the website.

# using go full path for the executable
# makes the script more portable
local_go_version=$(/usr/local/go/bin/go version | grep --only-matching --extended-regexp '[0-9]+\.[0-9]+(\.[0-9]+)*')

current_go_version=$(curl --silent --user-agent "mozilla" 'https://golang.org/dl/' \
  | grep --extended-regexp '<span class="filename">.*src.*' \
  | grep --only-matching --extended-regexp '[0-9]+\.[0-9]+(\.[0-9]+)*')

echo "local   = ${local_go_version}"
echo "current = ${current_go_version}"

if [[ "${local_go_version}" = "${current_go_version}" ]]
then
    echo "OK"
else
    echo "NOT UP TO DATE"
    exit 1
fi
