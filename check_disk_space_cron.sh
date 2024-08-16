#!/usr/bin/bash

diskspace=`df -h | grep vda | awk '{print $5}'`
diskspace=`echo $diskspace | tr -d [%]`
if [[ $diskspace -ge "95" ]]; then
    vpsip=`ip r | grep kernel | awk '{print $9}'`
    logsspace=`du -sh /var/log/ | awk '{print $1}'`
    recordsspace=`du -sh /var/lib/freeswitch/recordings/ | awk '{print $1}'`
    if [[ $logsspace =~ ^[0-9]+\.[0-9]+G|[0-9]+G$ || $recordsspace =~ ^[0-9]+\.[0-9]+G|[0-9]+G$ ]]; then
        echo "VPS IP address $vpsip, Disk used space is $diskspace%, Logs space is $logsspace, Call records space is $recordsspace. It's time to do something." | mail -s "VPS disk space is almost over" leozor_krasota@te.net.ua
    else
        echo "VPS IP address $vpsip, Disk used space is $diskspace%. Logs and call records not a problem. Need check what used disk space manuale." | mail -s "VPS disk space is almost over" leozor_krasota@te.net.ua
    fi
fi

exit 0;

