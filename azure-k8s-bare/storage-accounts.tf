# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      storage-accounts.tf
# Environments:   all
# Purpose:        Module to define storage accounts for the various
#                 VMs.
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

# Boot diagnostics is a useful tool for understanding and interacting
# with virtual machines at start-up and during operation. One really
# useful feature is serial console. To enable this, VMs need to be
# created with a boot diagnostic storage account; rather than do this
# with multiple storage accounts, a single SA is used.
#
# **NOTE** In production, there is a high chance that applications would
#          be alloacted a storage account to use rather than creating 
#          their own. In this case, this module would be removed and
#          wherever sa-boot-diag.id was used, it would be replaced with
#          the ID for the SA to be used.
#
locals {
  l-storage-account-name       = "${lower(format("sa%s%s%s", lower(var.target), var.sa-name, random_integer.unique-sa-id.result))}"
}

module "sa-boot-diag" {
  source                    = "git::https://github.com/dsandersAzure/terraform-library.git//modules/storage-account?ref=0.8.0"
  name                      = "${local.l-storage-account-name}"
  resource-group-name       = "${module.resource-group.name}"
  account-tier              = "Standard"
  account-replication-type  = "LRS"
  enable-blob-encryption    = true
  enable-https-traffic-only = true
  location                  = "${var.location}"
  tags                      = "${var.tags}"
}
