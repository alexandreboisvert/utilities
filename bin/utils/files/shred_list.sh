#!/usr/bin/env bash

# Shred (overwrite) the provided files

for item in "$@"
do
    echo "$(date '+%Y-%m-%d %H:%M:%S') Shredding file: ${item}"
    shred --iterations=1 --remove --zero "${item}"
    sync
done

echo "$(date '+%Y-%m-%d %H:%M:%S') Shredding done"
