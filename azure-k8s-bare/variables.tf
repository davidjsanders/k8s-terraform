# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      variables.tf
# Environments:   all
# Purpose:        Module to define variables used in various tf
#                 scripts. Values are provided in .tfvars files
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

# Dynamic DNS Variables
variable "ddns_domain_name" {}
variable "k8s_dev_username" {}
variable "jenkins_dev_username" {}
variable "sonarqube_dev_username" {}
variable "nexus_dev_username" {}
variable "traefik_dev_username" {}
variable "k8s_dev_password" {}
variable "jenkins_dev_password" {}
variable "sonarqube_dev_password" {}
variable "nexus_dev_password" {}
variable "traefik_dev_password" {}

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
variable "nsg-name" {}
variable "dc-prefix" {}
variable "public-dns-name" {}
variable "lb-static-pip" {}
variable "lb-prefix" {}
variable "lb-name" {}

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
