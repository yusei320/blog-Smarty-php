# Script PowerShell pour installer Smarty automatiquement
# Ce script télécharge et installe Smarty dans le dossier libs/

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Installation automatique de Smarty" -ForegroundColor Cyan
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
    Write-Host "Fichier trouvé: libs/Smarty/libs/Smarty.class.php" -ForegroundColor Green
    exit
}

Write-Host "Téléchargement de Smarty 4.5.0 depuis GitHub..." -ForegroundColor Yellow

$url = "https://github.com/smarty-php/smarty/archive/refs/tags/v4.5.0.tar.gz"
$tempDir = "temp_smarty_install"
$tarFile = "$tempDir\smarty.tar.gz"
$extractDir = "$tempDir\smarty-4.5.0"

# Créer le dossier temporaire
if (Test-Path $tempDir) {
    Remove-Item -Path $tempDir -Recurse -Force
}
New-Item -ItemType Directory -Path $tempDir | Out-Null

try {
    # Télécharger Smarty
    Write-Host "Téléchargement en cours..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $url -OutFile $tarFile -UseBasicParsing
    Write-Host "Téléchargement terminé!" -ForegroundColor Green
    
    # Extraire le fichier tar.gz
    Write-Host "Extraction de l'archive..." -ForegroundColor Yellow
    
    # Vérifier si tar est disponible (Windows 10+)
    $tarAvailable = Get-Command tar -ErrorAction SilentlyContinue
    
    if ($tarAvailable) {
        # Utiliser tar intégré de Windows
        Set-Location $tempDir
        tar -xzf smarty.tar.gz
        Set-Location ..
    } else {
        # Essayer avec Expand-Archive si c'est un ZIP, sinon erreur
        Write-Host "tar n'est pas disponible. Tentative avec une méthode alternative..." -ForegroundColor Yellow
        
        # Pour .tar.gz sous Windows sans tar, on peut utiliser 7-Zip ou télécharger directement un ZIP
        # Ici, on va essayer de télécharger depuis une source qui fournit un ZIP
        Write-Host "Téléchargement d'une version ZIP alternative..." -ForegroundColor Yellow
        
        # Télécharger directement depuis une release qui pourrait avoir un ZIP
        # Sinon, on informe l'utilisateur
        Write-Host "Erreur: Impossible d'extraire .tar.gz automatiquement." -ForegroundColor Red
        Write-Host "Veuillez installer 7-Zip ou utiliser Windows 10+ qui inclut tar." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Alternative: Téléchargez manuellement depuis:" -ForegroundColor Cyan
        Write-Host "https://github.com/smarty-php/smarty/releases/download/v4.5.0/smarty-4.5.0.zip" -ForegroundColor White
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
        exit 1
    }
    
    # Vérifier que l'extraction a réussi
    if (-not (Test-Path $extractDir)) {
        throw "L'extraction a échoué"
    }
    
    Write-Host "Extraction terminée!" -ForegroundColor Green
    
    # Déplacer le dossier vers libs/Smarty
    Write-Host "Installation dans libs/Smarty/..." -ForegroundColor Yellow
    
    $targetDir = "libs\Smarty"
    if (Test-Path $targetDir) {
        Remove-Item -Path $targetDir -Recurse -Force
    }
    
    Move-Item -Path $extractDir -Destination $targetDir
    
    # Nettoyer
    Remove-Item -Path $tempDir -Recurse -Force
    
    # Vérifier l'installation
    if (Test-Path "libs/Smarty/libs/Smarty.class.php") {
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Green
        Write-Host "Installation réussie!" -ForegroundColor Green
        Write-Host "========================================" -ForegroundColor Green
        Write-Host ""
        Write-Host "Smarty a été installé dans: libs/Smarty/" -ForegroundColor Green
        Write-Host "Fichier principal: libs/Smarty/libs/Smarty.class.php" -ForegroundColor Green
        Write-Host ""
        Write-Host "Vous pouvez maintenant utiliser votre blog!" -ForegroundColor Cyan
    } else {
        throw "L'installation semble avoir échoué. Le fichier Smarty.class.php n'a pas été trouvé."
    }
    
} catch {
    Write-Host ""
    Write-Host "Erreur: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Installation manuelle nécessaire:" -ForegroundColor Yellow
    Write-Host "1. Allez sur https://www.smarty.net/download" -ForegroundColor White
    Write-Host "2. Téléchargez Smarty 4.x" -ForegroundColor White
    Write-Host "3. Extrayez dans libs/Smarty/" -ForegroundColor White
    Write-Host "4. Vérifiez que libs/Smarty/libs/Smarty.class.php existe" -ForegroundColor White
    
    # Nettoyer en cas d'erreur
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
    exit 1
}

