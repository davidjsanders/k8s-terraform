# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      sa-boot-daig.tf
# Environments:   all
# Purpose:        Module to define the Azure storage account for boot
#                 diagnostics.
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

resource "azurerm_storage_account" "k8s-sa-boot-diag" {
  account_tier             = "Standard"
  account_replication_type = "LRS"
  name = lower(
    format(
      "sa%s%s%s",
      lower(var.target),
      var.sa-name,
      random_integer.unique-sa-id.result,
    ),
  )
  location            = var.location
  resource_group_name = azurerm_resource_group.k8s-rg.name

  tags = var.tags
}

