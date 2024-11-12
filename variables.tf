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

variable "name" {
  description = "Name of the web app to create"
  type        = string
}

variable "location" {
  description = "Location where the web app will be created"
  type        = string
}

variable "resource_group_name" {
  description = "name of the resource group where the web app will be created"
  type        = string
}

variable "service_plan_id" {
  description = "ID of the service plan to use"
  type        = string
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
        slow_request = optional(object({
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

### Optional Parameters

variable "app_settings" {
  description = "Environment variables to set on the web app"
  type        = map(string)
  default     = {}
}



variable "auth_settings" {
  description = "(Optional) A auth_settings block."
  type = object({
    enabled = bool
    active_directory = optional(object({
      client_id                  = string
      allowed_audiences          = list(string)
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
    }))
    additional_login_parameters    = optional(list(map(any)))
    allowed_external_redirect_urls = optional(list(string))
    default_provider               = optional(string)
    facebook = optional(object({
      app_id                  = string
      app_secret              = optional(string)
      app_secret_setting_name = optional(string)
      oauth_scopes            = optional(list(string))
    }))
    github = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    google = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    issuer = optional(string)
    microsoft = optional(object({
      client_id                  = string
      client_secret              = optional(string)
      client_secret_setting_name = optional(string)
      oauth_scopes               = optional(list(string))
    }))
    runtime_version               = optional(string)
    token_refresh_extension_hours = optional(number)
    token_store_enabled           = optional(bool)
    twitter = optional(object({
      consumer_key                 = string
      consumer_secret              = optional(string)
      consumer_secret_setting_name = optional(string)
    }))
    unauthenticated_client_action = optional(string)
  })
  default = null
}

variable "auth_settings_v2" {
  description = "(Optional) A auth_settings_v2 block."
  type = object({
    auth_enabled                            = optional(bool)
    runtime_version                         = optional(string)
    config_file_path                        = optional(string)
    require_authentication                  = optional(bool)
    unauthenticated_action                  = optional(string)
    default_provider                        = optional(string)
    excluded_paths                          = optional(list(string))
    require_https                           = optional(bool)
    http_route_api_prefix                   = optional(string)
    forward_proxy_convention                = optional(string)
    forward_proxy_custom_host_header_name   = optional(string)
    forward_proxy_custom_scheme_header_name = optional(string)
    apple_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = optional(string)
      login_scopes               = optional(list(string))
    }))
    active_directory_v2 = optional(object({
      client_id                            = string
      tenant_auth_endpoint                 = optional(string)
      client_secret_setting_name           = optional(string)
      client_secret_certificate_thumbprint = optional(string)
      jwt_allowed_groups                   = optional(list(string))
      jwt_allowed_client_applications      = optional(list(string))
      www_authentication_disabled          = optional(bool)
      allowed_groups                       = optional(list(string))
      allowed_identities                   = optional(list(string))
      allowed_applications                 = optional(list(string))
      login_parameters                     = optional(map(any))
      allowed_audiences                    = optional(list(string))
    }))
    azure_static_web_app_v2 = optional(object({
      client_id = string
    }))
    custom_oidc_v2 = optional(object({
      name                          = string
      client_id                     = string
      openid_configuration_endpoint = string
      name_claim_type               = optional(string)
      scopes                        = optional(list(string))
      client_credential_method      = string
      client_secret_setting_name    = optional(string)
      authorisation_endpoint        = string
      token_endpoint                = string
      issuer_endpoint               = string
      certification_uri             = string
    }))
    facebook_v2 = optional(object({
      app_id                  = string
      app_secret_setting_name = string
      graph_api_version       = optional(string)
      login_scopes            = optional(list(string))
    }))
    github_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      login_scopes               = optional(list(string))
    }))
    google_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    microsoft_v2 = optional(object({
      client_id                  = string
      client_secret_setting_name = string
      allowed_audiences          = optional(list(string))
      login_scopes               = optional(list(string))
    }))
    twitter_v2 = optional(object({
      consumer_key                 = string
      consumer_secret_setting_name = string
    }))
    login = optional(object({
      logout_endpoint                   = optional(string)
      token_store_enabled               = optional(bool)
      token_refresh_extension_time      = optional(number)
      token_store_path                  = optional(string)
      token_store_sas_setting_name      = optional(string)
      preserve_url_fragments_for_logins = optional(bool)
      allowed_external_redirect_urls    = optional(list(string))
      cookie_expiration_convention      = optional(string)
      cookie_expiration_time            = optional(string)
      validate_nonce                    = optional(bool)
      nonce_expiration_time             = optional(string)
    }))
  })
  default = null
}

variable "backup" {
  description = "(Optional) A backup block."
  type = object({
    name = string
    schedule = object({
      frequency_interval       = number
      frequency_unit           = string
      keep_at_least_one_backup = optional(bool)
      retention_period_days    = optional(number)
      start_time               = optional(string)
      last_execution_time      = optional(string)
    })
    storage_account_url = string
    enabled             = optional(bool, true)
  })
  default = null
}

variable "client_affinity_enabled" {
  description = "If true, the web app will use client affinity"
  type        = bool
  default     = false
}

variable "client_certificate_enabled" {
  description = "If true, the web app will require client certificates"
  type        = bool
  default     = false
}

variable "client_certificate_mode" {
  description = "The client certificate mode of the web app. Only effective if client_certificate_enabled is set to true."
  type        = string
  default     = "Required"
  validation {
    condition     = can(contains(["Required", "Optional", "OptionalInteractiveUser"], var.client_certificate_mode))
    error_message = "client_certificate_mode must be one of Required or Optional."
  }
}

variable "client_certificate_exclusion_paths" {
  description = "Paths to exclude when using client certificates, separated by ;"
  type        = string
  default     = null
}

variable "connection_string" {
  description = "Connection string definition"
  type = object({
    name  = string
    type  = string
    value = string
  })
  default = null
}

variable "enabled" {
  description = "If true, the web app will be enabled"
  type        = bool
  default     = true
}

variable "ftp_publish_basic_authentication_enabled" {
  description = "If true, the web app will use basic FTP authentication"
  type        = bool
  default     = false
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

variable "identity" {
  description = "(Optional) An identity block."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
  validation {
    condition     = var.identity == null || can(contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], var.identity.type))
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

variable "logs" {
  description = "(Optional) A logs block."
  type = object({
    application_logs = optional(object({
      azure_blob_storage = optional(object({
        level             = string
        sas_url           = string
        retention_in_days = number
      }))
      file_system_level = string
    }))
    detailed_error_messages = optional(bool, true)
    failed_request_tracing  = optional(bool, true)
    http_logs = optional(object({
      azure_blob_storage = optional(object({
        retention_in_days = optional(number)
        sas_url           = string
      }))
      file_system = optional(object({
        retention_in_days = number
        retention_in_mb   = number
      }))
    }))
  })
  default = null
}

variable "sticky_settings" {
  description = "A list of settings that should be sticky to the slot during a swap."
  type = object({
    app_setting_names       = optional(list(string))
    connection_string_names = optional(list(string))
  })
  default = null
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

variable "tags" {
  type    = map(string)
  default = {}
}

variable "virtual_network_subnet_id" {
  description = "(Optional) The ID of the subnet to place the web app in."
  type        = string
  default     = null
}

variable "webdeploy_publish_basic_authentication_enabled" {
  description = "If true, the web app will use basic WebDeploy authentication"
  type        = bool
  default     = false
}

variable "zip_deploy_file" {
  description = "The path to a zip file to deploy to the web app"
  type        = string
  default     = null
}

variable "os_type" {
  description = "The operating system type of the web app"
  type        = string
  default     = "Linux"
}
