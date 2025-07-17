#!/usr/bin/env python3

"""
mediainfo_short.sh in Python3
"""

import re
import shlex
import subprocess
import sys


def main():
    """
    Program Entrypoint
    """

    if len(sys.argv) < 2:
        print_help()
        sys.exit(0)

    if sys.argv[1] == "help":
        print_help()
        sys.exit(0)

    if sys.argv[1] != "files":
        print("Incorrect arguments, try 'help'")
        sys.exit(1)

    if len(sys.argv) < 3:
        print("Incorrect arguments, try 'help'")
        sys.exit(1)

    # Before going any further, check if mediainfo is installed.
    if not mediainfo_available():
        print("mediainfo is not available/callable.")
        sys.exit(1)

    infos = []
    for file_path in sys.argv[2:]:
        cmd = ""
        cmd += "mediainfo --full "
        cmd += "{}".format(shlex.quote(file_path))
        ok, mediainfo_text, stderr = run_command(cmd)
        if not ok:
            print("failure to mediainfo {}".format(file_path))
            continue
        file_info, err_msg = parse_mediainfo(mediainfo_text)
        if err_msg != "":
            print("can't parse mediainfo: {} {}".format(file_path, err_msg))
            continue
        file_info["path"] = file_path
        infos.append(file_info)

    for i in infos:
        message = ""
        message += "{:6d} ".format(i["width"])
        message += "{:6d} ".format(i["height"])
        message += "{:12d} ".format(i["size"])
        message += "{:12d} ".format(i["duration"])
        message += "{} ".format(duration_text(int(i["duration"])))
        message += i["path"]
        print(message)

    pass


def print_help():
    """
    Print a simple help message on STDOUT.
    """
    help_message = ""
    help_message += "Get a short summary from mediainfo\n"
    help_message += "Arguments:\n"
    help_message += "help        : Show this help and exit.\n"
    help_message += "files a b c : Process the files a, b and c.\n"
    help_message += "Output:\n"
    help_message += "Width (in pixels) "
    help_message += "Height (in pixels) "
    help_message += "File Size (in bytes) "
    help_message += "Duration (in milliseconds) "
    help_message += "Duration (in H and M) "
    help_message += "File Name\n"
    help_message += "The program mediainfo must be available.\n"
    print(help_message)
    pass


def mediainfo_available() -> bool:
    """
    Validating if the external program mediainfo is usable.
    """

    # The command output is like this:
    # $ mediainfo --version
    # MediaInfo Command line,
    # MediaInfoLib - v23.04

    success_run, stdout, stderr = run_command("mediainfo --version")

    if not success_run:
        print("failure to check if mediainfo is available")
        return False

    if "MediaInfo Command line" not in stdout:
        return False

    return True


def parse_mediainfo(mediainfo_output: str) -> tuple[dict, str]:
    """
    Parsing mediainfo output to get a dict with the following values:
    width (in pixels),
    height (in pixels),
    duration (in milliseconds),
    size (in bytes).
    The error string is empty ("") on success.
    """

    mediainfo = {}
    mediainfo["width"] = 0
    mediainfo["height"] = 0
    mediainfo["duration"] = 0
    mediainfo["size"] = 0

    file_timestamp = ""

    for line in mediainfo_output.split("\n"):
        m = re.compile(r"^Width\s+:\s+([0-9]+)$").search(line.strip())
        if m:
            mediainfo["width"] = int(m.group(1))
        m = re.compile(r"^Height\s+:\s+([0-9]+)$").search(line.strip())
        if m:
            mediainfo["height"] = int(m.group(1))
        m = re.compile(r"^File size\s+:\s+([0-9]+)$").search(line.strip())
        if m:
            mediainfo["size"] = int(m.group(1))
        m = re.compile(r"^Duration\s+:\s+([0-9]+)$").search(line.strip())
        if m:
            mediainfo["duration"] = int(m.group(1))
        m = re.compile(r"^File last modification date\s+:\s+(\S.+)$").search(line.strip())
        if m:
            file_timestamp = m.group(1)

    # Width, Height and Duration could be all 0 for a non-media file.
    # This is the case for text files, zip files, etc.
    # Width and Height are typically 0 for audio files.
    # A size of 0 bytes does not indicate a clear problem with the
    # parsing.
    # A file of 0 bytes is valid, so only check the date.
    if file_timestamp == "":
        return {}, "error parsing mediainfo output, timestamp is null"

    return mediainfo, ""


def run_command(cmd: str, timeout=5) -> tuple[bool, str, str]:
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
            cmd,
            check=True,
            capture_output=True,
            text=True,
            shell=True,
            timeout=timeout)

    except Exception as e:
        return status, "failure to execute command", f"{e}"

    if cmd_output.returncode == 0:
        status = True

    return status, cmd_output.stdout, cmd_output.stderr


def duration_text(duration_ms: int) -> str:
    """
    Converting milliseconds to 00h00m
    """

    duration_s = duration_ms / 1000.0
    duration_h = int(duration_s / 3600.0)
    duration_m = int(((duration_s / 3600.0) - duration_h) * 60.0)

    return "{:02d}h{:02d}m".format(duration_h, duration_m)


if __name__ == "__main__":
    main()
