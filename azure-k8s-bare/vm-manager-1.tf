# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      vm-manager-1.tf
# Environments:   all
# Purpose:        Module to define the Azure VM to be used as the
#                 k8s master.
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
# 05 Aug 2019  | David Sanders               | Simplify resource 
#              |                             | names.
# -------------------------------------------------------------------

locals {
  # l-manager-1-temp-name   = "${format("%s-%s-MANAGER%s", var.target, var.vm-name, local.l-dev)}"
  l-manager-1-name-1      = "${format("VM-MANAGER-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-manager-1-osdisk-1    = "${format("OSD-MANAGER-1-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-manager-1-pk-file     = "${format("%s.pub", var.private-key)}"
}

module "vm-manager-1" {
  source                           = "git::https://github.com/dsandersAzure/terraform-library.git//modules/standard-linux-vm-datadisk?ref=0.8.0"
  name                             = "${local.l-manager-1-name-1}"
  location                         = "${var.location}"
  resource-group-name              = "${module.resource-group.name}"
  nic-id                           = "${module.nic-master-1.id}"
  availability-set-id              = "${module.avs-k8s.id}"
  vm-size                          = "${var.manager-vm-size}"
  delete-os-disk-on-termination    = "${var.delete-osdisk-on-termination}"
  delete-data-disks-on-termination = "${var.delete-datadisk-on-termination}"
  primary-blob-endpoint            = "${module.sa-boot-diag.primary_blob_endpoint}"
  image-publisher                  = "Canonical"
  image-offer                      = "UbuntuServer"
  image-sku                        = "18.04-LTS"
  image-version                    = "latest"
  os-disk-name                     = "${local.l-manager-1-osdisk-1}"
  os-disk-create-option            = "FromImage"
  os-disk-caching                  = "ReadWrite"
  os-disk-type                     = "${var.vm-osdisk-type}"
  os-disk-size-gb                  = "32"
  data-disk-name                   = "${data.azurerm_managed_disk.datasourcemd.name}"
  data-disk-id                     = "${data.azurerm_managed_disk.datasourcemd.id}"
  data-disk-create-option          = "Attach"
  data-disk-lun                    = 0
  data-disk-size                   = "${data.azurerm_managed_disk.datasourcemd.disk_size_gb}"
  adminuser                        = "${var.vm-adminuser}"
  adminpass                        = "${var.vm-adminpass}"
  ssh-key-path                     = "${local.l-manager-1-pk-file}"
  disable-password-auth            = "${var.vm-disable-password-auth}"
  custom-data                      = ""
  tags                             = "${var.tags}"
}
