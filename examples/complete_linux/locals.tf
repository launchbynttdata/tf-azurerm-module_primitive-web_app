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

locals {
  resource_group_name  = module.resource_names["resource_group"].minimal_random_suffix
  web_app_name         = module.resource_names["web_app"].minimal_random_suffix
  service_plan_name    = module.resource_names["service_plan"].minimal_random_suffix
  storage_account_name = module.resource_names["storage_account"].minimal_random_suffix_without_any_separators
}
