#!/usr/bin/env bash

# Check for Non-ASCII characters in file.
# Useful for source code files.
# All characters outside the range [0-127] will be spotted

cat --number "$1" | grep --perl-regexp '[^\x00-\x7F]'
