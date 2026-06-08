# 🌱 Script de Seeding - Données de Test

Ce script ajoute des données de test à la base de données pour que vous puissiez visualiser les graphes et tester la plateforme avec des données réalistes.

## 📊 Données Ajoutées

Le script crée automatiquement :
- **20 adhérents** avec profils complets
- **70 cotisations** distribuées sur les 12 derniers mois
- **20 prêts** avec remboursements variés
- **40 sinistres** avec états différents
- **20 ayants droits** liés aux adhérents

## 🚀 Comment Utiliser

### Localement (Windows)

```powershell
# Accédez au répertoire du projet
cd c:\Site-Web-Startup-security-git\projet_deve_web_mutuelle

# Exécutez le script
php backend/seed-test-data.php
```

Ou directement :
```bash
backend\run-seed.bat
```

### Localement (Linux/Mac)

```bash
# Accédez au répertoire du projet
cd ~/projet_deve_web_mutuelle

# Exécutez le script
php backend/seed-test-data.php
```

Ou :
```bash
bash backend/run-seed.sh
```

### Sur Railway

Via SSH dans le conteneur Railway :
```bash
php backend/seed-test-data.php
```

Ou via curl si une route est exposée (à créer) :
```bash
curl -X POST https://projetdevewebmutuelle-production.up.railway.app/api/seed
```

## 📈 Résultats Attendus

Après exécution, vous verrez :

```
🌱 Démarrage du seeding des données de test...

📝 Création de 20 adhérents...
  ✓ Traore Moussa (ADH-3000)
  ✓ Diallo Fatimata (ADH-3001)
  ...

💰 Création de 70 cotisations...
  ✓ 70 cotisations créées

🏦 Création de 20 prêts...
  ✓ 20 prêts créés

🆘 Création de 40 sinistres...
  ✓ 40 sinistres créés

👨‍👩‍👧 Création de 20 ayants droits...
  ✓ 20 ayants droits créés

✅ Seeding complété avec succès !
```

## 📊 Vérification des Données

Après seeding, allez sur le dashboard et vérifiez :

1. **Graphique "Évolution des cotisations"** - Devrait afficher une courbe avec 6-12 mois de données
2. **Graphique "Statistiques Cotisations"** - Devrait afficher les montants mensuels et le taux de recouvrement
3. **Graphique "Répartition Sinistres"** - Devrait afficher la répartition des sinistres
4. **Tableau des Adhérents** - Devrait afficher les 20 nouveaux adhérents
5. **Tableau des Cotisations** - Devrait afficher les 70 cotisations

## ⚙️ Personnalisation

Pour modifier les quantités, éditez les variables dans `backend/seed-test-data.php` :

```php
// Nombre d'adhérents
for ($i = 0; $i < 20; $i++) {  // Changer 20

// Cotisations par adhérent
for ($j = 0; $j < $nbCot; $j++) {  // Changer le nombre
```

## 🔄 Réappliquer le Seed

Le script ajoute toujours les données. Si vous voulez recommencer :

1. **Vider la base de données** :
```sql
TRUNCATE TABLE remboursement_prets;
TRUNCATE TABLE ayant_droits;
TRUNCATE TABLE sinistres;
TRUNCATE TABLE prets;
TRUNCATE TABLE cotisations;
TRUNCATE TABLE adherents;
ALTER SEQUENCE adherents_id_seq RESTART WITH 1;
```

2. **Puis relancer le seed** :
```bash
php backend/seed-test-data.php
```

## 📝 Notes

- Les dates sont distribuées sur les 12-36 derniers mois pour des données réalistes
- Les montants respectent les gammes typiques pour une mutuelle
- Les statuts des entités sont variés (payé, en retard, approuvé, remboursé, etc.)
- Les numéros de téléphone et emails sont générés automatiquement

## ❓ Troubleshooting

**Erreur: "class not found"**
- Vérifiez que vous êtes dans le répertoire racine du projet
- Vérifiez que Composer a installé les dépendances : `composer install`

**Erreur: "Connection refused"**
- Vérifiez que la base de données est accessible
- Vérifiez les variables d'environnement `.env`

**Erreur: "Syntax error"**
- Vérifiez que PHP 8.0+ est installé
- Vérifiez la version de Laravel (doit être 11+)
