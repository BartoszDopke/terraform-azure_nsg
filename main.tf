locals {
  tags = {
    "Environment" = lookup(var.environment.tags, "Environment", "empty"),
    "Remark"      = lookup(var.environment.tags, "Remark", "empty")
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.environment.location.name
  resource_group_name = var.resource_group_name

  tags = merge(local.tags, var.tags)
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}


### DIAGNOSTIC SETTINGS

data "azurerm_monitor_diagnostic_categories" "diagset" {
  resource_id = azurerm_network_security_group.nsg.id
}

locals {
  log_categories = (
    data.azurerm_monitor_diagnostic_categories.diagset.logs
  )
  metric_categories = (
    data.azurerm_monitor_diagnostic_categories.diagset.metrics
  )

  logs = {
    for category in local.log_categories : category => {
      enabled = var.enabled
    }
  }

  metrics = {
    for metric in local.metric_categories : metric => {
      enabled = var.enabled
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  count                      = var.enable_diagnostics == true ? 1 : 0
  name                       = "${var.nsg_name}-DIAG-01"
  target_resource_id         = azurerm_network_security_group.nsg.id
  log_analytics_workspace_id = var.ds_map["log_analytics_workspace_id"]

  dynamic "log" {
    for_each = local.logs

    content {
      category = log.key
      enabled  = log.value.enabled

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }

  dynamic "metric" {
    for_each = local.metrics

    content {
      category = metric.key
      enabled  = metric.value.enabled

      retention_policy {
        enabled = false
        days    = 0
      }
    }
  }
}


resource "azurerm_network_watcher_flow_log" "network_watcher_flow_log" {
  count                     = var.enable_nw_flow_log == true ? 1 : 0
  network_watcher_name      = var.environment.network_watcher.name
  resource_group_name       = "NetworkWatcherRG"
  network_security_group_id = azurerm_network_security_group.nsg.id
  storage_account_id        = var.storage_account_id
  enabled                   = var.enabled
  version                   = var.nwf_version

  retention_policy {
    enabled = var.rp_enabled
    days    = var.rp_days
  }

  dynamic "traffic_analytics" {
    for_each = var.traffic_analytics_enabled == true ? [1] : []
    content {
      enabled               = var.ta_enabled
      workspace_id          = var.workspace_id
      workspace_region      = var.environment.location.name
      workspace_resource_id = var.ds_map["log_analytics_workspace_id"]
      interval_in_minutes   = var.interval_in_minutes
    }
  }
}