#!/usr/bin/env bash
cat << EOF

# Handbrake (command line) notes

######################################################################
# List the titles from a DVD

HandBrakeCLI --verbose --input ./path_to_dvd_dir --title 0 --scan

######################################################################
# Extract a title from a DVD

HandBrakeCLI --input ./path_to_dvd_dir --title 9999 --output ./output_dir/my_dvd_name.m4v


EOF
