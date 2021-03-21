# TerraformModules

This is a repository for creating and attaching empty managed data disk,copying existing managed data disk,importing existing unmanaged data disk using Terraform.

Azure Managed Data disk Module :

-> Use Terraform source as below,
   
   source  = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_managed_datadisk/v1.0.0/ManagedDatadisk"


Eg: 

    ## Attach existing Managed Disk
	
	
	module "managed_disk"{
	  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_managed_datadisk/v1.0.0/ManagedDatadisk"
	  diskname = "stgdata3"
	  location = "East US"
	  resource_group_name = "Devrg"
	  create_option = "Copy"
	  storage_account_type = "Standard_LRS"
	  source_resource_id ="/subscriptions/XXX4acb5-a01e-4f10-aa14-XXXXX/resourceGroups/Devrg/providers/Microsoft.Compute/disks/data2"
	  tags = {
		environment = "staging"
	   }
	  lun_number = 4
	  cach_type = "ReadWrite"
	  vmname= "OELtest"
	}

	## Create & Attach Empty Managed disk
	
	
	module "managed_disk"{
	  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_managed_datadisk/v1.0.0/ManagedDatadisk"
	  diskname = "stgdata4"
	  location = "East US"
	  resource_group_name = "Devrg"
	  create_option = "Empty"
	  storage_account_type = "Standard_LRS"
	  disk_size_gb         = 8
	  tags = {
		environment = "staging"
	   }
	  lun_number = 4
	  cach_type = "ReadWrite"
	  vmname= "OELtest"
	}


	## Attache Unmanged disk as Managed Disk
	
	
	module "managed_disk"{
	  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_managed_datadisk/v1.0.0/ManagedDatadisk"
	  diskname = "stgdata4"
	  location = "East US"
	  resource_group_name = "Devrg"
	  create_option = "Import"
	  storage_account_type = "Standard_LRS"
	  source_uri="https://devrgdiag809.blob.core.windows.net/vhds/ubuntuvm1-20200806-204239.vhd"
	  tags = {
		environment = "staging"
	   }
	  storage_account_id = "/subscriptions/XXX4acb5-a01e-4f10-aa14-XXXXX/resourceGroups/Devrg/providers/Microsoft.Storage/storageAccounts/devrgdiagXXXX"
	  lun_number = 4
	  cach_type = "ReadWrite"
	  vmname= "OELtest"
	}


Varibales :


	lun_number = "The LUN specifies the slot in which the data drive appears when mounted for usage by the virtual machine,Valid LUN values are 0 through 31"
	  
	disk_size_gb = "The size, in GB, of an empty disk to be attached to the virtual machine. Required when creating a new disk, not used otherwise."

	storage_account_type = "The type of storage to use for the managed disk. Possible values are Standard_LRS, Premium_LRS, StandardSSD_LRS or UltraSSD_LRS"

	vmname = "The name of the virtual machine the disk will be attached to"

	resource_group_name = "The name of the ResourceGroup where VM and Disks are present"

	storage_account_id = "The ID of the Storage Account where the source_uri is located. Required when create_option is set to Import."

	create_option = "The method to use when creating the managed disk.Available options Copy,Import,Empty"

	source_uri = "URI to a valid VHD file to be used when create_option is Import."

	tags = "Tags used for resources."

	source_resource_id = "The ID of an existing Managed Disk to copy create_option is Copy"

	cach_type = "Specifies the caching requirements for this Data Disk. Possible values include None, ReadOnly and ReadWrite."

	diskname = "Specifies the name of the Managed Disk. Changing this forces a new resource to be created."

	location = "Specified the supported Azure location where the resource exists. Changing this forces a new resource to be created."
