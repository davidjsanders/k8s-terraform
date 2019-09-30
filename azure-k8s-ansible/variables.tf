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
# 19 Sep 2019  | David Sanders               | Add letsencrypt vars.
# -------------------------------------------------------------------
# 23 Sep 2019  | David Sanders               | Add map vars for
#              |                             | workers.
# -------------------------------------------------------------------
# 25 Sep 2019  | David Sanders               | Add new kubernetes
#              |                             | variable for kubeadm.
#              |                             | Tidy up variables and
#              |                             | naming conventions.
# -------------------------------------------------------------------

variable "workers" {
  default = {
    vm-count    = 2
    prefix      = "k8s-worker"
    vm-size     = "Standard_DS3_v2"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "18.04-LTS"
    version     = "latest"
    delete_os   = true
    delete_data = true
  }
}
variable "masters" {
  default = {
    vm-count    = 1
    prefix      = "k8s-master"
    vm-size     = "Standard_DS2_v2"
    publisher   = "Canonical"
    offer       = "UbuntuServer"
    sku         = "18.04-LTS"
    version     = "latest"
    delete_os   = true
    delete_data = true
  }
}

# Nexus Variables
variable "nexus_username" {}
variable "nexus_password" {}

# Letsencrypt Variables
variable "email" {}
variable "nexus_dns_name" {}

# PostgreSQL Variables
variable "postgres_db" {}
variable "postgres_user" {}
variable "postgres_password" {}

# Dynamic DNS Variables
variable "ddns_domain_name" {
}

variable "jumpbox_domain_name" {
}

variable "wild_username" {
}

variable "wild_password" {
}

variable "jumpbox_username" {
}

variable "jumpbox_password" {
}

#
# Auth variables
#
variable "auth_file" {
}

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
variable "kubeadm_api" {
  default = "kubeadm.k8s.io"
}
variable "kubeadm_api_version" {
  default = "v1beta1"
}
variable "kubeadm_cert_dir" {
  default = "/etc/kubernetes/pki"
}
variable "kubeadm_cluster_name" {
  default = "kubernetes"
}
variable "kubeadm_pod_subnet" {
  default = "192.168.0.0/16"
}
variable "kubeadm_service_subnet" {
  default = "10.96.0.0/12"
}
variable "kubeadm_k8s_version" {
  default = "v1.14.3"
}
variable "os_k8s_version" {
  default = "1.14.3-00"
}

#
# Service Principal Variables
#
variable "client_id" {
}

variable "client_secret" {
}

variable "tenant_id" {
}

variable "subscription_id" {
}

#
# General structure Variables
#
variable "target" {
}

variable "environ" {
}

variable "location" {
}

#
# Resource groups
#
variable "resource-group-name" {
}

#
# Datadisk Variables
#
variable "disk-rg-name" {
}

variable "disk-master-name" {
}

#
# Network Variables
#
variable "vnet-name" {
}

variable "vnet-cidr" {
}

variable "subnet-master-name" {
}

variable "subnet-worker-name" {
}

variable "subnet-jump-name" {
}

variable "nsg-name" {
}

variable "lb-name" {
}

#
# Load Balancer Variables
#
variable "lb-ports" {
  default = [
    {
        name = "http-port80"
        protocol = "Tcp"
        frontend-port = "80"
        backend-port = "30888"
    },
    {
        name = "https-port443"
        protocol = "Tcp"
        frontend-port = "443"
        backend-port = "30443"
    }
  ]
}

#
# NSG Rules
#
variable "nsg-rules-jumpbox" {
  default = [
    {
        name                        = "NSG-ALLOW-22-JUMPBOX"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "22"
        source_address_prefix       = "Internet"
    }
  ]
}
variable "nsg-rules-workers" {
  default = [
    {
        name                        = "NSG-ALLOW-80-WORKERS"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "30888"
        source_address_prefix       = "Internet"
    },
    {
        name                        = "NSG-ALLOW-443-WORKERS"
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "30443"
        source_address_prefix       = "Internet"
    }
  ]
}

#
# Storage Account Variables
#
variable "sa-name" {
}

variable "sa-persistent-name" {
}

#
# Tags
#
variable "tags" {
  type = map(string)
  default = {
    tag-description = "!!Not Defined!!"
    tag-billing     = "!!Not Defined!!"
    tag-environment = "!!Not Defined!!"
  }
}

#
# VM Variables
#
variable "vm-jumpbox-name" {
}

variable "vm-master-name" {
}

variable "image-rg" {
}

variable "image-name" {
}

variable "image-version" {
}

variable "master-vm-size" {
}

variable "worker-vm-size" {
}

variable "jumpbox-vm-size" {
}

variable "private-key" {
}

variable "delete-osdisk-on-termination" {
}

variable "delete-datadisk-on-termination" {
}

variable "vm-disable-password-auth" {
}

variable "vm-adminpass" {
}

variable "vm-adminuser" {
}

variable "vm-osdisk-type" {
}

#
# Helm Variables
#
variable "helm_service_account_name" {
}

