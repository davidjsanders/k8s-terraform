# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      random-string.tf
# Environments:   all
# Purpose:        Module to define random string which is used for all
#                 passwords, so avoids certain characters.
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

resource "random_string" "password" {
  length           = 16
  special          = true
  override_special = "!%^[]{}"
}

