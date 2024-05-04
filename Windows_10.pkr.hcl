packer {
  required_plugins {
    windows-update = {
      version = "0.12.0"
      source  = "github.com/rgl/windows-update"
    }
    azure = {
      source  = "github.com/hashicorp/azure"
      version = "2.0.1"
    }
  }
}

source "azure-arm" "windowsvm" {
  azure_tags = {
    dept = "CDW"
    task = "Image deployment"
  }
  #use_azure_cli_auth        = true
  client_id                 = "${var.client_id}"
  client_secret             = "${var.client_secret}"
  subscription_id           = "${var.subscription_id}"
  tenant_id                 = "${var.tenant_id}"
  build_resource_group_name = "${var.rgName}"
  communicator              = "winrm"
  # USE MARKETPLACE IMAGE AS SOURCE
  image_offer     = "${var.image_offer}"
  image_publisher = "${var.image_publisher}"
  image_sku       = "${var.image_sku}"
  image_version   = "${var.image_version}"
  os_type         = "Windows"

   //only CIDR range (172.16.72.0/23) is allowed to use in production account

  virtual_network_name                = "${var.network}"
  virtual_network_subnet_name         = "${var.subnetwork}"
  virtual_network_resource_group_name = "${var.network_rg_name}"
  # UNCOMMENT THE LINES BELOW TO ENABLE Trusted Launch
  # secure_boot_enabled                 = true
  # vtpm_enabled                        = true

  keep_os_disk = true
  #temp_os_disk_name                   = "${var.temp_os_disk_name}"

  shared_image_gallery_destination {
    gallery_name   = "${var.acgName}"
    image_name     = "${var.image_name}"
    image_version  = "${var.destination_image_version}"
    resource_group = "${var.rgName}"
  }
  #managed_image_name                = "cdw-int-${local.timestamp}"
  #managed_image_resource_group_name = "myPackerGroup"

  vm_size        = "${var.vmSize}"
  winrm_insecure = true
  winrm_timeout  = "30m"
  winrm_use_ssl  = true
  winrm_username = "packer"
}

build {
  sources = ["source.azure-arm.windowsvm"]

  provisioner "windows-update" {
    filters         = ["exclude:$_.Title -like '*Preview*'", "include:$true"]
    search_criteria = "IsInstalled=0"
    update_limit    = 25
  }
  provisioner "windows-restart" {
    restart_check_command = "powershell -command \"&amp; {Write-Output 'Machine restarted.'}\""
  }
  provisioner "powershell" {
    inline = ["if( Test-Path $Env:SystemRoot\\windows\\system32\\Sysprep\\unattend.xml ){ rm $Env:SystemRoot\\windows\\system32\\Sysprep\\unattend.xml -Force}", "& $env:SystemRoot\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /quiet /quit /mode:vm", "while($true) { $imageState = Get-ItemProperty HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\State | Select ImageState; Write-Output $imageState.ImageState; if($imageState.ImageState -ne 'IMAGE_STATE_GENERALIZE_RESEAL_TO_OOBE') { Start-Sleep -s 10 } else { break } }"]
  }
}