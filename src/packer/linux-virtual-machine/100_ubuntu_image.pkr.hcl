# https://github.com/hashicorp/packer-plugin-azure
source "azure-arm" "this" {
  client_id                         = var.client_id
  client_secret                     = var.client_secret
  image_offer                       = var.linux_virtual_machine.image_offer
  image_publisher                   = var.linux_virtual_machine.image_publisher
  image_sku                         = var.linux_virtual_machine.image_sku
  location                          = var.location
  managed_image_name                = "${lower(var.shared_image_name)}-${formatdate("YYYYMMDDhhmmss", timestamp())}"
  managed_image_resource_group_name = var.resource_group_name_managed_image
  os_type                           = var.linux_virtual_machine.os_type
  subscription_id                   = var.subscription_id
  tenant_id                         = var.tenant_id
  vm_size                           = var.linux_virtual_machine.vm_size

  shared_image_gallery_destination {
    subscription         = var.subscription_id
    resource_group       = var.resource_group_name_shared_image_gallery
    gallery_name         = var.gallery_name
    image_name           = var.shared_image_name
    image_version        = formatdate("YYYYMMDD.hhmm.ss", timestamp())
    storage_account_type = "Standard_ZRS"
  }
}

build {
  sources = ["source.azure-arm.this"]

  provisioner "shell" {
    execute_command = "chmod +x {{ .Path }}; {{ .Vars }} sudo -E sh '{{ .Path }}'"
    inline = [
      "apt-get update -y -q",
      "apt-get upgrade -y -q",
      "/usr/sbin/waagent -force -deprovision+user && export HISTSIZE=0 && sync"
    ]
    inline_shebang = "/bin/sh -x"
  }
}
