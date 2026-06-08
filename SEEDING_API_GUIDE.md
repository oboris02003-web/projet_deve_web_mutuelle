# 🌱 Guide d'Utilisation du Seeding API

## 📋 Vue d'ensemble

L'API de seeding vous permet d'ajouter **150+ données de test** à votre instance Railway avec une simple requête HTTP POST.

### ✨ Ce que le seeding crée :
- **20 adhérents** avec profils complets et diversifiés
- **70 cotisations** distribuées sur les 12 derniers mois
- **20 prêts** avec remboursements et intérêts variés
- **40 sinistres** (2 par adhérent) avec différents statuts
- **20 ayants droits** liés aux adhérents

**Résultat** : Graphes remplis, tableaux de bord fonctionnels, et données réalistes pour les tests.

---

## 🚀 Méthode 1 : Via Script Bash (Linux/Mac/WSL)

### Étape 1 : Obtenir votre token admin

1. Allez sur **https://projetdevewebmutuelle-production.up.railway.app/login.html**
2. Connectez-vous avec vos identifiants admin
3. Ouvrez la **console du navigateur** : `F12` → `Console`
4. Tapez et exécutez :
   ```javascript
   localStorage.getItem('token')
   ```
5. Copiez la valeur (c'est une longue chaîne de caractères)

### Étape 2 : Exécuter le script

```bash
# Terminal / WSL
bash railway-seed.sh "votre-token-ici"
```

**Exemple** :
```bash
bash railway-seed.sh "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

### ✅ Résultat attendu :

```json
{
  "success": true,
  "message": "Données de test semées avec succès !",
  "stats": {
    "adherents": 20,
    "cotisations": 70,
    "prets": 20,
    "sinistres": 40,
    "ayants_droits": 20
  },
  "total": 170
}
```

---

## 🟦 Méthode 2 : Via Script PowerShell (Windows)

### Étape 1 : Obtenir votre token admin

*(Même procédure que ci-dessus)*

### Étape 2 : Exécuter le script

```powershell
# PowerShell
.\railway-seed.bat "votre-token-ici"
```

---

## 🌐 Méthode 3 : Via CURL (Ligne de commande)

```bash
# Remplacez YOUR_TOKEN par votre token réel
TOKEN="votre-token-ici"

curl -X POST \
  https://projetdevewebmutuelle-production.up.railway.app/api/admin/seed-test-data \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -H "X-Seed-Key: $(date +%s)" \
  -v
```

---

## 📱 Méthode 4 : Via Postman

1. Ouvrez **Postman**
2. Créez une nouvelle requête **POST**
3. URL : `https://projetdevewebmutuelle-production.up.railway.app/api/admin/seed-test-data`
4. Onglet **Headers** :
   - `Authorization: Bearer votre-token-ici`
   - `Content-Type: application/json`
   - `X-Seed-Key: 1234567890` (timestamp)
5. Cliquez **Send**

---

## 🔒 Sécurité

- ✅ L'endpoint nécessite une authentification JWT valide
- ✅ Le token doit appartenir à un utilisateur **admin** ou **agent**
- ✅ Un header `X-Seed-Key` optionnel peut être validé (configurable via `SEED_KEY` en `.env`)

---

## 📊 Vérifier le Résultat

Après le seeding, accédez au **Dashboard** :

```
https://projetdevewebmutuelle-production.up.railway.app/dashboard.html
```

### Vérifiez que :

✅ **Graphique "Évolution des cotisations"**
- Doit afficher une courbe avec 6-12 mois de données
- Les montants doivent être entre 5,000 et 30,000 FCFA

✅ **Graphique "Statistiques Cotisations"**
- Deve afficher les montants mensuels et le taux de recouvrement
- Moyenne montant devrait être ~17,500 FCFA

✅ **Graphique "Répartition Sinistres"**
- Doit afficher les types de sinistres (Hospitalisation, Accident, etc.)
- Environ 40 sinistres répartis

✅ **Tableau des Adhérents**
- Doit afficher les 20 nouveaux adhérents
- Numéros : ADH-3000 à ADH-3019

✅ **Tableau des Cotisations**
- Doit afficher les 70 cotisations
- Mix de statuts "payée" et "impayée"

✅ **Historique**
- Doit afficher les 100 derniers événements (inscriptions, cotisations, prêts, sinistres)

---

## ⚙️ Configuration Avancée

### Personnaliser la clé de seed (pour la sécurité)

Éditez le fichier `.env` sur Railway :

```env
SEED_KEY=ma-clé-secrète-complexe-xyz
```

Puis mettez à jour le header de votre requête :
```bash
-H "X-Seed-Key: ma-clé-secrète-complexe-xyz"
```

### Modifier les quantités

Pour modifier le nombre de données générées, éditez [SeedController.php](backend/app/Http/Controllers/SeedController.php) :

```php
// Changer le nombre d'adhérents (ligne 43)
for ($i = 0; $i < 50; $i++) {  // Au lieu de 20

// Changer le nombre de cotisations par adhérent (ligne 60)
$nbCot = rand(5, 8);  // Au lieu de 3-4
```

---

## 🔄 Réinitialiser les Données

Si vous voulez **recommencer** :

1. **Connectez-vous à Railway Database** (PostgreSQL)
2. **Exécutez le SQL** :
   ```sql
   TRUNCATE TABLE remboursement_prets;
   TRUNCATE TABLE ayant_droits;
   TRUNCATE TABLE sinistres;
   TRUNCATE TABLE prets;
   TRUNCATE TABLE cotisations;
   TRUNCATE TABLE adherents;
   
   -- Réinitialiser les séquences ID
   ALTER SEQUENCE adherents_id_seq RESTART WITH 1;
   ALTER SEQUENCE cotisations_id_seq RESTART WITH 1;
   ALTER SEQUENCE prets_id_seq RESTART WITH 1;
   ALTER SEQUENCE sinistres_id_seq RESTART WITH 1;
   ALTER SEQUENCE ayant_droits_id_seq RESTART WITH 1;
   ```
3. **Relancez le seeding** via l'une des méthodes ci-dessus

---

## 🐛 Troubleshooting

### ❌ Erreur : "401 Unauthorized"
- **Cause** : Token invalide ou expiré
- **Solution** : 
  1. Reconnectez-vous au dashboard
  2. Récupérez un nouveau token via `localStorage.getItem('token')`
  3. Réessayez

### ❌ Erreur : "403 Forbidden"
- **Cause** : Votre compte n'est pas admin/agent
- **Solution** : Utilisez un compte **admin** pour vous connecter

### ❌ Erreur : "404 Not Found"
- **Cause** : Railway n'a pas le code à jour
- **Solution** : 
  1. Vérifiez que le dernier commit a été pushé
  2. Attendez 2-3 min que Railway redéploie
  3. Réessayez

### ❌ Les données ne s'affichent pas après seeding
- **Cause** : Le dashboard peut être en cache
- **Solution** : 
  1. Appuyez sur `F5` ou `Ctrl+Shift+R` (hard refresh)
  2. Nettoyez le cache du navigateur
  3. Réessayez

### ❌ Seeding échoue sans message d'erreur
- **Cause** : Problème de base de données
- **Solution** :
  1. Vérifiez que Railway est en ligne
  2. Attendez quelques minutes
  3. Relancez le seeding

---

## 📞 Support

Si vous rencontrez des problèmes :

1. **Vérifiez les logs Railway** : 
   - Allez sur https://railway.app → Deployments → Logs
   
2. **Vérifiez la console du navigateur** (F12 → Console)

3. **Vérifiez le statut de l'API** :
   ```bash
   curl https://projetdevewebmutuelle-production.up.railway.app/api
   ```

4. **Contactez l'équipe de support** avec :
   - Token utilisé (masquez la première moitié)
   - Message d'erreur exact
   - Logs de Railway (dernières 10 lignes)

---

## 📝 Notes Importantes

- ✅ Le seeding est **idempotent** - vous pouvez l'exécuter plusieurs fois sans problème (il ajoute juste de nouvelles données)
- ✅ Le seeding respecte les **relations de clés étrangères**
- ✅ Les données sont **réalistes** avec dates distribuées sur 12-36 mois
- ✅ Les montants respectent les **gammes typiques** pour une mutuelle
- ✅ Aucune donnée sensible n'est exposée (mots de passe hachés)

---

**Dernière mise à jour** : Commit `0767ac9`

