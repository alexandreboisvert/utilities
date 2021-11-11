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

# extract video from file
fmpeg -i audio_and_video.mp4 -c copy -an video_only.mp4

# reverse video
# NEVER TESTED, memory allocation problems
ffmpeg -i input.mp4 -vf reverse -af areverse reversed_video.mp4

# audio normalization

bytesandbones.wordpress.com
****** Audio normalization with ffmpeg using loudnorm (ebur128) filter ******
Source: https://developers.google.com/actions/tools/audio-loudness
Source: http://k.ylo.ph/2016/04/04/loudnorm.html (Credits: k@ylo.ph | Source
discovered by Mulvya)
    * ./ffmpeg -i /path/to/input.wav -af loudnorm=I=-16:TP=-1.5:LRA=11:
      print_format=summary -f null -
      This instructs FFmpeg to measure the audio values of your media file
      without creating an output file. You will get a series of values
      presented as follows:
      Input Integrated:    -27.2 LUFS
      Input True Peak:     -14.4 dBTP
      Input LRA:             0.1 LU
      Input Threshold:     -37.7 LUFS

      Output Integrated:   -15.5 LUFS
      Output True Peak:     -2.7 dBTP
      Output LRA:            0.0 LU
      Output Threshold:    -26.2 LUFS

      Normalization Type:   Dynamic
      Target Offset:        -0.5 LU
      The sample values above indicate important information about the incoming
      media. For instance, the Input Integrated value shown indicates audio
      that is too loud. The Output Integrated value is much closer to -16.0.
      Both the Input True Peak and Input LRA, or loudness range, values are
      higher than our provided ceilings and will be reduced in the normalized
      version. Finally, the Target Offset represents the offset gain used in
      the output.
    * Run a second pass of the loudnorm filter, supplying the values from step
      1 as "measured" values in the loudnorm options.
      ./ffmpeg -i /path/to/input.wav -af loudnorm=I=-16:TP=-1.5:LRA=11:
      measured_I=-27.2:measured_TP=-14.4:measured_LRA=0.1:measured_thresh=-
      37.7:offset=-0.7:linear=true:print_format=summary output.wav


EOF
