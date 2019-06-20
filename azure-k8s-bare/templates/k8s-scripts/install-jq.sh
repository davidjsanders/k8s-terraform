#!/bin/bash
source ~/scripts/banner.sh
banner "install-jq.sh" "apt-get install jq"

sudo DEBIAN_FRONTEND=noninteractive \
  apt-get -o Dpkg::Options::="--force-confold" \
  -q \
  --yes \
  install \
    jq
