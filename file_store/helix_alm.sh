#!/usr/bin/env bash

# Install prerequisites
apt-get update
apt-get install -y libgl1-mesa-glx
apt-get install -y libharfbuzz-dev
apt-get install -y net-tools
apt-get install -y libxrender1
apt-get install -y libxcomposite-dev
apt-get install -y libapache2-mod-cgi
# apt-get install -y libapache2-mod-fcgid
apt-get install -y apache2
apt-get install -y libgl1-mesa-glx libharfbuzz0b libbz2-1.0 libgtk2.0-0 libpangox-1.0-0 libpangoxft-1.0-0 libidn11 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-libav libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-shape0 libxcb-xinerama0 libxcb-xkb1 libxcb-xinput0 libxkbcommon-x11-0

# Copy the apache config file
# cp /terraform/file_store/helix_alm.conf /etc/apache2/apache2.conf

cat << EOF >> /etc/apache2/apache2.conf
ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"
<Directory "/var/www/cgi-bin">
    AllowOverride None
    Options None
    Require all granted
</Directory>
EOF

# Enable CGI
/usr/sbin/a2enmod cgi

# Restart Apache
systemctl restart apache2

# Download and install Helix ALM
wget https://ftp.perforce.com/alm/helixalm/r2024.1.0/ttlinuxinstall.tar.gz
tar -zxvf ttlinuxinstall.tar.gz
rm ttlinuxinstall.tar.gz # We have to do this or we run out of space on the VM
cd tt-*
# ./install.pl # This is an interactive installer, so we can't use it in a script.
# These are the install options needed 1 3 4 5 6 7 8 11 13 14
# 1566
# 5100

# To backup
# systemctl stop ttstudio.service
# cd /var/lib/HelixALM/TTServDb
# tar -cvf ALMbackup.tar TTDbs/
# systemctl start ttstudio.service
#
# To restore
# systemctl stop ttstudio.service
# cd /var/lib/HelixALM/TTServDb
# rm -rf TTDbs/
# tar -xvf ALMbackup.tar
# systemctl start ttstudio.service

# FIx this
# cp /var/www/cgi-bin/* /usr/lib/cgi-bin/

# Login
# Check apache http://<server>
# License server http://ip-10-138-1-15.eu-west-1.compute.internal/lsweb/admin/#loginPage/waitingForCredentials
# http://<hostname>/ttweb/ttadmin/adminlogin.htm
# http://<hostname>/lsweb/admin/#mainPage/licensesList
# http://<hostname>/ttweb/#Default/1/testCases?tabID=2147483657&filterID=0&page=0


http://ip-10-138-1-217.eu-west-1.compute.internal/lsweb/admin/#mainPage/licensesList