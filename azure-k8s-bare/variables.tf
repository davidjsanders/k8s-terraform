# -------------------------------------------------------------------
#
# Module:         terraform-reference-app/green
# Submodule:      variables.tf
# Purpose:        Define the variables used in the terraform script.
#
#                 **NOTE** No *ACTUAL* values are defined here, only
#                          the variables themselves; values are
#                          defined in .tfvars files.
#
# Created on:     22 August 2018
# Created by:     David Sanders
# Creator email:  david.sanders2@loblaw.ca
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 22 Aug 2018  | David Sanders               | First release and
#                                            | valid creation of
#                                            | sample app.
# -------------------------------------------------------------------

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
variable "elb-static-ip" {}
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

