#!/usr/bin/env bash

# Search DuckDuckGo from the command line

# Dependencies:
# curl: HTTP POST
# html2text: convert html to text. Usually available in the repo, but
#   could require compilation

if [ -z "$1" ]
then
    echo "provide input seach" > /dev/stderr
    exit 1
fi

curl --silent --user-agent 'mozilla' \
     --data-urlencode "q=${1}" \
     'https://lite.duckduckgo.com/lite/' \
| html2text -utf8 -nobs \
| cat -s \
| less

