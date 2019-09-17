# -------------------------------------------------------------------
#
# Module:         k8s-terraform/azure-k8s-ansible
# Submodule:      vm-jumpox.tf
# Environments:   all
# Purpose:        Module to define the Azure virtual machine for the
#                 jumpbox.
#
# Created on:     10 September 2019
# Created by:     David Sanders
# Creator email:  dsanderscanada@nospam-gmail.com
#
# -------------------------------------------------------------------
# Modifed On   | Modified By                 | Release Notes
# -------------------------------------------------------------------
# 10 Sep 2019  | David Sanders               | First release.
# -------------------------------------------------------------------

resource "azurerm_virtual_machine" "vm-jumpbox" {
  availability_set_id              = ""
  delete_os_disk_on_termination    = "true"
  delete_data_disks_on_termination = "true"
  location                         = var.location
  name = upper(
    format("VM-JUMP-%s-%s%s", var.target, var.environ, local.l-random),
  )
  network_interface_ids = [azurerm_network_interface.k8s-nic-jumpbox.id]
  resource_group_name   = azurerm_resource_group.k8s-rg.name
  vm_size               = var.jumpbox-vm-size

  boot_diagnostics {
    storage_uri = azurerm_storage_account.k8s-sa-boot-diag.primary_blob_endpoint
    enabled     = true
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name = format(
      "OSD-JUMPBOX-%s-%s%s",
      var.target,
      var.environ,
      local.l-random,
    )
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vm-osdisk-type
  }

  os_profile {
    computer_name = format(
      "%s-JUMPBOX-%s-%s%s",
      var.vm-name,
      var.target,
      var.environ,
      local.l-random,
    )
    admin_username = var.vm-adminuser
    admin_password = var.vm-adminpass
    custom_data    = ""
  }

  os_profile_linux_config {
    disable_password_authentication = var.vm-disable-password-auth

    ssh_keys {
      path     = "/home/${var.vm-adminuser}/.ssh/authorized_keys"
      key_data = file(format("%s.pub", var.private-key))
    }
  }

  tags = var.tags
}

