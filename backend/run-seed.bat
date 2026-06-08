@echo off
REM Script to seed test data into the Railway database
REM Usage: run-seed.bat

echo 🌱 Démarrage du seeding des données de test...
echo.

cd /d "%~dp0.."

php backend/seed-test-data.php

if %errorlevel% equ 0 (
    echo.
    echo ✅ Seeding complété!
) else (
    echo.
    echo ❌ Erreur lors du seeding
    exit /b %errorlevel%
)
