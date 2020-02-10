#!/bin/bash

dnf install nfs-utils -y

dracut -f -v

mkdir /backup

echo -e "\n\nVeuillez fournir l'adresse ip de votre client:"
read ip_client

echo "$ip_client client">>/etc/hosts

echo "/backup client(rw,no_root_squash) \ *.local.domain.edu(rw,no_root_squash)">>/etc/exports


systemctl enable rpcbind
systemctl enable nfs-server
systemctl start rpcbind
systemctl start nfs-server

touch auto.sh
chmod +x auto.sh

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier où vous voulez avoir une backup de votre dossier partager \nPar exemple '/home/antoine/Desktop'. Pensez à retirer le dernier '/' se trouvant après le dernier dossier"
read cheminbackup

echo -e "\n\nVeuillez fournir le chemin complet jusqu'à votre dossier contenant le fichier 'init_serveur.sh' que vous venez de lancer"
read cheminfichier

echo "sudo cp -r /backup $cheminbackup">>$cheminfichier/auto.sh

mv $cheminfichier/auto.sh /etc/cron.daily/

echo -e "\n\nL'installion est terminée, bravo"
