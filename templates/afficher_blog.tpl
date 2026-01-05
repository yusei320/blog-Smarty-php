<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{$titre}</title>
    {literal}
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: #f5f5f7;
            color: #1d1d1f;
            line-height: 1.6;
        }
        
        .navbar {
            background: white;
            border-bottom: 1px solid #e5e5e7;
            padding: 20px 0;
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .navbar-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #1d1d1f;
            text-decoration: none;
        }
        
        .back-link {
            color: #6e6e73;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .back-link:hover {
            color: #1d1d1f;
        }
        
        .back-link::before {
            content: '← ';
        }
        
        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 60px 40px;
        }
        
        .article-header {
            margin-bottom: 40px;
        }
        
        .article-meta {
            display: flex;
            gap: 16px;
            align-items: center;
            margin-bottom: 24px;
        }
        
        .category-badge {
            background: #1d1d1f;
            color: white;
            padding: 6px 14px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 600;
        }
        
        .date-text {
            color: #6e6e73;
            font-size: 14px;
        }
        
        h1 {
            font-size: 56px;
            font-weight: 700;
            margin-bottom: 24px;
            letter-spacing: -0.02em;
            line-height: 1.1;
        }
        
        .article-content {
            background: white;
            border-radius: 16px;
            padding: 48px;
            margin-bottom: 40px;
            font-size: 17px;
            line-height: 1.8;
            color: #1d1d1f;
            white-space: pre-wrap;
        }
        
        .comments-section {
            background: white;
            border-radius: 16px;
            padding: 48px;
        }
        
        .comments-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            padding-bottom: 24px;
            border-bottom: 1px solid #e5e5e7;
        }
        
        .comments-title {
            font-size: 28px;
            font-weight: 700;
        }
        
        .comments-count {
            color: #6e6e73;
            font-size: 15px;
        }
        
        .comment-card {
            padding: 24px 0;
            border-bottom: 1px solid #e5e5e7;
        }
        
        .comment-card:last-child {
            border-bottom: none;
        }
        
        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
        }
        
        .comment-author {
            font-weight: 700;
            font-size: 15px;
            color: #1d1d1f;
        }
        
        .comment-date {
            color: #86868b;
            font-size: 13px;
        }
        
        .comment-text {
            color: #1d1d1f;
            font-size: 15px;
            line-height: 1.6;
        }
        
        .no-comments {
            text-align: center;
            padding: 60px 20px;
            color: #6e6e73;
        }
        
        .no-comments-icon {
            font-size: 48px;
            margin-bottom: 16px;
        }
        
        .btn-add-comment {
            background: #1d1d1f;
            color: white;
            padding: 14px 32px;
            border: none;
            border-radius: 24px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
            margin-top: 24px;
        }
        
        .btn-add-comment:hover {
            background: #424245;
            transform: translateY(-1px);
        }
        
        #formulaire_commentaire {
            display: none;
            margin-top: 32px;
            padding: 32px;
            background: #f5f5f7;
            border-radius: 16px;
        }
        
        #formulaire_commentaire.active {
            display: block;
            animation: fadeIn 0.3s ease;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .form-title {
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 24px;
        }
        
        .form-group {
            margin-bottom: 24px;
        }
        
        label {
            display: block;
            font-weight: 600;
            color: #1d1d1f;
            margin-bottom: 10px;
            font-size: 14px;
        }
        
        input[type="text"],
        textarea {
            width: 100%;
            padding: 14px 18px;
            border: 1px solid #d2d2d7;
            border-radius: 12px;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            font-size: 15px;
            transition: border-color 0.3s, box-shadow 0.3s;
            background: white;
        }
        
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #1d1d1f;
            box-shadow: 0 0 0 4px rgba(29, 29, 31, 0.05);
        }
        
        textarea {
            resize: vertical;
            min-height: 120px;
            line-height: 1.6;
        }
        
        .btn-submit {
            background: #1d1d1f;
            color: white;
            padding: 14px 32px;
            border: none;
            border-radius: 24px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
        }
        
        .btn-submit:hover {
            background: #424245;
            transform: translateY(-1px);
        }
        
        @media (max-width: 768px) {
            .navbar-container,
            .container {
                padding: 20px;
            }
            
            h1 {
                font-size: 36px;
            }
            
            .article-content,
            .comments-section {
                padding: 32px 24px;
            }
            
            #formulaire_commentaire {
                padding: 24px;
            }
            
            .comment-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 4px;
            }
        }
    </style>
    <script type="text/javascript">
        function afficher_commentaire() {
            const form = document.getElementById('formulaire_commentaire');
            const btn = document.getElementById('lien_commentaire');
            
            form.classList.add('active');
            btn.style.display = 'none';
            
            return false;
        }
    </script>
    {/literal}
</head>
<body>
    <nav class="navbar">
        <div class="navbar-container">
            <a href="index_blog.php" class="logo">Techvibe blog</a>
            <a href="index_blog.php" class="back-link">Retour au blog</a>
        </div>
    </nav>
    
    <div class="container">
        <article>
            <div class="article-header">
                <div class="article-meta">
                    <span class="category-badge">{$billet_categorie}</span>
                    <span class="date-text">{$billet_date}</span>
                </div>
                <h1>{$billet_titre}</h1>
            </div>
            
            <div class="article-content">
                {$billet_contenu}
            </div>
        </article>
        
        <section class="comments-section">
            <div class="comments-header">
                <h2 class="comments-title">Commentaires</h2>
                {if $commentaires}
                    <span class="comments-count">{$commentaires|@count} commentaire(s)</span>
                {/if}
            </div>
            
            {if $commentaires}
                {section name=comment loop=$commentaires}
                    <div class="comment-card">
                        <div class="comment-header">
                            <span class="comment-author">{$commentaires[comment].nom}</span>
                            <span class="comment-date">{$commentaires[comment].date}</span>
                        </div>
                        <div class="comment-text">{$commentaires[comment].comment}</div>
                    </div>
                {/section}
            {else}
                <div class="no-comments">
                    <div class="no-comments-icon">💬</div>
                    <p>Aucun commentaire pour le moment.</p>
                    <p>Soyez le premier à partager votre avis !</p>
                </div>
            {/if}
            
            <button id="lien_commentaire" class="btn-add-comment" onclick="return afficher_commentaire();">
                Ajouter un commentaire
            </button>
            
            <div id="formulaire_commentaire">
                <h3 class="form-title">Laisser un commentaire</h3>
                <form method="post" action="commenter_blog.php">
                    <input type="hidden" name="ID" value="{$billet_id}" />
                    
                    <div class="form-group">
                        <label for="nom">Votre nom</label>
                        <input type="text" id="nom" name="nom" placeholder="Jean Dupont" required />
                    </div>
                    
                    <div class="form-group">
                        <label for="commentaire">Votre commentaire</label>
                        <textarea id="commentaire" name="commentaire" placeholder="Partagez votre avis..." required></textarea>
                    </div>
                    
                    <button type="submit" class="btn-submit">
                        Publier le commentaire
                    </button>
                </form>
            </div>
        </section>
    </div>
</body>
</html>