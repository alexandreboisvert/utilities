#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Leave the "coding" tag on the second line. It will prevent
# accidents with accentuated characters.

# This whole script could be replaced by this:
# grep -P '[^\x00-\x7F]' filename.txt
# or this:
# perl -nE 'if(m/[^\x00-\x7F]/){say "$_"}' < filename.txt

# importing argparse since optparse is now deprecated
# https://docs.python.org/2/library/argparse.html
import argparse

# opening stdin for reading
import sys

if __name__ == "__main__":
    args_parser = argparse.ArgumentParser(
        description="Check if the text contains non-ascii characters",
        epilog="Typical use: check_ascii.py -i file.txt ")
    args_parser.add_argument(
        "-i", "--input-file", default=None,
        type=str, required=False,
        help="File to check (using STDIN by default)",
        metavar="I", dest="input_filename")

    args_container = args_parser.parse_args()

    lines = []

    if args_container.input_filename is None:
        lines = sys.stdin.readlines()
    else:
        fh = open(args_container.input_filename)
        lines = fh.readlines()
        fh.close()

    # lists start at 0, but natural lines numbers at 1
    current_line_number = 1
    for current_line in lines:
        for current_char in current_line.strip():
            if ord(current_char) > 127:
                print(current_line_number, current_line.strip())
                break
        current_line_number += 1
