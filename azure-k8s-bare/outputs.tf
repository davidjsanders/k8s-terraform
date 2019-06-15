output "fqdn" {
    value = "${module.pip-elb.fqdn}"
}

output "IP-Address" {
    value = "${module.pip-elb.ip_address}"
}

output "Jumpbox-IP-Address" {
    value = "${module.pip-jumpbox.ip_address}"
}

output "nginx-hosts-line" {
    value = "${module.pip-elb.ip_address}    nginx-frontend"
}

output "traefik-hosts-line" {
    value = "${module.pip-elb.ip_address}    traefik-ui"
}