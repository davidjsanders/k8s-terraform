# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      vm-worker-2.tf
# Environments:   all
# Purpose:        Module to define the Azure VM to be used as the
#                 second k8s worker.
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
  l-worker-2-name-1        = "${format("VM-WORKER-2-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-worker-2-osdisk-name-1 = "${format("OSD-WORKER-2-%s-%s%s", var.target, var.environ, local.l-random)}"
  l-worker-2-pk-file       = "${format("%s.pub", var.private-key)}"
}

module "vm-worker-2" {
  source                           = "git::https://github.com/dsandersAzure/terraform-library.git//modules/standard-linux-vm-no-datadisk?ref=0.8.0"
  name                             = "${local.l-worker-2-name-1}"
  location                         = "${var.location}"
  resource-group-name              = "${module.resource-group.name}"
  nic-id                           = "${module.nic-worker-2.id}"
  availability-set-id              = "${module.avs-workers.id}"
  vm-size                          = "${var.worker-vm-size}"
  delete-os-disk-on-termination    = "${var.delete-osdisk-on-termination}"
  delete-data-disks-on-termination = "${var.delete-datadisk-on-termination}"
  primary-blob-endpoint            = "${module.sa-boot-diag.primary_blob_endpoint}"
  image-publisher                  = "Canonical"
  image-offer                      = "UbuntuServer"
  image-sku                        = "18.04-LTS"
  image-version                    = "latest"
  os-disk-name                     = "${local.l-worker-2-osdisk-name-1}"
  os-disk-create-option            = "FromImage"
  os-disk-caching                  = "ReadWrite"
  os-disk-type                     = "${var.vm-osdisk-type}"
  adminuser                        = "${var.vm-adminuser}"
  adminpass                        = "${var.vm-adminpass}"
  ssh-key-path                     = "${local.l-worker-2-pk-file}"
  disable-password-auth            = "${var.vm-disable-password-auth}"
  custom-data                      = ""
  tags                             = "${var.tags}"
}
