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

header "External IP"
echo "$(wget \
--user-agent="Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3 ( .NET CLR 3.5.30729)" \
--quiet -O- http://ipecho.net/plain)"

header "Uptime, memory, load, processes"
top -n1 -b | head -n5

header "NTP stats"
ntpq -pn

echo "======================================================================"
