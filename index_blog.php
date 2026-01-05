<?php
/**
 * Script d'affichage de la liste des billets (page d'accueil)
 */
require_once('config_blog.php');

$titre_page = "Mon blog";
$where_clause = "";
$categorie_filter = "";

// Vérification du paramètre catégorie
if (isset($_GET['categorie']) && !empty($_GET['categorie'])) {
    $categorie = trim($_GET['categorie']);
    $categorie = htmlspecialchars($categorie, ENT_QUOTES, 'UTF-8');
    $where_clause = "WHERE categorie = :categorie";
    $categorie_filter = $categorie;
    $titre_page = "Billets de la catégorie : " . $categorie;
}

try {
    // Récupération des billets
    $sql = "SELECT * FROM billets_blog " . $where_clause . " ORDER BY date_billet DESC";
    $stmt = $pdo->prepare($sql);
    
    if (!empty($categorie_filter)) {
        $stmt->execute([':categorie' => $categorie_filter]);
    } else {
        $stmt->execute();
    }
    
    $billets = $stmt->fetchAll();
    
    // Préparation des données pour le template
    $billets_array = [];
    foreach ($billets as $billet) {
        $billets_array[] = [
            'ID' => $billet['ID'],
            'titre' => htmlspecialchars($billet['titre'], ENT_QUOTES, 'UTF-8'),
            'annonce' => htmlspecialchars($billet['annonce'], ENT_QUOTES, 'UTF-8'),
            'date' => date('d/m/Y à H:i', strtotime($billet['date_billet'])),
            'categorie' => htmlspecialchars($billet['categorie'], ENT_QUOTES, 'UTF-8')
        ];
    }
    
    // Assignation des variables à Smarty
    $smarty->assign('titre', $titre_page);
    $smarty->assign('billets', $billets_array);
    $smarty->assign('categorie', $categorie_filter);
    
    // Affichage du template
    $smarty->display('index_blog.tpl');
    
} catch(PDOException $e) {
    die("Erreur : " . $e->getMessage());
}
?>

