#!/usr/bin/env bash

if [ -z "$1" ]
then
  echo "Get a short summary from mediainfo"
  echo "Pass as arguments the file names"
  echo "Output:"
  echo "Width (in pixels) [tab] Height (in pixels) [tab] Duration (in milliseconds) [tab] Duration (in H and M) [tab] File Size (in bytes) [tab] File Name"
  echo "Requires the program mediainfo"
  exit 0
fi

for filename in "$@"
do
  output=$(mediainfo --full "${filename}" \
  | awk 'BEGIN{
    width_pixel = 0;
    height_pixel = 0;
    duration_ms = 0;
    size_bytes = 0;
  }
  /^Width +: [0-9]+$/ { width_pixel = $NF }
  /^Height +: [0-9]+$/ { height_pixel = $NF }
  /^Duration +: [0-9]+$/ { duration_ms = $NF }
  /^File size +: [0-9]+$/ { size_bytes = $NF }
  END{
    duration_s = duration_ms / 1000.0;
    duration_h = int(duration_s / 3600.0);
    duration_m = int(((duration_s / 3600.0) - duration_h) * 60.0);
    print width_pixel "\t" height_pixel "\t" duration_ms "\t" duration_h "h" duration_m "m\t" size_bytes;
  }')
  printf "%s\t%s\n" "$output" "$filename"
done | column --table
# done | column --table --table-columns-limit 6
