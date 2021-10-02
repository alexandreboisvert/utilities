#!/usr/bin/env bash

set -e

usage(){
  cat <<EOF

Create MD5 checksum file for a directory.

Used for DVD directories.
Used for music directories.

Usage:

$0          : display help
$0 -h       : display help
$0 dir_name : compute MD5 for directory dir_name

EOF
}

dir_name="$1"


if [ -z "$dir_name" ]
then
  echo "[ FAIL ] ERROR: directory required"
  usage
  exit 1
fi

if [ "$dir_name" == "-h" ]
then
  usage
  exit 0
fi

# going inside to find all files
cd "$dir_name" || exit 1

# all the checksums are stored in memory in this variable
all_checksums=$(find . -type f -exec md5sum {} \;)

output_filename=$(basename "$dir_name")
output_filename="${output_filename}.md5"
echo "$all_checksums" > "$output_filename"

echo "[  OK  ] file written: $output_filename"
