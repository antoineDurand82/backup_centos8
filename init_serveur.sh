#!/bin/bash

dnf install nfs-utils -y

dracut -f -v

cd /srv/
mkdir /backup
mkdir /saveBackup

echo "192.168.56.111 client-1">>/etc/hosts
echo "192.168.56.112 client-2">>/etc/hosts

echo "/srv/backup client-1(rw,no_root_squash) \ *.local.domain.edu(rw,no_root_squash)">>/etc/exports
echo "/srv/backup client-2(rw,no_root_squash) \ *.local.domain.edu(rw,no_root_squash)">>/etc/exports


systemctl enable rpcbind
systemctl enable nfs-server
systemctl start rpcbind
systemctl start nfs-server

touch auto.sh
chmod +x auto.sh

echo "sudo cp -r /srv/backup /srv/saveBackup">>/srv/backup_centos8/auto.sh

mv /srv/saveBackup/auto.sh /etc/cron.daily/

echo -e "\n\nL'installion est terminée, bravo"
