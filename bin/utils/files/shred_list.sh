#!/usr/bin/env bash

# Shred (overwrite) the provided files

set -e

for item in "$@"
do
    echo "$(date) Processing: $item"
    shred --iterations=1 --remove --zero "$item"
    sync
done

