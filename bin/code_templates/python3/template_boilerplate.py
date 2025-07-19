#!/usr/bin/env python3
"""Template/Boilerplate for python3"""

# read a config file
# https://docs.python.org/2/library/configparser.html
# or use JSON...
import json

# importing argparse since optparse is now deprecated
# https://docs.python.org/2/library/argparse.html
import argparse

# writing to stderr
import sys

# syslog writing utilities
# works on linux, not tested on windows
import syslog

# HTTPS libraries
import ssl
import urllib.request

# Executing external commands
import subprocess

# syslog program name (instead of sys.argv[0])
PROGRAM_NAME = "template_boilerplate_py"


# syslog functions
def log_info(message):
    """Write an informational event to syslog"""
    syslog.syslog(message)


def log_err(message):
    """Write an error event to syslog"""
    syslog.syslog(syslog.LOG_ERR, message)


def main():
    """Program Entrypoint"""
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

    arguments_container = argument_parser.parse_args()

    # syslog, set the program name before starting
    syslog.openlog(ident=PROGRAM_NAME)
    log_info("Starting the program")

    print("Template boilerplate Python script")
    print("int value = %d" % (arguments_container.int_value))
    if arguments_container.config_file_name is None:
        # this is an error message, it should be on stderr
        print("No config file provided", file=sys.stderr)
    else:
        print(
            "Config file provided = %s"
            % (arguments_container.config_file_name))
        filehandle = open(arguments_container.config_file_name)
        config_text = filehandle.read()
        filehandle.close()
        config_json_dict = json.loads(config_text)
        print("title for config = %s" % (str(config_json_dict["title"])))

    print("%s %s" % ("message1", "message2"))

    # Error handling
    try:
        raise ValueError("this is not a real error")
    except ValueError as value_exception:
        print("Error occured:")
        print(value_exception)

    print("message1", "message2")

    current_context = ssl.create_default_context()

    if arguments_container.int_value < 1:
        current_context.check_hostname = False
        current_context.verify_mode = ssl.CERT_NONE

    with urllib.request.urlopen("https://example.com", timeout=3, context=current_context) as response:
        print("response length: {}".format(len(response.read())))

    log_err("Simulating an error")

    success, stdout, stderr = run_command(["ls", "-l", "file with spaces.txt"])

    if success:
        log_info("the command succeeded")
    else:
        log_info("the command failed")

    log_info("Ending the program")


def run_command(cmd_parts: str, timeout=5) -> tuple[bool, str, str]:
    """
    Runs the given command with the optional timeout.
    Returns 3 items.
    - Success: True/False
    - STDOUT text
    - STDERR text
    """

    status = False

    try:

        cmd_output = subprocess.run(
            cmd_parts,
            shell=False,
            capture_output=True,
            text=True,
            timeout=timeout)

    except Exception as e:
        return status, "failure to execute command", f"{e}"

    if cmd_output.returncode == 0:
        status = True

    return status, cmd_output.stdout, cmd_output.stderr


if __name__ == "__main__":
    main()
