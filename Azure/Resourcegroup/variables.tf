variable "ResourceGroup" {
  type = string
  description = "Azure Resource Group Name"  
}

variable "location" {
  type = string
  description = "Azure Resource Group Location"
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {}
}