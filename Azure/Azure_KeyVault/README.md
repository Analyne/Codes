# TerraformModules

Use this Module for Creating Azure Key Vault

Azure KeyVault Module :

-> Use Terraform source as below,
   
   source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/Azure_KeyVault/v1.0.0/AzureKeyVault"


Eg: 
    As of now policies should be created individually per user (User1, User2 in the below module example is a random name but the actual user will be identified by object_id  values).
	
	
	  module "keyvault" {
	  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/Azure_KeyVault/v1.0.0/AzureKeyVault"
	  name                = "tfkeyvault"
	  location            = "East US"
	  resource_group_name = "test"
	  
	  enabled_for_deployment          = true
	  enabled_for_disk_encryption     = true
	  enabled_for_template_deployment = true
	  bypass = "AzureServices"
	  subnetIds = ["/subscriptions/XXXX/resourceGroups/DevRg/providers/Microsoft.Network/virtualNetworks/DevVnet/subnets/front-end"] ## multiple subnets can be given with comma seperated also this variable is optional you can ignore it.
	  tags = {
		environment = "Prod"
	  }

	  policies = {
		User1 = {
		  tenant_id               = "xxx-xxx-xxx-xxx"
		  object_id               = "xxx-xxx-xxx-xxx"
		  key_permissions         = [ "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey","update", "verify", "wrapKey" ]
		  secret_permissions      = [ "backup", "delete", "get", "list", "purge", "recover", "restore", "set" ]
		  certificate_permissions = [ "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers","managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore" ]
		  storage_permissions     = [ "backup", "delete", "deletesas", "get", "getsas", "list", "listsas","purge", "recover", "regeneratekey", "restore", "set", "setsas", "update" ]
		}
		User2 = {
		  tenant_id               = "xxx-xxx-xxx-xxx"
		  object_id               = "xxx-xxx-xxx-xxx"
		  key_permissions         = [ "backup", "create", "decrypt", "delete", "encrypt", "get", "import", "list", "purge", "recover", "restore", "sign", "unwrapKey","update", "verify", "wrapKey" ]
		  secret_permissions      = [ "backup", "delete", "get", "list", "purge", "recover", "restore", "set" ]
		  certificate_permissions = [ "create", "delete", "deleteissuers", "get", "getissuers", "import", "list", "listissuers","managecontacts", "manageissuers", "purge", "recover", "setissuers", "update", "backup", "restore" ]
		  storage_permissions     = [ "backup", "delete", "deletesas", "get", "getsas", "list", "listsas","purge", "recover", "regeneratekey", "restore", "set", "setsas", "update" ]
		}
	  }

	  
	}


Variables :


	resource_group_name = "The name of an existing Resource Group"

	location = "Define the region the Azure Key Vault should be created, you should use the Resource Group location"

	name = "The name of the Azure Key Vault"

	sku_name = "Select Standard or Premium SKU"

	enabled_for_deployment = "Allow Azure Virtual Machines to retrieve certificates stored as secrets from the Azure Key Vault. Allowed values true or false"

	enabled_for_disk_encryption = "Allow Azure Disk Encryption to retrieve secrets from the Azure Key Vault and unwrap keys Allowed values true or false "

	enabled_for_template_deployment = "Allow Azure Resource Manager to retrieve secrets from the Azure Key Vault Allowed values true or false"

	bypass = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"
	  
	tags = "A mapping of tags to assign to the resource"

	subnetIds = "One or more Subnet ID's which should be able to access this Key Vault.This is optional you can ignore it if you do not need" Below is the format of it to use
	/subscriptions/Subscription_ID/resourceGroups/ResourceGroup_Name/providers/Microsoft.Network/virtualNetworks/Vnet_Name/subnets/Subnet_name
