#
# Cookbook Name:: nvp
# Recipe:: default
#
# Copyright 2013, Opscode, Inc.
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

include_recipe "nvp::ovs"

package "python"
package "python-pexpect"

directory "/opt/nicira/" do
  recursive true
  mode "0755"
  user "root"
  group "root"
end

template "/opt/nicira/nvp-setup.py" do
  source "nvp-setup.py.erb"
  owner "root"
  group "root"
  mode "0750"
  variables(
    :user => node['nvp']['user'],
    :pass => node['nvp']['pass'],
    :hv_user => node['nvp']['hv_user'],
    :hv_pass => node['nvp']['hv_pass'],
    :timeout => node['nvp']['timeout'],
    :controllers => node['nvp']['controllers']
  )
end

execute "/opt/nicira/nvp-setup.py" do
  cwd "/opt/nicira/"
  creates "/opt/nicira/.nvp-setup-complete"
end
