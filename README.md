# k8s-terraform
Terraform to script a Kubernetes cluster on Azure with Calico (for policy) and Canal.

## Introduction
This Terraform script uses a [centralized library](https://github.com/dsandersAzure/terraform-library) which provides custom Terraform modules to provision:

* A Kubernetes (k8s) master
* Two k8s workers
* A jumpbox

The script then uses a provisioner to install Docker and k8s on the master and the workers before joining the workers to the cluster.

There are four helper scripts included in the repo which abstract terraform commands:

* helpers/init.sh
* helpers/plan.sh
* helpers/apply.sh
* helpers/destroy.sh

## Required Azure Resources
The following Azure resources need to be created in advance of running the scripts:

* `RG-TFSTATE` - A resource group for containing state objects
  * `terraformstate` - A Storage Account in RG-TFSTATE used to contain blobs for state
* `RG-K8S-PERSISTENT` - A resource group for containing persistent objects
  * `K8S-MASTER-DATA-DISK` - A managed disk which can be used for persistent storage; note, this should be 
> NOTE Persistent objects will incur charges; If you don't want on-going charges DO NOT use persistent objects (see below)
* 

## Required Files
In the azure-k8s-bare directory, there is a sub-directory called *targets*; this directory needs to contain the following files:

* beconf.tfvars
* credentials.secret
* dev.tfvars

Instructions on how to set these up are shown below.

## Running the script
After forking and cloning the repo and populating the azure-k8s-bare/targets directory, you can deploy the script as follows:

```
  mkdir -p /path/to/logs
  cd /path/to/k8s-terraform/azure-k8s-bare
  ../helpers/init.sh dev
  ../helpers/plan.sh dev
  ../helpers/apply.sh dev | tee /path/to/logs/apply-mmddyy-hhmm.log
```

> Note, the ../helpers/apply.sh script can take around 25 minutes to run! This is because it creates the Azure servics **and** configures all of the machines for Docker and k8s.

## Destroying the environment
To remove the environment run:

```
  cd /path/to/k8s-terraform/azure-k8s-bare
  ../helpers/destroy.sh dev --force
```

This *should* clear up all resources created by the scripts; **however** it is your responsibility to ensure that Azure has removed all of the resourcs.

> In an 'emergency', go to the Azure console and delete the resource group created by the scripts.