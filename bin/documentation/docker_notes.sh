#!/usr/bin/env bash

cat << EOF

# list running containers
docker ps -a

# list local images
docker images -a

# get an image from the web
docker pull ubuntu:18.04

# start a new container with a terminal
docker run -i -t 000_image_name_000 /bin/bash

# start with a shared directory
# /tmp: directory on the host
# /tmp/HOST: directory inside docker
docker run -i -t -v /tmp/TO_DOCKER:/tmp/TO_HOST 000_image_name_000 /bin/bash

# start an stopped container and attach a terminal
docker start -i -t 999_container_name_999 /bin/bash

# attach a terminal to a running container
docker exec -i -t 999_container_name_999 /bin/bash

# inside an Ubuntu/Debian docker, try installing some utilities
apt install bash-completion bzip2 cifs-utils curl ethtool exfat-fuse exfat-utils gawk gdebi-core git gzip html2text htop iotop iperf locate lsof mc oping p7zip p7zip-full p7zip-rar parted pv rsync shellcheck tar tcpdump telnet tmux tree unzip util-linux vim wget

# if needed --memory 500m

# list all volumes
docker volume ls

# cleanup old unused volumes
docker volume prune

EOF
