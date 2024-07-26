#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Leave the "coding" tag on the second line. It will prevent
# accidents with accentuated characters.

# importing argparse since optparse is now deprecated
# https://docs.python.org/2/library/argparse.html
import argparse

# opening stdin for reading
import sys

if __name__ == "__main__":
    args_parser = argparse.ArgumentParser(
        description="Check if the text contains non-ascii and control characters",
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
        fh = open(args_container.input_filename, "rt", errors="ignore")
        lines = fh.readlines()
        fh.close()

    # characters allowed (decimal values)
    allowed_chars = [9, 10, 13, 32, 33, 34, 35, 36, 37, 38, 39, 40,
                     41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52,
                     53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64,
                     65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76,
                     77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88,
                     89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
                     101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
                     111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
                     121, 122, 123, 124, 125, 126]
    # lists start at 0, but natural lines numbers at 1
    current_line_number = 1
    for current_line in lines:
        for current_char in current_line.strip():
            if ord(current_char) not in allowed_chars:
                print(current_line_number, current_line.strip())
                # breaking out of the current_char loop, not the
                # current_line loop
                break
        current_line_number += 1
