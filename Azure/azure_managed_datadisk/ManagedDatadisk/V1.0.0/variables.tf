variable "lun_number" {
  description = "The LUN specifies the slot in which the data drive appears when mounted for usage by the virtual machine,Valid LUN values are 0 through 31"
  type        = any
  default = null
}

variable "disk_size_gb" {
  description = "The size, in GB, of an empty disk to be attached to the virtual machine. Required when creating a new disk, not used otherwise."
  type        = any
  default = null
}

variable "storage_account_type" {
  description = "The type of storage to use for the managed disk. Possible values are Standard_LRS, Premium_LRS, StandardSSD_LRS or UltraSSD_LRS"
  type        = string
  default = null
}

variable "vmname" {
  description = "The name of the virtual machine the disk will be attached to"
  type        = string
  default = null
}

variable "resource_group_name" {
  description = "The name of the ResourceGroup where VM and Disks are present"
  type        = string
  default = null
}

variable "storage_account_id" {
  description = "The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import."
  type        = any
  default = null
}

variable "create_option" {
  description = "The method to use when creating the managed disk.Available options Copy,Import,Empty"
  type        = string
  default = null
}

variable "source_uri" {
  description = "URI to a valid VHD file to be used when create_option is Import."
  type        = string
  default = null
}

variable "tags" {
  description = "Tags used for resources."
  type        = map(string)
  default = {}
}

variable "source_resource_id" {
  description = "The ID of an existing Managed Disk to copy create_option is Copy"
  type        = string
  default = null
}

variable "cach_type" {
  description = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."
  type        = string
  default = "None"
}

variable "diskname" {
  description = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."
  type        = string
  default = null
}

variable "location" {
  description = "Specified the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
  default = null
}