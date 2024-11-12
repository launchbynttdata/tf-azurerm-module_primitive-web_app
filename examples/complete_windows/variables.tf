// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object({
    name       = string
    max_length = optional(number, 60)
  }))

  default = {
    web_app = {
      name       = "wap"
      max_length = 60
    }
    storage_account = {
      name       = "sa"
      max_length = 24
    }
    service_plan = {
      name       = "asp"
      max_length = 60
    }
    resource_group = {
      name       = "rg"
      max_length = 60
    }
  }
}

variable "os_type" {
  description = "The OS type of the web app."
  type        = string
  default     = "Windows"
}

variable "instance_env" {
  type        = number
  description = "Number that represents the instance of the environment."
  default     = 0

  validation {
    condition     = var.instance_env >= 0 && var.instance_env <= 999
    error_message = "Instance number should be between 0 to 999."
  }
}

variable "instance_resource" {
  type        = number
  description = "Number that represents the instance of the resource."
  default     = 0

  validation {
    condition     = var.instance_resource >= 0 && var.instance_resource <= 100
    error_message = "Instance number should be between 0 to 100."
  }
}

variable "logical_product_family" {
  type        = string
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_family))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "launch"
}

variable "logical_product_service" {
  type        = string
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  nullable    = false

  validation {
    condition     = can(regex("^[_\\-A-Za-z0-9]+$", var.logical_product_service))
    error_message = "The variable must contain letters, numbers, -, _, and .."
  }

  default = "func"
}

variable "class_env" {
  type        = string
  description = "(Required) Environment where resource is going to be deployed. For example. dev, qa, uat"
  nullable    = false
  default     = "dev"

  validation {
    condition     = length(regexall("\\b \\b", var.class_env)) == 0
    error_message = "Spaces between the words are not allowed."
  }
}

variable "location" {
  description = "Location where the web app will be created"
  type        = string
}

variable "storage_account_tier" {
  description = "The Tier to use for this storage account"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "The Replication Type to use for this storage account"
  type        = string
  default     = "LRS"
}

variable "sku" {
  description = "The SKU for the web app hosting plan"
  type        = string
  default     = "Y1"
}

variable "app_settings" {
  description = "Environment variables to set on the web app"
  type        = map(string)
  default     = {}
}

variable "https_only" {
  description = "If true, the web app will only accept HTTPS requests"
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "If true, the web app will be accessible from the public internet"
  type        = bool
  default     = true
}

variable "site_config" {
  type = object({
    always_on             = optional(bool)
    api_definition_url    = optional(string)
    api_management_api_id = optional(string)
    app_command_line      = optional(string)
    application_stack = optional(object({
      current_stack                = optional(string)
      docker_image_name            = optional(string)
      docker_registry_url          = optional(string)
      docker_registry_username     = optional(string)
      docker_registry_password     = optional(string)
      dotnet_version               = optional(string)
      dotnet_core_version          = optional(string)
      go_version                   = optional(string)
      tomcat_version               = optional(string)
      java_embedded_server_enabled = optional(bool)
      java_server                  = optional(string)
      java_server_version          = optional(string)
      java_version                 = optional(string)
      node_version                 = optional(string)
      php_version                  = optional(string)
      python                       = optional(bool)
      python_version               = optional(string)
      ruby_version                 = optional(string)
    }))
    auto_heal_setting = optional(object({
      action = object({
        action_type = string
        custom_action = optional(object({
          executable = string
          parameters = optional(string)
        }))
        minimum_process_execution_time = optional(string)
      })
      trigger = object({
        private_memory_kb = optional(number)
        requests = optional(object({
          count    = number
          interval = string
        }))
        slow_requests = optional(object({
          count      = number
          interval   = string
          time_taken = string
        }))
        slow_request_with_path = optional(object({
          count      = number
          interval   = string
          time_taken = string
          path       = optional(string)
        }))
        status_code = optional(object({
          count             = number
          interval          = string
          status_code_range = string
          path              = optional(string)
          sub_status        = optional(string)
          win32_status_code = optional(string)
        }))
      })
    }))
    container_registry_managed_identity_client_id = optional(string)
    container_registry_use_managed_identity       = optional(bool)
    cors = optional(object({
      allowed_origins     = list(string)
      support_credentials = optional(bool)
    }))
    default_documents                 = optional(list(string))
    ftps_state                        = optional(string)
    health_check_path                 = optional(string)
    health_check_eviction_time_in_min = optional(number)
    http2_enabled                     = optional(bool)
    ip_restriction = optional(list(object({
      ip_address                = optional(string)
      action                    = string
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(list(object({
        x_forwarded_for   = optional(string)
        x_forwarded_host  = optional(string)
        x_fd_health_probe = optional(string)
        x_azure_fdid      = optional(list(string))
      })))
    })))
    ip_restriction_default_action = optional(string)
    load_balancing_mode           = optional(string)
    local_mysql_enabled           = optional(bool)
    managed_pipeline_mode         = optional(string)
    minimum_tls_version           = optional(string)
    remote_debugging_enabled      = optional(bool)
    remote_debugging_version      = optional(string)
    scm_ip_restrictions = optional(list(object({
      ip_address                = optional(string)
      action                    = string
      name                      = optional(string)
      priority                  = optional(number)
      service_tag               = optional(string)
      virtual_network_subnet_id = optional(string)
      headers = optional(list(object({
        x_forwarded_for   = optional(string)
        x_forwarded_host  = optional(string)
        x_fd_health_probe = optional(string)
        x_azure_fdid      = optional(list(string))
      })))
    })))
    scm_ip_restrictions_default_action = optional(string)
    scm_minimum_tls_version            = optional(string)
    scm_use_main_ip_restriction        = optional(bool, true)
    use_32_bit_worker                  = optional(bool)
    handler_mapping = optional(object({
      extension             = string
      script_processor_path = string
      arguments             = optional(string)
    }))
    virtual_application = optional(list(object({
      physical_path = string
      preload       = bool
      virtual_directory = optional(list(object({
        physical_path = optional(string)
        virtual_path  = optional(string)
      })))
      virtual_path = string
    })))
    vnet_route_all_enabled = optional(bool)
    websockets_enabled     = optional(bool)
    worker_count           = optional(number)
  })
  default = {}
}

variable "storage_account" {
  description = "(Optional) One or more storage_account blocks."
  type = list(object({
    access_key   = string
    account_name = string
    name         = string
    share_name   = string
    type         = string
    mount_path   = optional(string)
  }))
  default = null
  validation {
    condition     = var.storage_account == null || can(contains(["AzureFiles", "AzureBlob"], var.storage_account[*].type))
    error_message = "storage_account.type must be one of AzureFiles or AzureBlob."
  }
}

variable "identity" {
  description = "(Optional) An identity block."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = {
    type         = "SystemAssigned"
    identity_ids = null
  }
  validation {
    condition     = can(contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type))
    error_message = "identity.type must be one of SystemAssigned, UserAssigned, or SystemAssigned, UserAssigned."
  }
}

variable "key_vault_reference_identity_id" {
  description = "(Optional) The identity ID of the Key Vault reference. Required when identity.type is set to UserAssigned or SystemAssigned, UserAssigned."
  type        = string
  default     = null
  validation {
    condition     = var.key_vault_reference_identity_id == null || can(regex("^[a-zA-Z0-9-/.]{2,255}$", var.key_vault_reference_identity_id))
    error_message = "key_vault_reference_identity_id must be a valid azure resource identifier."
  }
}

variable "tags" {
  type    = map(string)
  default = {}
}
