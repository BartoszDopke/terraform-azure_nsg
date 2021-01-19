#REQUIRED

variable "nsg_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "traffic_analytics_enabled" {
  type    = bool
  default = true
}

variable "enable_diagnostics" {
  type    = bool
  default = true
}

#tags
variable "environment" {
  type = map(any)
  default = {
    tags = {}
  }
  description = "Global tags"
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "Specific tags"
}

###DIAGNOSTIC SETTINGS

#REQUIRED

variable "ds_map" {
  type = map(any)
  default = {
    log_analytics_workspace_id = null
  }
}

#OPTIONAL

variable "enabled" {
  type        = bool
  default     = true
  description = "Either `true` to enable diagnostic settings or `false` to disable it."
}


### NETWORK WATCHER FLOW LOG

#REQUIRED

variable "enable_nw_flow_log" {
  type    = bool
  default = true
}

variable "network_watcher_name" {
  type    = string
  default = null
}
variable "storage_account_id" {
  type    = string
  default = null
}

variable "rp_enabled" {
  type    = bool
  default = false
}

variable "rp_days" {
  type    = number
  default = 0
}

#traffic analytics

variable "ta_enabled" {
  type    = bool
  default = true
}

variable "workspace_id" {
  type    = string
  default = null
}

variable "workspace_region" {
  type    = string
  default = null
}

#OPTIONAL

variable "nwf_version" {
  type    = number
  default = 2
}

variable "interval_in_minutes" {
  type    = number
  default = 10
}