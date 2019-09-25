# -------------------------------------------------------------------
#
# Module:         k8s-terraform
# Submodule:      random-integer.tf
# Environments:   all
# Purpose:        Module to define a random integer which is used to
#                 ensure unique names.
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

resource "random_integer" "unique-sa-id" {
  min = 1000
  max = 9999
}
