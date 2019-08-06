# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      vm-jumpbox.tf
# Environments:   all
# Purpose:        Module to define the Azure VM to be used as the
#                 jumpbox to other non-public resources.
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
  # l-jumpbox-temp-name   = "${format("%s-%s-JUMPBOX%s", var.target, var.vm-name, local.l-dev)}"
  l-jumpbox-name-1      = "${format("VM-JUMPBOX-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-jumpbox-osdisk-1    = "${format("OSD-JUMPBOX-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-jumpbox-pk-file     = "${format("%s.pub", var.private-key)}"
}

module "vm-jumpbox" {
  source                           = "git::https://github.com/dsandersAzure/terraform-library.git//modules/standard-linux-vm-no-datadisk?ref=0.6.0"
  name                             = "${local.l-jumpbox-name-1}"
  location                         = "${var.location}"
  resource-group-name              = "${module.resource-group.name}"
  nic-id                           = "${module.nic-jumpbox-1.id}"
  availability-set-id              = "${module.avs-k8s.id}"
  vm-size                          = "${var.jumpbox-vm-size}"
  delete-os-disk-on-termination    = "${var.delete-osdisk-on-termination}"
  delete-data-disks-on-termination = "${var.delete-datadisk-on-termination}"
  primary-blob-endpoint            = "${module.sa-boot-diag.primary_blob_endpoint}"
  image-publisher                  = "Canonical"
  image-offer                      = "UbuntuServer"
  image-sku                        = "18.04-LTS"
  image-version                    = "latest"
  os-disk-name                     = "${local.l-jumpbox-osdisk-1}"
  os-disk-create-option            = "FromImage"
  os-disk-caching                  = "ReadWrite"
  os-disk-type                     = "${var.vm-osdisk-type}"
  adminuser                        = "${var.vm-adminuser}"
  adminpass                        = "${var.vm-adminpass}"
  ssh-key-path                     = "${local.l-jumpbox-pk-file}"
  disable-password-auth            = "${var.vm-disable-password-auth}"
  custom-data                      = ""
  tags                             = "${var.tags}"
}
