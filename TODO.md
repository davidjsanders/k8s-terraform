# To Do
* Update README.md - provide instructions
* Fix OS Disk sizes
* Add Azure storage class support
* Add Helm support
* ~~Add nfs-provisioner (manual install)~~
* Add nfs-provisioner (automatic install)
* Add instructions to create permanent data disk
* Add additional error checking
* Fix master provisioning - only works for master n = 1 at the moment
* Fix deprecation warnings from old code
  * module.mgt-subnet.azurerm_subnet.subnets: "network_security_group_id
  * module.mgt-subnet.azurerm_subnet.subnets: "route_table_id"
  * module.nic-worker-1.azurerm_network_interface.nic-with-bepool-ip: "ip_configuration.0.load_balancer_backend_address_pools_ids"
  * module.nic-worker-2.azurerm_network_interface.nic-with-bepool-ip: "ip_configuration.0.load_balancer_backend_address_pools_ids"
  * module.pip-elb.azurerm_public_ip.pip: "public_ip_address_allocation"
  * module.pip-jumpbox.azurerm_public_ip.pip: "public_ip_address_allocation"
  * module.wrk-subnet.azurerm_subnet.subnets: "network_security_group_id"
  * module.wrk-subnet.azurerm_subnet.subnets: "route_table_id"
* ~~Add additional in-line comments~~
* ~~Update NFS storage to restrict to IPs for nodes~~
* ~~Add NFS persistent storage~~
* ~~Add automounting of /datadrive in a script on master~~
  * ~~`uuid=$(sudo -i blkid | grep /dev/sdc1 | awk '{print $2}' | sed -e 's/UUID="\(.*\)\"/\1/')`~~
  * ~~`echo "UUID=${uuid}   /datadrive   ext4   defaults,nofail   1   2" | sudo tee -a /etc/fstab`~~
* ~~Add jump box~~
* ~~Tidy up NSG definitions~~
* ~~Add persistent disk for storage~~
* ~~Parallelize master and workers~~
  * ~~provisioner_master into n units~~ (NOT DONE see below)
  * ~~make master.sh more focused~~
  * ~~provisioner_master to perform finall steps~~
  * ~~split worker.sh into worker-init.sh and worker-final.sh~~ (NOTE DONE see below)
  * ~~Make worker.sh run in background in parallel and wait for completion~~
* ~~modularize code (DRYify)~~
* ~~Fix /home/azadmin/scripts/kubeadm_join_cmd.sh not found~~
* ~~Do updates and reboot after provisioning and configuring~~
* ~~Update outputs to include correct IPs~~
* ~~Update master.sh and worker.sh to use Banner~~
