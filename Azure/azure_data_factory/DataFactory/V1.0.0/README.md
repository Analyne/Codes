
DataFactory Module :

-> Use Terraform source as below,
    
    source  = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_data_factory/v1.0.0/DataFactory"

    Eg: 
        module "DataFactory" {
        source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_data_factory/v1.0.0/DataFactory"
        df_name = "testdf"
        location = "Central US"
        rg_name = "ExampleRg"
        tags = {
        CreatedBy="VG068104",
        Environment = "Development"
        OwnedBy = "07521 Data & Integration"
        BillTo = "07521"
        Confidentiality="None"
        SupportedBy="Data & Integration" 
        }
        }

  
  
  -> OutPut 
        
        DataFactory_name : Name of the DataFactory
        DataFactory_id : The ID of the Data Factory.
  
