output "factory_id" {
  description = "The ID of the factory"
  value       = azurerm_data_factory.adf.id
}

output "factory_identity" {
  description = "The identity block of the data factory"
  value       = azurerm_data_factory.adf.identity
}
