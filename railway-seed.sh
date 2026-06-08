#!/bin/bash
# Script to seed test data on Railway via API
# Usage: bash railway-seed.sh

RAILWAY_URL="https://projetdevewebmutuelle-production.up.railway.app"
ADMIN_TOKEN="${1:-}"

echo "🌱 Démarrage du seeding sur Railway..."
echo ""

if [ -z "$ADMIN_TOKEN" ]; then
    echo "❌ Erreur: Token admin requis"
    echo "Usage: bash railway-seed.sh <admin_token>"
    echo ""
    echo "Pour obtenir le token:"
    echo "  1. Connectez-vous comme admin sur $RAILWAY_URL/login.html"
    echo "  2. Ouvrez la console du navigateur (F12 → Console)"
    echo "  3. Tapez: localStorage.getItem('token')"
    echo "  4. Copiez le token et passez-le à ce script"
    exit 1
fi

echo "🔗 Appel de l'API: $RAILWAY_URL/api/admin/seed-test-data"
echo "🔐 Token: ${ADMIN_TOKEN:0:20}..."
echo ""

curl -X POST "$RAILWAY_URL/api/admin/seed-test-data" \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -H "X-Seed-Key: $(date +%s)" \
  -H "Content-Type: application/json" \
  -w "\n\n%{http_code}\n" \
  2>&1

echo ""
echo "✅ Requête envoyée!"
