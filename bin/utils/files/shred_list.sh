#!/usr/bin/env bash

# Shred (overwrite) the provided files

for item in "$@"
do
    echo "$(date) Shredding file: $item"
    shred --iterations=1 --remove --zero "$item"
    sync
done

