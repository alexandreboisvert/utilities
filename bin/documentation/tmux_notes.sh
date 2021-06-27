#!/usr/bin/env bash

cat << EOF

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
