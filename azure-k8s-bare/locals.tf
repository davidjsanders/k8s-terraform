# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      locals.tf
# Environments:   all
# Purpose:        Module to define key local variables used throughout
#                 the package.
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

locals {
  l-random     = "${substr(lower(terraform.workspace), 0, 3) == "dev" ? format("-%s", random_integer.unique-sa-id.result) : "" }"
  l-random-int = "${substr(lower(terraform.workspace), 0, 3) == "dev" ? format("%s", random_integer.unique-sa-id.result) : "" }"
  l-dev        = ""
  l-dev-lower  = ""
  l_pk_file    = "${format("%s", var.private-key)}"
}