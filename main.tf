resource "azurerm_data_factory" "adf" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  public_network_enabled           = var.public_network_enabled
  customer_managed_key_id          = var.customer_managed_key_id
  customer_managed_key_identity_id = var.customer_managed_key_identity_id
  purview_id                       = var.purview_id
  managed_virtual_network_enabled  = var.managed_virtual_network_enabled

  dynamic "github_configuration" {
    for_each = var.github_configuration != null ? [var.github_configuration] : []
    content {
      account_name       = github_configuration.value.account_name
      branch_name        = github_configuration.value.branch_name
      git_url            = github_configuration.value.git_url
      repository_name    = github_configuration.value.repository_name
      root_folder        = github_configuration.value.root_folder
      publishing_enabled = github_configuration.value.publishing_enabled
    }
  }

  dynamic "vsts_configuration" {
    for_each = var.vsts_configuration != null ? [var.vsts_configuration] : []
    content {
      account_name       = vsts_configuration.value.account_name
      branch_name        = vsts_configuration.value.branch_name
      project_name       = vsts_configuration.value.project_name
      repository_name    = vsts_configuration.value.repository_name
      root_folder        = vsts_configuration.value.root_folder
      tenant_id          = vsts_configuration.value.tenant_id
      publishing_enabled = vsts_configuration.value.publishing_enabled
    }
  }

  dynamic "global_parameter" {
    for_each = var.global_parameter != null ? var.global_parameter : []
    content {
      name  = global_parameter.value.name
      type  = global_parameter.value.type
      value = global_parameter.value.value
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) == 0 && var.identity_type == "SystemAssigned" ? [var.identity_type] : []
    content {
      type = var.identity_type
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 || var.identity_type == "UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }

  dynamic "identity" {
    for_each = length(var.identity_ids) > 0 || var.identity_type == "SystemAssigned, UserAssigned" ? [var.identity_type] : []
    content {
      type         = var.identity_type
      identity_ids = length(var.identity_ids) > 0 ? var.identity_ids : []
    }
  }

}
