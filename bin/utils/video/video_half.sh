#!/usr/bin/env bash

if [ -z "$1" ]
then
  echo "Create a new video file half the resolution (W x H)"
  echo "e.g."
  echo "Arguments: video1.mp4 video2.mkv"
  echo "Output: The script will create new files video1.mp4.SMALL.mp4 and video2.mkv.SMALL.mkv"
  exit 0
fi

for input_filename in "$@"
do
  input_extension="${input_filename##*.}"
  ffmpeg -i "${input_filename}" -vf 'scale=iw*0.5:ih*0.5' "${input_filename}.SMALL.${input_extension}"
done
