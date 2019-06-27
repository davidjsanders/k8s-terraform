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

# Include the banner function for logging purposes (see 
# templates/banner.sh)
#
source ~/scripts/banner.sh

banner "install-docker.sh" "Install Docker CE (latest), docker-compose and apache2-utils"

banner "install-docker.sh" "Fetch Docker 18.09.6 tarball"
current_directory=$(pwd)

mkdir -p /tmp/docker-install
cd /tmp/docker-install
wget https://download.docker.com/linux/static/stable/x86_64/docker-18.09.6.tgz
wget https://raw.githubusercontent.com/moby/moby/master/contrib/init/systemd/docker.socket
wget https://raw.githubusercontent.com/moby/moby/master/contrib/init/systemd/docker.service

banner "install-docker.sh" "Un-tar Docker 18.09.6 tarball"
tar xzvf docker-18.09.6.tgz

banner "install-docker.sh" "Copy all Docker files to /usr/bin"
sudo cp docker/* /usr/bin/

banner "install-docker.sh" "Change docker.service from -H fd:// to -H unix:// for Ubuntu"
sed 's/dockerd -H fd:\/\//dockerd -H unix:\/\//g' docker.service

banner "install-docker.sh" "Copy all systemd files to /lib/systemd/system"
sudo cp docker.service /etc/systemd/system
sudo cp docker.socket /etc/systemd/system

banner "install-docker.sh" "Reload systemd"
sudo systemctl daemon-reload

banner "install-docker.sh" "Copy Docker files to /usr/local/bin"
sudo cp docker/docker /usr/local/bin/

banner "install-docker.sh" "Enable and start the Docker service"
sudo groupadd -g 10000 docker
sudo systemctl enable docker
sudo systemctl start docker

banner "install-docker.sh" "Return to ${current_directory}"
cd ${current_directory}

banner "install-docker.sh" "Install docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sleep 2
