#!/usr/bin/env bash

# quick-and-dirty cleanup script
# replace non-ascii characters
# useful for source code files

sed \
  --follow-symlinks \
  --in-place \
  --expression='s/“/"/g' \
  --expression='s/”/"/g' \
  --expression="s/’/'/g" \
  --expression="s/‘/'/g" \
  --expression='s/—/-/g' \
  --expression='s/–/-/g' \
  --expression='s/\xA0/ /g' \
  --expression='s/…/.../g' \
  --expression='s/•/*/g' \
  --expression='s/À/A/g' \
  --expression='s/Á/A/g' \
  --expression='s/Â/A/g' \
  --expression='s/Ã/A/g' \
  --expression='s/Ä/A/g' \
  --expression='s/Å/A/g' \
  --expression='s/Æ/AE/g' \
  --expression='s/Ç/C/g' \
  --expression='s/È/E/g' \
  --expression='s/É/E/g' \
  --expression='s/Ê/E/g' \
  --expression='s/Ë/E/g' \
  --expression='s/Ì/I/g' \
  --expression='s/Í/I/g' \
  --expression='s/Î/I/g' \
  --expression='s/Ï/I/g' \
  --expression='s/Ñ/N/g' \
  --expression='s/Ò/O/g' \
  --expression='s/Ó/O/g' \
  --expression='s/Ô/O/g' \
  --expression='s/Õ/O/g' \
  --expression='s/Ö/O/g' \
  --expression='s/Ø/O/g' \
  --expression='s/Ù/U/g' \
  --expression='s/Ú/U/g' \
  --expression='s/Û/U/g' \
  --expression='s/Ü/U/g' \
  --expression='s/à/a/g' \
  --expression='s/á/a/g' \
  --expression='s/â/a/g' \
  --expression='s/ã/a/g' \
  --expression='s/ä/a/g' \
  --expression='s/å/a/g' \
  --expression='s/æ/ae/g' \
  --expression='s/ç/c/g' \
  --expression='s/è/e/g' \
  --expression='s/é/e/g' \
  --expression='s/ê/e/g' \
  --expression='s/ë/e/g' \
  --expression='s/ì/i/g' \
  --expression='s/í/i/g' \
  --expression='s/î/i/g' \
  --expression='s/ï/i/g' \
  --expression='s/ñ/n/g' \
  --expression='s/ò/o/g' \
  --expression='s/ó/o/g' \
  --expression='s/ô/o/g' \
  --expression='s/õ/o/g' \
  --expression='s/ö/o/g' \
  --expression='s/ø/o/g' \
  --expression='s/ù/u/g' \
  --expression='s/ú/u/g' \
  --expression='s/û/u/g' \
  --expression='s/ü/u/g' \
  --expression='s/Œ/OE/g' \
  --expression='s/œ/oe/g' \
  "$1"
