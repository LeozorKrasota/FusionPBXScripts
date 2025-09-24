#!/bin/sh

# Set non-interactive mode for apt-get
export DEBIAN_FRONTEND=noninteractive

#upgrade the packages
apt-get update && apt-get upgrade -y

#install packages
apt-get install -y git lsb-release

#get the install script
cd /usr/src && git clone https://github.com/LeozorKrasota/FusionPBXScripts.git

#change the working directory
cd /usr/src/FusionPBXScripts
#Install FusionPBX and other components
./install.sh > /root/fusioninstall.log
