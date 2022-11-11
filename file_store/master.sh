#!/usr/bin/env bash

# Autosign local agents - probably don't need this anymore.
sudo cp /terraform/file_store/autosign.conf /etc/puppetlabs/puppet/autosign.conf

# Copy over the code manager private key 
cp /terraform/file_store/id-control_repo.rsa /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa
chown pe-puppet:pe-puppet /etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa

# Copy over the hiera keys, keys created using sudo eyaml createkeys
sudo mkdir -p /etc/puppetlabs/puppet/keys/
sudo cp /terraform/file_store/private_key.pkcs7.pem /etc/puppetlabs/puppet/keys/private_key.pkcs7.pem
sudo cp /terraform/file_store/public_key.pkcs7.pem /etc/puppetlabs/puppet/keys/public_key.pkcs7.pem
sudo chown -fR pe-puppet:pe-puppet /etc/puppetlabs/puppet/keys/

# Run Puppet a couple of times to straighten itself out. 
sudo /usr/local/bin/puppet agent -t || true
sudo /usr/local/bin/puppet agent -t || true

