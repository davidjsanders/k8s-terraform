module "nsg-docker-Allow2377" {
  source                      = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg_rule?ref=0.1.0"
  name                        = "Allow2377"
  resource-group-name         = "${module.docker-resource-group.name}"
  network-security-group-name = "${module.nsg-docker.name}"
  priority                    = "110"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source-address-prefix       = "Internet"
  source-port-range           = "*"
  destination-address-prefix  = "*"
  destination-port-range      = "2377"
}

