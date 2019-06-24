# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      backend.tf
# Environments:   all
# Purpose:        Define the backend as Azure.
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

terraform {
  backend "azurerm" {}
}
