### Module Version 1.0.0 ###

# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------

terraform {
  required_version = ">= 0.12"
}

# ----------------------------------------------------------------------------------------------------------------------
# This resouce creates Azure Public and Private DNS Zones and Records.
# Check the Terraform docs for any major changes to the arguments and requirement.
# Public Zone Resources:
# https://www.terraform.io/docs/providers/azurerm/r/dns_zone.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_a_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_aaaa_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_caa_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_cname_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_mx_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_ns_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_ptr_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_srv_record.html
# https://www.terraform.io/docs/providers/azurerm/r/dns_txt_record.html
# Private Zone Resources:
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_zone.html
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_a_record.html
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_aaaa_record.html
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_cname_record.html
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_mx_record.html
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_ptr_record.html
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_srv_record.html
# https://www.terraform.io/docs/providers/azurerm/r/private_dns_txt_record.html
# ----------------------------------------------------------------------------------------------------------------------

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

### INCOMPLETE - RESERVED FOR FUTURE VERSION ###
# data "azurerm_public_ip" "public_ip" {
#   name                = "name_of_public_ip"
#   resource_group_name = "name_of_resource_group"
# }
################################################

### Resources for Public DNS Zones and Records ###

resource "azurerm_dns_zone" "public_zone" {
  for_each = {
    for zone in local.zone_type : "${zone.dns_zone}" => zone
    if lower(element(split("_", zone.dns_zone), 1)) == "public"
  }
  name                = lower(element(split("_", each.key), 0))
  resource_group_name = data.azurerm_resource_group.resource_group.name
  tags                = each.value.tags
}

resource "azurerm_dns_a_record" "a_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "A" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_dns_aaaa_record" "aaaa_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "AAAA" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_dns_caa_record" "caa_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "CAA" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      flags = element(split(" ", record.value), 0)
      tag   = element(split(" ", record.value), 1)
      value = element(split(" ", record.value), 2)
    }
  }
}

resource "azurerm_dns_cname_record" "cname_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "CNAME" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  record              = element(each.value.records, 0)
  tags                = each.value.tags
}

resource "azurerm_dns_mx_record" "mx_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "MX" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      preference = element(split(" ", record.value), 0)
      exchange   = element(split(" ", record.value), 1)
    }
  }
}

resource "azurerm_dns_ns_record" "ns_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "NS" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_dns_ptr_record" "ptr_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "PTR" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_dns_srv_record" "srv_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "SRV" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      priority = element(split(" ", record.value), 0)
      weight   = element(split(" ", record.value), 1)
      port     = element(split(" ", record.value), 2)
      target   = element(split(" ", record.value), 3)
    }
  }
}

resource "azurerm_dns_txt_record" "txt_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "TXT" && lower(element(split("_", record.dns_zone), 1)) == "public"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value
    }
  }
}

### Resources for Azure Alias Records ###
### INCOMPLETE - RESERVED FOR FUTURE VERSION ### 

# resource "azurerm_dns_a_record" "a_alias_record" {
#   for_each = {
#     for record in local.alias_records : "${record.dns_record}.${record.dns_zone}" => record
#     if upper(record.record_type) == "A_ALIAS" && lower(element(split("_", record.dns_zone), 1)) == "public"
#   }

#   name                = each.value.record_name
#   zone_name           = each.value.zone_name
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   ttl                 = each.value.ttl
#   target_resource_id  = data.azurerm_public_ip.public_ip[each.value.records].id
#   tags                = each.value.tags
# }

# resource "azurerm_dns_aaaa_record" "aaaa_alias_record" {
#   for_each = {
#     for record in local.alias_records : "${record.dns_record}.${record.dns_zone}" => record
#     if upper(record.record_type) == "AAAA_ALIAS" && lower(element(split("_", record.dns_zone), 1)) == "public"
#   }

#   name                = each.value.record_name
#   zone_name           = each.value.zone_name
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   ttl                 = each.value.ttl
#   target_resource_id  = data.azurerm_public_ip.public_ip[each.value.records].id
#   tags                = each.value.tags
# }

# resource "azurerm_dns_cname_record" "cname_alias_record" {
#   for_each = {
#     for record in local.cname_alias_records : "${record.dns_record}.${record.dns_zone}" => record
#     if upper(record.record_type) == "CNAME_ALIAS"
#   }

#   name                = each.value.record_name
#   zone_name           = each.value.dns_zone
#   resource_group_name = data.azurerm_resource_group.resource_group.name
#   ttl                 = each.value.ttl
#   target_resource_id  = azurerm_dns_cname_record.cname_record["${each.value.target_cname_record}_public"].id
#   tags                = each.value.tags
# }
################################################

### Resources for Private DNS Zones and Records ###

resource "azurerm_private_dns_zone" "private_zone" {
  for_each = {
    for zone in local.zone_type : "${zone.dns_zone}" => zone
    if lower(element(split("_", zone.dns_zone), 1)) == "private"
  }
  name                = lower(element(split("_", each.key), 0))
  resource_group_name = data.azurerm_resource_group.resource_group.name
  tags                = each.value.tags
}

resource "azurerm_private_dns_a_record" "a_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "A" && lower(element(split("_", record.dns_zone), 1)) == "private"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_private_dns_aaaa_record" "aaaa_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "AAAA" && lower(element(split("_", record.dns_zone), 1)) == "private"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_private_dns_cname_record" "cname_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "CNAME" && lower(element(split("_", record.dns_zone), 1)) == "private"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  record              = element(each.value.records, 0)
  tags                = each.value.tags
}

resource "azurerm_private_dns_mx_record" "mx_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "MX" && lower(element(split("_", record.dns_zone), 1)) == "private"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      preference = element(split(" ", record.value), 0)
      exchange   = element(split(" ", record.value), 1)
    }
  }
}

resource "azurerm_private_dns_ptr_record" "ptr_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "PTR" && lower(element(split("_", record.dns_zone), 1)) == "private"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  records             = each.value.records
  tags                = each.value.tags
}

resource "azurerm_private_dns_srv_record" "srv_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "SRV" && lower(element(split("_", record.dns_zone), 1)) == "private"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      priority = element(split(" ", record.value), 0)
      weight   = element(split(" ", record.value), 1)
      port     = element(split(" ", record.value), 2)
      target   = element(split(" ", record.value), 3)
    }
  }
}

resource "azurerm_private_dns_txt_record" "txt_record" {
  for_each = {
    for record in local.dns_records : "${record.dns_record}.${record.dns_zone}" => record
    if upper(record.record_type) == "TXT" && lower(element(split("_", record.dns_zone), 1)) == "private"
  }

  name                = each.value.record_name
  zone_name           = each.value.zone_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
  ttl                 = each.value.ttl
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

    content {
      value = record.value
    }
  }
}

### Local values for use in resources ###

locals {
  # Merge user defined tags with tags added by automation.
  global_tags = merge(var.tags, var.auto_tags)
  # Flatten ensures that local values are a flat list of objects, rather
  # than a list of lists of objects for use in for_each loops.
  zone_type = flatten([
    for dns_zone, zone in var.dns_zones_and_records : {
      dns_zone = dns_zone
      tags     = merge(local.global_tags, zone.tags)
    }
  ])
  dns_records = flatten([
    for dns_zone, zone in var.dns_zones_and_records : [
      for dns_record, record in zone.recordsets : {
        dns_zone    = dns_zone
        dns_record  = dns_record
        record_name = record.record_name
        zone_name   = lower(element(split("_", dns_zone), 1)) == "private" ? azurerm_private_dns_zone.private_zone[dns_zone].name : azurerm_dns_zone.public_zone[dns_zone].name
        record_type = record.record_type
        ttl         = record.ttl
        records     = record.records
        tags        = merge(local.global_tags, record.tags)
      }
    ]
  ])

  ### INCOMPLETE - RESERVED FOR FUTURE VERSION ###
  # cname_alias_records = flatten([
  #   for cname_alias, record in var.azure_alias_cname_records : {
  #     dns_zone            = record.zone_name
  #     dns_record          = cname_alias
  #     record_type         = record.record_type
  #     target_cname_record = record.target_cname_fqdn
  #     ttl                 = record.ttl
  #     tags                = record.tags
  #   }
  # ])
  ################################################

  # Zones of unsupported types would be silently ignored.
  # The following two expressions ensure that
  # unsupported types will produce an error message instead.  
  supported_zone_types = {
    PUBLIC  = true
    PRIVATE = true
  }
  check_supported_zone_types = [
    # The index operation here will fail if one of the zones has
    # an unsupported type.
    for zone in local.zone_type : local.supported_zone_types[upper(element(split("_", zone.dns_zone), 1))]
  ]
  supported_public_record_types = {
    A     = true
    AAAA  = true
    CAA   = true
    CNAME = true
    MX    = true
    NS    = true
    PTR   = true
    SRV   = true
    TXT   = true
  }
  check_public_supported_record_types = [
    # The index operation here will fail if one of the records has
    # an unsupported type.
    for record in local.dns_records : local.supported_public_record_types[upper(record.record_type)]
    if lower(element(split("_", record.dns_zone), 1)) == "public"
  ]
  supported_private_record_types = {
    A     = true
    AAAA  = true
    CNAME = true
    MX    = true
    PTR   = true
    SRV   = true
    TXT   = true
  }
  check_private_supported_record_types = [
    # The index operation here will fail if one of the records has
    # an unsupported type.
    for record in local.dns_records : local.supported_private_record_types[upper(record.record_type)]
    if lower(element(split("_", record.dns_zone), 1)) == "private"
  ]
}