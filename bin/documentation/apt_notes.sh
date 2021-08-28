#!/usr/bin/env bash

cat <<EOF

# From https://wiki.archlinux.org/title/Pacman/Rosetta

# Install a package(s) by name
apt install

# Remove a package(s) by name
apt remove

# Search for package(s) by name/description/short description
apt search

# Upgrade Packages - Install packages which have an older version already installed
apt update
# and then
apt upgrade
# and then
apt dist-upgrade

# Show all or most information about a package.
apt show

EOF
