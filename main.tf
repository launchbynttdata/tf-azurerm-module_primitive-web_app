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

resource "azurerm_windows_web_app" "web_app" {
  count               = lower(var.os_type) == "windows" ? 1 : 0
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  site_config {
    always_on             = lookup(var.site_config, "always_on", null)
    api_definition_url    = lookup(var.site_config, "api_definition_url", null)
    api_management_api_id = lookup(var.site_config, "api_management_api_id", null)
    app_command_line      = lookup(var.site_config, "app_command_line", null)
    dynamic "application_stack" {
      iterator = application_stack
      for_each = try(var.site_config["application_stack"][*], [])
      content {
        current_stack                = lookup(application_stack.value, "current_stack", null)
        docker_image_name            = lookup(application_stack.value, "docker_image_name", null)
        docker_registry_url          = lookup(application_stack.value, "docker_registry_url", null)
        docker_registry_username     = lookup(application_stack.value, "docker_registry_username", null)
        docker_registry_password     = lookup(application_stack.value, "docker_registry_password", null)
        dotnet_version               = lookup(application_stack.value, "dotnet_version", null)
        dotnet_core_version          = lookup(application_stack.value, "dotnet_core_version", null)
        tomcat_version               = lookup(application_stack.value, "tomcat_version", null)
        java_embedded_server_enabled = lookup(application_stack.value, "java_embedded_server_enabled", null)
        java_version                 = lookup(application_stack.value, "java_version", null)
        node_version                 = lookup(application_stack.value, "node_version", null)
        php_version                  = lookup(application_stack.value, "php_version", null)
        python                       = lookup(application_stack.value, "python", null)
      }
    }
    dynamic "auto_heal_setting" {
      iterator = auto_heal_setting
      for_each = try(var.site_config["auto_heal_setting"][*], [])
      content {
        dynamic "action" {
          iterator = action
          for_each = try(auto_heal_setting.value["action"][*], [])
          content {
            action_type = lookup(action.value, "action_type", null)
            dynamic "custom_action" {
              iterator = custom_action
              for_each = try(action.value["custom_action"][*], [])
              content {
                executable = lookup(custom_action.value, "executable", null)
                parameters = lookup(custom_action.value, "parameters", null)
              }
            }
            minimum_process_execution_time = lookup(action.value, "minimum_process_execution_time", null)
          }
        }
        dynamic "trigger" {
          iterator = trigger
          for_each = try(auto_heal_setting.value["trigger"][*], [])
          content {
            private_memory_kb = lookup(trigger.value, "private_memory_kb", null)
            dynamic "requests" {
              iterator = requests
              for_each = try(trigger.value["requests"][*], [])
              content {
                count    = lookup(requests.value, "count", null)
                interval = lookup(requests.value, "time", null)
              }
            }
            dynamic "slow_request" {
              iterator = slow_request
              for_each = try(trigger.value["slow_request"][*], [])
              content {
                count      = lookup(slow_request.value, "count", null)
                interval   = lookup(slow_request.value, "time", null)
                time_taken = lookup(slow_request.value, "time_taken", null)
              }
            }
            dynamic "slow_request_with_path" {
              iterator = slow_request_with_path
              for_each = try(trigger.value["slow_request_with_path"][*], [])
              content {
                count      = lookup(slow_request_with_path.value, "count", null)
                interval   = lookup(slow_request_with_path.value, "time", null)
                time_taken = lookup(slow_request_with_path.value, "time_taken", null)
                path       = lookup(slow_request_with_path.value, "path", null)
              }
            }
            dynamic "status_code" {
              iterator = status_code
              for_each = try(trigger.value["status_code"][*], [])
              content {
                count             = lookup(status_code.value, "count", null)
                interval          = lookup(status_code.value, "time", null)
                status_code_range = lookup(status_code.value, "status_code_range", null)
                path              = lookup(status_code.value, "path", null)
                sub_status        = lookup(status_code.value, "sub_status", null)
                win32_status_code = lookup(status_code.value, "win32_status_code", null)
              }
            }
          }
        }
      }
    }
    container_registry_managed_identity_client_id = lookup(var.site_config, "container_registry_managed_identity_client_id", null)
    container_registry_use_managed_identity       = lookup(var.site_config, "container_registry_use_managed_identity", null)
    dynamic "cors" {
      iterator = cors
      for_each = try(var.site_config["cors"][*], [])
      content {
        allowed_origins     = lookup(cors.value, "allowed_origins", null)
        support_credentials = lookup(cors.value, "support_credentials", null)
      }
    }
    default_documents = lookup(var.site_config, "default_documents", null)
    ftps_state        = lookup(var.site_config, "ftps_state", null)
    health_check_path = lookup(var.site_config, "health_check_path", null)
    http2_enabled     = lookup(var.site_config, "http2_enabled", null)
    dynamic "ip_restriction" {
      iterator = ip_restriction
      for_each = try(var.site_config["ip_restriction"][*], [])
      content {
        action                    = lookup(ip_restriction.value, "action", null)
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        name                      = lookup(ip_restriction.value, "name", null)
        priority                  = lookup(ip_restriction.value, "priority", null)
        service_tag               = lookup(ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
        dynamic "headers" {
          iterator = headers
          for_each = try(ip_restriction.value["headers"][*], [])
          content {
            x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
            x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
            x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
          }
        }
      }
    }
    ip_restriction_default_action = lookup(var.site_config, "ip_restriction_default_action", null)
    load_balancing_mode           = lookup(var.site_config, "load_balancing_mode", null)
    local_mysql_enabled           = lookup(var.site_config, "local_mysql_enabled", null)
    managed_pipeline_mode         = lookup(var.site_config, "managed_pipeline_mode", null)
    minimum_tls_version           = lookup(var.site_config, "minimum_tls_version", null)
    remote_debugging_enabled      = lookup(var.site_config, "remote_debugging_enabled", null)
    remote_debugging_version      = lookup(var.site_config, "remote_debugging_version", null)
    dynamic "scm_ip_restriction" {
      iterator = scm_ip_restriction
      for_each = try(var.site_config["scm_ip_restriction"][*], [])
      content {
        action                    = lookup(scm_ip_restriction.value, "action", null)
        ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
        name                      = lookup(scm_ip_restriction.value, "name", null)
        priority                  = lookup(scm_ip_restriction.value, "priority", null)
        service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
        dynamic "headers" {
          iterator = headers
          for_each = try(scm_ip_restriction.value["headers"][*], [])
          content {
            x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
            x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
            x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
          }
        }
      }
    }
    scm_ip_restriction_default_action = lookup(var.site_config, "scm_ip_restriction_default_action", null)
    scm_minimum_tls_version           = lookup(var.site_config, "scm_minimum_tls_version", null)
    scm_use_main_ip_restriction       = lookup(var.site_config, "scm_use_main_ip_restriction", null)
    use_32_bit_worker                 = lookup(var.site_config, "use_32_bit_worker", null)
    dynamic "handler_mapping" {
      iterator = handler_mapping
      for_each = try(var.site_config["handler_mapping"][*], [])
      content {
        arguments             = lookup(handler_mapping.value, "arguments", null)
        extension             = lookup(handler_mapping.value, "extension", null)
        script_processor_path = lookup(handler_mapping.value, "script_processor_path", null)
      }
    }
    dynamic "virtual_application" {
      iterator = virtual_application
      for_each = try(var.site_config["virtual_application"][*], [])
      content {
        physical_path = lookup(virtual_application.value, "physical_path", null)
        preload       = lookup(virtual_application.value, "preload", null)
        dynamic "virtual_directory" {
          iterator = virtual_directory
          for_each = try(virtual_application.value["virtual_directory"][*], [])
          content {
            physical_path = lookup(virtual_directory.value, "physical_path", null)
            virtual_path  = lookup(virtual_directory.value, "virtual_path", null)
          }
        }
        virtual_path = lookup(virtual_application.value, "virtual_path", null)
      }
    }
    vnet_route_all_enabled = lookup(var.site_config, "vnet_route_all_enabled", null)
    websockets_enabled     = lookup(var.site_config, "websockets_enabled", null)
    worker_count           = lookup(var.site_config, "worker_count", null)
  }

  app_settings = var.app_settings
  dynamic "auth_settings" {
    iterator = auth_settings
    for_each = try(var.auth_settings[*], [])
    content {
      enabled = lookup(auth_settings.value, "enabled", null)
      dynamic "active_directory" {
        iterator = active_directory
        for_each = try(auth_settings.value["active_directory"][*], [])
        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = lookup(active_directory.value, "allowed_audiences", null)
          client_secret              = lookup(active_directory.value, "client_secret", null)
          client_secret_setting_name = lookup(active_directory.value, "client_secret_setting_name", null)
        }
      }
      additional_login_parameters    = lookup(auth_settings.value, "additional_login_parameters", null)
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", null)
      default_provider               = lookup(auth_settings.value, "default_provider", null)
      dynamic "facebook" {
        iterator = facebook
        for_each = try(auth_settings.value["facebook"][*], [])
        content {
          app_id                  = facebook.value.app_id
          app_secret              = lookup(facebook.value, "app_secret", null)
          app_secret_setting_name = lookup(facebook.value, "app_secret_setting_name", null)
          oauth_scopes            = lookup(facebook.value, "oauth_scopes", null)
        }
      }
      dynamic "github" {
        iterator = github
        for_each = try(auth_settings.value["github"][*], [])
        content {
          client_id                  = github.value.client_id
          client_secret              = lookup(github.value, "client_secret", null)
          client_secret_setting_name = lookup(github.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(github.value, "oauth_scopes", null)
        }
      }
      dynamic "google" {
        iterator = google
        for_each = try(auth_settings.value["google"][*], [])
        content {
          client_id                  = google.value.client_id
          client_secret              = lookup(google.value, "client_secret", null)
          client_secret_setting_name = lookup(google.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(google.value, "oauth_scopes", null)
        }
      }
      issuer = lookup(auth_settings.value, "issuer", null)
      dynamic "microsoft" {
        iterator = microsoft
        for_each = try(auth_settings.value["microsoft"][*], [])
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = lookup(microsoft.value, "client_secret", null)
          client_secret_setting_name = lookup(microsoft.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(microsoft.value, "oauth_scopes", null)
        }
      }
      runtime_version               = lookup(auth_settings.value, "runtime_version", null)
      token_refresh_extension_hours = lookup(auth_settings.value, "token_refresh_extension_hours", null)
      token_store_enabled           = lookup(auth_settings.value, "token_store_enabled", null)
      dynamic "twitter" {
        iterator = twitter
        for_each = try(auth_settings.value["twitter"][*], [])
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = lookup(twitter.value, "consumer_secret", null)
          consumer_secret_setting_name = lookup(twitter.value, "consumer_secret_setting_name", null)
        }
      }
      unauthenticated_client_action = lookup(auth_settings.value, "unauthenticated_client_action", null)
    }
  }

  dynamic "auth_settings_v2" {
    iterator = auth_settings_v2
    for_each = try(var.auth_settings_v2[*], [])
    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled", null)
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version", null)
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path", null)
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication", null)
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action", null)
      default_provider                        = lookup(auth_settings_v2.value, "default_provider", null)
      excluded_paths                          = lookup(auth_settings_v2.value, "exclude_paths", null)
      require_https                           = lookup(auth_settings_v2.value, "require_https", null)
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention", null)
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name", null)
      dynamic "apple_v2" {
        iterator = apple_v2
        for_each = try(auth_settings_v2.value["apple_v2"][*], [])
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = lookup(apple_v2.value, "client_secret_setting_name", null)
          login_scopes               = lookup(apple_v2.value, "login_scopes", null)
        }
      }
      dynamic "active_directory_v2" {
        iterator = active_directory_v2
        for_each = try(auth_settings_v2.value["active_directory_v2"][*], [])
        content {
          client_id                       = active_directory_v2.client_id
          tenant_auth_endpoint            = lookup(active_directory_v2.value, "tenant_auth_endpoint", null)
          client_secret_setting_name      = lookup(active_directory_v2.value, "client_secret_setting_name", null)
          jwt_allowed_groups              = lookup(active_directory_v2.value, "jwt_allowed_groups", null)
          jwt_allowed_client_applications = lookup(active_directory_v2.value, "jwt_allowed_client_applications", null)
          www_authentication_disabled     = lookup(active_directory_v2.value, "www_authentication_disabled", null)
          allowed_groups                  = lookup(active_directory_v2.value, "allowed_groups", null)
          allowed_identities              = lookup(active_directory_v2.value, "allowed_identities", null)
          allowed_applications            = lookup(active_directory_v2.value, "allowed_applications", null)
          login_parameters                = lookup(active_directory_v2.value, "login_parameters", null)
          allowed_audiences               = lookup(active_directory_v2.value, "allowed_audiences", null)
        }
      }
      dynamic "azure_static_web_app_v2" {
        iterator = azure_static_web_app_v2
        for_each = try(auth_settings_v2.value["azure_static_web_app_v2"][*], [])
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }
      dynamic "custom_oidc_v2" {
        iterator = custom_oidc_v2
        for_each = try(auth_settings_v2.value["custom_oidc_v2"][*], [])
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = lookup(custom_oidc_v2.value, "name_claim_type", null)
          scopes                        = lookup(custom_oidc_v2.value, "scopes", null)
          client_credential_method      = custom_oidc_v2.value.client_credential_method
          client_secret_setting_name    = lookup(custom_oidc_v2.value, "client_secret_setting_name", null)
          authorisation_endpoint        = custom_oidc_v2.value.authorisation_endpoint
          token_endpoint                = custom_oidc_v2.value.token_endpoint
          issuer_endpoint               = custom_oidc_v2.value.issuer_endpoint
          certification_uri             = custom_oidc_v2.value.certification_uri
        }
      }
      dynamic "facebook_v2" {
        iterator = facebook_v2
        for_each = try(auth_settings_v2.value["facebook_v2"][*], [])
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = lookup(facebook_v2.value, "graph_api_version", null)
          login_scopes            = lookup(facebook_v2.value, "login_scopes", null)
        }
      }
      dynamic "github_v2" {
        iterator = github_v2
        for_each = try(auth_settings_v2.value["github_v2"][*], [])
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = lookup(github_v2.value, "login_scopes", null)
        }
      }
      dynamic "google_v2" {
        iterator = google_v2
        for_each = try(auth_settings_v2.value["google_v2"][*], [])
        content {
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(google_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(google_v2.value, "login_scopes", null)
        }
      }
      dynamic "microsoft_v2" {
        iterator = microsoft_v2
        for_each = try(auth_settings_v2.value["microsoft_v2"][*], [])
        content {
          client_id                  = microsoft_v2.value.client_id
          client_secret_setting_name = microsoft_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(microsoft_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(microsoft_v2.value, "login_scopes", null)
        }
      }
      dynamic "twitter_v2" {
        iterator = twitter_v2
        for_each = try(auth_settings_v2.value["twitter_v2"][*], [])
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }
      login {
        logout_endpoint                   = lookup(auth_settings_v2.value.login, "logout_endpoint", null)
        token_store_enabled               = lookup(auth_settings_v2.value.login, "token_store_enabled", null)
        token_store_path                  = lookup(auth_settings_v2.value.login, "token_store_path", null)
        token_store_sas_setting_name      = lookup(auth_settings_v2.value.login, "token_store_sas_setting_name", null)
        preserve_url_fragments_for_logins = lookup(auth_settings_v2.value.login, "preserve_url_fragments_for_logins", null)
        allowed_external_redirect_urls    = lookup(auth_settings_v2.value.login, "allowed_external_redirect_urls", null)
        cookie_expiration_convention      = lookup(auth_settings_v2.value.login, "cookie_expiration_convention", null)
        cookie_expiration_time            = lookup(auth_settings_v2.value.login, "cookie_expiration_time", null)
        validate_nonce                    = lookup(auth_settings_v2.value.login, "validate_nonce", null)
        nonce_expiration_time             = lookup(auth_settings_v2.value.login, "nonce_expiration_time", null)
      }
    }
  }

  dynamic "backup" {
    iterator = backup
    for_each = try(var.backup[*], [])
    content {
      name = backup.value.name
      schedule {
        frequency_interval       = backup.value["schedule"]["frequency_interval"]
        frequency_unit           = backup.value["schedule"]["frequency_unit"]
        keep_at_least_one_backup = lookup(backup.value["schedule"], "keep_at_least_one_backup", null)
        retention_period_days    = lookup(backup.value["schedule"], "retention_period_days", null)
        start_time               = lookup(backup.value["schedule"], "start_time", null)
        last_execution_time      = lookup(backup.value["schedule"], "last_execution_time", null)
      }
      storage_account_url = backup.value.storage_account_url
      enabled             = backup.value.enabled
    }
  }

  client_affinity_enabled            = var.client_affinity_enabled
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_enabled != true ? null : var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths == null ? null : var.client_certificate_exclusion_paths
  dynamic "connection_string" {
    iterator = connection_string
    for_each = try(var.connection_string[*], [])
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  enabled                                  = var.enabled
  ftp_publish_basic_authentication_enabled = var.ftp_publish_basic_authentication_enabled
  https_only                               = var.https_only
  public_network_access_enabled            = var.public_network_access_enabled
  dynamic "identity" {
    iterator = identity
    for_each = try(var.identity[*], [])
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  dynamic "logs" {
    iterator = logs
    for_each = try(var.logs[*], [])
    content {
      dynamic "application_logs" {
        iterator = application_logs
        for_each = try(logs.value["application_logs"][*], [])
        content {
          dynamic "azure_blob_storage" {
            iterator = azure_blob_storage
            for_each = try(application_logs.value["azure_blob_storage"][*], [])
            content {
              level             = lookup(azure_blob_storage.value, "level", null)
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", null)
              sas_url           = lookup(azure_blob_storage.value, "sas_url", null)
            }
          }
          file_system_level = lookup(application_logs.value, "file_system_level", "Off")
        }
      }
      detailed_error_messages = lookup(logs.value, "detailed_error_messages", null)
      failed_request_tracing  = lookup(logs.value, "failed_request_tracing", null)
      dynamic "http_logs" {
        iterator = http_logs
        for_each = try(logs.value["http_logs"][*], [])
        content {
          dynamic "azure_blob_storage" {
            iterator = azure_blob_storage
            for_each = try(http_logs.value["azure_blob_storage"][*], [])
            content {
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", null)
              sas_url           = lookup(azure_blob_storage.value, "sas_url", null)
            }
          }
          dynamic "file_system" {
            iterator = file_system
            for_each = try(http_logs.value["file_system"][*], [])
            content {
              retention_in_days = lookup(file_system.value, "retention_in_days", null)
              retention_in_mb   = lookup(file_system.value, "retention_in_mb", null)
            }
          }
        }
      }
    }
  }
  dynamic "sticky_settings" {
    iterator = sticky_settings
    for_each = try(var.sticky_settings[*], [])
    content {
      app_setting_names       = lookup(sticky_settings.value, "app_setting_names", null)
      connection_string_names = lookup(sticky_settings.value, "connection_string_names", null)
    }
  }
  dynamic "storage_account" {
    iterator = storage_account
    for_each = try(var.storage_account[*], [])
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }
  tags                                           = merge(local.default_tags, var.tags)
  virtual_network_subnet_id                      = var.virtual_network_subnet_id == null ? null : var.virtual_network_subnet_id
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  zip_deploy_file                                = var.zip_deploy_file == null ? null : var.zip_deploy_file

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings
    ]
  }
}

resource "azurerm_linux_web_app" "web_app" {
  count               = lower(var.os_type) == "linux" ? 1 : 0
  location            = var.location
  name                = var.name
  resource_group_name = var.resource_group_name
  service_plan_id     = var.service_plan_id
  site_config {
    always_on             = lookup(var.site_config, "always_on", null)
    api_definition_url    = lookup(var.site_config, "api_definition_url", null)
    api_management_api_id = lookup(var.site_config, "api_management_api_id", null)
    app_command_line      = lookup(var.site_config, "app_command_line", null)
    dynamic "application_stack" {
      iterator = application_stack
      for_each = try(var.site_config["application_stack"][*], [])
      content {
        # current_stack                = lookup(application_stack.value, "current_stack", null)
        docker_image_name        = lookup(application_stack.value, "docker_image_name", null)
        docker_registry_url      = lookup(application_stack.value, "docker_registry_url", null)
        docker_registry_username = lookup(application_stack.value, "docker_registry_username", null)
        docker_registry_password = lookup(application_stack.value, "docker_registry_password", null)
        dotnet_version           = lookup(application_stack.value, "dotnet_version", null)
        go_version               = lookup(application_stack.value, "go_version", null)
        # dotnet_core_version          = lookup(application_stack.value, "dotnet_core_version", null)
        # tomcat_version               = lookup(application_stack.value, "tomcat_version", null)
        # java_embedded_server_enabled = lookup(application_stack.value, "java_embedded_server_enabled", null)
        java_server         = lookup(application_stack.value, "java_server", null)
        java_server_version = lookup(application_stack.value, "java_server_version", null)
        java_version        = lookup(application_stack.value, "java_version", null)
        node_version        = lookup(application_stack.value, "node_version", null)
        php_version         = lookup(application_stack.value, "php_version", null)
        # python                       = lookup(application_stack.value, "python", null)
        python_version = lookup(application_stack.value, "python_version", null)
        ruby_version   = lookup(application_stack.value, "ruby_version", null)
      }
    }
    dynamic "auto_heal_setting" {
      iterator = auto_heal_setting
      for_each = try(var.site_config["auto_heal_setting"][*], [])
      content {
        dynamic "action" {
          iterator = action
          for_each = try(auto_heal_setting.value["action"][*], [])
          content {
            action_type = lookup(action.value, "action_type", null)
            # dynamic "custom_action" {
            #   iterator = custom_action
            #   for_each = try(action.value["custom_action"][*], [])
            #   content {
            #     executable = lookup(custom_action.value, "executable", null)
            #     parameters = lookup(custom_action.value, "parameters", null)
            #   }
            # }
            minimum_process_execution_time = lookup(action.value, "minimum_process_execution_time", null)
          }
        }
        dynamic "trigger" {
          iterator = trigger
          for_each = try(auto_heal_setting.value["trigger"][*], [])
          content {
            # private_memory_kb = lookup(trigger.value, "private_memory_kb", null)
            dynamic "requests" {
              iterator = requests
              for_each = try(trigger.value["requests"][*], [])
              content {
                count    = lookup(requests.value, "count", null)
                interval = lookup(requests.value, "time", null)
              }
            }
            dynamic "slow_request" {
              iterator = slow_request
              for_each = try(trigger.value["slow_request"][*], [])
              content {
                count      = lookup(slow_request.value, "count", null)
                interval   = lookup(slow_request.value, "time", null)
                time_taken = lookup(slow_request.value, "time_taken", null)
              }
            }
            dynamic "slow_request_with_path" {
              iterator = slow_request_with_path
              for_each = try(trigger.value["slow_request_with_path"][*], [])
              content {
                count      = lookup(slow_request_with_path.value, "count", null)
                interval   = lookup(slow_request_with_path.value, "time", null)
                time_taken = lookup(slow_request_with_path.value, "time_taken", null)
                path       = lookup(slow_request_with_path.value, "path", null)
              }
            }
            dynamic "status_code" {
              iterator = status_code
              for_each = try(trigger.value["status_code"][*], [])
              content {
                count             = lookup(status_code.value, "count", null)
                interval          = lookup(status_code.value, "time", null)
                status_code_range = lookup(status_code.value, "status_code_range", null)
                path              = lookup(status_code.value, "path", null)
                sub_status        = lookup(status_code.value, "sub_status", null)
                win32_status_code = lookup(status_code.value, "win32_status_code", null)
              }
            }
          }
        }
      }
    }
    container_registry_managed_identity_client_id = lookup(var.site_config, "container_registry_managed_identity_client_id", null)
    container_registry_use_managed_identity       = lookup(var.site_config, "container_registry_use_managed_identity", null)
    dynamic "cors" {
      iterator = cors
      for_each = try(var.site_config["cors"][*], [])
      content {
        allowed_origins     = lookup(cors.value, "allowed_origins", null)
        support_credentials = lookup(cors.value, "support_credentials", null)
      }
    }
    default_documents = lookup(var.site_config, "default_documents", null)
    ftps_state        = lookup(var.site_config, "ftps_state", null)
    health_check_path = lookup(var.site_config, "health_check_path", null)
    http2_enabled     = lookup(var.site_config, "http2_enabled", null)
    dynamic "ip_restriction" {
      iterator = ip_restriction
      for_each = try(var.site_config["ip_restriction"][*], [])
      content {
        action                    = lookup(ip_restriction.value, "action", null)
        ip_address                = lookup(ip_restriction.value, "ip_address", null)
        name                      = lookup(ip_restriction.value, "name", null)
        priority                  = lookup(ip_restriction.value, "priority", null)
        service_tag               = lookup(ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(ip_restriction.value, "virtual_network_subnet_id", null)
        dynamic "headers" {
          iterator = headers
          for_each = try(ip_restriction.value["headers"][*], [])
          content {
            x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
            x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
            x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
          }
        }
      }
    }
    ip_restriction_default_action = lookup(var.site_config, "ip_restriction_default_action", null)
    load_balancing_mode           = lookup(var.site_config, "load_balancing_mode", null)
    local_mysql_enabled           = lookup(var.site_config, "local_mysql_enabled", null)
    managed_pipeline_mode         = lookup(var.site_config, "managed_pipeline_mode", null)
    minimum_tls_version           = lookup(var.site_config, "minimum_tls_version", null)
    remote_debugging_enabled      = lookup(var.site_config, "remote_debugging_enabled", null)
    remote_debugging_version      = lookup(var.site_config, "remote_debugging_version", null)
    dynamic "scm_ip_restriction" {
      iterator = scm_ip_restriction
      for_each = try(var.site_config["scm_ip_restriction"][*], [])
      content {
        action                    = lookup(scm_ip_restriction.value, "action", null)
        ip_address                = lookup(scm_ip_restriction.value, "ip_address", null)
        name                      = lookup(scm_ip_restriction.value, "name", null)
        priority                  = lookup(scm_ip_restriction.value, "priority", null)
        service_tag               = lookup(scm_ip_restriction.value, "service_tag", null)
        virtual_network_subnet_id = lookup(scm_ip_restriction.value, "virtual_network_subnet_id", null)
        dynamic "headers" {
          iterator = headers
          for_each = try(scm_ip_restriction.value["headers"][*], [])
          content {
            x_azure_fdid      = lookup(headers.value, "x_azure_fdid", null)
            x_fd_health_probe = lookup(headers.value, "x_fd_health_probe", null)
            x_forwarded_for   = lookup(headers.value, "x_forwarded_for", null)
            x_forwarded_host  = lookup(headers.value, "x_forwarded_host", null)
          }
        }
      }
    }
    scm_ip_restriction_default_action = lookup(var.site_config, "scm_ip_restriction_default_action", null)
    scm_minimum_tls_version           = lookup(var.site_config, "scm_minimum_tls_version", null)
    scm_use_main_ip_restriction       = lookup(var.site_config, "scm_use_main_ip_restriction", null)
    use_32_bit_worker                 = lookup(var.site_config, "use_32_bit_worker", null)
    # dynamic "handler_mapping" {
    #   iterator = handler_mapping
    #   for_each = try(var.site_config["handler_mapping"][*], [])
    #   content {
    #     arguments             = lookup(handler_mapping.value, "arguments", null)
    #     extension             = lookup(handler_mapping.value, "extension", null)
    #     script_processor_path = lookup(handler_mapping.value, "script_processor_path", null)
    #   }
    # }
    # dynamic "virtual_application" {
    #   iterator = virtual_application
    #   for_each = try(var.site_config["virtual_application"][*], [])
    #   content {
    #     physical_path = lookup(virtual_application.value, "physical_path", null)
    #     preload       = lookup(virtual_application.value, "preload", null)
    #     dynamic "virtual_directory" {
    #       iterator = virtual_directory
    #       for_each = try(virtual_application.value["virtual_directory"][*], [])
    #       content {
    #         physical_path = lookup(virtual_directory.value, "physical_path", null)
    #         virtual_path  = lookup(virtual_directory.value, "virtual_path", null)
    #       }
    #     }
    #     virtual_path = lookup(virtual_application.value, "virtual_path", null)
    #   }
    # }
    vnet_route_all_enabled = lookup(var.site_config, "vnet_route_all_enabled", null)
    websockets_enabled     = lookup(var.site_config, "websockets_enabled", null)
    worker_count           = lookup(var.site_config, "worker_count", null)
  }

  app_settings = var.app_settings
  dynamic "auth_settings" {
    iterator = auth_settings
    for_each = try(var.auth_settings[*], [])
    content {
      enabled = lookup(auth_settings.value, "enabled", null)
      dynamic "active_directory" {
        iterator = active_directory
        for_each = try(auth_settings.value["active_directory"][*], [])
        content {
          client_id                  = active_directory.value.client_id
          allowed_audiences          = lookup(active_directory.value, "allowed_audiences", null)
          client_secret              = lookup(active_directory.value, "client_secret", null)
          client_secret_setting_name = lookup(active_directory.value, "client_secret_setting_name", null)
        }
      }
      additional_login_parameters    = lookup(auth_settings.value, "additional_login_parameters", null)
      allowed_external_redirect_urls = lookup(auth_settings.value, "allowed_external_redirect_urls", null)
      default_provider               = lookup(auth_settings.value, "default_provider", null)
      dynamic "facebook" {
        iterator = facebook
        for_each = try(auth_settings.value["facebook"][*], [])
        content {
          app_id                  = facebook.value.app_id
          app_secret              = lookup(facebook.value, "app_secret", null)
          app_secret_setting_name = lookup(facebook.value, "app_secret_setting_name", null)
          oauth_scopes            = lookup(facebook.value, "oauth_scopes", null)
        }
      }
      dynamic "github" {
        iterator = github
        for_each = try(auth_settings.value["github"][*], [])
        content {
          client_id                  = github.value.client_id
          client_secret              = lookup(github.value, "client_secret", null)
          client_secret_setting_name = lookup(github.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(github.value, "oauth_scopes", null)
        }
      }
      dynamic "google" {
        iterator = google
        for_each = try(auth_settings.value["google"][*], [])
        content {
          client_id                  = google.value.client_id
          client_secret              = lookup(google.value, "client_secret", null)
          client_secret_setting_name = lookup(google.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(google.value, "oauth_scopes", null)
        }
      }
      issuer = lookup(auth_settings.value, "issuer", null)
      dynamic "microsoft" {
        iterator = microsoft
        for_each = try(auth_settings.value["microsoft"][*], [])
        content {
          client_id                  = microsoft.value.client_id
          client_secret              = lookup(microsoft.value, "client_secret", null)
          client_secret_setting_name = lookup(microsoft.value, "client_secret_setting_name", null)
          oauth_scopes               = lookup(microsoft.value, "oauth_scopes", null)
        }
      }
      runtime_version               = lookup(auth_settings.value, "runtime_version", null)
      token_refresh_extension_hours = lookup(auth_settings.value, "token_refresh_extension_hours", null)
      token_store_enabled           = lookup(auth_settings.value, "token_store_enabled", null)
      dynamic "twitter" {
        iterator = twitter
        for_each = try(auth_settings.value["twitter"][*], [])
        content {
          consumer_key                 = twitter.value.consumer_key
          consumer_secret              = lookup(twitter.value, "consumer_secret", null)
          consumer_secret_setting_name = lookup(twitter.value, "consumer_secret_setting_name", null)
        }
      }
      unauthenticated_client_action = lookup(auth_settings.value, "unauthenticated_client_action", null)
    }
  }

  dynamic "auth_settings_v2" {
    iterator = auth_settings_v2
    for_each = try(var.auth_settings_v2[*], [])
    content {
      auth_enabled                            = lookup(auth_settings_v2.value, "auth_enabled", null)
      runtime_version                         = lookup(auth_settings_v2.value, "runtime_version", null)
      config_file_path                        = lookup(auth_settings_v2.value, "config_file_path", null)
      require_authentication                  = lookup(auth_settings_v2.value, "require_authentication", null)
      unauthenticated_action                  = lookup(auth_settings_v2.value, "unauthenticated_action", null)
      default_provider                        = lookup(auth_settings_v2.value, "default_provider", null)
      excluded_paths                          = lookup(auth_settings_v2.value, "exclude_paths", null)
      require_https                           = lookup(auth_settings_v2.value, "require_https", null)
      forward_proxy_convention                = lookup(auth_settings_v2.value, "forward_proxy_convention", null)
      forward_proxy_custom_host_header_name   = lookup(auth_settings_v2.value, "forward_proxy_custom_host_header_name", null)
      forward_proxy_custom_scheme_header_name = lookup(auth_settings_v2.value, "forward_proxy_custom_scheme_header_name", null)
      dynamic "apple_v2" {
        iterator = apple_v2
        for_each = try(auth_settings_v2.value["apple_v2"][*], [])
        content {
          client_id                  = apple_v2.value.client_id
          client_secret_setting_name = lookup(apple_v2.value, "client_secret_setting_name", null)
          login_scopes               = lookup(apple_v2.value, "login_scopes", null)
        }
      }
      dynamic "active_directory_v2" {
        iterator = active_directory_v2
        for_each = try(auth_settings_v2.value["active_directory_v2"][*], [])
        content {
          client_id                       = active_directory_v2.client_id
          tenant_auth_endpoint            = lookup(active_directory_v2.value, "tenant_auth_endpoint", null)
          client_secret_setting_name      = lookup(active_directory_v2.value, "client_secret_setting_name", null)
          jwt_allowed_groups              = lookup(active_directory_v2.value, "jwt_allowed_groups", null)
          jwt_allowed_client_applications = lookup(active_directory_v2.value, "jwt_allowed_client_applications", null)
          www_authentication_disabled     = lookup(active_directory_v2.value, "www_authentication_disabled", null)
          allowed_groups                  = lookup(active_directory_v2.value, "allowed_groups", null)
          allowed_identities              = lookup(active_directory_v2.value, "allowed_identities", null)
          allowed_applications            = lookup(active_directory_v2.value, "allowed_applications", null)
          login_parameters                = lookup(active_directory_v2.value, "login_parameters", null)
          allowed_audiences               = lookup(active_directory_v2.value, "allowed_audiences", null)
        }
      }
      dynamic "azure_static_web_app_v2" {
        iterator = azure_static_web_app_v2
        for_each = try(auth_settings_v2.value["azure_static_web_app_v2"][*], [])
        content {
          client_id = azure_static_web_app_v2.value.client_id
        }
      }
      dynamic "custom_oidc_v2" {
        iterator = custom_oidc_v2
        for_each = try(auth_settings_v2.value["custom_oidc_v2"][*], [])
        content {
          name                          = custom_oidc_v2.value.name
          client_id                     = custom_oidc_v2.value.client_id
          openid_configuration_endpoint = custom_oidc_v2.value.openid_configuration_endpoint
          name_claim_type               = lookup(custom_oidc_v2.value, "name_claim_type", null)
          scopes                        = lookup(custom_oidc_v2.value, "scopes", null)
          client_credential_method      = custom_oidc_v2.value.client_credential_method
          client_secret_setting_name    = lookup(custom_oidc_v2.value, "client_secret_setting_name", null)
          authorisation_endpoint        = custom_oidc_v2.value.authorisation_endpoint
          token_endpoint                = custom_oidc_v2.value.token_endpoint
          issuer_endpoint               = custom_oidc_v2.value.issuer_endpoint
          certification_uri             = custom_oidc_v2.value.certification_uri
        }
      }
      dynamic "facebook_v2" {
        iterator = facebook_v2
        for_each = try(auth_settings_v2.value["facebook_v2"][*], [])
        content {
          app_id                  = facebook_v2.value.app_id
          app_secret_setting_name = facebook_v2.value.app_secret_setting_name
          graph_api_version       = lookup(facebook_v2.value, "graph_api_version", null)
          login_scopes            = lookup(facebook_v2.value, "login_scopes", null)
        }
      }
      dynamic "github_v2" {
        iterator = github_v2
        for_each = try(auth_settings_v2.value["github_v2"][*], [])
        content {
          client_id                  = github_v2.value.client_id
          client_secret_setting_name = github_v2.value.client_secret_setting_name
          login_scopes               = lookup(github_v2.value, "login_scopes", null)
        }
      }
      dynamic "google_v2" {
        iterator = google_v2
        for_each = try(auth_settings_v2.value["google_v2"][*], [])
        content {
          client_id                  = google_v2.value.client_id
          client_secret_setting_name = google_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(google_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(google_v2.value, "login_scopes", null)
        }
      }
      dynamic "microsoft_v2" {
        iterator = microsoft_v2
        for_each = try(auth_settings_v2.value["microsoft_v2"][*], [])
        content {
          client_id                  = microsoft_v2.value.client_id
          client_secret_setting_name = microsoft_v2.value.client_secret_setting_name
          allowed_audiences          = lookup(microsoft_v2.value, "allowed_audiences", null)
          login_scopes               = lookup(microsoft_v2.value, "login_scopes", null)
        }
      }
      dynamic "twitter_v2" {
        iterator = twitter_v2
        for_each = try(auth_settings_v2.value["twitter_v2"][*], [])
        content {
          consumer_key                 = twitter_v2.value.consumer_key
          consumer_secret_setting_name = twitter_v2.value.consumer_secret_setting_name
        }
      }
      login {
        logout_endpoint                   = lookup(auth_settings_v2.value.login, "logout_endpoint", null)
        token_store_enabled               = lookup(auth_settings_v2.value.login, "token_store_enabled", null)
        token_store_path                  = lookup(auth_settings_v2.value.login, "token_store_path", null)
        token_store_sas_setting_name      = lookup(auth_settings_v2.value.login, "token_store_sas_setting_name", null)
        preserve_url_fragments_for_logins = lookup(auth_settings_v2.value.login, "preserve_url_fragments_for_logins", null)
        allowed_external_redirect_urls    = lookup(auth_settings_v2.value.login, "allowed_external_redirect_urls", null)
        cookie_expiration_convention      = lookup(auth_settings_v2.value.login, "cookie_expiration_convention", null)
        cookie_expiration_time            = lookup(auth_settings_v2.value.login, "cookie_expiration_time", null)
        validate_nonce                    = lookup(auth_settings_v2.value.login, "validate_nonce", null)
        nonce_expiration_time             = lookup(auth_settings_v2.value.login, "nonce_expiration_time", null)
      }
    }
  }

  dynamic "backup" {
    iterator = backup
    for_each = try(var.backup[*], [])
    content {
      name = backup.value.name
      schedule {
        frequency_interval       = backup.value["schedule"]["frequency_interval"]
        frequency_unit           = backup.value["schedule"]["frequency_unit"]
        keep_at_least_one_backup = lookup(backup.value["schedule"], "keep_at_least_one_backup", null)
        retention_period_days    = lookup(backup.value["schedule"], "retention_period_days", null)
        start_time               = lookup(backup.value["schedule"], "start_time", null)
        last_execution_time      = lookup(backup.value["schedule"], "last_execution_time", null)
      }
      storage_account_url = backup.value.storage_account_url
      enabled             = backup.value.enabled
    }
  }

  client_affinity_enabled            = var.client_affinity_enabled
  client_certificate_enabled         = var.client_certificate_enabled
  client_certificate_mode            = var.client_certificate_enabled != true ? null : var.client_certificate_mode
  client_certificate_exclusion_paths = var.client_certificate_exclusion_paths == null ? null : var.client_certificate_exclusion_paths
  dynamic "connection_string" {
    iterator = connection_string
    for_each = try(var.connection_string[*], [])
    content {
      name  = connection_string.value.name
      type  = connection_string.value.type
      value = connection_string.value.value
    }
  }
  enabled                                  = var.enabled
  ftp_publish_basic_authentication_enabled = var.ftp_publish_basic_authentication_enabled
  https_only                               = var.https_only
  public_network_access_enabled            = var.public_network_access_enabled
  dynamic "identity" {
    iterator = identity
    for_each = try(var.identity[*], [])
    content {
      type         = identity.value.type
      identity_ids = lookup(identity.value, "identity_ids", null)
    }
  }
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  dynamic "logs" {
    iterator = logs
    for_each = try(var.logs[*], [])
    content {
      dynamic "application_logs" {
        iterator = application_logs
        for_each = try(logs.value["application_logs"][*], [])
        content {
          dynamic "azure_blob_storage" {
            iterator = azure_blob_storage
            for_each = try(application_logs.value["azure_blob_storage"][*], [])
            content {
              level             = lookup(azure_blob_storage.value, "level", null)
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", null)
              sas_url           = lookup(azure_blob_storage.value, "sas_url", null)
            }
          }
          file_system_level = lookup(application_logs.value, "file_system_level", "Off")
        }
      }
      detailed_error_messages = lookup(logs.value, "detailed_error_messages", null)
      failed_request_tracing  = lookup(logs.value, "failed_request_tracing", null)
      dynamic "http_logs" {
        iterator = http_logs
        for_each = try(logs.value["http_logs"][*], [])
        content {
          dynamic "azure_blob_storage" {
            iterator = azure_blob_storage
            for_each = try(http_logs.value["azure_blob_storage"][*], [])
            content {
              retention_in_days = lookup(azure_blob_storage.value, "retention_in_days", null)
              sas_url           = lookup(azure_blob_storage.value, "sas_url", null)
            }
          }
          dynamic "file_system" {
            iterator = file_system
            for_each = try(http_logs.value["file_system"][*], [])
            content {
              retention_in_days = lookup(file_system.value, "retention_in_days", null)
              retention_in_mb   = lookup(file_system.value, "retention_in_mb", null)
            }
          }
        }
      }
    }
  }
  dynamic "sticky_settings" {
    iterator = sticky_settings
    for_each = try(var.sticky_settings[*], [])
    content {
      app_setting_names       = lookup(sticky_settings.value, "app_setting_names", null)
      connection_string_names = lookup(sticky_settings.value, "connection_string_names", null)
    }
  }
  dynamic "storage_account" {
    iterator = storage_account
    for_each = try(var.storage_account[*], [])
    content {
      access_key   = storage_account.value.access_key
      account_name = storage_account.value.account_name
      name         = storage_account.value.name
      share_name   = storage_account.value.share_name
      type         = storage_account.value.type
      mount_path   = lookup(storage_account.value, "mount_path", null)
    }
  }
  tags                                           = merge(local.default_tags, var.tags)
  virtual_network_subnet_id                      = var.virtual_network_subnet_id == null ? null : var.virtual_network_subnet_id
  webdeploy_publish_basic_authentication_enabled = var.webdeploy_publish_basic_authentication_enabled
  zip_deploy_file                                = var.zip_deploy_file == null ? null : var.zip_deploy_file

  lifecycle {
    ignore_changes = [
      app_settings,
      sticky_settings
    ]
  }

}
