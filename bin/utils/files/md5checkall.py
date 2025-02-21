#!/usr/bin/env python3

# MD5 Check All - Pure Python Version

# https://www.baeldung.com/linux/md5-hash-verify-many-files
# https://docs.python.org/3/library/hashlib.html

import argparse
import datetime
import hashlib
import os
import re
import sys


def print_log(message: str):
    """Printing a message to STDERR"""
    ts = datetime.datetime.now().strftime("%F %T.%f")
    print("{} {}".format(ts, message), file=sys.stderr)


def get_directory_from_args() -> str:
    """Parsing command line argument to get the directory"""
    parser = argparse.ArgumentParser(
        description="MD5 Check All - Python version",
        epilog="Created to be al little more portable (Linux, BSD, etc.)")
    parser.add_argument(
        "-d", "--directory", default="",
        type=str, required=False,
        help="The path to directory to check (recursive)",
        metavar="<dir_name>", dest="dir_name")
    args = parser.parse_args()
    directory = args.dir_name
    if directory == "":
        print_log("Directory not provided, using '.'")
        directory = "."
    return directory


def process_md5(path: str):
    """Check the MD5 checksums for a given file"""
    # simulating a push/pop to come back to the proper directory
    current_dir = os.getcwd()
    try:
        with open(path, "rt") as md5_file:
            new_dir = os.path.dirname(path)
            os.chdir(new_dir)
            failure = False
            for line in md5_file.readlines():
                # some MD5 files use a *
                m = re.match(r"([a-fA-F0-9]{32})\s+\*{0,1}(.+)", line)
                if not m:
                    print_log("[ FAIL ] can't parse {}".format(path))
                    break
                expected_checksum = m.group(1)
                filename = m.group(2)
                with open(filename, "rb") as fhandle:
                    md5_digest = hashlib.file_digest(fhandle, "md5")
                computed_checksum = md5_digest.hexdigest()
                if computed_checksum != expected_checksum:
                    failure = True
                    print_log("[ FAIL ] {} in {}".format(filename, path))
                    break
            if not failure:
                print_log("[  OK  ] {}".format(path))
    except Exception as e:
        print_log("[ FAIL ] error processing file {} : {}".format(path, e))
    # end of the push/pop
    os.chdir(current_dir)


def main():
    """Program Entrypoint"""
    directory = get_directory_from_args()
    print_log("Processing directory {}".format(directory))
    for root, dirs, files in os.walk(directory):
        for file_name in files:
            if file_name.endswith(".md5"):
                process_md5(os.path.join(root, file_name))
    print_log("MD5 check terminated, see above if any error message")


if __name__ == "__main__":
    main()
