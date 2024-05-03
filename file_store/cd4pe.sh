#!/usr/bin/env bash
# Istall CD4PE agent on Ubuntu 20.04
# https://help.puppet.com/cdpe/current/Content/UserGuide/CDPE/Installation/cd_install.htm

wget https://apt.puppet.com/puppet-tools-release-focal.deb
sudo dpkg -i puppet-tools-release-focal.deb
sudo apt-get update 
sudo apt-get install puppet-bolt

mkdir cd4pe-bolt-project 
cd cd4pe-bolt-project
bolt project init cd4pe_bolt_project

touch cd4pe-bolt-project/bolt-project.yaml
cat << EOF >> cd4pe-bolt-project/bolt-project.yaml
modules:
  - name: puppetlabs/cd4peadm
    version_requirement: 5.3.2
EOF

touch cd4pe-bolt-project/inventory.yaml
cat << EOF >> cd4pe-bolt-project/inventory.yaml
---
groups:
  - name: cd4pe-nodes
    config:
      transport: local
    targets:
      - uri: localhost
EOF

cd cd4pe-bolt-project/

bolt module install

bolt plan run cd4peadm::install