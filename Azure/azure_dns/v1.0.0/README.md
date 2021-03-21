# Terraform Module `azure_dns`

## Version: 1.0.0

### Terraform Syntax 0.12

This module has been created with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.

## Features

This Terraform module deploys [DNS in Azure](https://docs.microsoft.com/en-us/azure/dns/ "Azure Documentation") with the following characteristics:

* Create zero or more DNS zones and corresponding DNS records.
* Support for both public and private DNS zones.
* Public zones support A, AAAA, CAA, CNAME, MX, NS, PTR, SRV and TXT records.
* Private zones support A, AAAA, CNAME, MX, PTR, SRV and TXT records.
* Support for applying tags to individual resource groups and/or applying tags on all resource groups.
* Support for applying additional tags to all resource groups as part of an automation pipeline.

## Usage

* Changing the name or resource group of a DNS Zone will cause it to be destroyed then recreated. If a zone is destroyed and recreated it will almost always be created with new NS servers which would have to updated with the DNS registrar.
* If a DNS Zone needs to be moved/renamed without being destroyed then it needs to be moved manually in Azure and then imported into terraform state with the new name and/or location and update config to match.

```hcl
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "Central US"
}

module "dns_zones_and_records" {
  source = "git::https://github.cerner.com/CSM/terraform_registry.git//Azure/azure_dns/v1.0.0"

  resource_group_name   = azurerm_resource_group.example.name
  dns_zones_and_records = {
  "example.com_public" = {
    tags = {Tag = "ZoneExample", ZoneType = "Public"}
    recordsets = {
      "@0" = {
        record_name = "@"
        record_type = "A"
        ttl         = 300
        records     = ["10.0.180.5"]
        tags        = {Tag = "RecordExample", RecordType = "A"}
      }
      "A_SplitBrain" = {
        record_name = "splitbrain"
        record_type = "A"
        ttl         = 300
        records     = [
            "10.0.180.6",
            "10.0.180.7"
            ]
        tags        = {Tag = "RecordExample", RecordType = "A-SplitBrain"}
      }
      "@1" = {
        record_name = "@"
        record_type = "AAAA"
        ttl         = 300
        records     = ["fdef:e8c0:1665:4fdc:0050::"]
        tags        = {Tag = "RecordExample", RecordType = "AAAA"}
      }
      "AAAA_SplitBrain" = {
        record_name = "splitbrain"
        record_type = "AAAA"
        ttl         = 300
        records     = [
            "fdef:e8c0:1665:4fdc:0051::",
            "fdef:e8c0:1665:4fdc:0052::"
            ]
        tags        = {Tag = "RecordExample", RecordType = "AAAA-SplitBrain"}
      }
      "www" = {
        record_name = "www"
        record_type = "CNAME"
        ttl         = 300
        records     = ["example.com"]
        tags        = {Tag = "RecordExample", RecordType = "CNAME"}
      }
      "@2" = {
        record_name = "@"
        record_type = "CAA"
        ttl         = 300
        records = [
          "0 issue example0.net",
          "1 issue example1.com",
          "0 issuewild example2.com"
          "0 iodef mailto:example@example.com"
        ]
        tags = {Tag = "RecordExample", RecordType = "CAA"}
      }
      "@3" = {
        record_name = "@"
        record_type = "MX"
        ttl         = 300
        records = [
          "10 mail0.example.com",
          "20 mail1.example.com"
        ]
        tags = {Tag = "RecordExample", RecordType = "MX"}
      }
      "subdomain0" = {
        record_name = "subdomain"
        record_type = "NS"
        ttl         = 300
        records = [
          "ns1.example.com",
          "ns2.example.com"
        ]
        tags = {Tag = "RecordExample", RecordType = "NS"}
      }
      "host_PTR" = {
        record_name = "15"
        record_type = "PTR"
        ttl         = 300
        records     = ["host.example.com"]
        tags        = {Tag = "RecordExample", RecordType = "PTR"}
      }
      "_sip._tcp_SRV" = {
        record_name = "_sip._tcp"
        record_type = "SRV"
        ttl         = 300
        records = [
          "1 5 8080 target1.example2.com",
          "2 10 8080 target2.example2.com"
        ]
        tags = {Tag = "RecordExample", RecordType = "SRV"}
      }
      "@4" = {
        record_name = "@"
        record_type = "TXT"
        ttl         = 300
        records     = [
            "string of text",
            "another string of text"
            ]
        tags        = {Tag = "RecordExample", RecordType = "TXT"}
      }
    }
  }
  "example.com_private" = {
    tags = {Tag = "ZoneExample", ZoneType = "Private"}
    recordsets = {
      "@0" = {
        record_name = "@"
        record_type = "A"
        ttl         = 300
        records     = ["10.0.180.5"]
        tags        = {Tag = "RecordExample", RecordType = "A"}
      }
      "A_SplitBrain" = {
        record_name = "splitbrain"
        record_type = "A"
        ttl         = 300
        records     = [
            "10.0.180.6",
            "10.0.180.7"
            ]
        tags        = {Tag = "RecordExample", RecordType = "A-SplitBrain"}
      }
      "@1" = {
        record_name = "@"
        record_type = "AAAA"
        ttl         = 300
        records     = ["fdef:e8c0:1665:4fdc:0050::"]
        tags        = {Tag = "RecordExample", RecordType = "AAAA"}
      }
      "AAAA_SplitBrain" = {
        record_name = "splitbrain"
        record_type = "AAAA"
        ttl         = 300
        records     = [
            "fdef:e8c0:1665:4fdc:0051::",
            "fdef:e8c0:1665:4fdc:0052::"
            ]
        tags        = {Tag = "RecordExample", RecordType = "AAAA-SplitBrain"}
      }
      "www" = {
        record_name = "www"
        record_type = "CNAME"
        ttl         = 300
        records     = ["example.com"]
        tags        = {Tag = "RecordExample", RecordType = "CNAME"}
      }
      "@3" = {
        record_name = "@"
        record_type = "MX"
        ttl         = 300
        records = [
          "10 mail0.example.com",
          "20 mail1.example.com"
        ]
        tags = {Tag = "RecordExample", RecordType = "MX"}
      }
      "host_PTR" = {
        record_name = "15"
        record_type = "PTR"
        ttl         = 300
        records     = ["host.example.com"]
        tags        = {Tag = "RecordExample", RecordType = "PTR"}
      }
      "_sip._tcp_SRV" = {
        record_name = "_sip._tcp"
        record_type = "SRV"
        ttl         = 300
        records = [
          "1 5 8080 target1.example2.com",
          "2 10 8080 target2.example2.com"
        ]
        tags = {Tag = "RecordExample", RecordType = "SRV"}
      }
      "@4" = {
        record_name = "@"
        record_type = "TXT"
        ttl         = 300
        records     = [
            "string of text",
            "another string of text"
            ]
        tags        = {Tag = "RecordExample", RecordType = "TXT"}
      }
    }
  }
}
  tags = {
    Provisioner = "Terraform"
    ManagedBy   = "ManagedByTeam"
  }
}

output "public_zone_name_servers" {
  value = module.dns_zones_and_records.public_zone_name_servers
}
```

Recommended use for `auto_tags` variable is to generate a `tags.auto.tfvars` file as part of an automation pipeline to enforce default tags across all resources if needed. `auto_tags` merges with the universal `tags` and then merges with the resource specific `tags`.

## Inputs

### Required Inputs

These variables must be set in the `module` block when using this module.

**resource_group_name** `string`

Description: The name of the resource group that the DNS zones/records will be created within.

**dns_zones_and_records** `map(object)`

Description: Object mapping for creation of zones and respective records. **Map Keys** are the DNS zone name. Zone names must follow pattern of domain_public for public zones or domain_private for private zones.

Required Objects:

* **tags** `map(string)`

  Description: Mapping for azure resource metadata tags that will apply only to the corresponding DNS Zone.

* **recordsets** `map(object)`

  Description: Nested object mapping for creation of the records in the corresponding zone.
  
  &nbsp;&nbsp;&nbsp;&nbsp;Required Objects:

  * **record_name** `string`

    Description: Name of the DNS record (NOT FQDN)

  * **record_type** `string`

    Description: The type of record being created.
    * Public zones support A, AAAA, CAA, CNAME, MX, NS, PTR, SRV and TXT records.
    * Private zones support A, AAAA, CNAME, MX, PTR, SRV and TXT records.

  * **ttl** `number`

    Description: Time-To-Live of the record in seconds.

  * **records** `list(string)`

    Description: The records to be added based on record type. **Review Usage section for examples.**

    * **A Records:** Either a single IPv4 address or multiple for split-brain DNS.
    * **AAAA Records:** Either a single IPv6 address or multiple for split-brain DNS.
    * **CAA Records:** One or more strings with the format of "flags tag value".
    * **CNAME Records:** Target FQDN of the CNAME record. Only supports one value per CNAME record.
    * **MX Records:** One or more strings with the format of "preference exchange".
    * **NS Records:** Target FQDN of the name servers. Supports multiple values per NS record.
    * **PTR Records:** Target FQDN of the PTR record. Supports multiple values per PTR record.
    * **SRV Records:** One or more strings with the format of "priority weight port target".
    * **TXT Records:** One or more string values for the TXT record. Max length: 1024 characters.

  * **tags** `map(string)`

    Description: Mapping for azure resource metadata tags that will apply only to the corresponding DNS Record.

### Optional Inputs

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

**tags** `map(string)`

Description: Mapping for azure resource metadata tags that will apply to all resources.

**auto_tags** `map(string)`

Description: Mapping for azure resource metadata tags that will apply to all resources (for use in automation pipeline).

## Outputs

**public_zone_name_servers** `map(string)`

Description: Mapping of zone names to names servers for the zone.

## Dependencies

Dependencies are external modules that this module references. A module is considered external if it isn't within the same repository.

**This module has no external module dependencies.**

### Module Dependencies

Providers are Terraform plugins that will be automatically installed during `terraform init` if available on the Terraform Registry.

* [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm)

## Resources and Data Sources

This is the list of resources/data sources that the module may create. The module can create zero or more of each of these resources/data sources depending on how many keys are defined. `for_each` and/or `count` values are determined at runtime. The goal of this section is to present the types of resources/data sources that may be created.

This list contains all of the resources/data sources this module plus any submodules may create. When using this module, it may create less resources if you use a submodule.

This module defines 1 data source(s):

* `azurerm_resource_group.resource_group`

This module defines 18 resource(s):

* `azurerm_dns_zone.public_zone`
* `azurerm_dns_a_record.a_record`
* `azurerm_dns_aaaa_record.aaaa_record`
* `azurerm_dns_caa_record.caa_record`
* `azurerm_dns_cname_record.cname_record`
* `azurerm_dns_mx_record.mx_record`
* `azurerm_dns_ns_record.ns_record`
* `azurerm_dns_ptr_record.ptr_record`
* `azurerm_dns_srv_record.srv_record`
* `azurerm_dns_txt_record.txt_record`
* `azurerm_private_dns_zone.public_zone`
* `azurerm_private_dns_a_record.a_record`
* `azurerm_private_dns_aaaa_record.aaaa_record`
* `azurerm_private_dns_cname_record.cname_record`
* `azurerm_private_dns_mx_record.mx_record`
* `azurerm_private_dns_ptr_record.ptr_record`
* `azurerm_private_dns_srv_record.srv_record`
* `azurerm_private_dns_txt_record.txt_record`
