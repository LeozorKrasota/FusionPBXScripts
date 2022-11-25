#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ./config.sh
. ./colors.sh

#send a message
verbose "Installing FusionPBX"

#install dependencies
apt-get install -y vim git dbus haveged ssl-cert qrencode
apt-get install -y ghostscript libtiff5-dev libtiff-tools at

#add the cache directory
mkdir -p /var/cache/fusionpbx
chown -R www-data:www-data /var/cache/fusionpbx

#get the source code
git clone --branch 5.0 https://github.com/fusionpbx/fusionpbx.git /var/www/fusionpbx
chown -R www-data:www-data /var/www/fusionpbx

rm /var/www/fusionpbx/core/install/install.php
cd /var/www/fusionpbx/core/install
wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/ggvp/install.php
cd /usr/src/fusionpbx-install.sh/debian
