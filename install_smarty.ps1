# Script PowerShell pour installer Smarty manuellement
# Ce script télécharge et installe Smarty dans le dossier libs/

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installation de Smarty" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier si le dossier libs existe
if (-not (Test-Path "libs")) {
    Write-Host "Création du dossier libs..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path "libs" | Out-Null
}

# Vérifier si Smarty est déjà installé
if (Test-Path "libs/Smarty/libs/Smarty.class.php") {
    Write-Host "Smarty est déjà installé dans libs/Smarty/" -ForegroundColor Green
    Write-Host "Pour réinstaller, supprimez d'abord le dossier libs/Smarty/" -ForegroundColor Yellow
    exit
}

Write-Host "Instructions pour installer Smarty manuellement:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Téléchargez Smarty depuis: https://www.smarty.net/download" -ForegroundColor White
Write-Host "2. Extrayez l'archive ZIP" -ForegroundColor White
Write-Host "3. Renommez le dossier extrait en 'Smarty' et placez-le dans le dossier 'libs/'" -ForegroundColor White
Write-Host "4. Vous devriez avoir: libs/Smarty/libs/Smarty.class.php" -ForegroundColor White
Write-Host ""
Write-Host "Structure attendue:" -ForegroundColor Cyan
Write-Host "  projectecole/" -ForegroundColor Gray
Write-Host "  ├── libs/" -ForegroundColor Gray
Write-Host "  │   └── Smarty/" -ForegroundColor Gray
Write-Host "  │       └── libs/" -ForegroundColor Gray
Write-Host "  │           └── Smarty.class.php" -ForegroundColor Green
Write-Host ""
Write-Host "Alternative: Vous pouvez aussi télécharger Smarty directement avec PowerShell:" -ForegroundColor Yellow
Write-Host ""
Write-Host '# Exemple de commande (ajustez la version):' -ForegroundColor Gray
Write-Host '# $url = "https://github.com/smarty-php/smarty/releases/download/v4.5.0/Smarty-4.5.0.tar.gz"' -ForegroundColor Gray
Write-Host '# Invoke-WebRequest -Uri $url -OutFile "smarty.tar.gz"' -ForegroundColor Gray
Write-Host ""

$continue = Read-Host "Voulez-vous que je tente de télécharger Smarty automatiquement? (O/N)"
if ($continue -eq "O" -or $continue -eq "o") {
    Write-Host ""
    Write-Host "Téléchargement de Smarty 4.5.0..." -ForegroundColor Yellow
    
    $url = "https://github.com/smarty-php/smarty/archive/refs/tags/v4.5.0.tar.gz"
    $zipFile = "smarty-temp.tar.gz"
    
    try {
        Invoke-WebRequest -Uri $url -OutFile $zipFile -UseBasicParsing
        Write-Host "Téléchargement terminé!" -ForegroundColor Green
        
        # Note: PowerShell natif ne peut pas décompresser .tar.gz facilement
        # L'utilisateur devra le faire manuellement ou installer 7-Zip
        Write-Host ""
        Write-Host "Le fichier a été téléchargé: $zipFile" -ForegroundColor Yellow
        Write-Host "Vous devez maintenant:" -ForegroundColor Yellow
        Write-Host "1. Décompresser $zipFile" -ForegroundColor White
        Write-Host "2. Renommer le dossier 'smarty-4.5.0' en 'Smarty'" -ForegroundColor White
        Write-Host "3. Déplacer 'Smarty' dans le dossier 'libs/'" -ForegroundColor White
        
    } catch {
        Write-Host "Erreur lors du téléchargement: $_" -ForegroundColor Red
        Write-Host "Veuillez télécharger Smarty manuellement depuis https://www.smarty.net/download" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "Veuillez installer Smarty manuellement selon les instructions ci-dessus." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Une fois Smarty installé, testez en ouvrant index_blog.php dans votre navigateur." -ForegroundColor Cyan

