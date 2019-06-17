# To Do
* Update README.md - provide instructions
* Fix OS Disk sizes
* Add Azure storage class support
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
