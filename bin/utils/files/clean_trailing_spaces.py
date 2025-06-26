#!/usr/bin/env python3
"""
Clean trailing spaces for the input file.
The input file will be replaced with new content.
"""

import argparse
import sys
import tempfile


def main():
    """
    Main function to remove trailing whitespaces from each line in
    a file. Write the new lines to the original file.
    """

    parser = argparse.ArgumentParser(
        description="Clean trailing spaces in file.",
        epilog="The input file will be replaced with new content.")
    parser.add_argument(
        "-f", "--file", default="",
        type=str, required=True,
        help="The path to the file to clean",
        metavar="filename", dest="input_file_path")
    parser.add_argument(
        "-c", "--check", action="store_true",
        help="Check the file and report the lines only, do not alter the file.",
        dest="check_mode_enabled")

    args = parser.parse_args()

    # In check mode, simply report the line numbers
    if args.check_mode_enabled:
        print_report(args.input_file_path)
        sys.exit(0)

    trim_trailing_spaces(args.input_file_path)
    pass


def print_report(filename: str):
    """
    Print a message containing the list of lines containing
    trailing spaces.
    """

    line_count = 0
    lines_list = []
    with open(filename, "rt") as input_fh:
        for input_line in input_fh.readlines():
            line_count += 1
            if input_line[:-1] != input_line.rstrip():
                # Converting the line_count to a string for easier
                # printing later.
                lines_list.append(str(line_count))
    if len(lines_list) > 0:
        print("{}: trailing spaces detected in lines: {}".format(filename, ", ".join(lines_list)))
    else:
        print("{}: no trailing spaces detected".format(filename))
    pass


def trim_trailing_spaces(filename: str):
    """
    Trim only the trailing spaces on each line of the file.
    """

    # Using a temp file to store the results instead of writing all
    # the file contents in memory.
    with tempfile.TemporaryFile() as temp_fh:

        # "rt" to get lines of text
        with open(filename, "rt") as input_fh:
            for input_line in input_fh.readlines():
                # rstrip is like strip only at the end of the line
                s = input_line.rstrip() + "\n"
                temp_fh.write(s.encode("utf-8"))

        temp_fh.seek(0)

        # "wb" is overwrite in bytes
        with open(filename, "wb") as output_fh:
            output_fh.write(temp_fh.read())
    pass


if __name__ == "__main__":
    main()
