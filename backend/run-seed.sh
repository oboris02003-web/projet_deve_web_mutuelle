#!/bin/bash
# Script to seed test data into the Railway database
# Usage: bash backend/run-seed.sh

echo "🌱 Démarrage du seeding des données de test..."
echo ""

cd "$(dirname "$0")/.."

# Vérifier si on est en production (Railway)
if [ -f "/.dockerenv" ]; then
    echo "✅ Environnement détecté: Docker (Railway)"
    php backend/seed-test-data.php
else
    echo "✅ Environnement détecté: Local"
    php backend/seed-test-data.php
fi

echo ""
echo "✅ Seeding complété!"
