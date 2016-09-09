#!/bin/bash

# Thumbnails cleaner

# Context
# Ubuntu stores a shitload of thumbnails images in a directory called 
# ~/.thumbnails. These thumbnails are used as a cache when using a file
# manager.

# Problem
# The ~/.thumbnails directory can get really big (over 500 MB).

# Solution
# This script will find all the files older than the number of days 
# specified (the first version of this script used 30 days) in a 
# script variable. The script then deletes each file.

# Files older than N days
olderThan=1

# Find all the PNG files older than the limit and delete them
find ~/.thumbnails/ -type f -mtime "+${olderThan}" -name '*.png' -exec shred --remove --zero {} \;

# The sxiv programs also creates a large amount of thumbnails
find ~/.cache/sxiv -type f -exec shred --remove --zero {} \;
find ~/.cache/sxiv -type d -exec rm -r {} \;

