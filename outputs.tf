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

output "web_app_id" {
  description = "The ID of the Web App"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].id : azurerm_linux_web_app.web_app[0].id
}

output "web_app_default_hostname" {
  description = "The default hostname of the Web App"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].default_hostname : azurerm_linux_web_app.web_app[0].default_hostname
}

output "web_app_name" {
  description = "The name of the Web App"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].name : azurerm_linux_web_app.web_app[0].name
}

output "web_app_outbound_ip_addresses" {
  description = "The outbound IP addresses of the Web App"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].outbound_ip_addresses : azurerm_linux_web_app.web_app[0].outbound_ip_addresses
}

output "web_app_possible_outbound_ip_addresses" {
  description = "The possible outbound IP addresses of the Web App"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].possible_outbound_ip_addresses : azurerm_linux_web_app.web_app[0].possible_outbound_ip_addresses
}

output "custom_domain_verification_id" {
  description = "The ID of the Custom Domain Verification"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].custom_domain_verification_id : azurerm_linux_web_app.web_app[0].custom_domain_verification_id
}

output "web_app_identity" {
  description = "The identity of the Web App"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].identity : azurerm_linux_web_app.web_app[0].identity
}

output "web_app_principal_id" {
  description = "The principal ID of the Web App"
  value       = lower(var.os_type) == "windows" ? azurerm_windows_web_app.web_app[0].identity[0].principal_id : azurerm_linux_web_app.web_app[0].identity[0].principal_id
}
