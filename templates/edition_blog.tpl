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
            margin: 60px auto;
            padding: 0 40px;
        }
        
        .form-card {
            background: white;
            border-radius: 16px;
            padding: 48px;
        }
        
        h1 {
            font-size: 48px;
            font-weight: 700;
            margin-bottom: 40px;
            letter-spacing: -0.02em;
        }
        
        .message {
            background: #fff3cd;
            border: 1px solid #ffc107;
            color: #856404;
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 32px;
            font-size: 14px;
        }
        
        .form-group {
            margin-bottom: 32px;
        }
        
        label {
            display: block;
            font-weight: 600;
            color: #1d1d1f;
            margin-bottom: 10px;
            font-size: 15px;
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
            min-height: 300px;
            line-height: 1.7;
        }
        
        .form-hint {
            font-size: 13px;
            color: #6e6e73;
            margin-top: 8px;
        }
        
        .btn-group {
            display: flex;
            gap: 16px;
            margin-top: 40px;
        }
        
        .btn-submit {
            background: #1d1d1f;
            color: white;
            padding: 14px 40px;
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
        
        .btn-submit:active {
            transform: translateY(0);
        }
        
        .btn-cancel {
            background: transparent;
            color: #6e6e73;
            padding: 14px 40px;
            border: 1px solid #d2d2d7;
            border-radius: 24px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-cancel:hover {
            border-color: #1d1d1f;
            color: #1d1d1f;
        }
        
        @media (max-width: 768px) {
            .navbar-container,
            .container {
                padding: 0 20px;
            }
            
            .form-card {
                padding: 32px 24px;
            }
            
            h1 {
                font-size: 36px;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .btn-submit,
            .btn-cancel {
                width: 100%;
                text-align: center;
            }
        }
    </style>
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
        <div class="form-card">
            <h1>Nouveau billet</h1>
            
            {if $message}
                <div class="message">⚠️ {$message}</div>
            {/if}
            
            <form method="post" action="editer_blog.php">
                <div class="form-group">
                    <label for="titre">Titre</label>
                    <input 
                        type="text" 
                        id="titre" 
                        name="titre" 
                        placeholder="Entrez un titre accrocheur pour votre billet..." 
                        required 
                    />
                    <p class="form-hint">Choisissez un titre clair et engageant</p>
                </div>
                
                <div class="form-group">
                    <label for="contenu">Contenu</label>
                    <textarea 
                        id="contenu" 
                        name="contenu" 
                        placeholder="Écrivez votre article ici..." 
                        required
                    ></textarea>
                    <p class="form-hint">Partagez vos idées, expériences ou connaissances</p>
                </div>
                
                <div class="form-group">
                    <label for="categorie">Catégorie</label>
                    <input 
                        type="text" 
                        id="categorie" 
                        name="categorie" 
                        placeholder="Ex: Design, Technologie, Voyages..." 
                        required 
                    />
                    <p class="form-hint">Aidez les lecteurs à trouver votre contenu</p>
                </div>
                
                <div class="btn-group">
                    <button type="submit" name="submit" class="btn-submit">
                        Publier le billet
                    </button>
                    <a href="index_blog.php" class="btn-cancel">
                        Annuler
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>