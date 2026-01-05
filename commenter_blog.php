<?php
/**
 * Script d'ajout de commentaires
 * Ce script ne génère pas de HTML, il redirige après traitement
 */
require_once('config_blog.php');

// Vérification de la méthode POST
if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    header("Location: index_blog.php");
    exit();
}

// Récupération et validation des paramètres
$id_billet = isset($_POST['ID']) ? intval($_POST['ID']) : 0;
$nom = trim(isset($_POST['nom']) ? $_POST['nom'] : '');
$commentaire = trim(isset($_POST['commentaire']) ? $_POST['commentaire'] : '');

// Validation
if ($id_billet <= 0 || empty($nom) || empty($commentaire)) {
    header("Location: index_blog.php");
    exit();
}

try {
    // Vérification que le billet existe
    $stmt = $pdo->prepare("SELECT ID FROM billets_blog WHERE ID = :id");
    $stmt->execute([':id' => $id_billet]);
    $billet = $stmt->fetch();
    
    if (!$billet) {
        header("Location: index_blog.php");
        exit();
    }
    
    // Nettoyage des données
    $nom = htmlspecialchars($nom, ENT_QUOTES, 'UTF-8');
    $commentaire = htmlspecialchars($commentaire, ENT_QUOTES, 'UTF-8');
    
    // Insertion du commentaire (la date sera automatiquement ajoutée par MySQL grâce à TIMESTAMP DEFAULT CURRENT_TIMESTAMP)
    $stmt = $pdo->prepare("
        INSERT INTO commentaires_blog (nom, comment, ID)
        VALUES (:nom, :comment, :id)
    ");
    
    $stmt->execute([
        ':nom' => $nom,
        ':comment' => $commentaire,
        ':id' => $id_billet
    ]);
    
    // Redirection vers la page d'affichage du billet
    header("Location: afficher_blog.php?ID=" . $id_billet);
    exit();
    
} catch(PDOException $e) {
    // En cas d'erreur, redirection vers l'index
    header("Location: index_blog.php");
    exit();
}
?>

