echo "*** $(date) *** apt-get install -y docker.io"
sudo apt-get install -y docker.io
sleep 2

echo "*** $(date) *** systemctl enable docker"
sudo systemctl enable docker.service
sleep 2
