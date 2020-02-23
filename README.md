# Documentation d'utilisation

Ces scripts sont fait pour être utlisés sous centos8.  

Ils permettent de créer et gérer des backups des arborescences que vous souhaitez ainsi que de les sauvegarder sur un serveur.
Cela inclus une sauvegarde automatique tous les jours du dossier de votre choix ainsi qu'une copie des backups tous les jours sur un autre dossier du serveur pour plus de sécurité.

## Installation  

Il faut en tout premier configurer votre serveur: 

### Serveur:
 
Clonez ce repository dans le dossier de votre choix. Ce sera depuis ce dossier que vous devrez lancer le script d'installation.  

Assurez vous d'être dans votre dossier où vous avez pull le repository et écrivez dans votre terminal: 

    chmod +xw init_serveur.sh  

Tapez ensuite `sudo ./init_serveur.sh` pour lancer l'installation et la configuration de tout ce qui est necessaire pour le partage de fichier des backup de votre client vers votre serveur.  

Vous n'avez plus qu'à suivre les instructions que le script vous donnera et c'est tout !  

### Client:

Maintenant que le serveur est configuré, il faut configurer votre client:
Clonez ce repository dans le dossier de votre choix. Ce sera depuis ce dossier que vous devrez lancer le script d'installation.  

Assurez vous d'être dans votre dossier où vous avez pull le repository et écrivez : 

    chmod +xw init_client.sh  

Écrivez `ip a` pour connaitre votre adresse ip. Vous en aurez besoin lors de la configuration du client.  
Tapez ensuite `sudo ./init_client.sh` pour lancer l'installation et la configuration de tout ce qui est necessaire pour pouvoir faire des backups et permettre le partage de fichier des backups de votre client vers votre serveur.  

Vous n'avez plus qu'à suivre les instructions que le script vous donnera et c'est tout !    

## Utilisation  

### Par ligne de commande

Maintenant que l'installation est faite, vous n'avez plus qu'a apprendre à faire des backup. Assurez vous d'exécutez ces commande en étant dans le dossier de votre repository ! Sinon il faut entrer le chemin absolu du script backup.sh.    

Pour enregistrer un backup, écrivez:  

    ./backup.sh save nom_de_votre_backup chemin_du_backup

Remplacez nom_de_votre_backup par le nom que vous voulez donner à votre backup en ne mettant aucun espace! Vous pouvez mettre des _ à la place.
Remplacez chemin_du_backup par le chemin du dossier dont vous voulez faire une backup.  

  
Pour lister tous vos backup enregistrés, écrivez:  

    ./backup.sh list 


Pour extraire votre backup dans le répertoire courant, écrivez:  

    ./backup.sh extract nom_de_votre_backup

Remplacez nom_de_votre_backup par le nom du backup que vous voulez extraire.  
Si vous voulez extraire une backup dans un dossier en particulier, vous devez aller dans le dossier où vous voulez extraire votre backup puis executer la commande en spécifiant le chemin absolu de votre commande au lieu de mettre directement ./backup.sh  

Pour restorer votre backup, écrivez:  

    ./backup.sh restore nom_de_votre_backup

Remplacez nom_de_votre_backup par le nom du backup que vous voulez restaurer.  
La restauration d'un backup est différente qu'une simple extraction. En faisant une restauration, le backup va automatiquement se remettre à son emplacement d'origine en remplaçant votre dossier actuel. Par exemple une restauration du backup de /etc supprimera votre /etc actuel pour le remplaçer par la version du backup.  

Attention, vous allez remarquer qu'à la racine de votre Ubuntu se trouve un fichier nePasSupprimer qui va se créer lors de la première utilisation de backup.sh. Ce fichier sert au bon fonctionnement de la fonction "restore". La suppression de ce fichier empèchera les backups de se restaurer dans l'emplacement d'origine !  


Pour supprimer le backup de votre choix, écrivez:

    ./backup.sh delete nom_de_votre_backup

Remplacez nom_de_votre_backup par le nom du backup que vous voulez supprimer.  


Pour supprimer tous vos backup:

    ./backup.sh delete all

Il vous sera ensuite demandé d'écrire YES pour valider la suppression de tous vos backup.  


Si vous ne vous rappelez plus de l'utilisation du script, vous pouvez taper:

    ./backup.sh --help

ou

    ./backup.sh -h

Cela vous rappellera commment utiliser le script.
  

### Au sujet des sauvegardes automatiques toutes les 24h

Lors de l'installation il vous a été demander de choisir quel dossier sauvegarder toute les 24h et dans quel dossier du serveur vous voudriez copié les backups du dossier partagé.

Si pour n'importe quelle raison cela ne fonctionnerait pas, sur le client tapez:  

    sudo crontab -e

Et copiez-collez dedans:

    30 19 * * * yes | /chemin_absolu/backup.sh save sauvegardeJournaliere_`date "+\%d.\%m.\%Y"` chemin_absolu_dossier

Remplacez chemin_absolu par le chemin absolu jusqu'au backup.sh et chemin_voulu_dossier par le chemin absolu du dossier dont vous voulez faire un backup toutes les 24h.  



Pour le serveur:  

Si pour n'importe quelle raison cela ne fonctionnerait pas, sur le serveur tapez:  

    sudo crontab -e

Et copiez-collez dedans:

    40 19 * * * sudo cp -r /backup chemin_absolu_dossier_copie

Remplacez chemin_absolu_dossier_copie par le chemin absolu du dossier où vous voulez copier les backup du dossier partager.
