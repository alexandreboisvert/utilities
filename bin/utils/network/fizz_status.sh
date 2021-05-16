#!/usr/bin/env bash

# Simple status for FIZZ network

# Dependencies:
# curl: HTTP processing
# html2text: convert HTML to text. Usually available in the repos.

url='https://fizz.ca/en/faq/status-services'

curl \
    --silent \
    --user-agent mozilla \
    "${url}" \ |
html2text \
    -utf8 | \
awk 'BEGIN{inside = 0;}
  /Status of our services/{
    inside = 1;
  }
  /Network Mobile Technical_issues Home_Internet/{
    inside = 0;
  }
  {
    if (inside == 1) print $0;
  }
  END{}'

