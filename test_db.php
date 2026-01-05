<?php
/**
 * Script de test pour vérifier la connexion à la base de données
 * et l'installation de Smarty
 */

echo "<h1>Test de Configuration</h1>";

// Test 1: Vérifier PHP
echo "<h2>1. Version PHP</h2>";
echo "Version PHP : " . phpversion() . "<br>";
echo "PDO MySQL disponible : " . (extension_loaded('pdo_mysql') ? "✅ Oui" : "❌ Non") . "<br><br>";

// Test 2: Vérifier Smarty
echo "<h2>2. Installation de Smarty</h2>";
try {
    if (file_exists('libs/Smarty/libs/Smarty.class.php')) {
        require_once('libs/Smarty/libs/Smarty.class.php');
        $smarty = new Smarty();
        echo "✅ Smarty est installé correctement<br>";
        echo "Version Smarty : " . Smarty::SMARTY_VERSION . "<br><br>";
    } elseif (file_exists('vendor/autoload.php')) {
        require_once('vendor/autoload.php');
        $smarty = new Smarty\Smarty();
        echo "✅ Smarty est installé via Composer<br><br>";
    } else {
        echo "❌ Smarty n'est pas trouvé<br><br>";
    }
} catch (Exception $e) {
    echo "❌ Erreur Smarty : " . $e->getMessage() . "<br><br>";
}

// Test 3: Vérifier la connexion à la base de données
echo "<h2>3. Connexion à la base de données</h2>";

// Charger la configuration (attention : cela va aussi initialiser Smarty)
// Pour éviter les conflits, on teste d'abord la connexion directement
try {
    require_once('config_blog.php');
    // La connexion a déjà été créée dans config_blog.php
    // Testons une requête simple
    $stmt = $pdo->query("SELECT DATABASE() as db_name");
    $result = $stmt->fetch();
    echo "✅ Connexion MySQL réussie<br>";
    echo "Base de données connectée : " . $result['db_name'] . "<br><br>";
    
    // Vérifier que les tables existent
    echo "<h3>4. Vérification des tables</h3>";
    
    $stmt = $pdo->query("SHOW TABLES");
    $tables = $stmt->fetchAll(PDO::FETCH_COLUMN);
    
    $required_tables = ['billets_blog', 'commentaires_blog'];
    $found_tables = [];
    
    foreach ($tables as $table) {
        if (in_array($table, $required_tables)) {
            $found_tables[] = $table;
            echo "✅ Table '$table' existe<br>";
        }
    }
    
    $missing_tables = array_diff($required_tables, $found_tables);
    if (!empty($missing_tables)) {
        echo "<br>❌ Tables manquantes : " . implode(', ', $missing_tables) . "<br>";
        echo "Veuillez importer le fichier database.sql<br><br>";
    } else {
        echo "<br>✅ Toutes les tables requises sont présentes<br><br>";
    }
    
    // Compter les billets
    $stmt = $pdo->query("SELECT COUNT(*) as count FROM billets_blog");
    $count = $stmt->fetch();
    echo "Nombre de billets dans la base : " . $count['count'] . "<br><br>";
    
} catch(PDOException $e) {
    echo "❌ Erreur de connexion : " . $e->getMessage() . "<br>";
    if (defined('DB_HOST')) {
        echo "<br>Vérifiez vos paramètres dans config_blog.php :<br>";
        echo "- DB_HOST : " . DB_HOST . "<br>";
        echo "- DB_NAME : " . DB_NAME . "<br>";
        echo "- DB_USER : " . DB_USER . "<br>";
        echo "- DB_PASS : " . (empty(DB_PASS) ? "(vide)" : "***") . "<br>";
    }
} catch(Exception $e) {
    echo "❌ Erreur : " . $e->getMessage() . "<br>";
}

// Test 5: Vérifier les répertoires Smarty
echo "<h2>5. Répertoires Smarty</h2>";
$dirs = ['templates', 'templates_c', 'cache'];
foreach ($dirs as $dir) {
    if (file_exists($dir) && is_dir($dir)) {
        $writable = is_writable($dir) ? "✅" : "⚠️";
        echo "$writable Répertoire '$dir' existe " . (is_writable($dir) ? "(accessible en écriture)" : "(non accessible en écriture)") . "<br>";
    } else {
        echo "❌ Répertoire '$dir' n'existe pas<br>";
    }
}

echo "<br><hr>";
echo "<h2>Résumé</h2>";
echo "<p>Si tous les tests sont ✅, votre système est prêt à fonctionner !</p>";
echo "<p><a href='index_blog.php'>→ Aller à la page d'accueil du blog</a></p>";
?>

