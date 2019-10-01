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
# 24 Sep 2019  | David Sanders               | Update to place all
#              |                             | variables in inventory
#              |                             | and populate through a
#              |                             | single template_file.
#              |                             | Change k8s advertise
#              |                             | IP to match the IP from
#              |                             | the NIC automatically.
#              |                             | Alphabetize variables.
# -------------------------------------------------------------------
# 01 Oct 2019  | David Sanders               | Add prod_staging_flag
#              |                             | to indicate production
#              |                             | or staging Let's
#              |                             | Encrypt server.
# -------------------------------------------------------------------

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-ansible-inventory" {
  template = file("ansible/multi-inventory")

  vars = {
    admin                        = var.vm-adminuser
    auth_file                    = var.auth_file
    ansible_ssh_private_key_file = format(
      "/home/%s/.ssh/azure_pk",
      var.vm-adminuser
    )
    domain                       = var.ddns_domain_name
    email                        = var.email
    jumpbox                      = azurerm_network_interface.k8s-nic-jumpbox.private_ip_address
    helm_service_account_name    = var.helm_service_account_name
    kubeadm_api                  = var.kubeadm_api
    kubeadm_api_version          = var.kubeadm_api_version
    kubeadm_api_advertise_ip     = azurerm_network_interface.k8s-nic-master.private_ip_address
    kubeadm_cert_dir             = var.kubeadm_cert_dir
    kubeadm_cluster_name         = var.kubeadm_cluster_name
    kubeadm_pod_subnet           = var.kubeadm_pod_subnet
    kubeadm_service_subnet       = var.kubeadm_service_subnet
    kubeadm_k8s_version          = var.kubeadm_k8s_version
    master                       = azurerm_network_interface.k8s-nic-master.private_ip_address
    master_name                  = var.vm-master-name
    masters                      = ""
    nexus_username               = var.nexus_username
    nexus_password               = var.nexus_password
    os_k8s_version               = var.os_k8s_version
    postgres_db                  = var.postgres_db
    postgres_user                = var.postgres_user
    postgres_password            = var.postgres_password
    postgres_endpoint            = var.postgres_endpoint
    postgres_port                = var.postgres_port
    prod_staging_flag            = var.prod_staging_flag
    registry                     = format("%s:32080/", var.vm-master-name)
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
  }
}

