#!/usr/bin/env bash

cat << EOF

ffmpeg notes

# scale down a picture or video
ffmpeg -i input.jpg -vf 'scale=iw/2:ih/2' input_half_size.png
ffmpeg -i input.mp4 -vf 'scale=iw/2:ih/2' input_half_size.mp4

# extract the audio from a video
ffmpeg -i video.mp4 audio.mp3
# extract the audio from a video (higher quality)
ffmpeg -i video.mp4 -b:a 320K audio.mp3"

# convert a GIF to MP4 (significant space savings)
ffmpeg -i video.gif video.mp4

EOF
