# Guide d'installation manuelle de Smarty

Ce guide vous explique comment installer Smarty manuellement sans utiliser Composer.

## Étape 1 : Télécharger Smarty

1. Allez sur le site officiel de Smarty : https://www.smarty.net/download
2. Téléchargez la dernière version stable de Smarty (version 4.x recommandée)
3. Le fichier téléchargé sera un fichier ZIP (ex: `Smarty-4.x.x.tar.gz` ou `.zip`)

## Étape 2 : Extraire Smarty dans votre projet

### Option A : Dans un sous-dossier du projet (recommandé)

1. Créez un dossier `libs` à la racine de votre projet `projectecole`
2. Extrayez le contenu de l'archive Smarty
3. Renommez le dossier extrait en `Smarty` et placez-le dans `libs/`
4. Vous devriez avoir cette structure :
   ```
   projectecole/
   ├── libs/
   │   └── Smarty/
   │       ├── libs/
   │       │   └── Smarty.class.php  ← Le fichier principal
   │       ├── plugins/
   │       └── ...
   ├── config_blog.php
   ├── index_blog.php
   └── ...
   ```

### Option B : Utiliser le dossier vendor (si vous préférez)

1. Créez un dossier `vendor` à la racine de votre projet
2. Extrayez Smarty dans `vendor/smarty/smarty/`
3. Vous devriez avoir :
   ```
   projectecole/
   ├── vendor/
   │   └── smarty/
   │       └── smarty/
   │           ├── libs/
   │           │   └── Smarty.class.php
   │           └── ...
   ```

## Étape 3 : Modifier config_blog.php

Le fichier `config_blog.php` a déjà été modifié pour fonctionner avec une installation manuelle.
Il cherche automatiquement Smarty dans plusieurs emplacements communs.

Si votre structure est différente, modifiez la ligne `require_once` dans `config_blog.php` :

**Pour Option A (libs/Smarty) :**
```php
require_once('libs/Smarty/libs/Smarty.class.php');
```

**Pour Option B (vendor/smarty/smarty) :**
```php
require_once('vendor/smarty/smarty/libs/Smarty.class.php');
```

## Étape 4 : Vérifier l'installation

1. Assurez-vous que le fichier `Smarty.class.php` existe à l'emplacement indiqué
2. Vérifiez que PHP peut lire le fichier (pas de problèmes de permissions)
3. Testez en ouvrant `index_blog.php` dans votre navigateur

## Structure finale recommandée

```
projectecole/
├── libs/
│   └── Smarty/
│       └── libs/
│           └── Smarty.class.php
├── templates/
│   ├── index_blog.tpl
│   ├── edition_blog.tpl
│   └── afficher_blog.tpl
├── templates_c/          (créé automatiquement par Smarty)
├── cache/                (créé automatiquement par Smarty)
├── config_blog.php
├── index_blog.php
├── editer_blog.php
├── afficher_blog.php
├── commenter_blog.php
└── database.sql
```

## Dépannage

### Erreur "Class 'Smarty' not found"
- Vérifiez que le chemin dans `config_blog.php` est correct
- Vérifiez que le fichier `Smarty.class.php` existe bien à cet emplacement
- Vérifiez les permissions de lecture du fichier

### Erreur "Failed to open stream"
- Le chemin vers Smarty est incorrect
- Vérifiez l'orthographe du chemin (attention aux majuscules/minuscules sur Linux/Mac)
- Vérifiez que tous les dossiers intermédiaires existent

### Les templates ne s'affichent pas
- Vérifiez que le dossier `templates_c` existe et est accessible en écriture
- Vérifiez les permissions : `chmod 755 templates_c` (Linux/Mac)

