output "sql_server" {

  value = azurerm_mssql_server.sql_server
}



output "sql_database" {

  value = azurerm_mssql_database.sql_database

}
output "sql_private_endpoint_ip" {
  value = azurerm_private_endpoint.sql_private_endpoint.private_service_connection[0].private_ip_address
}

output "sql_dns_zone" {
  value = azurerm_private_dns_zone.sql_dns_zone.name
}
