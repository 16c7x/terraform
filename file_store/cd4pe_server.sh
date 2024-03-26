#!/usr/bin/env bash
# based on https://github.com/puppetlabs/PipelinesInfra/blob/main/deploy/docs/install.md

sudo rpm -Uvh https://yum.puppet.com/puppet-tools-release-el-8.noarch.rpm
sudo yum -y install puppet-bolt
mkdir cd4pe-bolt-project && cd cd4pe-bolt-project && bolt project init cd4pe_bolt_project
sudo cp /terraform/file_store/bolt-project.yaml /home/ec2-user/cd4pe-bolt-project/bolt-project.yaml