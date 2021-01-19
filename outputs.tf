output "nsg_name" {
  value = azurerm_network_security_group.nsg.name
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "flow_log_id" {
  value = azurerm_network_watcher_flow_log.network_watcher_flow_log[0].id
}