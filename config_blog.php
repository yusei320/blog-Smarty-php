<?php
/**
 * Configuration du système de blog
 * Configure la connexion MySQL et initialise Smarty
 */

// Configuration MySQL (supporte les variables d'environnement Vercel)
define('DB_HOST', getenv('DB_HOST') ?: 'localhost:3309');
define('DB_NAME', getenv('DB_NAME') ?: 'blog_db');
define('DB_USER', getenv('DB_USER') ?: 'root');
define('DB_PASS', getenv('DB_PASS') ?: '');

// Chemin vers Smarty
// D'abord, on essaie avec Composer (si installé)
if (file_exists('vendor/autoload.php')) {
    require_once('vendor/autoload.php');
} 
// Sinon, on essaie une installation manuelle dans différents emplacements courants
elseif (file_exists('libs/Smarty/libs/Smarty.class.php')) {
    require_once('libs/Smarty/libs/Smarty.class.php');
}
elseif (file_exists('vendor/smarty/smarty/libs/Smarty.class.php')) {
    require_once('vendor/smarty/smarty/libs/Smarty.class.php');
}
elseif (file_exists('Smarty/libs/Smarty.class.php')) {
    require_once('Smarty/libs/Smarty.class.php');
}
else {
    die("Erreur : Smarty n'a pas été trouvé. Veuillez installer Smarty manuellement ou via Composer.\nVoir INSTALLATION_SMARTY.md pour les instructions.");
}

// Création de la connexion MySQL
try {
    $pdo = new PDO(
        "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=utf8mb4",
        DB_USER,
        DB_PASS,
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC
        ]
    );
} catch(PDOException $e) {
    die("Erreur de connexion à la base de données : " . $e->getMessage());
}

// Configuration Smarty
$smarty = new Smarty();

// Configuration des répertoires Smarty
$smarty->setTemplateDir(__DIR__ . '/templates');
$smarty->setConfigDir(__DIR__ . '/configs');

// Sur Vercel, seul le dossier /tmp est accessible en écriture
if (getenv('VERCEL') == '1' || getenv('VERCEL_ENV')) {
    $smarty->setCompileDir('/tmp/templates_c');
    $smarty->setCacheDir('/tmp/cache');
    
    if (!file_exists('/tmp/templates_c')) mkdir('/tmp/templates_c', 0777, true);
    if (!file_exists('/tmp/cache')) mkdir('/tmp/cache', 0777, true);
} else {
    $smarty->setCompileDir(__DIR__ . '/templates_c');
    $smarty->setCacheDir(__DIR__ . '/cache');
    
    if (!file_exists(__DIR__ . '/templates_c')) mkdir(__DIR__ . '/templates_c', 0777, true);
    if (!file_exists(__DIR__ . '/cache')) mkdir(__DIR__ . '/cache', 0777, true);
}

// Options de débogage (désactivez en production)
$smarty->debugging = false;
$smarty->caching = false;

?>

