# Configurer un serveur apache

**Prérequis**

Avoir une machine virtuelle ou un serveur (VPS ou dédié)

`vim` (peut être remplcé par tout éditeur en ligne de commande)


_Je sais que certaines personnes vont me destester, mais voilà... j'utilise `vim`!_

---

Ce tutoriel est la suite de `Monter une VM avec Vagrant`. Vous pouvez le suivre si vous possedez déjà un sereur (VPS ou 
dédié).

Configuration de ma VM : `Debian 10 (Buster)`

```diff
- Attention : si vous utilisez un VPS ou un serveur dédié pour suivre ce tutoriel, veillez à faire une sauvegarde de vos données avant de commencer !
```

## Démarage : mises à jour et installations

### Se connecter en ssh à son serveur
Commecez par vous connectez en ssh à votre serveur. 
Normalement votre hébergeur vous a envoyé les identifiants de l'utilisateur `root`. 

```shell script
ssh root@adresse.ip.du.serveur
```

### Mises à jour
```bash
apt update
apt upgrade
```

### Installation d'aptitude et de vim
```bash
apt-get install aptitude vim
```

### Installation d'`apache2`, `Php`, `composer`et `git`
On en profite pour installer `composer` et `git` en plus du reste 
comme ça on n'aura pas à le faire plus tard.
```bash
aptitude install apache2 php composer git
```

### Regardons si notre serveur est bien accessible
Sur votre navigateur, tappez l'adresse ip de votre serveur.
Dans mon cas, ce sera `192.168.33.10`.

Normalement vous devriez avoir une page Apache qui s'affche.

C'est bon, nous avons installé le serveur web!

Maintenant passons à la configuration.

## Configuration

## Configuration d'apache
Regardons un peu ce que nous avons à ce moment de notre 
installation.

Le dossier `/var/www`, contiendra notre ou nos sites.

Pour le moment il y a un site : `public_html`

### Faisons du ménage
On va pouvoir supprimer ce dossier et ce qu'il contient.

```bash
cd /var/www
rm -rf public_html
```

Maintenant que c'est fait, on va désactiver le site par défaut
(les fichiers qu'on vient de supprimer).

```bash
a2dissite 000-default.conf
systemctl reload apache2
```

On peut vérifier que le service `apache2` tourne bien en tappant
```bash
systemctl status apache2
```

### On configure notre premier site
On créé ensuite notre premier fichier de configuration apache.

```bash
vim /etc/apache2/sites-available/monpremiersite.conf
```

Pour passer en mode `insertion` sur `vim`, tapper `i`.

On y rentre la configuration suivante (on va tout détailler
après ;))

```apacheconf
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/monpremiersite

    ErrorLog /var/www/monpremiersite/logs/error.log
    CustomLog /var/www/monpremiersite/logs/access.log combined
</VirtualHost>
```

Pour quitter et enregistrer avec `vim`, il faut faire
`échap` puis tapper `wq` puis `entrer`.

### Activation de notre premier site
```bash
a2ensite monpremiersite.conf
systemctl reload apache2
```

### Création des fichiers de notre site

Pour rappel, nous sommes dans `/var/www`.

On va afficher un simple site vitrine.

Ce site est un site vitrine développé à 
l'aide de bootstrap 4 par [Hayanisaid](https://github.com/hayanisaid).

```bash
git clone https://github.com/hayanisaid/bootstrap4-website.git onpremiersite
``` 

Nous devons maintenant créer le dossier qui contiendra nos fichiers de logs.

```bash
mkdir monpremiersite/logs
```

## Un dernier test!
Comme plus tôt nous avons regardé que la page d'apache s'affichait
bien, nous allons vérifié le bon affichage de notre site.

Normalement vous devriez tomber sur le site d'Hayanisaid.

C'est fini! La prochaine fois nous mettrons en place une base de donnée.