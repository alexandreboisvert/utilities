#!/usr/bin/env python2
# -*- coding: utf-8 -*-
# Leave the "coding" tag on the second line. It will prevent
# accidents with accentuated characters.

# read a config file
# https://docs.python.org/2/library/configparser.html
# or use JSON...
import json

# importing argparse since optparse is now deprecated
# https://docs.python.org/2/library/argparse.html
import argparse

# syslog writing utilities
import syslog

# writing to stderr
import sys

# date for logging
import datetime

# syslog program name (instead of sys.argv[0])
PROGRAM_NAME = "template_boilerplate_py"


# syslog functions
def log_info(message):
    """Write an informational event to syslog
    :rtype: object
    :param message:
    """
    syslog.syslog(message)


def log_err(message):
    """Write an error event to syslog
    :param message:
    """
    syslog.syslog(syslog.LOG_ERR, message)


def print_message(message):
    print >> sys.stderr, "{} LOG {}".format(
        datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        str(message))


if __name__ == "__main__":
    argument_parser = argparse.ArgumentParser(
        description="Template Boilerplate script",
        epilog="Typical use: ...")
    argument_parser.add_argument(
        "-i", "--integer-value", default=0,
        type=int, required=False,
        help="an integer of your choice",
        metavar="I", dest="int_value")
    argument_parser.add_argument(
        "-c", "--config-file", default=None,
        type=str, required=False,
        help="The path to the config file to use",
        metavar="C", dest="config_file_name")
    argument_parser.add_argument(
        "-s", "--stdin", required=False,
        action="store_true",
        help="Use STDIN as input",
        dest="use_stdin")

    arguments_container = argument_parser.parse_args()

    # syslog, set the program name before starting
    syslog.openlog(ident=PROGRAM_NAME)
    log_info("Starting the program")

    print_message("Template boilerplate Python script")
    print_message("int value = {}".format(arguments_container.int_value))

    if arguments_container.config_file_name is None:
        # this is an error message, it should be on stderr
        print_message("No config file provided")
    else:
        print_message("Config file provided = {}".format(
            arguments_container.config_file_name))
        fh = open(arguments_container.config_file_name)
        config_text = fh.read()
        fh.close()
        config_json_dict = json.loads(config_text)
        print_message("title for config = %s" % (str(
            config_json_dict["title"])))

    if arguments_container.use_stdin:
        print_message("Reading from stdin:")
        input_text = sys.stdin.read()
        print_message("Text received: %s" % input_text)

    # Error handling
    try:
        raise ValueError("this is not a real error")
    except ValueError as ve:
        print("Error occured:")
        print(ve)

    log_err("Simulating an error")
    log_info("Ending the program")
