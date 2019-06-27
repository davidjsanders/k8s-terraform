#!/bin/bash
# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      templates/k8s-scripts/install-docker.sh
# Environments:   all
# Purpose:        Install and enable Docker using the apt package 
#
# Created on:     23 June 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 23 Jun 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 26 Jun 2019  | David Sanders               | Install Docker from
#              |                             | binaries to address.
#              |                             | issues with Ubuntu bug
#              |                             | 1813003.
# -------------------------------------------------------------------
# 27 Jun 2019  | David Sanders               | Remove docker-compose
#              |                             | from script for greate
#              |                             | granularity.
# -------------------------------------------------------------------

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

banner "install-docker.sh" "Install Docker CE (latest), docker-compose and apache2-utils"

# Get the current directory so we can cd back to it
banner "install-docker.sh" "Fetch Docker 18.09.6 tarball"
current_directory=$(pwd)

# Make a temporary directory, change to it and download the Docker
# tarball, service definition and socket definition.
mkdir -p /tmp/docker-install
cd /tmp/docker-install
wget https://download.docker.com/linux/static/stable/x86_64/docker-18.09.6.tgz
wget https://raw.githubusercontent.com/moby/moby/master/contrib/init/systemd/docker.socket
wget https://raw.githubusercontent.com/moby/moby/master/contrib/init/systemd/docker.service

# Expand the tarball
banner "install-docker.sh" "Un-tar Docker 18.09.6 tarball"
tar xzvf docker-18.09.6.tgz

# Copy the executable files to the /usr/bin directory
banner "install-docker.sh" "Copy all Docker files to /usr/bin"
sudo cp docker/* /usr/bin/

# Modify the service definition to point to unix:// instead of fd://
# because this is needed for Ubuntu 18.04.
banner "install-docker.sh" "Change docker.service from -H fd:// to -H unix:// for Ubuntu"
sed 's/dockerd -H fd:\/\//dockerd -H unix:\/\//g' docker.service

# Copy the systemd files to /etc/systemd/system
banner "install-docker.sh" "Copy all systemd files to /lib/systemd/system"
sudo cp docker.service /etc/systemd/system
sudo cp docker.socket /etc/systemd/system

# Reload the daemon
banner "install-docker.sh" "Reload systemd"
sudo systemctl daemon-reload

# Copy the docker executable to /usr/local/bin
banner "install-docker.sh" "Copy Docker files to /usr/local/bin"
sudo cp docker/docker /usr/local/bin/

# Define the docker group with a gid of 10000
banner "install-docker.sh" "Define the docker group"
sudo groupadd -g 10000 docker

# Enable and start the Docker service
banner "install-docker.sh" "Enable and start the Docker service"
sudo systemctl enable docker
sudo systemctl start docker

# Return to the previous directory location
cd ${current_directory}

sleep 2
