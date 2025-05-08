#!/usr/bin/env bash
# Istall CD4PE agent on Ubuntu 20.04
# https://help.puppet.com/cdpe/current/Content/UserGuide/CDPE/Installation/cd_install.htm

# Install Puppet Bolt - RedHat
#sudo rpm -Uvh https://yum.puppet.com/puppet-tools-release-el-8.noarch.rpm
#sudo yum install puppet-bolt

# Install Puppet Bolt - Ubuntu
wget https://apt.puppet.com/puppet-tools-release-focal.deb
sudo dpkg -i puppet-tools-release-focal.deb
sudo apt-get update 
sudo apt-get install puppet-bolt

mkdir cd4pe-bolt-project 
cd cd4pe-bolt-project
bolt project init cd4pe_bolt_project

touch bolt-project.yaml
cat << EOF >> bolt-project.yaml
modules:
  - name: puppetlabs/cd4peadm
    version_requirement: 5.5.0
module-install:
  forge:
    authorization_token: 'Bearer <your API token>'
    baseurl: https://forgeapi.puppet.com
EOF

touch inventory.yaml
cat << EOF >> inventory.yaml
---
groups:
  - name: cd4pe-nodes
    config:
      transport: local
    targets:
      - uri: localhost
EOF

bolt module install

bolt plan run cd4peadm::install