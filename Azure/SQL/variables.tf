variable "name" {
  type = string
  description = "Azure server_name"
  }

variable "location" {
  type = string
  description = "Azure location"
  }
 
 variable "administrator_login" {
     type = string
	 description = "Azure username"
  }
  
  variable "administrator_login_password" {
     type = string
	 description = "Azure password"
  }
  
  variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {}
}

variable "resourcegroupname" {
  description = "The name of an existing resource group to be imported."
}