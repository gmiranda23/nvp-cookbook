#
# Cookbook name:: nvp
# Attributes:: default
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

# Nicira Controller Settings
default['nvp']['controllers'] = [ "10.127.1.10", "10.127.1.11", "10.127.1.12" ]
default['nvp']['user'] = "admin"
default['nvp']['pass'] = "admin"
default['nvp']['timeout'] = 100
default['nvp']['default-route'] = "10.127.1.1"

# Service Nodes
default['nvp']['sn']['sn11']['ip'] = "10.127.1.5"
default['nvp']['sn']['sn11']['id'] = "11"
default['nvp']['sn']['sn11']['gateway'] = "10.10.1.1"
default['nvp']['sn']['sn11']['controller'] = "#{nvp['controllers'].first}"
default['nvp']['sn']['sn11']['sub1'] = "10.127"
default['nvp']['sn']['sn11']['sub2'] = "10.10"

default['nvp']['sn']['sn21']['ip'] = "10.127.1.6"
default['nvp']['sn']['sn21']['id'] = "21"
default['nvp']['sn']['sn11']['gateway'] = "10.10.2.1"
default['nvp']['sn']['sn21']['controller'] = "#{nvp['controllers'].first}"
default['nvp']['sn']['sn21']['sub1'] = "10.127.1"
default['nvp']['sn']['sn21']['sub2'] = "10.10.1"

# Hypervisors
default['nvp']['hvs'] = [ "10.127.1.2", "10.127.1.3" ]
default['nvp']['hv_user'] = "nicira"
default['nvp']['hv_pass'] = "nicira"

# the "fun stuff"
default['nvp']['zonename'] = "TZ"
default['nvp']['nvp_api_client_endpoint'] = "#{nvp['controllers'].first}"

default['nvp']['tenants']['a']['name'] = "TenantA"
default['nvp']['tenants']['a']['vif'] = "eth0"
default['nvp']['tenants']['a']['vms'] = [ "vm1", "vm2", "vm3" ]

default['nvp']['tenants']['b']['name'] = "TenantB"
default['nvp']['tenants']['b']['vif'] = "eth0"
default['nvp']['tenants']['b']['vms'] = [ "vm1", "vm2" ]
