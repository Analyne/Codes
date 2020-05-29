variable "name" {
  type = string
  description = "Azure name"
  }

variable "location" {
  type = string
  description = "Azure location"
  }
 
 variable "servername" {
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

variable "resourcegroupname"{

  type = string
}


