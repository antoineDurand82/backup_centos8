#!/bin/bash

dnf install nfs-utils -y

dracut -f -v

cd /srv/
mkdir backup
mkdir saveBackup

mount --bind /srv/backup /srv/backup

echo "/srv/backup /srv/backup  none   bind   0   0">>/etc/fstab

echo "192.168.56.111 client-1">>/etc/hosts
echo "192.168.56.112 client-2">>/etc/hosts

echo "/srv/backup client-1(rw,no_root_squash) \ *.local.domain.edu(rw,no_root_squash)">>/etc/exports
echo "/srv/backup client-2(rw,no_root_squash) \ *.local.domain.edu(rw,no_root_squash)">>/etc/exports

exportfs -ra


systemctl enable rpcbind
systemctl enable --now nfs-server
systemctl start rpcbind
systemctl start nfs-server

touch auto.sh
chmod +x auto.sh

echo "sudo cp -r /srv/backup /srv/saveBackup">>/srv/backup_centos8/auto.sh

mv /srv/backup_centos8/auto.sh /etc/cron.daily/

echo -e "\n\nL'installion est terminée, bravo"
