<?php
/**
 * Script d'édition et de création de billets
 */
require_once('config_blog.php');

$titre_page = "Nouveau billet";
$message = "";

// Si le formulaire est soumis
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['submit'])) {
    // Récupération et nettoyage des données
    $titre = trim(isset($_POST['titre']) ? $_POST['titre'] : '');
    $contenu = trim(isset($_POST['contenu']) ? $_POST['contenu'] : '');
    $categorie = trim(isset($_POST['categorie']) ? $_POST['categorie'] : '');
    
    // Validation des champs
    if (empty($titre) || empty($contenu) || empty($categorie)) {
        $message = "Tous les champs sont obligatoires.";
    } else {
        // Nettoyage des données (protection contre XSS)
        $titre = htmlspecialchars($titre, ENT_QUOTES, 'UTF-8');
        $contenu = htmlspecialchars($contenu, ENT_QUOTES, 'UTF-8');
        $categorie = htmlspecialchars($categorie, ENT_QUOTES, 'UTF-8');
        
        // Génération de l'annonce (extrait sans balises HTML, limité à 200 caractères)
        $annonce = strip_tags($contenu);
        $annonce = substr($annonce, 0, 200);
        if (strlen(strip_tags($contenu)) > 200) {
            $annonce .= '...';
        }
        
        // Date actuelle
        $date_billet = date('Y-m-d H:i:s');
        
        try {
            // Insertion dans la base de données
            $stmt = $pdo->prepare("
                INSERT INTO billets_blog (titre, contenu, annonce, date_billet, categorie)
                VALUES (:titre, :contenu, :annonce, :date_billet, :categorie)
            ");
            
            $stmt->execute([
                ':titre' => $titre,
                ':contenu' => $contenu,
                ':annonce' => $annonce,
                ':date_billet' => $date_billet,
                ':categorie' => $categorie
            ]);
            
            // Récupération de l'ID du billet créé
            $id_billet = $pdo->lastInsertId();
            
            // Redirection vers la page d'affichage du billet
            header("Location: afficher_blog.php?ID=" . $id_billet);
            exit();
            
        } catch(PDOException $e) {
            $message = "Erreur lors de l'ajout du billet : " . $e->getMessage();
        }
    }
}

// Assignation des variables à Smarty
$smarty->assign('titre', $titre_page);
$smarty->assign('message', $message);

// Affichage du template
$smarty->display('edition_blog.tpl');
?>

