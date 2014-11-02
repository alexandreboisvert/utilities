#!/bin/bash

# Get a quick overview of the system

header(){
    echo "======================================================================"
    echo "$1"
    echo "======================================================================"
}

header "Disk Usage (Space)"
df -h

header "Disk Usage (Inodes)"
df -i

header "IP addresses"
ip a | grep inet | grep -v inet6

header "Uptime, memory, load, processes"
top -n1 -b | head -n5

header "NTP stats"
ntpq -pn

echo "======================================================================"
