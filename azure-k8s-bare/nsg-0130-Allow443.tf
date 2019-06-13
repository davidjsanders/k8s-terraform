module "nsg-Allow443" {
  source                      = "git::https://github.com/dsandersAzure/terraform-library.git//modules/nsg_rule?ref=0.5.2"
  name                        = "Allow443"
  resource-group-name         = "${module.resource-group.name}"
  network-security-group-name = "${module.nsg-k8s.name}"
  priority                    = "130"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source-address-prefix       = "Internet"
  source-port-range           = "*"
  destination-address-prefix  = "*"
  destination-port-range      = "443"
}

