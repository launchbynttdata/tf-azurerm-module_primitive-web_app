# // Licensed under the Apache License, Version 2.0 (the "License");
# // you may not use this file except in compliance with the License.
# // You may obtain a copy of the License at
# //
# //     http://www.apache.org/licenses/LICENSE-2.0
# //
# // Unless required by applicable law or agreed to in writing, software
# // distributed under the License is distributed on an "AS IS" BASIS,
# // WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# // See the License for the specific language governing permissions and
# // limitations under the License.

output "default_hostname" {
  value = module.web_app.web_app_default_hostname
}

output "web_app_name" {
  value = module.web_app.web_app_name
}

output "web_app_id" {
  value = module.web_app.web_app_id
}

output "web_app_principal_id" {
  value = module.web_app.web_app_principal_id
}

output "service_plan_name" {
  value = module.app_service_plan.name
}

output "service_plan_id" {
  value = module.app_service_plan.id
}

output "storage_account_id" {
  description = "The id of the storage account"
  value       = module.storage_account.id
}
