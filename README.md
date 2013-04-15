Description
===========
This cookbook configures the Nicira Network Virtualization Platform as part of an OpenStack **Folsom** deployment.  The cookbook depends on its end user to have access to proprietary Nicira software packages to install OpenVswitch since they are not publically available.  Additionally, this cookbook does not manage installation of NVP appliances directly. NVP appliances should already be installed in your environment prior to using this cookbook. 

This cookbook can be used to configure an OpenStack Nova Controller or Nova Compute node to use NVP as a plugin for the Quantum Networking service. It can also configure virtual networks on NVP appliances based on specified attributes.

http://nicira.com/en/network-virtualization-platform
http://quantum.openstack.org

Requirements
============
Chef 0.10.0 or higher required (for Chef environment use).

Platforms
--------
 
* Ubuntu-12.04

Software
--------
For distribution, this cookbook contains 4 zero-byte openvswitch debian packages in its files/ directory. To use this cookbook for installing OpenVswitch, replace the zero-byte files included in the cookbook with the deb packages you have received from Nicira prior to uploading them to your Chef server. This cookbook has only been verified to work with the exact package versions listed in the zero-byte file names, but may work with other versions of Nicira's OpenVswitch build.

-`openvswitch-common_1.7.0.15247_amd64.deb`
-`openvswitch-pki_1.7.0.15247_all.deb`
-`openvswitch-datapath-dkms_1.7.0.15247_all.deb`
-`openvswitch-switch_1.7.0.15247_amd64.deb`

This package distribution method is used since Nicira does not make their packages available for use in public repos.
 
Cookbooks
---------
 
The following cookbooks are dependencies:
 
* quantum
 
Recipes
=======
 
default
----
-includes recipe `ovs`
 
ovs
----
-distributes openvswitch packages to your node
-installs package dependencies
-installs openvswitch

plugin
----
-ensures the quantum::server and quantum::plugin recipes have been applied
-ensures openvswitch has been installed
-generates a script to configure your distributed NVP controllers
-applies that script idempotently

Note: at present, this recipe is intended to initially set up NVP in an OpenStack Cluster

Attributes
==========
* `nvp['ovs']['pkgs']` - sets the name of ovs pkgs to distribute and install

* `nvp['controllers']` - array of IP addresses for all NVP controller nodes
* `nvp['user']` - user login to configure NVP appliances
* `nvp['pass']` - user password to configure NVP appliances 
* `nvp['default-route']` - default route used on NVP controller nodes
* `nvp['timeout']` - adjustable timeout for issuing commands to NVP appliances
* `nvp['zonename']` - Name of NVP zone
* `nvp['nvp_api_client_endpoint']` - NVP Controller API endpoint for issuing commands

* `nvp['hvs']` - array of IP addresses for all hypervisors to be controlled by NVP nodes
* `nvp['hv_user']` - user login to configure hypervisor networking stack
* `nvp['hv_pass']` - user password to configure hypervisor networking stack

For each service node to configure:
* `nvp['sn_name']['ip']` - IP of service node
* `nvp['sn_name']['id']` - Service Node ID
* `nvp['sn_name']['gateway']` - Service Node gateway
* `nvp['sn_name']['controller']` - Controller to use for configuring service node
* `nvp['sn_name']['sub1']` - Network prefix currently used
* `nvp['sn_name']['sub2']` - Network prefix desired
Change `sn_name` to the name of your service node, and repeat for additional service nodes to configure

For each network tenant to configure:
* `nvp['tenants']['tenant_id']['name']` - Name to identify tenant
* `nvp['tenants']['tenant_id']['vif']` - Virtual Network Interface to use
* `nvp['tenants']['tenant_id']['vms']` - An array of VM names to associate with this tenant
Change `tenant_id` to the the id of your tenant, and repeat for additional tenants to configure

License and Author
==================
 
Author:: George Miranda (<gmiranda@opscode.com>)
Author:: Duffie Cooley (<dcooley@vmware.com>)

Copyright 2013, Opscode, Inc.
Copyright 2013, VMware, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
 
    http://www.apache.org/licenses/LICENSE-2.0
 
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
