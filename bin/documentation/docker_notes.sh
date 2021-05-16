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
docker run -i -t -v /tmp:/tmp/HOST 000_image_name_000 /bin/bash

# start an stopped container and attach a terminal
docker start -i -t 999_container_name_999 /bin/bash

# attach a terminal to a running container
docker exec -i -t 999_container_name_999 /bin/bash

EOF
