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
  default = "203a4ab7-b38b-4118-bc67-c1abd445ce16"
}
variable "client_secret" {
  type      = string
  default   = "nHX8Q~DDNMTNrD3pIBmSIz0lTN_ZpZKYmeGEwb~2"
  sensitive = true
}
variable "subscription_id" {
  type    = string
  default = "d08ef21b-2f8c-4f9c-88b5-eb2699435ceb"
}
variable "tenant_id" {
  type    = string
  default = "9652d7c2-1ccf-4940-8151-4a92bd474ed0"
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
