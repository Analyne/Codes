### General Inputs ###
variable "resource_group_name" {
  type        = string
  description = "The resource group that the DNS zones/records will be created within."
  default     = null
}

variable "location" {
  description = "(Optional) The location (azure region) in which the resources will be created. Defaults to resource group location."
  default     = null
}

### Public IP Inputs ###
variable "public_ip_sku" {
  type        = string
  description = "The SKU of the Public IP. Options are Basic and Standard."
  default     = "Basic"
}

variable "public_ip_allocation_method" {
  type        = string
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = "Dynamic"
}

variable "public_ip_version" {
  type        = string
  description = "The IP Version to use. Options are IPv6 or IPv4."
  default     = "IPv4"
}

variable "public_ip_idle_timeout" {
  type        = number
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  default     = 4
}

variable "public_ip_domain_name_label" {
  type        = string
  description = ""
  default     = null
}

variable "public_ip_reverse_fqdn" {
  type        = string
  description = ""
  default     = null
}

variable "public_ip_prefix_id" {
  type        = string
  description = ""
  default     = null
}

variable "public_ip_zones" {
  type        = list(string)
  description = ""
  default     = []
}

variable "public_ip_tags" {
  type        = map(string)
  description = ""
  default     = {}
}

### NIC Inputs ###
variable "dns_servers" {
  type        = list(string)
  description = "A list of IP Addresses defining the DNS Servers which should be used for this Network Interface."
  default     = []
}

variable "enable_ip_forwarding" {
  type        = bool
  description = ""
  default     = false
}

variable "enable_accelerated_networking" {
  type        = bool
  description = ""
  default     = false
}

variable "internal_dns_name_label" {
  type        = string
  description = ""
  default     = null
}

variable "nic_tags" {
  type        = map(string)
  description = ""
  default     = {}
}

### NIC IP Config Inputs ###
variable "vnet_subnet_id" {
  type        = string
  description = "The subnet id of the vnet where the VM will reside."
  default     = null
}

variable "private_ip_version" {
  type        = string
  description = "The IP Version to use. Options are IPv6 or IPv4."
  default     = "IPv4"
}

variable "private_ip_allocation_method" {
  type        = string
  description = "Defines how an IP address is assigned. Options are Static or Dynamic."
  default     = "Dynamic"
}

variable "private_ip_address_static" {
  type        = string
  description = "The static IP address to use if allocation method is static."
  default     = null
}

### NSG Inputs ###
variable "remote_port" {
  type        = number
  description = ""
  default     = null
}

variable "nsg_tags" {
  type        = map(string)
  description = ""
  default     = {}
}

### General VM Inputs ###
variable "is_windows_image" {
  type        = bool
  description = ""
  default     = false
}

variable "vm_hostname" {
  type        = string
  description = "Resource name of the VM."
  default     = null
}

variable "vm_size" {
  type        = string
  description = "Specifies the size of the virtual machine."
  default     = "Standard_B2ms"
}

variable "admin_username" {
  type        = string
  description = "Admin username of the VM(s)."
  default     = "azureuser"
}

variable "admin_password" {
  type        = string
  description = "Admin password of the VM(s). Must meet Azure complexity requirements."
  default     = null
}

variable "allow_extension_operations" {
  type        = bool
  description = ""
  default     = true
}

variable "availability_set_id" {
  type        = string
  description = ""
  default     = null
}

variable "computer_name" {
  type        = string
  description = "Local VM hostname. Defaults to same as hostname."
  default     = null
}

variable "custom_data_file" {
  type        = string
  description = "Custom Data file which should be used for this Virtual Machine."
  default     = null
}

variable "dedicated_host_id" {
  type        = string
  description = "ID of a Dedicated Host where this machine should be run on. Changing this forces a new resource to be created."
  default     = null
}

variable "provision_vm_agent" {
  type        = bool
  description = ""
  default     = true
}

variable "vm_os_id" {
  type        = string
  description = "The resource ID of the image that you want to deploy if you are using a custom image.Note, need to provide is_windows_image = true for windows custom images."
  default     = null
}

variable "scale_set_id" {
  type        = string
  description = ""
  default     = null
}

variable "vm_availability_zone" {
  type        = number
  description = ""
  default     = null
}

variable "vm_tags" {
  type        = map(string)
  description = ""
  default     = {}
}

variable "enable_ultra_ssd" {
  type        = bool
  description = ""
  default     = false
}

variable "admin_ssh_public_key" {
  type        = string
  description = ""
  default     = null
}

variable "os_disk_caching" {
  type        = string
  description = "Caching setting for OS disk."
  default     = "ReadWrite"
}

variable "os_disk_sa_type" {
  type        = string
  description = "Storage account type for OS disk."
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  type        = number
  description = ""
  default     = null
}

variable "os_disk_enable_write_accelerator" {
  type        = bool
  description = ""
  default     = false
}

variable "os_disk_ephemeral" {
  type        = bool
  description = ""
  default     = false
}

variable "enable_boot_diagnostics" {
  type        = bool
  description = "(Optional) Enable or Disable boot diagnostics"
  default     = false
}

variable "boot_diagnostics_sa_type" {
  type        = string
  description = "(Optional) Storage account type for boot diagnostics"
  default     = "Standard_LRS"
}

variable "managed_identity_type" {
  type        = string
  description = ""
  default     = null
}

variable "managed_identity_ids" {
  type        = list(string)
  description = ""
  default     = []
}

# variable "certificates" {
#   type = 
# }

variable "vm_os_simple" {
  type        = string
  description = "Specify UbuntuServer, WindowsServer, RHEL, openSUSE-Leap, CentOS, Debian, CoreOS and SLES to get the latest image version of the specified os.  Do not provide this value if a custom value is used for vm_os_publisher, vm_os_offer, and vm_os_sku."
  default     = ""
}

variable "vm_os_publisher" {
  type        = string
  description = "The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_offer" {
  type        = string
  description = "The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_sku" {
  type        = string
  description = "The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_version" {
  type        = string
  description = "The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = "latest"
}

### Linux VM Inputs ###
variable "disable_password_authentication" {
  type        = bool
  description = "Disables password authentication on Linux VM(s). Requires SSH keys if set to true."
  default     = false
}

### Windows VM Inputs ###
variable "enable_automatic_updates" {
  type        = bool
  description = ""
  default     = true
}

variable "license_type" {
  type        = string
  description = ""
  default     = "None"
}

variable "proximity_placement_group_id" {
  type        = string
  description = ""
  default     = null
}

variable "timezone" {
  type        = string
  description = ""
  default     = "UTC"
}

variable "additional_unattended_content" {
  type = map(object({
    content = string
    setting = string
  }))
  description = ""
  default     = {}
}

### Data Disk Inputs ###
variable "data_disks" {
  type = map(object({
    disk_size_gb         = number
    storage_account_type = string
    lun                  = number
    caching              = string
    tags                 = map(string)
  }))
  description = ""
  default     = {}
}

### Tags ###
variable "tags" {
  type        = map(string)
  description = "Mapping for azure resource metadata tags that will apply to all resources."
  default     = {}
}

variable "auto_tags" {
  type        = map(string)
  description = "For use in automation. Merges with 'tags' variable."
  default     = {}
}