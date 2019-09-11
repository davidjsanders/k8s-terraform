# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      data-managed-disks.tf
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

# Get the managed disk being used to provide persistent storage
# for the k8s cluster.
data "azurerm_managed_disk" "datasourcemd" {
  name                = "${var.disk-master-name}"
  resource_group_name = "${var.disk-rg-name}"
}
