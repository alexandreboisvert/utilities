#!/usr/bin/env python3

"""Rename the provided path to a cleaner name (no spaces, etc.)"""

import os
import sys


def print_help():
    print("")
    print('Rename each provided file with a more "acceptable" name')
    print("")
    print("Usage:")
    print("help           : show this help and exit")
    print("file1 file2... : file list")
    print("")
    print('Replace all the characters that are not "[:alnum:].-/" with "_"')
    print('The "+" sign is also replaced')
    print("If the name is OK do not attempt the rename")
    print("")


def main():
    """Program Entrypoint"""

    if len(sys.argv) < 2:
        print("Arguments required, try 'help'")
        sys.exit(1)

    if sys.argv[1].strip().lower() == "help":
        print_help()
        sys.exit(0)

    # Creating the list of allowed characters
    ok_chars = []
    # lowecase
    ok_chars = ok_chars + ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']
    ok_chars = ok_chars + ['i', 'j', 'k', 'l', 'm', 'n', 'o', 'p']
    ok_chars = ok_chars + ['q', 'r', 's', 't', 'u', 'v', 'w', 'x']
    ok_chars = ok_chars + ['y', 'z']
    # UPPERCASE
    ok_chars = ok_chars + ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
    ok_chars = ok_chars + ['I', 'J', 'K', 'L', 'M', 'N', 'O', 'P']
    ok_chars = ok_chars + ['Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X']
    ok_chars = ok_chars + ['Y', 'Z']
    # Digits
    ok_chars = ok_chars + ['0', '1', '2', '3', '4', '5', '6', '7']
    ok_chars = ok_chars + ['8', '9']
    # Very few punctuation marks.
    # Namely "." and "/" to make sure the more complex paths are
    # supported.
    ok_chars = ok_chars + ['.', '-', '/', '_']

    for path in sys.argv[1:]:

        old_name = path
        new_name = ""

        for c in old_name:
            if c in ok_chars:
                new_name += c
            else:
                new_name += "_"

        if old_name == new_name:
            # Don't try to move a file to the same path
            print("[ NOOP ] {}".format(old_name))
        else:
            try:
                os.rename(old_name, new_name)
                print("[ DONE ] {} ==> {}".format(old_name, new_name))
            except Exception as e:
                print("[ FAIL ] {} ==> {} ==> {}".format(old_name, new_name, str(e)))


if __name__ == "__main__":
    main()
