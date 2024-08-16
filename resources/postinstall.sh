#!/bin/bash

# Останавливаем event guard FusionPBX
systemctl stop event_guard
systemctl disable event_guard
systemctl daemon-reload

# Меняем экшины Fail2ban
cp /etc/fail2ban/action.d/iptables.conf /etc/fail2ban/action.d/iptables.conf.backup
rm /etc/fail2ban/action.d/iptables.conf
cd /etc/fail2ban/action.d/ && wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/iptables.conf

# Создаем файл чтения логов Fail2ban
cd /etc/fail2ban/jail.d/ && wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/freeswitch.local

# Меняем параметры тюрем (jail.local) Fail2ban
cp /etc/fail2ban/jail.local /etc/fail2ban/jail.local.backup
rm /etc/fail2ban/jail.local
cd /etc/fail2ban/ && wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/jail.local
chmod +x /etc/fail2ban/jail.local

# Рестартим Fail2ban для применения новых конфигов
systemctl restart fail2ban

# Обновляем звуковые файлы Freeswitch
cd /usr/share/freeswitch/sounds/en/us/callie
wget http://files-sync.freeswitch.org/freeswitch-sounds-ru-RU-elena-8000-1.0.13.tar.gz
wget http://files-sync.freeswitch.org/freeswitch-sounds-ru-RU-elena-16000-1.0.13.tar.gz
wget http://files-sync.freeswitch.org/freeswitch-sounds-ru-RU-elena-32000-1.0.13.tar.gz
wget http://files.freeswitch.org/releases/sounds/freeswitch-sounds-ru-RU-elena-48000-1.0.51.tar.gz
tar -xzvf freeswitch-sounds-ru-RU-elena-8000-1.0.13.tar.gz
tar -xzvf freeswitch-sounds-ru-RU-elena-16000-1.0.13.tar.gz
tar -xzvf freeswitch-sounds-ru-RU-elena-32000-1.0.13.tar.gz
tar -xzvf freeswitch-sounds-ru-RU-elena-48000-1.0.51.tar.gz
rm freeswitch-sounds-ru-RU-elena-8000-1.0.13.tar.gz
rm freeswitch-sounds-ru-RU-elena-16000-1.0.13.tar.gz
rm freeswitch-sounds-ru-RU-elena-32000-1.0.13.tar.gz
rm freeswitch-sounds-ru-RU-elena-48000-1.0.51.tar.gz
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/ascii /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/conference /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/currency /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/digits /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/directory /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/ivr /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/misc /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/phonetic-ascii /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/time /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/users /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/voicemail /usr/share/freeswitch/sounds/en/us/callie
cp -Rf /usr/share/freeswitch/sounds/en/us/callie/ru/RU/elena/zrtp /usr/share/freeswitch/sounds/en/us/callie
rm -R /usr/share/freeswitch/sounds/en/us/callie/ru

# Добавляем скрипты, настраиваем кронтаб и ротацию логов
cd /home/ratibor
wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/check_and_restart_event_socket.sh
wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/check_disk_space_cron.sh
chmod +x check_and_restart_event_socket.sh
chmod +x check_disk_space_cron.sh
wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/newcrontab
crontab newcrontab
rm newcrontab
cd /etc/logrotate.d
rm exim4-base
wget https://raw.githubusercontent.com/LeozorKrasota/FusionPBXScripts/main/exim4-base
chown root:root exim4-base

# Перезадаем часовой пояс машины
timedatectl set-timezone Europe/Kiev
