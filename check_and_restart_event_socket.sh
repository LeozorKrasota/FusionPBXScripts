#!/usr/bin/bash

check=`netstat -anlp | grep :8021`
if [[ -n "$check" ]]; then
    uptime=`systemctl status freeswitch | grep Active: | awk '{print $9" "$10" "$11" "$12" "$13}'`
    echo `date +"%Y-%m-%d %T"`" Freeswitch listen port 8021. Event Socket is alright. Freeswitch uptime: "$uptime >> /var/log/event_socket_check.log
else
    echo `date +"%Y-%m-%d %T"`" Freeswitch not listen port 8021. Event Socket is crush. Restart Freeswitch service." >> /var/log/event_socket_check.log
    systemctl restart freeswitch.service
fi

