# Guide de Configuration de la Base de Données

Ce guide vous explique comment configurer MySQL pour votre système de blog.

## Option 1 : Via phpMyAdmin (Recommandé pour débutants)

1. **Ouvrez phpMyAdmin** dans votre navigateur (généralement : `http://localhost/phpmyadmin`)

2. **Créez une nouvelle base de données** :
   - Cliquez sur "Nouvelle base de données" dans le menu de gauche
   - Nommez-la `blog_db`
   - Choisissez l'interclassement : `utf8mb4_unicode_ci`
   - Cliquez sur "Créer"

3. **Importez le fichier SQL** :
   - Sélectionnez la base de données `blog_db` dans le menu de gauche
   - Cliquez sur l'onglet "Importer"
   - Cliquez sur "Choisir un fichier" et sélectionnez `database.sql`
   - Cliquez sur "Exécuter"

4. **Vérifiez que les tables sont créées** :
   - Vous devriez voir deux tables : `billets_blog` et `commentaires_blog`

## Option 2 : Via la ligne de commande MySQL

Si MySQL est installé mais pas dans le PATH :

1. **Trouvez l'emplacement de MySQL** (généralement dans `C:\Program Files\MySQL\MySQL Server X.X\bin\`)

2. **Ouvrez une invite de commande** et naviguez vers le dossier bin de MySQL

3. **Exécutez les commandes suivantes** :
   ```bash
   mysql -u root -p
   ```
   (Entrez votre mot de passe MySQL si demandé)

4. **Dans MySQL, exécutez** :
   ```sql
   CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   USE blog_db;
   SOURCE C:/Users/loice/OneDrive/Bureau/projectecole/database.sql;
   EXIT;
   ```

## Option 3 : Via XAMPP/WAMP

Si vous utilisez XAMPP ou WAMP :

1. **Démarrez MySQL** depuis le panneau de contrôle XAMPP/WAMP

2. **Ouvrez phpMyAdmin** : `http://localhost/phpmyadmin`

3. **Suivez les étapes de l'Option 1**

## Configuration dans config_blog.php

Ouvrez `config_blog.php` et vérifiez/modifiez ces lignes selon votre configuration :

```php
define('DB_HOST', 'localhost');     // Généralement 'localhost'
define('DB_NAME', 'blog_db');       // Nom de votre base de données
define('DB_USER', 'root');          // Votre nom d'utilisateur MySQL
define('DB_PASS', '');              // Votre mot de passe MySQL (vide par défaut avec XAMPP)
```

**Important** : 
- Si votre MySQL a un mot de passe, modifiez `DB_PASS`
- Si votre MySQL écoute sur un autre port, utilisez `localhost:3307` (ou le port approprié)

## Vérification

Une fois la base de données configurée, testez la connexion avec le script `test_db.php` que nous avons créé.

