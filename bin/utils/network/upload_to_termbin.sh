#!/usr/bin/env bash

# Simple upload to terbin

# TODO this could use more validation and be more verbose

[ -z "$1" ] && echo "file required" && exit 1

tar -z -c "$1" | gpg -c | base64 | nc termbin.com 9999

