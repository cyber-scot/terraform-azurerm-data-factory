module "rg" {
  source = "cyber-scot/rg/azurerm"

  name     = "rg-${var.short}-${var.loc}-${var.env}-01"
  location = local.location
  tags     = local.tags
}


module "adf" {
  source = "cyber-scot/data-factory/azurerm"

  rg_name  = module.rg.rg_name
  location = module.rg.rg_location
  tags     = module.rg.rg_tags

  name                            = "adf-${var.short}-${var.loc}-${var.env}-01"
  public_network_enabled          = false
  managed_virtual_network_enabled = false

}
