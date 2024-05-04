variable "rgName" {
  type    = string
  default = "cdw-eu-west-rg"
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "acgName" {
  type    = string
  default = "cdwAzureComputeGallery"
}

variable "image_name" {
  type    = string
  default = "cdw-packer-windows-base-template-1.0"
}
variable "network" {
  type    = string
  default = "cdw-eu-west-vnet"
}
variable "subnetwork" {
  type    = string
  default = "cdw-eu-west-snet2"
}

variable "network_rg_name" {
  type    = string
  default = "cdw-eu-west-rg"
}

variable "client_id" {
  type    = string
  default = ""
}
variable "client_secret" {
  type      = string
  default   = ""
  sensitive = true
}
variable "subscription_id" {
  type    = string
  default = ""
}
variable "tenant_id" {
  type    = string
  default = ""
}
variable "image_offer" {
  type    = string
  default = "Windows-10"
}

variable "image_publisher" {
  type    = string
  default = "MicrosoftWindowsDesktop"
}

variable "image_sku" {
  type    = string
  default = "win10-22h2-pro-g2"
}

variable "image_version" {
  type    = string
  default = "latest"
}


variable "vmSize" {
  type    = string
  default = "Standard_D8S_V5"
}

variable "destination_image_version" {
  type    = string
  default = "1.0.0"
}
