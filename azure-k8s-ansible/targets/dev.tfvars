# -------------------------------------------------------------------
#
# Module:         terraform-reference-app/green
# Submodule:      dev.tfvars
# Purpose:        Sets of values for the variables used in the
#                 terraform scripts designed for use in development.
#
# Created on:     22 August 2018
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 22 Aug 2018  | David Sanders               | First release and
#                                            | valid creation of
#                                            | sample app.
# -------------------------------------------------------------------
# 14 Jul 2019  | David Sanders               | Update vars
# -------------------------------------------------------------------
# 26 Aug 2019  | David Sanders               | Add DDNS creds
# -------------------------------------------------------------------
# 08 Sep 2019  | David Sanders               | Ported to ansible
#              |                             | module.
# -------------------------------------------------------------------
# 19 Sep 2019  | David Sanders               | Add letsencrypt
#              |                             | vars.
# -------------------------------------------------------------------
# 23 Sep 2019  | David Sanders               | Add map vars for
#              |                             | workers.
# -------------------------------------------------------------------
# 23 Sep 2019  | David Sanders               | Add new k8s vars for
#              |                             | kubeadm.
#              |                             | Add vm prefix.
#              |                             | Removed secrets from
#              |                             | tfvars to enable config
#              |                             | to reside on GitHub.
# -------------------------------------------------------------------

#
# New VM variables
#
workers = {
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
masters = {
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

#
# Letsencrypt variables
#
email="dsanderscanada@gmail.com"
nexus_dns_name="nexus-tls.dgsd-consulting.com"

#
# Kubernetes Variables
#
os_k8s_version="1.14.3-00"
kubeadm_api = "kubeadm.k8s.io"
kubeadm_api_version = "v1beta1"
kubeadm_cert_dir = "/etc/kubernetes/pki"
kubeadm_cluster_name = "kubernetes"
kubeadm_pod_subnet = "192.168.0.0/16"
kubeadm_service_subnet = "10.96.0.0/12"
kubeadm_k8s_version = "v1.14.3"

#
# Resource Groups
#
resource-group-name = "K8S"

#
# Storage Account Variables
#
sa-name = "k8s"
sa-persistent-name = "bootdiag"

#
# Location and Tags
#
location = "eastus"
target = "DJS"
environ = "EUS"
tags = {
    tag-description = "K8S Bare metal"
    tag-billing     = "DJS MSDN Subscription"
    tag-environment = "DEV"
    tag-target      = "East US"
    tag-bg          = "dev"
}

#
# Networks
#
vnet-name = "K8S"
vnet-cidr = "10.70.0.0/20"
subnet-master-name = "MGT"
subnet-worker-name = "WRK"
subnet-jump-name = "JUMP"
nsg-name = "K8S"

#
# Load Balancer
#
lb-ports = [
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
lb-name = "k8slfd"

#
# Network Security Group Rules
#
nsg-rules-jumpbox = [
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
nsg-rules-workers = [
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


#
# VM
#
vm-jumpbox-name = "k8s-jumpbox"
vm-master-name = "k8s-master"
master-vm-size = "Standard_DS2_v2"
worker-vm-size = "Standard_DS3_v2"
jumpbox-vm-size = "Standard_DS1_v2"
image-name = "img-ubuntu"
image-version = "1-0-26-u"
image-rg = "RG-ENGINEERING"
private-key = "~/.ssh/azure-pk"
delete-osdisk-on-termination = true
delete-datadisk-on-termination = false
vm-disable-password-auth = true
vm-osdisk-type = "Premium_LRS"

#
# Helm
#
helm_service_account_name = "tiller"
