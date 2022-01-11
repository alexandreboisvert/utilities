#!/usr/bin/env bash

cat <<EOF

# From https://wiki.archlinux.org/title/Pacman/Rosetta

# Install a package(s) by name
pacman -S

# Remove a package(s) by name
pacman -Rs

# Search for package(s) by name/description/short description
pacman -Ss

# Upgrade Packages - Install packages which have an older version already installed
pacman -Syu

# Show all or most information about a package.
pacman -Si # remote query
pacman -Qi # local query

# Arch Linux alternative to "apt install build-essential"
pacman -S base-devel

EOF
