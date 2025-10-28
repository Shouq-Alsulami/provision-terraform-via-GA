# Create Private DNS Zone for SQL
resource "azurerm_private_dns_zone" "sql_dns_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

# Link DNS Zone with the existing VNet
resource "azurerm_private_dns_zone_virtual_network_link" "sql_dns_link" {
  name                  = "${var.server_name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_dns_zone.name
  virtual_network_id    = var.vnet_id
}

# Create Private Endpoint in the subnet
resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "${var.server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.server_name}-sql-connection"
    private_connection_resource_id = azurerm_mssql_server.sql_server.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.sql_dns_zone.id]
  }
    depends_on = [
  azurerm_private_endpoint.sql_private_endpoint
]

}

