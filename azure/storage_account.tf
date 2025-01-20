resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = local.location
}

resource "azurerm_storage_account" "this" {
  name                            = local.storage_name
  resource_group_name             = azurerm_resource_group.this.name
  location                        = local.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  is_hns_enabled                  = false
  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "this" {
  name                  = local.container_name
  container_access_type = "private"
  storage_account_id    = azurerm_storage_account.this.id
}