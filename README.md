# k8s-terraform
Terraform to script a Kubernetes cluster on Azure with Calico (for policy) and Canal.

## Introduction
This Terraform script uses a [centralized library](https://github.com/dsandersAzure/terraform-library) which provides custom Terraform modules to provision:

* A Kubernetes (k8s) master
* n k8s workers (Specified in the environment.tfvars file)
* A jumpbox
* An Azure Load Balancer (Layer 4) with front-end and back-end connections to the Worker availability set
* Traefik as an Ingress controller
* NFS for serving (existing) persistent storage through the cluster
* Sample services (nginx) with xip.io addresses for the Ingress

The script then uses a provisioner to install Docker and k8s on the master and the workers before joining the workers to the cluster. The script also provisions persistent storage (via NFS), Traefik as an Ingress controller, a sample nginx app running and a private registry (by default accessed through
a node port on k8s-master:32000)

> NOTE: The registry does not run on the master (which is tainted) but the master is used for the node to target and the workload goes to whichever node contains the pod that is handling registry traffic.

There are four helper scripts included in the repo which abstract terraform commands:

* helpers/init.sh
* helpers/plan.sh
* helpers/apply.sh
* helpers/destroy.sh

## Required Resources
The following resources need to be created in advance of running the scripts:

* Terraform must be installed on the workstation running the script.
> NOTE The scripts were tested with v0.11.8
* An Azure subscription
> NOTE Typically costs incurred have been around about CAD$4.50 for 2 to 2.5 hours work per evening on the environment.
* `RG-TFSTATE` - A resource group for containing state objects
  * `terraformstate` - A Storage Account in RG-TFSTATE used to contain blobs for state
> NOTE Persistent objects will incur charges; If you don't want on-going charges DO NOT use persistent objects (see below)
* `RG-K8S-PERSISTENT` - A resource group for containing persistent objects
  * `K8S-MASTER-DATA-DISK` - A managed disk which can be used for persistent storage; note, this can be ssd or hdd BUT must be in the same location as the VMs, e.g. East US.
> NOTE Persistent objects will incur charges, even when your cluster is deleted and not running; If you don't want on-going charges DO NOT use persistent objects (see below)
* A private key (created with `ssh-keygen -b 4096 -t rsa`) which is specified in the dev.tfvars file and copied to all the Azure VMs.
> NOTE The private key *must not* have a keyphrase as there will be no ability to provide it to the provisioner. Also, it is highly recommended to not use this private key pair for any other resources.

## Required Files
In the azure-k8s-bare directory, there is a sub-directory called *targets*; this directory needs to contain the following files:

* beconf.tfvars
* credentials.secret
* dev.tfvars

Instructions on how to set these up are shown below and samples are in the samples directory.

## Running the script
After forking and cloning the repo and populating the azure-k8s-bare/targets directory, you can deploy the script as follows:

```
  mkdir -p /path/to/logs
  cd /path/to/k8s-terraform/azure-k8s-bare
  ../helpers/init.sh dev
  ../helpers/plan.sh dev
  ../helpers/apply.sh dev | tee /path/to/logs/apply-mmddyy-hhmm.log
```

> Note 1: the `dev` in the command tells the helper scripts to expect to find variable values in a file called `dev.tfvars` in the targets directory. If you create other environments, e.g. prod, then create them in a `prod.tfvars` file and pass `prod` instead of `dev`. This is useful for varying the resources between environment targets (e.g. 2 small workers for dev and 5 big workers for prod.). 

> About `dev`: When dev is found in the environment name, the scripts will append a random 4 digit number to ensure uniqueness; this is usefull as it allows you to have multiple terraform workspaces and deploy without worrying about uniqueness.

> Note 2: The .gitignore in the project ignores **ALL** files ending in .tfvars to help prevent secret leakage.

> Note 3: The ../helpers/apply.sh script can take around 15 minutes to run! This is because it creates the Azure servics **and** configures all of the machines for Docker and k8s.

## Destroying the environment
To remove the environment run:

```
  cd /path/to/k8s-terraform/azure-k8s-bare
  ../helpers/destroy.sh dev --force
```

This *should* clear up all resources created by the scripts; **however** it is your responsibility to ensure that Azure has removed all of the resourcs.

> In an 'emergency', go to the Azure console and delete the resource group created by the scripts.