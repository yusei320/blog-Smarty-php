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
            max-width: 1200px;
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
        
        .nav-links {
            display: flex;
            gap: 30px;
            align-items: center;
        }
        
        .nav-links a {
            color: #6e6e73;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .nav-links a:hover {
            color: #1d1d1f;
        }
        
        .btn-new {
            background: #1d1d1f;
            color: white;
            padding: 10px 24px;
            border-radius: 24px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: background 0.3s;
        }
        
        .btn-new:hover {
            background: #424245;
        }
        
        .hero {
            max-width: 1200px;
            margin: 0 auto;
            padding: 60px 40px 40px;
        }
        
        .hero-title {
            font-size: 56px;
            font-weight: 700;
            margin-bottom: 20px;
            letter-spacing: -0.02em;
        }
        
        .hero-subtitle {
            font-size: 18px;
            color: #6e6e73;
            margin-bottom: 30px;
            max-width: 600px;
        }
        
        .subscribe-form {
            display: flex;
            gap: 10px;
            margin-bottom: 40px;
        }
        
        .subscribe-form input {
            flex: 1;
            max-width: 300px;
            padding: 12px 20px;
            border: 1px solid #d2d2d7;
            border-radius: 24px;
            font-size: 14px;
            outline: none;
            transition: border-color 0.3s;
        }
        
        .subscribe-form input:focus {
            border-color: #1d1d1f;
        }
        
        .subscribe-form button {
            background: #1d1d1f;
            color: white;
            padding: 12px 32px;
            border: none;
            border-radius: 24px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s;
        }
        
        .subscribe-form button:hover {
            background: #424245;
        }
        
        .filters {
            display: flex;
            gap: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #e5e5e7;
            margin-bottom: 40px;
            overflow-x: auto;
        }
        
        .filter-item {
            color: #6e6e73;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            white-space: nowrap;
            padding-bottom: 8px;
            border-bottom: 2px solid transparent;
            transition: all 0.3s;
        }
        
        .filter-item:hover,
        .filter-item.active {
            color: #1d1d1f;
            border-bottom-color: #1d1d1f;
        }
        
        .filtre-badge {
            background: #f5f5f7;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            color: #6e6e73;
            margin-bottom: 30px;
            display: inline-block;
        }
        
        .filtre-badge a {
            color: #1d1d1f;
            text-decoration: none;
            font-weight: 600;
            margin-left: 8px;
        }
        
        .blog-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(500px, 1fr));
            gap: 30px;
            margin-bottom: 60px;
        }
        
        .blog-card {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer;
        }
        
        .blog-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 20px 40px rgba(0,0,0,0.08);
        }
        
        .blog-image {
            width: 100%;
            height: 280px;
            background: linear-gradient(135deg, #f5f5f7 0%, #e5e5e7 100%);
            position: relative;
            overflow: hidden;
        }
        
        .blog-image::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 100px;
            background: linear-gradient(to bottom, transparent, rgba(0,0,0,0.3));
        }
        
        .blog-meta-overlay {
            position: absolute;
            bottom: 16px;
            left: 16px;
            right: 16px;
            z-index: 1;
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            color: white;
        }
        
        .author-info {
            font-size: 13px;
            font-weight: 500;
        }
        
        .category-badge {
            background: white;
            color: #1d1d1f;
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .blog-content {
            padding: 24px;
        }
        
        .blog-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 12px;
            letter-spacing: -0.01em;
        }
        
        .blog-title a {
            color: #1d1d1f;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .blog-title a:hover {
            color: #6e6e73;
        }
        
        .blog-excerpt {
            color: #6e6e73;
            font-size: 15px;
            line-height: 1.6;
            margin-bottom: 16px;
        }
        
        .read-more {
            color: #1d1d1f;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: gap 0.3s;
        }
        
        .read-more:hover {
            gap: 10px;
        }
        
        .read-more::after {
            content: '→';
        }
        
        .no-posts {
            text-align: center;
            padding: 80px 20px;
        }
        
        .no-posts h3 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        
        .no-posts p {
            color: #6e6e73;
            font-size: 16px;
        }
        
        .no-posts a {
            color: #1d1d1f;
            text-decoration: none;
            font-weight: 600;
        }
        
        footer {
            background: white;
            border-top: 1px solid #e5e5e7;
            padding: 40px 0;
            margin-top: 80px;
        }
        
        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 40px;
            text-align: center;
        }
        
        .footer-text {
            color: #6e6e73;
            font-size: 13px;
        }
        
        @media (max-width: 768px) {
            .hero-title {
                font-size: 36px;
            }
            
            .blog-grid {
                grid-template-columns: 1fr;
            }
            
            .navbar-container {
                padding: 0 20px;
            }
            
            .hero {
                padding: 40px 20px 20px;
            }
            
            .nav-links {
                display: none;
            }
        }
    </style>
    {/literal}
</head>
<body>
    <nav class="navbar">
        <div class="navbar-container">
            <a href="index_blog.php" class="logo">Techvibe blog</a>
            <div class="nav-links">
                <a href="index_blog.php">Accueil</a>
                <a href="editer_blog.php" class="btn-new">Nouveau billet</a>
            </div>
        </div>
    </nav>
    
    <div class="hero">
        <h1 class="hero-title">Techvibe Blog</h1>
        <p class="hero-subtitle">
            Nouvelles fonctionnalités, les dernières nouveautés en technologie, solutions et mises à jour.
        </p>
        
        <form class="subscribe-form">
            <input type="email" placeholder="Entrez votre email" />
            <button type="submit">S'abonner</button>
        </form>
        
        <div class="filters">
            <a href="index_blog.php" class="filter-item {if !$categorie}active{/if}">Tous</a>
            <a href="index_blog.php?categorie=Design" class="filter-item {if $categorie == 'Design'}active{/if}">Design</a>
            <a href="index_blog.php?categorie=Produit" class="filter-item {if $categorie == 'Produit'}active{/if}">Produit</a>
            <a href="index_blog.php?categorie=Développement" class="filter-item {if $categorie == 'Développement'}active{/if}">Développement</a>
            <a href="index_blog.php?categorie=Support" class="filter-item {if $categorie == 'Support'}active{/if}">Support</a>
        </div>
        
        {if $categorie}
            <div class="filtre-badge">
                Filtre actif : <strong>{$categorie}</strong>
                <a href="index_blog.php">✕</a>
            </div>
        {/if}
        
        {if $billets}
            <div class="blog-grid">
                {section name=billet loop=$billets}
                    <article class="blog-card">
                        <div class="blog-image">
                            <div class="blog-meta-overlay">
                                <div class="author-info">
                                    <div>{$billets[billet].date}</div>
                                </div>
                                <div class="category-badge">{$billets[billet].categorie}</div>
                            </div>
                        </div>
                        <div class="blog-content">
                            <h2 class="blog-title">
                                <a href="afficher_blog.php?ID={$billets[billet].ID}">
                                    {$billets[billet].titre}
                                </a>
                            </h2>
                            <p class="blog-excerpt">
                                {$billets[billet].annonce}
                            </p>
                            <a href="afficher_blog.php?ID={$billets[billet].ID}" class="read-more">
                                Lire l'article
                            </a>
                        </div>
                    </article>
                {/section}
            </div>
        {else}
            <div class="no-posts">
                <h3>Aucun billet trouvé</h3>
                <p>
                    {if $categorie}
                        <a href="index_blog.php">Voir tous les billets</a>
                    {else}
                        Commencez par créer votre premier billet
                    {/if}
                </p>
            </div>
        {/if}
    </div>
    
    <footer>
        <div class="footer-content">
            <p class="footer-text">© 2026 Techvibe blog. Tous droits réservés a christ.</p>
        </div>
    </footer>
</body>
</html>