echo "*** $(date) *** apt-get install -y docker.io"
sudo DEBIAN_FRONTEND=noninteractive \
        apt-get -o Dpkg::Options::="--force-confold" \
        -q \
        --yes \
        install docker.io
sleep 2

echo "*** $(date) *** systemctl enable docker"
sudo systemctl enable docker.service
sleep 2
