#!/usr/bin/env bash

if [ -z "$1" ]
then
  echo "Get a short summary from mediainfo"
  echo "Width (in pixels) [tab] Height (in pixels) [tab] Duration (in milliseconds) [tab] File Size (in bytes) [tab] File Name"
  echo "Requires the program mediainfo"
  exit 0
fi

for item in "$@"
do
  mediainfo --full "${item}" \
  | awk 'BEGIN{
    width_pixel = 0;
    height_pixel = 0;
    duration_ms = 0;
    size_bytes = 0;
    file_name = "no name";
  }
  /^Width +: [0-9]+$/ { width_pixel = $NF }
  /^Height +: [0-9]+$/ { height_pixel = $NF }
  /^Duration +: [0-9]+$/ { duration_ms = $NF }
  /^File size +: [0-9]+$/ { size_bytes = $NF }
  /^Complete name +: .*$/ { file_name = $NF }
  END{
    print width_pixel "\t" height_pixel "\t" duration_ms "\t" size_bytes "\t" file_name;
  }'
done
