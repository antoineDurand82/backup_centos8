#!/bin/bash

dnf install nfs-utils -y

dnf install borgbackup -y

chmod +x backup.sh
chmod +wxr Backup.py

echo "192.168.56.100 serveurnfs">>/etc/hosts

showmount -e serveurnfs

mkdir /srv/backup

mount serveurnfs:/srv/backup /srv/backup

touch auto.sh
chmod +x auto.sh

echo "serveurnfs:/srv/backup /srv/backup nfs defaults,user,auto,noatime,bg 0 0">>/etc/fstab

echo "yes | /srv/backup_centos8/backup.sh save sauvegardeJournaliere_`date "+\%d.\%m.\%Y"` /home">>/srv/backup_centos8/auto.sh

mv /srv/backup_centos8/auto.sh /etc/cron.daily/

mount -a -v /etc/fstab

echo "Installation terminée."

