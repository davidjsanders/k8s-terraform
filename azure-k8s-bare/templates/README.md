# The templates directory
The azure-k8s-bare/templates directory in the repo provides a set of bash shell scripts used to provision Kubernetes the hard way! They are imperative actions that occur in a strict order fired off by the terraform module `provisioner-k8s.tf`.

The provisioner connects to the jumpbox (as the only externally accessible source in the vnet) via the public IP, copies a number of files (some of which have been pre-processed using Terraform data modules - see data.tf) and then executes a number of steps on the jumpbox to:

* Configure the hosts file for each node so that short-names can be used (k8s-master, k8s-worker-1, k8s-worker-2, etc.)
* Ensure the private key is set to 0600
* Set various scripts to be executable (chmod +x)
* Create a logs directory
* Run the script `scp-commands.sh`
* Run the script `ssh-commands.sh`

## scp-commands.sh
The scp-commands.sh copies files from the jumpbox (which were provisioned by Terraform) to every node:

* The private key pair
* An ssh config file
* A hosts file (with the IPs and short-names)
* The scripts directory (containing all necessary scripts)

## ssh-commands.sh
The ssh-commands.sh script allows the jumpbox to issue remote ssh commands to each of the nodes to initiate setup of Docker, docker-compose, kompose, kubernetes and other resources. This script is the key script in actually standing up the various nodes, ensuring they have the correct software, versions and configurations. It is complex but it's worth reading and reviewing to understand how k8s needs to be provisioned.

> NOTE: An ansible playbook is currently being developed to perform the imperative steps as a declarative set of roles, tasks and activities. Check the status of the ansible directory (if it's *not* there, it hasn't been written yet.)