#!/usr/bin/env python

# importing argparse since optparse is now deprecated
# https://docs.python.org/2/library/argparse.html
import argparse

argument_parser = argparse.ArgumentParser(
                      description="Template Boilerplate script",
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

if __name__ == "__main__":
    print "Template boilerplate Python script"
    print "int value =", arguments_container.int_value
    if arguments_container.config_file_name is None:
        print "No config file provided"
    else:
        print "Config file provided =", arguments_container.config_file_name

# TODO read a config file
# https://docs.python.org/2/library/configparser.html

# TODO write a log file
# https://docs.python.org/2/howto/logging.html

# TODO write to syslog
# https://docs.python.org/2/library/syslog.html
