#!/bin/bash

# Stop all running containers
docker stop $(docker ps -aq)

# Remove all containers
docker rm -f $(docker ps -aq)

# Remove all images
docker rmi $(docker images -q)

#prune
docker builder prune --all --force

# Optionally, remove all volumes
# Uncomment the following line if you want to remove all Docker volumes
# docker volume rm $(docker volume ls -q)

echo "All Docker containers, images, and optional volumes have been removed."
