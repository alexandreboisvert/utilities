#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo "argument required: file or url"
    exit 1
fi

# if the argument is a file: use the batch mode
if [ -f "$1" ]
then
    echo "File found, using it as a batch file"
    yt-dlp     --limit-rate 500k --restrict-filenames --ignore-errors --batch-file "$1"
else
    echo "File not found, using it as URL"
    yt-dlp     --limit-rate 500k --restrict-filenames --ignore-errors "$1"
fi

