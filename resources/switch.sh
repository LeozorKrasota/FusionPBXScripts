#!/bin/sh

#move to script directory so all relative paths work
cd "$(dirname "$0")"

#includes
. ./config.sh
. ./environment.sh

if [ .$switch_source = .true ]; then
	if [ ."$switch_branch" = "master" ]; then
		switch/source-master.sh > /root/source-master-switch.log
	else
		switch/source-release.sh > /root/source-release-switch.log
	fi

	#add sounds and music files
	switch/source-sounds.sh

	#copy the switch conf files to /etc/freeswitch
	switch/conf-copy.sh

	#set the file permissions
	#switch/source-permissions.sh
	switch/package-permissions.sh

	#systemd service
	#switch/source-systemd.sh
	switch/package-systemd.sh
fi

if [ .$switch_package = .true ]; then
	if [ ."$switch_branch" = "master" ]; then
		if [ .$switch_package_all = .true ]; then
			switch/package-master-all.sh > /root/package-master-all-switch.log
		else
			switch/package-master.sh > /root/package-master-switch.log
		fi
	else
		if [ .$switch_package_all = .true ]; then
			switch/package-all.sh
		else
			switch/package-release.sh
		fi
	fi

	#copy the switch conf files to /etc/freeswitch
	switch/conf-copy.sh

	#set the file permissions
	switch/package-permissions.sh

	#systemd service
	switch/package-systemd.sh
fi
