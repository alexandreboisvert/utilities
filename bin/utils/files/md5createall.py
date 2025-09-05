#!/usr/bin/env python3

import datetime
import hashlib
import os.path
import sys


def print_help():
    print("Create MD5 sum for individual files", file=sys.stderr)
    print("Usage: md5createall.py f1 f2 ...", file=sys.stderr)
    print("This creates a .md5 file for each file in the list", file=sys.stderr)
    pass


def ts() -> str:
    return datetime.datetime.now().strftime("%F %T.%f")


def create_md5(filename: str):
    try:
        if os.path.isfile(filename):
            with open(filename, "rb") as input_fh:
                md5_digest = hashlib.file_digest(input_fh, "md5")
            with open(filename + ".md5", "wt") as output_fh:
                # 2 spaces between the filename and the MD5
                # using basename to make a "local" MD5 file
                output_fh.write("{}  {}\n".format(md5_digest.hexdigest(), os.path.basename(filename)))
            print("{} [  OK  ] Created MD5 for {}".format(ts(), filename), file=sys.stderr)
        else:
            raise ValueError("Not a file")
    except Exception as e:
        print("{} [ FAIL ] Unable to create MD5 for {}: {}".format(ts(), filename, e), file=sys.stderr)
    pass


def main():
    if len(sys.argv) < 2:
        print_help()
        sys.exit(1)
    filenames = sys.argv[1:]
    for filename in filenames:
        create_md5(filename)
    pass


if __name__ == "__main__":
    main()
