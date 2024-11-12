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

instance_env                  = 0
instance_resource             = 0
logical_product_family        = "launch"
logical_product_service       = "webcapp"
class_env                     = "gotest"
location                      = "eastus"
sku                           = "P0v3"
os_type                       = "windows"
public_network_access_enabled = true
identity = {
  type = "SystemAssigned"
}
