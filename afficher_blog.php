<?php
/**
 * Script d'affichage d'un billet individuel avec ses commentaires
 */
require_once('config_blog.php');

// Vérification du paramètre ID
if (!isset($_GET['ID']) || !is_numeric($_GET['ID'])) {
    header("Location: index_blog.php");
    exit();
}

$id_billet = intval($_GET['ID']);

try {
    // Récupération du billet
    $stmt = $pdo->prepare("SELECT * FROM billets_blog WHERE ID = :id");
    $stmt->execute([':id' => $id_billet]);
    $billet = $stmt->fetch();
    
    if (!$billet) {
        header("Location: index_blog.php");
        exit();
    }
    
    // Récupération des commentaires pour ce billet
    $stmt_commentaires = $pdo->prepare("
        SELECT * FROM commentaires_blog 
        WHERE ID = :id 
        ORDER BY date_comment ASC
    ");
    $stmt_commentaires->execute([':id' => $id_billet]);
    $commentaires = $stmt_commentaires->fetchAll();
    
    // Préparation des données pour le template
    $commentaires_array = [];
    foreach ($commentaires as $comment) {
        $commentaires_array[] = [
            'nom' => htmlspecialchars($comment['nom'], ENT_QUOTES, 'UTF-8'),
            'date' => date('d/m/Y à H:i', strtotime($comment['date_comment'])),
            'comment' => nl2br(htmlspecialchars($comment['comment'], ENT_QUOTES, 'UTF-8'))
        ];
    }
    
    // Assignation des variables à Smarty
    $smarty->assign('titre', htmlspecialchars($billet['titre'], ENT_QUOTES, 'UTF-8'));
    $smarty->assign('billet_titre', htmlspecialchars($billet['titre'], ENT_QUOTES, 'UTF-8'));
    $smarty->assign('billet_contenu', nl2br(htmlspecialchars($billet['contenu'], ENT_QUOTES, 'UTF-8')));
    $smarty->assign('billet_date', date('d/m/Y à H:i', strtotime($billet['date_billet'])));
    $smarty->assign('billet_categorie', htmlspecialchars($billet['categorie'], ENT_QUOTES, 'UTF-8'));
    $smarty->assign('billet_id', $billet['ID']);
    $smarty->assign('commentaires', $commentaires_array);
    
    // Affichage du template
    $smarty->display('afficher_blog.tpl');
    
} catch(PDOException $e) {
    die("Erreur : " . $e->getMessage());
}
?>

