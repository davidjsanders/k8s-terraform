# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-ansible-inventory.tf
# Environments:   all
# Purpose:        Module to set the Ansible inventory (hosts) file
#                 to contain the actual private IP addresses of all
#                 hosts.
#
# Created on:     11 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 11 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-ansible-inventory" {
  template = file("ansible/multi-inventory")

  vars = {
    master                   = azurerm_network_interface.k8s-nic-master.private_ip_address
    masters                  = ""
    workers = join(
      "\n",
      [
        for i in range(0, var.workers.vm-count) : 
          format(
            "%s-%01d    ansible_host=%s",
            var.workers.prefix,
            i+1,
            azurerm_network_interface.k8s-nic-workers.*.private_ip_address[i]
          )
      ]
    )
    jumpbox                  = azurerm_network_interface.k8s-nic-jumpbox.private_ip_address
    admin                    = var.vm-adminuser
    email                    = var.email
    domain                   = var.ddns_domain_name
    domain_name              = var.ddns_domain_name
    kubeadm_api              = "kubeadm.k8s.io"
    kubeadm_api_version      = "v1beta1"
    kubeadm_api_advertise_ip = "10.70.1.6"
    kubeadm_cert_dir         = "/etc/kubernetes/pki"
    kubeadm_cluster_name     = "kubernetes"
    kubeadm_pod_subnet       = "192.168.0.0/16"
    kubeadm_service_subnet   = "10.96.0.0/12"
    kubeadm_k8s_version      = "v1.14.3"
    admin                    = var.vm-adminuser
    auth_file                = var.auth_file
  }
}

