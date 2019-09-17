#!/usr/bin/env bash
echo
echo "Set permissions on SSH keys"
echo
chmod 0600 ~/.ssh/config ~/.ssh/azure_pk

echo
echo "apt-get update"
echo
sudo DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" -q update

echo
echo "apt-get upgrade"
echo
sudo DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" -q --yes upgrade

echo
echo "apt-get install software-properties-common"
echo
sudo DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" -q --yes install software-properties-common

echo
echo "apt-add-repository ansible/ansible"
echo
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository --yes ppa:ansible/ansible

echo
echo "apt-get update"
echo
sudo DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" -q update

echo
echo "apt-get install ansible"
echo
sudo DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" -q --yes install ansible
echo 'Done.'

echo
echo "Configure hosts file"
echo
cat ~/hosts | sudo tee /etc/hosts

echo
echo "Configure Ansible inventory"
echo
sudo cp ~/inventory /etc/ansible/hosts
sudo chown root:root /etc/ansible/hosts

echo
echo "Execute Ansible playbook"
echo
cd ~/playbooks
ansible-playbook playbook.yml | tee ~/playbook.out
