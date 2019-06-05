# -------------------------------------------------------------------
#
# Module:         terraform-reference-app
# Submodule:      engine/main.tf
# Environment:    dev
# Purpose:        .
#
# Created on:     29 August 2018
# Created by:     David Sanders
# Creator email:  david.sanders2@loblaw.ca
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 29 Aug 2018  | David Sanders               | First release and
#                                            | valid creation of
#                                            | sample app.
# -------------------------------------------------------------------

provider "azurerm" {
  version         = "1.9.0"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
}

provider "random" {
  version = "1.3.1"
}

provider "template" {
  version = "1.0.0"
}
