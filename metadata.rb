name             "nvp"
maintainer       "Opscode, Inc."
maintainer_email "gmiranda@opscode.com"
license          "Apache 2.0"
description      "Installs/configures Nicira's Network Virtualization Platform for use with OpenStack Quanutm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ ubuntu }.each do |os|
    supports os
end

%w{ quantum }.each do |dep|
    depends dep
end
