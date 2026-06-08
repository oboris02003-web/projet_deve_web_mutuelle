@echo off
REM Script to seed test data on Railway via API
REM Usage: railway-seed.bat <admin_token>

setlocal enabledelayedexpansion

set RAILWAY_URL=https://projetdevewebmutuelle-production.up.railway.app
set ADMIN_TOKEN=%1

echo 🌱 Démarrage du seeding sur Railway...
echo.

if "!ADMIN_TOKEN!"=="" (
    echo ❌ Erreur: Token admin requis
    echo Usage: railway-seed.bat ^<admin_token^>
    echo.
    echo Pour obtenir le token:
    echo   1. Connectez-vous comme admin sur !RAILWAY_URL!/login.html
    echo   2. Ouvrez la console du navigateur (F12 → Console^)
    echo   3. Tapez: localStorage.getItem('token'^)
    echo   4. Copiez le token et passez-le à ce script
    exit /b 1
)

echo 🔗 Appel de l'API: !RAILWAY_URL!/api/admin/seed-test-data
echo 🔐 Token: !ADMIN_TOKEN:~0,20!...
echo.

powershell -Command "^
$headers = @{ ^
    'Authorization' = 'Bearer !ADMIN_TOKEN!'; ^
    'X-Seed-Key' = [int][double]::Parse((Get-Date -UFormat %%s)); ^
    'Content-Type' = 'application/json' ^
}; ^
$response = Invoke-WebRequest -Uri '!RAILWAY_URL!/api/admin/seed-test-data' -Method POST -Headers $headers; ^
Write-Host $response.Content; ^
Write-Host ('HTTP ' + $response.StatusCode)^
"

echo.
echo ✅ Requête envoyée!
