#
# Author:: Kendrick Martin (kendrick.martin@webtrends.com)
# Cookbook Name:: iis
# Resource:: config
#
# Copyright:: 2011, Webtrends
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

require 'chef/mixin/shell_out'

include Chef::Mixin::ShellOut
include Windows::Helper

action :config do
	Chef::Log.debug("#{appcmd} set config #{@new_resource.cfg_cmd}")
	shell_out!("#{appcmd} set config #{@new_resource.cfg_cmd}")
	Chef::Log.info("IIS Config command run")	
end

action :backup do
	Chef::Log.debug("#{appcmd} add backup \"#{@new_resource.cfg_cmd}\"")
	shell_out!(%{"#{appcmd} add backup #{@new_resource.cfg_cmd}"})
	Chef::Log.info("IIS Backup created: \"#{node['iis']['home']}\\backup\\#{@new_resource.cfg_cmd}\"")
end

private
def appcmd
  @appcmd ||= begin
    "#{node['iis']['home']}\\appcmd.exe"
  end
end
