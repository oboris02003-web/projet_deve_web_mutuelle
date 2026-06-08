# 🌱 Guide Utilisation du Script SQL de Seeding

## 📝 Résumé

Le fichier `database/seed-test-data.sql` contient **toutes les données** que tu dois ajouter :
- ✅ **20 adhérents** (ADH-3000 à ADH-3019)
- ✅ **70 cotisations** distribuées sur les 12 derniers mois
- ✅ **20 prêts** avec remboursements
- ✅ **40 sinistres** (2 par adhérent)
- ✅ **20 ayants droits**
- ✅ **Remboursements de prêts** liés

---

## 🚀 Comment Exécuter sur Railway

### **Méthode 1️⃣ : Avec pgAdmin (Plus Facile)**

1. **Ouvre pgAdmin** → Connecte-toi à ta base Railway
   - URL : https://pgadmin.railway.app (ou ton URL pgAdmin)
   - Utilisateur/Mot de passe : Tes identifiants

2. **Localise ta base de données**
   - Left sidebar → Servers → Railway (ou le nom de ton serveur)
   - Double-clic pour développer
   - Trouve la base `projet_deve_web_mutuelle` (ou similaire)

3. **Ouvre l'éditeur SQL**
   - Clic droit sur la base → **Query Tool**
   - Ou en haut : **Tools** → **Query Tool**

4. **Copie-colle le script**
   - Ouvre `database/seed-test-data.sql`
   - Copie **tout le contenu** (Ctrl+A)
   - Colle dans l'éditeur SQL de pgAdmin

5. **Exécute**
   - Clic sur **Execute** (ou F5)
   - Attend quelques secondes...

6. **Vérification**
   - Tu dois voir un message "Query returned successfully"
   - En bas, une table avec les comptages :
     ```
     adherents | cotisations | prets | sinistres | ayants_droits | remboursements
     20        | 70          | 20    | 40        | 20            | 6
     ```

---

### **Méthode 2️⃣ : Avec psql (Terminal/CLI)**

1. **Récupère ton URL de connexion Railway** :
   - Allez sur https://railway.app
   - Ton projet → Variables d'environnement
   - Cherche `DATABASE_URL` (ou `POSTGRES_URL`)
   - C'est quelque chose comme : `postgresql://user:pass@host:5432/dbname`

2. **Connecte-toi via psql** :
   ```bash
   psql "postgresql://user:pass@host:5432/dbname" -f database/seed-test-data.sql
   ```

3. **Ou copie le contenu du fichier** et execute ligne par ligne

---

## ✅ Vérifier que ça a Marché

Après l'exécution, va sur ton **Dashboard** :
- URL : https://projetdevewebmutuelle-production.up.railway.app/dashboard.html

### Vérificatifs :

1. **Graphique "Évolution des cotisations"**
   - Doit afficher une **courbe** (pas vide)
   - Les boutons 1m, 3m, 6m, 12m, 24m, 36m doivent **changer le graphique**

2. **Tableau Adhérents**
   - 20+ adhérents affichés
   - ADH-3000, ADH-3001, etc.

3. **Tableau Cotisations**
   - 70+ cotisations visibles

4. **Tableau Prêts**
   - 20+ prêts

5. **Tableau Sinistres**
   - 40+ sinistres

6. **Historique**
   - 100+ événements visibles
   - Dropdown de filtrage fonctionne

---

## ❌ Si ça Ne Marche Pas

### Erreur : "Table not found"
- **Cause** : Les migrations n'ont pas été exécutées
- **Solution** : Exécute d'abord la migration Laravel :
  ```bash
  php artisan migrate
  ```

### Erreur : "Syntax error"
- **Cause** : Le script est incomplet ou mal copié
- **Solution** : 
  1. Recommence
  2. Copie le fichier complet `database/seed-test-data.sql`

### Erreur : "Connection refused"
- **Cause** : Railway n'est pas accessible
- **Solution** :
  1. Vérifiez que Railway fonctionne
  2. Vérifiez les identifiants de connexion

### Les données ne s'affichent pas
- **Cause** : Cache du navigateur
- **Solution** : Appuyez sur `Ctrl+Shift+R` (hard refresh)

---

## 🔄 Réinitialiser les Données

Si tu veux **recommencer** :

```sql
-- Vider toutes les tables
TRUNCATE TABLE remboursement_prets CASCADE;
TRUNCATE TABLE ayant_droits CASCADE;
TRUNCATE TABLE sinistres CASCADE;
TRUNCATE TABLE prets CASCADE;
TRUNCATE TABLE cotisations CASCADE;
TRUNCATE TABLE adherents CASCADE;

-- Réinitialiser les ID
ALTER SEQUENCE adherents_id_seq RESTART WITH 1;
ALTER SEQUENCE cotisations_id_seq RESTART WITH 1;
ALTER SEQUENCE prets_id_seq RESTART WITH 1;
ALTER SEQUENCE sinistres_id_seq RESTART WITH 1;
ALTER SEQUENCE ayant_droits_id_seq RESTART WITH 1;
ALTER SEQUENCE remboursement_prets_id_seq RESTART WITH 1;
```

Puis relance le script complet `seed-test-data.sql`

---

## 📞 Besoin d'Aide ?

Si tu bloques quelque part, indique :
- ✋ À quelle étape
- 📋 Le message d'erreur exact
- 🖥️ Le screenshot de l'erreur (si possible)

Bonne chance ! 🚀
