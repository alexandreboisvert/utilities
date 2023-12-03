#!/usr/bin/env bash

print_usage(){
  echo "YT DL helper script"
  echo "Usage:"
  echo "help            : Display this help and exit"
  echo "stdin           : Read STDIN line by line"
  echo "file input.txt  : Read from input file line by line"
  echo "url https://... : Directly download URL"
}

[[ -z "$1" ]] && echo "argument required, see 'help'" && exit 1

case $1 in

  "help")
    print_usage
    exit 0
    ;;

  "stdin")
    echo "reading stdin"
    while read -r current_line
    do
      yt-dlp \
        --limit-rate 750k \
        --restrict-filenames \
        --ignore-errors \
        "${current_line}"
    done
    ;;

  "file")
    [[ -z "$2" ]] && echo "argument required, see 'help'" && exit 1
    if [[ -f "$2" ]] && [[ -r "$2" ]]
    then
      echo "File found, using it as a batch file"
      yt-dlp \
        --limit-rate 750k \
        --restrict-filenames \
        --ignore-errors \
        --batch-file "$2"
    else
      echo "File '$2' unreadable"
      exit 1
    fi
    ;;

  "url")
    [[ -z "$2" ]] && echo "argument required, see 'help'" && exit 1
    echo "Using URL"
    yt-dlp \
      --limit-rate 750k \
      --restrict-filenames \
      --ignore-errors \
      "$2"
    ;;

  # Handling the incorrect arguments
  *)
    print_usage
    exit 1
    ;;
esac
