# Système de Blog PHP/MySQL/Smarty

Système de blog simple permettant d'ajouter des billets, des commentaires et de visualiser les billets. Utilise MySQL pour le stockage des données et Smarty pour la séparation des templates.

## Prérequis

- PHP 7.4 ou supérieur
- MySQL 5.7 ou supérieur (ou MariaDB)
- Smarty 3.x ou 4.x
- Serveur web (Apache, Nginx, ou serveur PHP intégré)

## Installation

### 1. Installation de Smarty

#### Option A : Via Composer (recommandé)
```bash
composer require smarty/smarty
```

#### Option B : Installation manuelle
- Téléchargez Smarty depuis https://www.smarty.net/
- Décompressez-le dans votre projet ou ajustez le chemin dans `config_blog.php`

### 2. Configuration de la base de données

1. Créez une base de données MySQL :
```sql
CREATE DATABASE blog_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

2. Importez la structure des tables :
```bash
mysql -u root -p blog_db < database.sql
```

Ou via phpMyAdmin : importez le fichier `database.sql`

### 3. Configuration de la connexion

Éditez le fichier `config_blog.php` et ajustez les paramètres de connexion MySQL :
```php
define('DB_HOST', 'localhost');
define('DB_NAME', 'blog_db');
define('DB_USER', 'root');
define('DB_PASS', '');
```

### 4. Permissions des répertoires

Assurez-vous que PHP peut écrire dans les répertoires suivants (créés automatiquement par le script si nécessaire) :
- `templates_c/` (templates compilés de Smarty)
- `cache/` (cache de Smarty)

Sur Linux/Mac :
```bash
chmod 777 templates_c cache
```

## Structure du projet

```
projectecole/
├── config_blog.php          # Configuration MySQL et Smarty
├── database.sql             # Structure de la base de données
├── editer_blog.php          # Création et édition de billets
├── afficher_blog.php        # Affichage d'un billet individuel
├── commenter_blog.php       # Ajout de commentaires
├── index_blog.php           # Liste des billets (page d'accueil)
├── templates/               # Templates Smarty
│   ├── edition_blog.tpl
│   ├── afficher_blog.tpl
│   └── index_blog.tpl
├── templates_c/             # Templates compilés (généré automatiquement)
└── cache/                   # Cache Smarty (généré automatiquement)
```

## Utilisation

### Démarrer le serveur de développement PHP
```bash
php -S localhost:8000
```

Puis ouvrez votre navigateur à l'adresse : http://localhost:8000/index_blog.php

### Fonctionnalités

1. **Page d'accueil** (`index_blog.php`) : Affiche la liste de tous les billets, les plus récents en premier
   - Filtrage par catégorie possible
   - Lien vers l'éditeur de billet

2. **Création de billet** (`editer_blog.php`) : Formulaire pour créer un nouveau billet
   - Champs : Titre, Contenu, Catégorie
   - L'annonce (extrait) est générée automatiquement

3. **Affichage de billet** (`afficher_blog.php`) : Affiche un billet complet avec ses commentaires
   - Formulaire de commentaire masqué au chargement (affiché au clic)
   - Liste de tous les commentaires associés

4. **Ajout de commentaire** (`commenter_blog.php`) : Traite l'ajout d'un commentaire et redirige vers le billet

## Structure de la base de données

### Table `billets_blog`
- `ID` : Identifiant unique (auto-increment)
- `titre` : Titre du billet (max 120 caractères)
- `contenu` : Contenu complet du billet
- `annonce` : Extrait du billet (généré automatiquement)
- `date_billet` : Date et heure de publication
- `categorie` : Catégorie du billet (max 12 caractères)

### Table `commentaires_blog`
- `ID_comment` : Identifiant unique du commentaire (auto-increment)
- `nom` : Nom de l'auteur du commentaire (max 50 caractères)
- `comment` : Contenu du commentaire
- `date_comment` : Date et heure du commentaire (timestamp automatique)
- `ID` : Identifiant du billet associé (clé étrangère)

## Sécurité

Les scripts incluent :
- Protection contre les injections SQL (utilisation de requêtes préparées)
- Protection contre XSS (htmlspecialchars)
- Validation des entrées
- Nettoyage des données utilisateur

**Note** : Pour un environnement de production, considérez :
- Désactiver le débogage Smarty
- Ajouter une authentification pour l'édition de billets
- Implémenter un système de CSRF tokens
- Utiliser HTTPS
- Configurer correctement les permissions de fichiers

## Dépannage

### Erreur "Class 'Smarty' not found"
- Vérifiez que Smarty est correctement installé
- Vérifiez le chemin dans `config_blog.php`

### Erreur de connexion à la base de données
- Vérifiez les identifiants dans `config_blog.php`
- Vérifiez que MySQL est en cours d'exécution
- Vérifiez que la base de données existe

### Erreur "Permission denied" sur templates_c ou cache
- Vérifiez les permissions des répertoires
- Créez les répertoires manuellement si nécessaire

