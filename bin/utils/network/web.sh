#!/usr/bin/env bash

set -e

touch ~/.w3m/history

w3m -no-mouse -no-cookie -no-graph -s -W -v "$@"

#     -no-mouse        don't use mouse
#     -cookie          use cookie (-no-cookie: don't use cookie)
#     -no-graph        use ASCII character for border of table and menu
#     -s               squeeze multiple blank lines
#     -W               toggle search wrap mode
#     -v               start with the built-in page if no targets
