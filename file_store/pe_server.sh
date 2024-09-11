#!/usr/bin/env bash
sudo yum -y install net-tools
sudo yum -y install wget
sudo yum -y install bind-utils

# Install Puppet -  ToDo - we should probably handle .tar.gz files rather then presume it'll all be uncompressed.
#wget --content-disposition 'https://pm.puppet.com/cgi-bin/download.cgi?dist=el&rel=8&arch=x86_64&ver=latest'
wget --content-disposition 'https://pm.puppetlabs.com/puppet-enterprise/2023.8.0/puppet-enterprise-2023.8.0-ubuntu-20.04-amd64.tar.gz'
# 

tar -xvf puppet-enterprise-*.gz
directory=$(echo puppet*amd64)
cd $directory
sudo ./puppet-enterprise-installer -c /terraform/file_store/pe.conf
cd ..

# Autosign local agents - probably don't need this anymore.
sudo cp /terraform/file_store/autosign.conf /etc/puppetlabs/puppet/autosign.conf

# Copy over the code manager private key 
cp /tmp/puppet-control-repo /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
rm /tmp/puppet-control-repo

# Copy over the hiera keys, keys created using sudo eyaml createkeys
# this block should be removed.
sudo mkdir -p /etc/puppetlabs/puppet/keys/
#sudo cp /terraform/file_store/private_key.pkcs7.pem /etc/puppetlabs/puppet/keys/private_key.pkcs7.pem
#sudo cp /terraform/file_store/public_key.pkcs7.pem /etc/puppetlabs/puppet/keys/public_key.pkcs7.pem
sudo chown -fR pe-puppet:pe-puppet /etc/puppetlabs/puppet/keys/

# Run Puppet a couple of times to straighten itself out. 
sudo /usr/local/bin/puppet agent -t || true
sudo /usr/local/bin/puppet agent -t || true

# need to copy / fix this 
# /opt/puppetlabs/server/data/puppetserver/.ssh/known_hosts
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/githubs-ssh-key-fingerprints

# Use the RBAC API to get an authentication token, strip the quotes off, save it where code manager can find it and then run a code deploy.
token=$(curl --insecure –cacert $(puppet config print cacert) -X POST -H 'Content-Type: application/json' -d '{"login": "admin", "password": "puppetlabs", "lifetime": "4h", "label": "four-hour token"}' https://localhost:4433/rbac-api/v1/auth/token)
mkdir ~/.puppetlabs
echo $token | awk -F\" '{ print $4 }' > ~/.puppetlabs/token
/usr/local/bin/

echo "role: role::pe_server" > /opt/puppetlabs/facter/facts.d/stuff.yaml
