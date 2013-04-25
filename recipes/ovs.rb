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

# Install deps apt would resolve
%w{libssl0.9.8 gcc build-essential dkms}.each do |prereq|
package prereq
end

# Nicira distributes private OVS packages for NVP to its customers.
# Since these aren't in a repo, they must be on the Nova Controller
# prior to kicking off a chef-client run to configure NVP.  These
# must also be installed on OpenStack Computer nodes.

node['nvp']['ovs']['pkgs'].each do |pkg|

  cookbook_file "#{Chef::Config[:file_cache_path]}/#{pkg}" do
    source pkg
    owner "root"
    group "root"
    mode "0644"
  end

  ruby_block "check if #{pkg} is non-zero" do
    block do
      Chef::Application.fatal!("Zero file size for #{pkg}. Upload a valid package in your 'nvp' cookbook files directory")
    end
    only_if { File.stat("#{Chef::Config[:file_cache_path]}/#{pkg}").zero? }
  end

  dpkg_package pkg do
  source "#{Chef::Config[:file_cache_path]}/#{pkg}"
  end
end
