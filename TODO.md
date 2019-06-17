# To Do
* ~~Add jump box~~
* Tidy up NSG definitions
* Fix OS Disk sizes
* ~~Add persistent disk for storage~~
* Add Azure storage class
* Update README.md - provide instructions
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
