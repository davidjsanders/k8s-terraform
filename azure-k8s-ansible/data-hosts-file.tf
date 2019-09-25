# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-hosts-file.tf
# Environments:   all
# Purpose:        Module to get the persistent Azure managed disks.
#
# Created on:     10 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 10 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

# Compute and interpolate the variables required for the hosts file
data "template_file" "template-hosts-file" {
  template = file("template-data/hosts")

  vars = {
    jumpbox = format(
      "%s    %s",
      azurerm_network_interface.k8s-nic-jumpbox.private_ip_address,
      "jumpbox"
    )
    master  = format(
      "%s    %s",
      azurerm_network_interface.k8s-nic-master.private_ip_address,
      "k8s-master"
    )
    workers = join(
      " ",
      [
        for i in range(0, var.workers.vm-count) : 
          format(
            "%s    %s-%01d",
            azurerm_network_interface.k8s-nic-workers.*.private_ip_address[i],
            var.workers.prefix,
            i+1
          )
      ]
    )
  }
}

