#!/usr/bin/env bash

# Shred (overwrite) the provided files

for item in "$@"
do
    echo "$(date --rfc-3339=second) Shredding file: ${item}"
    shred --iterations=1 --remove --zero "${item}"
    sync
done

echo "$(date --rfc-3339=second) Shredding done"
