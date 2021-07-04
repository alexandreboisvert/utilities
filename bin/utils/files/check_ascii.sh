#!/usr/bin/env bash

# Check for Non-ASCII characters in file.
# Useful for source code files.
# All characters outside the range [0-127] will be spotted

grep --line-number --color=always --perl-regexp '[^\x00-\x7F]' "$1"
