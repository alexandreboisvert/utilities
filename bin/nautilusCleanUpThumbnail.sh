#!/bin/bash

# Thumbnails cleaner

# Context
# Ubuntu stores a shitload of thumbnails images in a directory called 
# ~/.thumbnails. These thumbnails are used as a cache when using Nautilus
# to see images.

# Problem
# The ~/.thumbnails directory can get really big (over 500 MB).

# Solution
# This script will find all the files older than the number of days 
# specified (the first version of this script used 30 days) in a 
# script variable. The script then deletes each file.

# TODO
# At this time, the script is run manually to see the results (using the 
# -v option of rm). It would be great to have a cron job or a login script 
# to do this job automatically.

# Files older than N days
olderThan=7

# Find all the PNG files older than the limit and delete them
find ~/.thumbnails/ -type f -mtime +$olderThan -name "*.png" -exec rm -v -- {} \;

