#!/usr/bin/env bash

# Install prerequisites
apt-get install -y libgl1-mesa-glx
apt-get install -y libharfbuzz-dev
apt-get install -y net-tools
apt-get install -y libxrender1
apt-get install -y libxcomposite-dev
apt-get install -y libapache2-mod-cgi
apt-get install -y apache2
apt-get install -y libgl1-mesa-glx libharfbuzz0b libbz2-1.0 libgtk2.0-0 libpangox-1.0-0 libpangoxft-1.0-0 libidn11 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-libav libxcb-icccm4 libxcb-image0 libxcb-keysyms1 libxcb-render-util0 libxcb-shape0 libxcb-xinerama0 libxcb-xkb1 libxcb-xinput0 libxkbcommon-x11-0

# Copy the apache config file
# cp /terraform/file_store/helix_alm.conf /etc/apache2/apache2.conf

cat << EOF > /etc/apache2/apache2.conf
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
wget https://ftp.perforce.com/alm/helixalm/r2023.4.0/ttlinuxinstall.tar.gz
tar -zxvf ttlinuxinstall.tar.gz
rm ttlinuxinstall.tar.gz # We have to do this or we run out of space on the VM
cd tt-*
# ./install.pl # This is an interactive installer, so we can't use it in a script.

