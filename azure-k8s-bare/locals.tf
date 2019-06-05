locals {
  l-random     = "${substr(lower(terraform.workspace), 0, 3) == "dev" ? format("-%s", random_integer.unique-sa-id.result) : "" }"
  l-random-int = "${substr(lower(terraform.workspace), 0, 3) == "dev" ? format("%s", random_integer.unique-sa-id.result) : "" }"
  l-dev        = ""
  l-dev-lower  = ""
  l_pk_file    = "${format("%s", var.private-key)}"
}