# complete

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.113 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | terraform.registry.launch.nttdata.com/module_primitive/storage_account/azurerm | ~> 1.0 |
| <a name="module_app_service_plan"></a> [app\_service\_plan](#module\_app\_service\_plan) | terraform.registry.launch.nttdata.com/module_primitive/app_service_plan/azurerm | ~> 1.0 |
| <a name="module_web_app"></a> [web\_app](#module\_web\_app) | ../.. | n/a |
| <a name="module_role_assignment"></a> [role\_assignment](#module\_role\_assignment) | terraform.registry.launch.nttdata.com/module_primitive/role_assignment/azurerm | ~> 1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "resource_group": {<br>    "max_length": 60,<br>    "name": "rg"<br>  },<br>  "service_plan": {<br>    "max_length": 60,<br>    "name": "asp"<br>  },<br>  "storage_account": {<br>    "max_length": 24,<br>    "name": "sa"<br>  },<br>  "web_app": {<br>    "max_length": 60,<br>    "name": "wap"<br>  }<br>}</pre> | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The OS type of the web app. | `string` | `"Windows"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"func"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where the web app will be created | `string` | n/a | yes |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | The Tier to use for this storage account | `string` | `"Standard"` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | The Replication Type to use for this storage account | `string` | `"LRS"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU for the web app hosting plan | `string` | `"Y1"` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Environment variables to set on the web app | `map(string)` | `{}` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | If true, the web app will only accept HTTPS requests | `bool` | `true` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | If true, the web app will be accessible from the public internet | `bool` | `true` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | n/a | <pre>object({<br>    always_on             = optional(bool)<br>    api_definition_url    = optional(string)<br>    api_management_api_id = optional(string)<br>    app_command_line      = optional(string)<br>    application_stack = optional(object({<br>      current_stack                = optional(string)<br>      docker_image_name            = optional(string)<br>      docker_registry_url          = optional(string)<br>      docker_registry_username     = optional(string)<br>      docker_registry_password     = optional(string)<br>      dotnet_version               = optional(string)<br>      dotnet_core_version          = optional(string)<br>      go_version                   = optional(string)<br>      tomcat_version               = optional(string)<br>      java_embedded_server_enabled = optional(bool)<br>      java_server                  = optional(string)<br>      java_server_version          = optional(string)<br>      java_version                 = optional(string)<br>      node_version                 = optional(string)<br>      php_version                  = optional(string)<br>      python                       = optional(bool)<br>      python_version               = optional(string)<br>      ruby_version                 = optional(string)<br>    }))<br>    auto_heal_setting = optional(object({<br>      action = object({<br>        action_type = string<br>        custom_action = optional(object({<br>          executable = string<br>          parameters = optional(string)<br>        }))<br>        minimum_process_execution_time = optional(string)<br>      })<br>      trigger = object({<br>        private_memory_kb = optional(number)<br>        requests = optional(object({<br>          count    = number<br>          interval = string<br>        }))<br>        slow_requests = optional(object({<br>          count      = number<br>          interval   = string<br>          time_taken = string<br>        }))<br>        slow_request_with_path = optional(object({<br>          count      = number<br>          interval   = string<br>          time_taken = string<br>          path       = optional(string)<br>        }))<br>        status_code = optional(object({<br>          count             = number<br>          interval          = string<br>          status_code_range = string<br>          path              = optional(string)<br>          sub_status        = optional(string)<br>          win32_status_code = optional(string)<br>        }))<br>      })<br>    }))<br>    container_registry_managed_identity_client_id = optional(string)<br>    container_registry_use_managed_identity       = optional(bool)<br>    cors = optional(object({<br>      allowed_origins     = list(string)<br>      support_credentials = optional(bool)<br>    }))<br>    default_documents                 = optional(list(string))<br>    ftps_state                        = optional(string)<br>    health_check_path                 = optional(string)<br>    health_check_eviction_time_in_min = optional(number)<br>    http2_enabled                     = optional(bool)<br>    ip_restriction = optional(list(object({<br>      ip_address                = optional(string)<br>      action                    = string<br>      name                      = optional(string)<br>      priority                  = optional(number)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>      headers = optional(list(object({<br>        x_forwarded_for   = optional(string)<br>        x_forwarded_host  = optional(string)<br>        x_fd_health_probe = optional(string)<br>        x_azure_fdid      = optional(list(string))<br>      })))<br>    })))<br>    ip_restriction_default_action = optional(string)<br>    load_balancing_mode           = optional(string)<br>    local_mysql_enabled           = optional(bool)<br>    managed_pipeline_mode         = optional(string)<br>    minimum_tls_version           = optional(string)<br>    remote_debugging_enabled      = optional(bool)<br>    remote_debugging_version      = optional(string)<br>    scm_ip_restrictions = optional(list(object({<br>      ip_address                = optional(string)<br>      action                    = string<br>      name                      = optional(string)<br>      priority                  = optional(number)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>      headers = optional(list(object({<br>        x_forwarded_for   = optional(string)<br>        x_forwarded_host  = optional(string)<br>        x_fd_health_probe = optional(string)<br>        x_azure_fdid      = optional(list(string))<br>      })))<br>    })))<br>    scm_ip_restrictions_default_action = optional(string)<br>    scm_minimum_tls_version            = optional(string)<br>    scm_use_main_ip_restriction        = optional(bool, true)<br>    use_32_bit_worker                  = optional(bool)<br>    handler_mapping = optional(object({<br>      extension             = string<br>      script_processor_path = string<br>      arguments             = optional(string)<br>    }))<br>    virtual_application = optional(list(object({<br>      physical_path = string<br>      preload       = bool<br>      virtual_directory = optional(list(object({<br>        physical_path = optional(string)<br>        virtual_path  = optional(string)<br>      })))<br>      virtual_path = string<br>    })))<br>    vnet_route_all_enabled = optional(bool)<br>    websockets_enabled     = optional(bool)<br>    worker_count           = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | (Optional) One or more storage\_account blocks. | <pre>list(object({<br>    access_key   = string<br>    account_name = string<br>    name         = string<br>    share_name   = string<br>    type         = string<br>    mount_path   = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | <pre>{<br>  "identity_ids": null,<br>  "type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_key_vault_reference_identity_id"></a> [key\_vault\_reference\_identity\_id](#input\_key\_vault\_reference\_identity\_id) | (Optional) The identity ID of the Key Vault reference. Required when identity.type is set to UserAssigned or SystemAssigned, UserAssigned. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | n/a |
| <a name="output_web_app_name"></a> [web\_app\_name](#output\_web\_app\_name) | n/a |
| <a name="output_web_app_id"></a> [web\_app\_id](#output\_web\_app\_id) | n/a |
| <a name="output_web_app_principal_id"></a> [web\_app\_principal\_id](#output\_web\_app\_principal\_id) | n/a |
| <a name="output_service_plan_name"></a> [service\_plan\_name](#output\_service\_plan\_name) | n/a |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | n/a |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The id of the storage account |
<!-- END_TF_DOCS -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.113 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | terraform.registry.launch.nttdata.com/module_primitive/storage_account/azurerm | ~> 1.0 |
| <a name="module_app_service_plan"></a> [app\_service\_plan](#module\_app\_service\_plan) | terraform.registry.launch.nttdata.com/module_primitive/app_service_plan/azurerm | ~> 1.0 |
| <a name="module_web_app"></a> [web\_app](#module\_web\_app) | ../.. | n/a |
| <a name="module_role_assignment"></a> [role\_assignment](#module\_role\_assignment) | terraform.registry.launch.nttdata.com/module_primitive/role_assignment/azurerm | ~> 1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object({<br>    name       = string<br>    max_length = optional(number, 60)<br>  }))</pre> | <pre>{<br>  "resource_group": {<br>    "max_length": 60,<br>    "name": "rg"<br>  },<br>  "service_plan": {<br>    "max_length": 60,<br>    "name": "asp"<br>  },<br>  "storage_account": {<br>    "max_length": 24,<br>    "name": "sa"<br>  },<br>  "web_app": {<br>    "max_length": 60,<br>    "name": "wap"<br>  }<br>}</pre> | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The OS type of the web app. | `string` | `"Windows"` | no |
| <a name="input_instance_env"></a> [instance\_env](#input\_instance\_env) | Number that represents the instance of the environment. | `number` | `0` | no |
| <a name="input_instance_resource"></a> [instance\_resource](#input\_instance\_resource) | Number that represents the instance of the resource. | `number` | `0` | no |
| <a name="input_logical_product_family"></a> [logical\_product\_family](#input\_logical\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"launch"` | no |
| <a name="input_logical_product_service"></a> [logical\_product\_service](#input\_logical\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"func"` | no |
| <a name="input_class_env"></a> [class\_env](#input\_class\_env) | (Required) Environment where resource is going to be deployed. For example. dev, qa, uat | `string` | `"dev"` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where the web app will be created | `string` | n/a | yes |
| <a name="input_storage_account_tier"></a> [storage\_account\_tier](#input\_storage\_account\_tier) | The Tier to use for this storage account | `string` | `"Standard"` | no |
| <a name="input_storage_account_replication_type"></a> [storage\_account\_replication\_type](#input\_storage\_account\_replication\_type) | The Replication Type to use for this storage account | `string` | `"LRS"` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU for the web app hosting plan | `string` | `"Y1"` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Environment variables to set on the web app | `map(string)` | `{}` | no |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | If true, the web app will only accept HTTPS requests | `bool` | `true` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | If true, the web app will be accessible from the public internet | `bool` | `true` | no |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | n/a | <pre>object({<br>    always_on             = optional(bool)<br>    api_definition_url    = optional(string)<br>    api_management_api_id = optional(string)<br>    app_command_line      = optional(string)<br>    application_stack = optional(object({<br>      current_stack                = optional(string)<br>      docker_image_name            = optional(string)<br>      docker_registry_url          = optional(string)<br>      docker_registry_username     = optional(string)<br>      docker_registry_password     = optional(string)<br>      dotnet_version               = optional(string)<br>      dotnet_core_version          = optional(string)<br>      go_version                   = optional(string)<br>      tomcat_version               = optional(string)<br>      java_embedded_server_enabled = optional(bool)<br>      java_server                  = optional(string)<br>      java_server_version          = optional(string)<br>      java_version                 = optional(string)<br>      node_version                 = optional(string)<br>      php_version                  = optional(string)<br>      python                       = optional(bool)<br>      python_version               = optional(string)<br>      ruby_version                 = optional(string)<br>    }))<br>    auto_heal_setting = optional(object({<br>      action = object({<br>        action_type = string<br>        custom_action = optional(object({<br>          executable = string<br>          parameters = optional(string)<br>        }))<br>        minimum_process_execution_time = optional(string)<br>      })<br>      trigger = object({<br>        private_memory_kb = optional(number)<br>        requests = optional(object({<br>          count    = number<br>          interval = string<br>        }))<br>        slow_requests = optional(object({<br>          count      = number<br>          interval   = string<br>          time_taken = string<br>        }))<br>        slow_request_with_path = optional(object({<br>          count      = number<br>          interval   = string<br>          time_taken = string<br>          path       = optional(string)<br>        }))<br>        status_code = optional(object({<br>          count             = number<br>          interval          = string<br>          status_code_range = string<br>          path              = optional(string)<br>          sub_status        = optional(string)<br>          win32_status_code = optional(string)<br>        }))<br>      })<br>    }))<br>    container_registry_managed_identity_client_id = optional(string)<br>    container_registry_use_managed_identity       = optional(bool)<br>    cors = optional(object({<br>      allowed_origins     = list(string)<br>      support_credentials = optional(bool)<br>    }))<br>    default_documents                 = optional(list(string))<br>    ftps_state                        = optional(string)<br>    health_check_path                 = optional(string)<br>    health_check_eviction_time_in_min = optional(number)<br>    http2_enabled                     = optional(bool)<br>    ip_restriction = optional(list(object({<br>      ip_address                = optional(string)<br>      action                    = string<br>      name                      = optional(string)<br>      priority                  = optional(number)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>      headers = optional(list(object({<br>        x_forwarded_for   = optional(string)<br>        x_forwarded_host  = optional(string)<br>        x_fd_health_probe = optional(string)<br>        x_azure_fdid      = optional(list(string))<br>      })))<br>    })))<br>    ip_restriction_default_action = optional(string)<br>    load_balancing_mode           = optional(string)<br>    local_mysql_enabled           = optional(bool)<br>    managed_pipeline_mode         = optional(string)<br>    minimum_tls_version           = optional(string)<br>    remote_debugging_enabled      = optional(bool)<br>    remote_debugging_version      = optional(string)<br>    scm_ip_restrictions = optional(list(object({<br>      ip_address                = optional(string)<br>      action                    = string<br>      name                      = optional(string)<br>      priority                  = optional(number)<br>      service_tag               = optional(string)<br>      virtual_network_subnet_id = optional(string)<br>      headers = optional(list(object({<br>        x_forwarded_for   = optional(string)<br>        x_forwarded_host  = optional(string)<br>        x_fd_health_probe = optional(string)<br>        x_azure_fdid      = optional(list(string))<br>      })))<br>    })))<br>    scm_ip_restrictions_default_action = optional(string)<br>    scm_minimum_tls_version            = optional(string)<br>    scm_use_main_ip_restriction        = optional(bool, true)<br>    use_32_bit_worker                  = optional(bool)<br>    handler_mapping = optional(object({<br>      extension             = string<br>      script_processor_path = string<br>      arguments             = optional(string)<br>    }))<br>    virtual_application = optional(list(object({<br>      physical_path = string<br>      preload       = bool<br>      virtual_directory = optional(list(object({<br>        physical_path = optional(string)<br>        virtual_path  = optional(string)<br>      })))<br>      virtual_path = string<br>    })))<br>    vnet_route_all_enabled = optional(bool)<br>    websockets_enabled     = optional(bool)<br>    worker_count           = optional(number)<br>  })</pre> | `{}` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | (Optional) One or more storage\_account blocks. | <pre>list(object({<br>    access_key   = string<br>    account_name = string<br>    name         = string<br>    share_name   = string<br>    type         = string<br>    mount_path   = optional(string)<br>  }))</pre> | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) An identity block. | <pre>object({<br>    type         = string<br>    identity_ids = optional(list(string))<br>  })</pre> | <pre>{<br>  "identity_ids": null,<br>  "type": "SystemAssigned"<br>}</pre> | no |
| <a name="input_key_vault_reference_identity_id"></a> [key\_vault\_reference\_identity\_id](#input\_key\_vault\_reference\_identity\_id) | (Optional) The identity ID of the Key Vault reference. Required when identity.type is set to UserAssigned or SystemAssigned, UserAssigned. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | n/a |
| <a name="output_web_app_name"></a> [web\_app\_name](#output\_web\_app\_name) | n/a |
| <a name="output_web_app_id"></a> [web\_app\_id](#output\_web\_app\_id) | n/a |
| <a name="output_web_app_principal_id"></a> [web\_app\_principal\_id](#output\_web\_app\_principal\_id) | n/a |
| <a name="output_service_plan_name"></a> [service\_plan\_name](#output\_service\_plan\_name) | n/a |
| <a name="output_service_plan_id"></a> [service\_plan\_id](#output\_service\_plan\_id) | n/a |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The id of the storage account |
<!-- END_TF_DOCS -->
