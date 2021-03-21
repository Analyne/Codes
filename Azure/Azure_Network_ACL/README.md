# TerraformModules

Use this Module for allowing\blocking Network ACL.Use variables in output.tf to input values in your terraform code.

Azure Network ACL Module :

-> Use Terraform source as below,
   
   source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/Azure_Network_ACL/v1.0.0/AzureNetworkACL"


Eg: 
    This is to allow a list of IPs in Azure Vault network_acls.This module gives "Az_vault_allowed_IPs" as an output variable.
	
    ##Calling module in Azure_KeyVault module
	
    module allowedIPs{

         source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/Azure_Network_ACL/v1.0.0/AzureNetworkACL"
    }

    network_acls {
         default_action = "Deny"
         bypass         = var.bypass
         ip_rules = module.allowedIPs.Az_vault_allowed_IPs
    }