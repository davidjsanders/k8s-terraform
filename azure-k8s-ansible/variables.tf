# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      variables.tf
# Environments:   all
# Purpose:        Module to define variables used in various tf
#                 scripts. Values are provided in .tfvars files
#
# Created on:     08 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 08 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------
# 10 Sep 2019  | David Sanders               | Add jump pip variables.
# -------------------------------------------------------------------

# Dynamic DNS Variables
variable "ddns_domain_name" {}
variable "jumpbox_domain_name" {}
variable "wild_username" {}
variable "wild_password" {}
variable "jumpbox_username" {}
variable "jumpbox_password" {}

#
# Auth variables
#
variable "auth_file" {}
# To generate the auth file run the command below and 
# enter a password and confirm when prompted:
#
# htpasswd -c ./auth <theusername>
# 
# Then cat the auth file and base64 encode it:
#
# cat ./auth | base64
#
# Then update the .tfvars file with the output of the cat command:
#
# auth_file="..........."

#
# Kubernetes Variables
#
variable "k8s_version" {
  default = "1.14.3-00"
}

#
# Service Principal Variables
#
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

#
# General structure Variables
#
variable "target" {}
variable "environ" {}
variable "location" {}

#
# Resource groups
#
variable "resource-group-name" {}

#
# Datadisk Variables
#
variable "disk-rg-name" {}
variable "disk-master-name" {}


#
# Network Variables
#
variable "vnet-name" {}
variable "vnet-resource-group" {}
variable "vnet-cidr" {}
variable "subnet-mgt-name" {}
variable "subnet-mgt-cidr" {}
variable "subnet-wrk-name" {}
variable "subnet-wrk-cidr" {}
variable "subnet-jump-name" {}
variable "subnet-jump-cidr" {}
variable "subnet-lb-name" {}
variable "subnet-lb-cidr" {}
variable "nsg-name" {}
variable "dc-prefix" {}
variable "public-dns-name" {}
variable "lb-static-pip" {}
variable "lb-prefix" {}
variable "lb-name" {}
variable "jump-name" {}
variable "jump-prefix" {}

variable "worker-static-ip-1" {}
variable "worker-static-ip-2" {}
variable "master-static-ip-1" {}
variable "master-static-ip-2" {}
variable "master-static-ip-3" {}
variable "jumpbox-static-ip" {}
variable "nic-name" {}

#
# Load Balancer Variables
#
variable "lb-frontend-port" {}
variable "lb-backend-port" {}

#
# Storage Account Variables
#
variable "sa-name" {}
variable "sa-persistent-name" {}

#
# Tags
#
variable "tags" {
  type = "map"
  default = {
    tag-description = "!!Not Defined!!"
    tag-billing     = "!!Not Defined!!"
    tag-environment = "!!Not Defined!!"
  }
}

#
# VM Variables
#
variable "vm-name" {}
variable "image-name" {}
variable "image-version" {}
variable "vm-size" {}
variable "manager-vm-size" {}
variable "worker-vm-size" {}
variable "jumpbox-vm-size" {}
variable "image-rg" {}
variable "private-key" {}
variable "delete-osdisk-on-termination" {}
variable "delete-datadisk-on-termination" {}
variable "vm-disable-password-auth" {}
variable "vm-adminpass" {}
variable "vm-adminuser" {}
variable "vm-osdisk-type" {}

#
# Docker Variables
#
variable "docker_username" {}
variable "docker_password" {}
variable "docker_registry" {}
variable "docker_image" {}
variable "docker_tag" {}

#
# Helm Variables
#
variable "helm_service_account_name" {}
