#!/usr/bin/env python

# TODO read a config file
# https://docs.python.org/2/library/configparser.html
# or use JSON...

# importing argparse since optparse is now deprecated
# https://docs.python.org/2/library/argparse.html
import argparse

# syslog writing utilities
import syslog

# syslog program name (instead of sys.argv[0])
PROGRAM_NAME = "template_boilerplate_py"


# syslog functions
def log_info(message):
    """Write an informational event to syslog"""
    syslog.syslog(message)


def log_err(message):
    """Write an error event to syslog"""
    syslog.syslog(syslog.LOG_ERR, message)

if __name__ == "__main__":
    argument_parser = argparse.ArgumentParser(description="Template Boilerplate script",
        epilog="Typical use: ...")
    argument_parser.add_argument("-i", "--integer-value", default=0,
        type=int, required=False,
        help="an integer of your choice",
        metavar="I", dest="int_value")
    argument_parser.add_argument("-c", "--config-file", default=None,
        type=str, required=False,
        help="The path to the config file to use",
        metavar="C", dest="config_file_name")

    arguments_container = argument_parser.parse_args()

    # syslog, set the program name before starting
    syslog.openlog(ident=PROGRAM_NAME)
    log_info("Starting the program")

    print "Template boilerplate Python script"
    print "int value =", arguments_container.int_value
    if arguments_container.config_file_name is None:
        print "No config file provided"
    else:
        print "Config file provided =", arguments_container.config_file_name

    log_err("Simulating an error")
    log_info("Ending the program")
