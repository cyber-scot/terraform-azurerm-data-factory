variable "customer_managed_key_id" {
  type        = string
  description = "The customer managed key id if used"
  default     = null
}

variable "customer_managed_key_identity_id" {
  type        = string
  description = "The customer managed key identity id if used"
  default     = null
}

variable "github_configuration" {
  description = "The github configuration block if used"
  type = object({
    account_name       = string
    branch_name        = string
    git_url            = string
    repository_name    = string
    root_folder        = string
    publishing_enabled = optional(bool, true)
  })
  default = null
}

variable "global_parameter" {
  description = "The global parameter blocks if used"
  type = list(object({
    name  = string
    type  = string
    value = string
  }))
  default = null
}

variable "identity_ids" {
  description = "Specifies a list of user managed identity ids to be assigned to the VM."
  type        = list(string)
  default     = []
}

variable "identity_type" {
  description = "The Managed Service Identity Type of this Virtual Machine."
  type        = string
  default     = ""
}

variable "location" {
  description = "The location for this resource to be put in"
  type        = string
}

variable "managed_virtual_network_enabled" {
  type        = bool
  description = "Whether a managed virtual network is enabled in this ADF"
  default     = false
}

variable "name" {
  type        = string
  description = "The name of the VNet gateway"
}

variable "public_network_enabled" {
  type        = bool
  description = "Whether public network is enabled"
  default     = false
}

variable "purview_id" {
  type        = string
  description = "The purview id if used"
  default     = null
}

variable "rg_name" {
  description = "The name of the resource group, this module does not create a resource group, it is expecting the value of a resource group already exists"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of the tags to use on the resources that are deployed with this module."
}

variable "vsts_configuration" {
  description = "The vsts configuration block if used"
  type = object({
    account_name       = string
    branch_name        = string
    project_name       = string
    repository_name    = string
    root_folder        = string
    tenant_id          = string
    publishing_enabled = optional(bool, true)
  })
  default = null
}
