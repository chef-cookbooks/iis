#
# Author:: Justin Schuhmann
# Cookbook:: iis
# Recipe:: mod_auth_basic
#
# Copyright:: 2016, Justin Schuhmann
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

iis_install 'install IIS' do
  source node['iis']['source']
  install_method node['iis']['windows_feature_install_method']
  start_iis true
end

iis_section 'unlocks anonymous authentication control in web.config' do
  section 'system.webServer/security/authentication/anonymousAuthentication'
  action :unlock
end
