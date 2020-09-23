#Installer PhpMyAdmin

##Téléchargement des packets
On va récupérer la dernière version de PhpMyAdmin grace au fichier txt disponible à 
[ici](https://www.phpmyadmin.net/home_page/version.txt).

Dans une variable `DATA`, on va stocker le contenu du fichier.

```bash
DATA="$(wget https://www.phpmyadmin.net/home_page/version.txt -q -O-)"
```

Il ne nous reste plus qu'à récupérer le numéro de version. Le numéro de version est 
disponible à la 1ère ligne du fichier texte.

```bash
VERSION="$(echo $DATA | cut -d ' ' -f 1)"
```

Maintenant que nous avons le numéro de la dernière version disponible, nous pouvons 
télécharger l'archive à jour.

```bash
cd /tmp
wget https://files.phpmyadmin.net/phpMyAdmin/${VERSION}/phpMyAdmin-${VERSION}-all-languages.tar.gz
tar xvf phpMyAdmin-${VERSION}-all-languages.tar.gz
```

Une fois l'archive téléchargée et décompressée, nous alons déplacer tous les fichier de 
PhpMyAdmin à leur emplacement final.

```bash
mv phpMyAdmin-*/ /usr/share/phpmyadmin
```

##Installation

On créé les dossiers dont on va avoir besoin pour finaliser l'installation de PhpMyAdmin 
et on n'oublie pas de mettre définir les permissions.

```bash
mkdir -p /var/lib/phpmyadmin/tmp
chown -R www-data:www-data /var/lib/phpmyadmin
mkdir /etc/phpmyadmin/
```

On copie les fichiers de configuration.

```bash
cp /usr/share/phpmyadmin/config.sample.inc.php  /usr/share/phpmyadmin/config.inc.php
```

##Configuration

###PhpMyAdmin
Il faut éditer le fichier `config.inc.php` que nous venons de copier.

```bash
vim  /usr/share/phpmyadmin/config.inc.php
```

Une fois en mode `édition`, il faut ajouter la ligne (si elle n'existe pas, sinon la 
modifier) :

```php
$cfg['TempDir'] = '/var/lib/phpmyadmin/tmp';
```

Vous pouvez quitter le fichier de configuration.

###Apache

Configurons le serveur `apache` maintenant.

Pour ce faire, soit vous copier le fichier `phpmyadmin.conf` disponible dans ce dossier, 
soit vous créer un nouveau fichier de configuration `apache`.

**Dans les deux cas**, le fichier de configuration doit être placé à l'adresse suivante :

```
/etc/apache2/conf-enabled/phpmyadmin.conf
```

On n'oublie pas de redémarer le serveur `apache` une fois la configuration activée :

```bash
a2ensite phpmyadmin.conf
systemctl restart apache2
```

Pour vous rendre sur votre PhpMyAdmin, c'est très simple, vous allez l'adresse de l'un 
de vos site configurés sur le serveur en ajoutant `/phpmyadmin` à la fin.

ex : `monpremiersite.test/phpmyadmin`