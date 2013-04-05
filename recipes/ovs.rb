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

# Nicira distributes private OVS packages for NVP to its customers.
# Since these aren't in a repo, they must be on the Nova Controller
# prior to kicking off a chef-client run to configure NVP.  These
# must also be installed on OpenStack Computer nodes.
#
# Check packages are present or exit the run
%w{openvswitch-common openvswitch-datapath-dkms openvswitch-pki openvswitch-switch}.each do |pkg|
  NVP.checkpkg("#{node['nvp']['ovs']['pkg_path']}/#{pkg}")
  file = Dir.glob("#{node['nvp']['ovs']['pkg_path']}/#{pkg}*.deb")

  package pkg do
    action :install
    source "#{file}"
  end
end
