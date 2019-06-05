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
# Network Variables
#
variable "vnet-name" {}
variable "vnet-resource-group" {}
variable "subnet-docker-mgt-name" {}
variable "subnet-docker-mgt-cidr" {}
variable "subnet-docker-wrk-name" {}
variable "subnet-docker-wrk-cidr" {}
variable "nsg-docker-name" {}
variable "dc-prefix" {}
variable "public-dns-name" {}
variable "elb-static-ip" {}
variable "worker-static-ip-1" {}
variable "worker-static-ip-2" {}
variable "master-static-ip-1" {}
variable "master-static-ip-2" {}
variable "master-static-ip-3" {}
variable "nic-name" {}

#
# Load Balancer Variables
#
variable "lb-frontend-port" {}
variable "lb-backend-port" {}

#
# Storage Account Variables
#
variable "sa-docker-name" {}
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
variable "docker-vm-name" {}
variable "docker-image-name" {}
variable "docker-image-version" {}
variable "docker-vm-size" {}
variable "docker-manager-vm-size" {}
variable "docker-worker-vm-size" {}
variable "docker-image-rg" {}
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

