```hcl
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
```
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_data_factory.adf](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/data_factory) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer_managed_key_id"></a> [customer\_managed\_key\_id](#input\_customer\_managed\_key\_id) | The customer managed key id if used | `string` | `null` | no |
| <a name="input_customer_managed_key_identity_id"></a> [customer\_managed\_key\_identity\_id](#input\_customer\_managed\_key\_identity\_id) | The customer managed key identity id if used | `string` | `null` | no |
| <a name="input_github_configuration"></a> [github\_configuration](#input\_github\_configuration) | The github configuration block if used | <pre>object({<br>    account_name       = string<br>    branch_name        = string<br>    git_url            = string<br>    repository_name    = string<br>    root_folder        = string<br>    publishing_enabled = optional(bool, true)<br>  })</pre> | `null` | no |
| <a name="input_global_parameter"></a> [global\_parameter](#input\_global\_parameter) | The global parameter blocks if used | <pre>list(object({<br>    name  = string<br>    type  = string<br>    value = string<br>  }))</pre> | `null` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | Specifies a list of user managed identity ids to be assigned to the VM. | `list(string)` | `[]` | no |
| <a name="input_identity_type"></a> [identity\_type](#input\_identity\_type) | The Managed Service Identity Type of this Virtual Machine. | `string` | `""` | no |
| <a name="input_location"></a> [location](#input\_location) | The location for this resource to be put in | `string` | n/a | yes |
| <a name="input_managed_virtual_network_enabled"></a> [managed\_virtual\_network\_enabled](#input\_managed\_virtual\_network\_enabled) | Whether a managed virtual network is enabled in this ADF | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the VNet gateway | `string` | n/a | yes |
| <a name="input_public_network_enabled"></a> [public\_network\_enabled](#input\_public\_network\_enabled) | Whether public network is enabled | `bool` | `false` | no |
| <a name="input_purview_id"></a> [purview\_id](#input\_purview\_id) | The purview id if used | `string` | `null` | no |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of the tags to use on the resources that are deployed with this module. | `map(string)` | n/a | yes |
| <a name="input_vsts_configuration"></a> [vsts\_configuration](#input\_vsts\_configuration) | The vsts configuration block if used | <pre>object({<br>    account_name       = string<br>    branch_name        = string<br>    project_name       = string<br>    repository_name    = string<br>    root_folder        = string<br>    tenant_id          = string<br>    publishing_enabled = optional(bool, true)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_factory_id"></a> [factory\_id](#output\_factory\_id) | The ID of the factory |
| <a name="output_factory_identity"></a> [factory\_identity](#output\_factory\_identity) | The identity block of the data factory |
