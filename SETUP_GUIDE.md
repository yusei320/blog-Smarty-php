# Guide de Configuration Complète du Système de Blog

Ce guide vous accompagne étape par étape pour configurer votre système de blog.

## ✅ Étape 1 : Vérifier les Prérequis

### PHP
- **Vérifier PHP** : Ouvrez un terminal et tapez `php -v`
- **Version requise** : PHP 7.4 ou supérieur
- Si PHP n'est pas installé, installez XAMPP, WAMP, ou PHP directement

### MySQL/MariaDB
- **Vérifier MySQL** : Le serveur MySQL doit être démarré
- Si vous utilisez XAMPP/WAMP, démarrez MySQL depuis le panneau de contrôle
- Si vous utilisez MySQL standalone, assurez-vous que le service est démarré

## ✅ Étape 2 : Installation de Smarty (DÉJÀ FAIT)

Smarty a déjà été installé automatiquement dans `libs/Smarty/`. ✅

## ✅ Étape 3 : Configuration de la Base de Données

### 3.1 Créer la Base de Données

**Méthode A : Via phpMyAdmin (Recommandé)**
1. Ouvrez phpMyAdmin : `http://localhost/phpmyadmin`
2. Cliquez sur "Nouvelle base de données"
3. Nom : `blog_db`
4. Interclassement : `utf8mb4_unicode_ci`
5. Cliquez sur "Créer"

**Méthode B : Via la ligne de commande**
```sql
CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 3.2 Importer les Tables

**Via phpMyAdmin :**
1. Sélectionnez la base `blog_db`
2. Onglet "Importer"
3. Choisissez le fichier `database.sql`
4. Cliquez sur "Exécuter"

**Via la ligne de commande :**
```bash
mysql -u root -p blog_db < database.sql
```

### 3.3 Configurer les Identifiants

Ouvrez `config_blog.php` et ajustez si nécessaire :
```php
define('DB_HOST', 'localhost');
define('DB_NAME', 'blog_db');
define('DB_USER', 'root');        // Votre utilisateur MySQL
define('DB_PASS', '');            // Votre mot de passe MySQL
```

## ✅ Étape 4 : Tester la Configuration

1. **Ouvrez dans votre navigateur** : `http://localhost/test_db.php`
   - (Si vous utilisez le serveur PHP intégré, voir étape 5)

2. **Vérifiez que tous les tests sont ✅**

3. **Si des erreurs apparaissent** :
   - Vérifiez que MySQL est démarré
   - Vérifiez les identifiants dans `config_blog.php`
   - Vérifiez que la base de données `blog_db` existe
   - Vérifiez que les tables ont été importées

## ✅ Étape 5 : Lancer le Serveur Web

### Option A : Serveur PHP Intégré (Recommandé pour développement)

Dans le terminal, depuis le dossier du projet :
```bash
php -S localhost:8000
```

Puis ouvrez dans votre navigateur :
- Page de test : `http://localhost:8000/test_db.php`
- Blog : `http://localhost:8000/index_blog.php`

### Option B : Apache/XAMPP/WAMP

1. Placez votre projet dans :
   - XAMPP : `C:\xampp\htdocs\projectecole\`
   - WAMP : `C:\wamp64\www\projectecole\`

2. Accédez via :
   - `http://localhost/projectecole/test_db.php`
   - `http://localhost/projectecole/index_blog.php`

## ✅ Étape 6 : Utiliser le Blog

Une fois tout configuré :

1. **Page d'accueil** : `index_blog.php`
   - Affiche la liste des billets
   - Lien pour créer un nouveau billet

2. **Créer un billet** : `editer_blog.php`
   - Formulaire pour ajouter un nouveau billet

3. **Voir un billet** : Cliquez sur un titre dans la liste
   - Affiche le billet complet
   - Permet d'ajouter des commentaires

## 🛠️ Dépannage

### Erreur "Class 'Smarty' not found"
- Vérifiez que `libs/Smarty/libs/Smarty.class.php` existe
- Vérifiez les permissions de lecture

### Erreur de connexion MySQL
- Vérifiez que MySQL est démarré
- Vérifiez les identifiants dans `config_blog.php`
- Vérifiez que la base de données `blog_db` existe

### Erreur "Table doesn't exist"
- Importez le fichier `database.sql` dans votre base de données

### Templates ne s'affichent pas
- Vérifiez que le dossier `templates_c` existe et est accessible en écriture
- Vérifiez les permissions du dossier

## 📝 Résumé des Fichiers Importants

- `config_blog.php` : Configuration MySQL et Smarty
- `database.sql` : Structure de la base de données
- `index_blog.php` : Page d'accueil
- `editer_blog.php` : Création de billets
- `afficher_blog.php` : Affichage d'un billet
- `commenter_blog.php` : Ajout de commentaires
- `test_db.php` : Script de test de configuration

Bon développement ! 🚀

