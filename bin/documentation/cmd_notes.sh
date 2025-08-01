#!/usr/bin/env bash

[[ -z "$1" ]] && \
echo "Provide program name or 'help'" >> /dev/stderr && \
exit 1

case $1 in
  help)
    echo "Provide the program name to show a quick help/usage note."
    echo "Supported programs:"
    echo "apt"
    echo "awk"
    echo "bash"
    echo "docker"
    echo "ffmpeg"
    echo "find"
    echo "handbrake"
    echo "sed"
    echo "tesseract"
    echo "tmux"
    echo "vim"
    echo "w3m"
    echo "See also the program tldr (tldr.sh)"
    ;;
  apt)
    cat <<EOF
Command: apt
Description: Debian package manager

# From https://wiki.archlinux.org/title/Pacman/Rosetta

# Install a package by name
apt install package_name

# Remove a package by name
apt remove package_name

# Search for package(s) by name/description/short description
apt search keyword

# Upgrade Packages - Install packages which have an older version 
# already installed
apt update
# and then
apt upgrade
# and then
apt dist-upgrade

# Show information about a package.
apt show package_name
EOF
    ;;
  awk)
    cat <<EOF
Command: awk
Description: Text processing tool

# grep-like use
awk '/floppy/{print \$0} /wheel/{print \$0}' /etc/group

# using BEGIN END blocks example
# view numbers in file
cat list_of_numbers.txt
99.98
0.01
# get the sum of the numbers
awk 'BEGIN{sum = 0;}{sum += \$1}END{print "sum = ", sum}' list_of_numbers.txt
sum = 99.99

# using system() for external programs
# part of the update script
docker images -a | awk '{if (\$1 != "REPOSITORY" && \$2 != "<none>") system("docker pull " \$1 ":" \$2)}'

# change the field separator
awk -F ':' '{print \$1}' /etc/passwd
root
bin
...

# last field = NF
awk -F '/' '/^\//{print \$NF}' /etc/shells
sh
bash
git-shell
...

# some built-in functions
# length of the line
awk 'length(\$0) > 10' /etc/shells
/usr/bin/git-shell
...

# getting the index of a match
awk 'match(\$0, /us/){print \$0 " has a us at position " RSTART}' /etc/shells
/usr/bin/git-shell has a us at position 2

# conditionals
ps -ef | awk '{if(\$NF == "/bin/bash") print \$0}'
user1        1502    1497  0 16:34 pts/0    00:00:00 /bin/bash
user1        3457    3452  0 16:44 pts/12   00:00:00 /bin/bash
user1       15839   15834  0 18:14 pts/14   00:00:00 /bin/bash
...

# loops
awk 'BEGIN{for(i=0;i<10;i++) print i, i*i}'
0 0
1 1
2 4
3 9
4 16
5 25
6 36
7 49
8 64
9 81

# only print lines between 10 and 20
ps -ef | awk 'NR==10, NR==20 {print NR, \$0}'

# match something in the first field and second field
# and count the rows
cmd_or_script | awk 'BEGIN{r = 0} \$1 == 1 && \$2 ~ /^regex\$/ { r += 1} END{print r}'

# extract a particular field
# only for GNU AWK http://www.gnu.org/software/gawk/
cmd_or_script | awk 'match(\$0, /price = ([0-9]+) USD/, g){print g[1]}'
EOF
    ;;
  bash)
    cat <<EOF
Command: bash
Description: Shell

# Check out this:
https://github.com/dylanaraps/pure-bash-bible
https://github.com/dylanaraps/pure-sh-bible

# diff on 2 commands outputs
diff <(tail -n5 file1.txt) <(tail -n5 file2.txt)

# simple shell expansion
# will print numbers with leading 0
for i in {01..05}
do
  echo "\${i}"
done

### wrong
#count=1
#echo "count before \$count"
#cat /tmp/foo.txt | while read -r line ; do
#  ((count++))
#  echo "\$count \$line"
#done
#echo "count after \$count"

### ok
#count=1
#echo "count before \$count"
#while read -r line ; do
#  ((count++))
#  echo "\$count \$line"
#done < /tmp/foo.txt
#echo "count after \$count"

# it does not work because "|" creates a subshell

# using [[ ]] instead of [ ]
# see http://mywiki.wooledge.org/BashGuide/SpecialCharacters
# see http://mywiki.wooledge.org/BashFAQ/031

# string splitting
input_string="abc def ghi jkl mno pqr"
echo "\${input_string}"
echo "first and last token"
echo "\${input_string%% *}"
echo "\${input_string##* }"
# greedy %% and ##
# non greedy % and #

# regex in bash
echo "blah 1234 blah" > a.txt
echo "bluh 1234 bluh" >> a.txt
echo "blah blah blah" >> a.txt

while read -r current_line
do
  # pro tip: use perl, this is a poor choice
  # must use [[:space:]] instead of a space
  if [[ "\$current_line" =~ ^blah[[:space:]](.*)[[:space:]]blah$ ]]
  then
    echo "found: \${BASH_REMATCH[0]}"
    echo "only the middle: \${BASH_REMATCH[1]}"
  fi
done < a.txt
EOF
    ;;
  docker)
    cat <<EOF
Command: docker
Description: Container management tool

# list running containers
docker ps -a

# list local images
docker images -a

# get an image from the web
docker pull ubuntu:18.04

# start a new container with a terminal
docker run -i -t 000_image_name_000 /bin/bash

# start with a shared directory
# /tmp: directory on the host
# /tmp/HOST: directory inside docker
docker run -i -t -v /tmp/TO_DOCKER:/tmp/TO_HOST 000_image_name_000 /bin/bash

# start an stopped container and attach a terminal
docker start -i -t 999_container_name_999 /bin/bash

# attach a terminal to a running container
docker exec -i -t 999_container_name_999 /bin/bash

# inside an Ubuntu/Debian docker, try installing some utilities
apt install bash-completion bzip2 cifs-utils curl dos2unix entr ethtool exfat-fuse exfat-utils gawk gdebi-core git gzip html2text htop iotop iperf3 jq locate lsof mc moreutils oping p7zip p7zip-full p7zip-rar parted progress pv rsync shellcheck tar tcpdump telnet tmux tree unzip util-linux vim visidata wget

# if needed --memory 500m

# list all volumes
docker volume ls

# cleanup old unused volumes
docker volume prune

# UNTESTED Copy all shared libraries for a binary to directory
ldd file | grep "=> /" | awk '{print \$3}' | xargs -I '{}' cp -v '{}' /destination
EOF
    ;;
  ffmpeg)
    cat <<EOF
Command: ffmpeg
Description: Audio/Video tool

# scale down a picture or video
ffmpeg -i input.jpg -vf 'scale=iw/2:ih/2' input_half_size.png
ffmpeg -i input.mp4 -vf 'scale=iw/2:ih/2' input_half_size.mp4

# extract the audio from a video
ffmpeg -i video.mp4 audio.mp3

# extract the audio from a video (higher quality)
ffmpeg -i video.mp4 -b:a 320K audio.mp3

# convert a GIF to MP4 (significant space savings)
ffmpeg -i video.gif video.mp4

# extract video from file
ffmpeg -i audio_and_video.mp4 -c copy -an video_only.mp4

# remove picture (image) from MP3 file
# -i      : input file
# -vn     : no video
# -c copy : copy the media, do not re-encode
ffmpeg -i music_with_image.mp3 -vn -c copy music_only.mp3

# reverse video
# NEVER TESTED, memory allocation problems
ffmpeg -i input.mp4 -vf reverse -af areverse reversed_video.mp4

# invert colors
ffmpeg -i image.jpg -vf negate image.inverted.jpg
ffmpeg -i video.mp4 -vf negate video.inverted.mp4

# flip video vertically
ffmpeg -i INPUT -vf vflip -c:a copy OUTPUT

# flip video horizontally
ffmpeg -i INPUT -vf hflip -c:a copy OUTPUT

# rotate 90 degrees clockwise
ffmpeg -i INPUT -vf transpose=1 -c:a copy OUTPUT

# rotate 90 degrees counterclockwise
ffmpeg -i INPUT -vf transpose=2 -c:a copy OUTPUT

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
    ;;
  find)
    cat <<EOF
Command: find
Description: Search for files

# find files by name (insensitive)
find /tmp -type f -iname '*report*.txt'

# find latest file in all sub directories
find . -type f -iname '*.deb'  -printf '%C@ %p\n' | sort -n

# find files newer than a given date
find . -type f -iname '*.deb' -newermt '1999-12-31'

# git pull on all git directories
# execdir: excute the command in the directory (cd into directory)
# execdir: the \; is important
find . -type d -name '.git' -print -execdir git pull --verbose --all --tags \;
EOF
    ;;
  handbrake)
    cat <<EOF
Command: handbrake
Description: DVD tool

# List the titles from a DVD
HandBrakeCLI --verbose --input ./path_to_dvd_dir --title 0 --scan

# Extract a title from a DVD
HandBrakeCLI --input ./path_to_dvd_dir --title 9999 --output ./output_dir/my_dvd_name.m4v
EOF
    ;;
  sed)
    cat <<EOF
Command: sed
Description: text tool

sed -E for better regex without having to cancel characters like "(" and ")"

echo 'the price is 10.00$ for 3 items' | sed -E 's/the price is ([0-9]+\.[0-9]+)\$ for ([0-9]+) items/\2 i for \1 bucks/'
3 i for 10.00 bucks
EOF
    ;;
  tesseract)
    cat <<EOF
Command: tesseract
Description: OCR command line tool

tesseract stdin stdout < image.png > image.txt
EOF
    ;;
  tmux)
    cat <<EOF
Command: tmux
Description: Terminal multiplexer

# auto attach to the latest session or start a new one
tmux a || tmux

# quick list of commands
CTRL B ?

# split horizontal
CTRL B "

# split vertical
CTRL B %

# Copy / Paste
# 1 Enter copy mode
CTRL B [
# 2 Move to starting point
Up/Down/Left/Right
# 3 Start Marking
CTRL Space
# 4 Move to end point
Up/Down/Left/Right
# 5 "Copy"
CTRL w
# 6 Paste
CTRL B ]
EOF
    ;;
  vim)
    cat <<EOF
Command: vim
Description: Text editor

# AUTOCOMPLETE
CTRL + n

# SPELLCHECK
# enable spellcheck (vim-spell-en package required)
:set spell spelllang=en_us
# move to the misspelled word and type
z=

# WHITE SPACE AND TABS
# Show white spaces and tabs in vim:
# from: https://stackoverflow.com/questions/1675688
:set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
:set list

# FORMAT (FOLD) A PARAGRAPH
# from rwxrob
# Get to a very long line (j, k, arrows...)
gw}
# } will select the whole paragraph up to the next blank line
EOF
    ;;
  w3m)
    cat <<EOF
Command: w3m
Description: Text-based web browser

# html2text conversion

curl 'http://example.com/page.html' | w3m -dump -T text/html > page.txt

# Keys

SHIFT + h : show help

# Navigation

j,k       : vim scroll
g         : top
SHIFT + g : bottom
TAB       : next link
SHIFT + s : save page (text format)
q         : quit

# URLs

a         : save URL
u         : URL preview
SHIFT + b : go back

# Search

/ : forward search
? : backward search

# Settings

o : open settings, go down to OK button to save
EOF
    ;;
  *)
    echo "Unknown program."
    exit 1
    ;;
esac

