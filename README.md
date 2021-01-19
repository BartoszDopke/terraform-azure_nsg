# terraform-azure_nsg
This module create Azure Network Security Group, NSG Association, Diagnostic Settings and Network Watcher Flow Log.


## Requirements   

No requirements.  

## Providers      

| Name | Version |
|------|---------|
| azurerm | n/a | 

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| ds\_map | n/a | `map(any)` | <pre>{<br>  "log_analytics_workspace_id": null<br>}</pre> | no |
| enable\_diagnostics | n/a | `bool` | `true` | no |
| enable\_nw\_flow\_log | n/a | `bool` | `true` | no |
| enabled | Either `true` to enable diagnostic settings or `false` to disable it. | `bool` | `true` | no |
| environment | Global tags | `map(any)` | <pre>{<br>  "tags": {}<br>}</pre> | no |
| interval\_in\_minutes | n/a | `number` | `10` | no |
| network\_watcher\_name | n/a | `string` | `null` | no |
| nsg\_name | n/a | `string` | n/a | yes |
| nwf\_version | n/a | `number` | `2` | no |
| resource\_group\_name | n/a | `string` | n/a | yes |
| rp\_days | n/a | `number` | `0` | no |
| rp\_enabled | n/a | `bool` | `false` | no |
| storage\_account\_id | n/a | `string` | `null` | no |
| subnet\_id | n/a | `string` | n/a | yes |
| ta\_enabled | n/a | `bool` | `true` | no |
| tags | Specific tags | `map(any)` | `{}` | no |
| traffic\_analytics\_enabled | n/a | `bool` | `true` | no |
| workspace\_id | n/a | `string` | `null` | no |
| workspace\_region | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| flow\_log\_id | n/a |
| nsg\_id | n/a |
| nsg\_name | n/a |
