output "public_zone_name_servers" {
  value = {
    for zone in azurerm_dns_zone.public_zone :
    zone.name => zone.name_servers
  }
}