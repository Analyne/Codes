
variable "name" {
  type = string
  description = "Azure name"
  }

variable "location" {
  type = string
  description = "Azure location"
  }
 
 variable "server_name" {
     type = string
	 description = "Azure servername"
  }
  
  variable "edition" {
     type = string
	 description = "Azure Edition"
  }

  variable "requestedservice" {
     type = string
	 description = "Azure requestedservice"
  }
  
  variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {}
}

variable "resource_group_name"{
  type = string
  description ="Azure resourcegroup"
}

variable "zone_redundant"{
  type = string
  description ="Azure zone redundant"
}

variable "max_size_gb"{
  type = string
  description = "Azure max size in GB"
}


