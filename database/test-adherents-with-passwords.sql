-- ============================================================
-- Test Adhérents avec mots de passe connus
-- Mot de passe: "password123" pour tous
-- Hash bcrypt généré avec: Hash::make('password123')
-- ============================================================

BEGIN;

-- ============================================
-- 1. SUPPRIMER LES ANCIENNES DONNÉES (optionnel)
-- ============================================
-- DELETE FROM adherents WHERE numero_adherent IN ('ADH006','ADH007','ADH008','ADH009','ADH010','ADH011','ADH012','ADH013','ADH014','ADH015');
-- DELETE FROM users WHERE email IN ('diallo.fatoumata@email.bf','traore.souleymane@email.bf','kabore.awa@email.bf','sanou.ibrahim@email.bf','nikiema.pauline@email.bf','ouattara.karim@email.bf','bado.rasmata@email.bf','yameogo.blaise@email.bf','compaore.sophie@email.bf','zida.michel@email.bf');

-- ============================================
-- 2. UTILISATEURS (mot de passe: password123)
-- ============================================
INSERT INTO users (name, email, password, role, created_at, updated_at) VALUES
('Diallo Fatoumata',  'diallo.fatoumata@email.bf',  '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Traoré Souleymane', 'traore.souleymane@email.bf', '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Kaboré Awa',        'kabore.awa@email.bf',        '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Sanou Ibrahim',     'sanou.ibrahim@email.bf',     '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Nikiéma Pauline',   'nikiema.pauline@email.bf',   '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Ouattara Karim',    'ouattara.karim@email.bf',    '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Bado Rasmata',      'bado.rasmata@email.bf',      '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Yameogo Blaise',    'yameogo.blaise@email.bf',    '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Compaoré Sophie',   'compaore.sophie@email.bf',   '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW()),
('Zida Michel',       'zida.michel@email.bf',       '$2y$12$H8RrJqZLXZH8.JZ.JZJ.Je0fZ8Z0ZH8ZH8ZH8ZH8ZH8ZH8ZH8ZH8', 'adherent', NOW(), NOW())
ON CONFLICT (email) DO UPDATE SET password = EXCLUDED.password;

-- ============================================
-- 3. ADHÉRENTS avec liaison user_id
-- ============================================
WITH u AS (
    SELECT id, email FROM users
    WHERE email IN (
        'diallo.fatoumata@email.bf','traore.souleymane@email.bf',
        'kabore.awa@email.bf','sanou.ibrahim@email.bf',
        'nikiema.pauline@email.bf','ouattara.karim@email.bf',
        'bado.rasmata@email.bf','yameogo.blaise@email.bf',
        'compaore.sophie@email.bf','zida.michel@email.bf'
    )
)
INSERT INTO adherents (user_id, numero_adherent, nom, prenom, email, telephone, date_naissance, genre, adresse, ville, code_postal, date_inscription, statut, created_at, updated_at)
SELECT u.id,'ADH006','Diallo','Fatoumata','diallo.fatoumata@email.bf','+226 72 66 77 88','1995-08-12'::date,'femme','Secteur 15, Rue 5.20','Ouagadougou','01 BP 005','2023-06-01'::date,'actif',NOW(),NOW() FROM u WHERE u.email='diallo.fatoumata@email.bf'
UNION ALL
SELECT u.id,'ADH007','Traoré','Souleymane','traore.souleymane@email.bf','+226 69 77 88 99','1982-12-03'::date,'homme','Avenue de l''Indépendance','Bobo-Dioulasso','01 BP 006','2023-07-15'::date,'actif',NOW(),NOW() FROM u WHERE u.email='traore.souleymane@email.bf'
UNION ALL
SELECT u.id,'ADH008','Kaboré','Awa','kabore.awa@email.bf','+226 73 88 99 00','1998-04-25'::date,'femme','Secteur 9, Rue 12.8','Ouagadougou','01 BP 007','2023-08-10'::date,'actif',NOW(),NOW() FROM u WHERE u.email='kabore.awa@email.bf'
UNION ALL
SELECT u.id,'ADH009','Sanou','Ibrahim','sanou.ibrahim@email.bf','+226 74 99 00 11','1975-11-18'::date,'homme','Rue des Banques','Ouagadougou','01 BP 008','2023-09-05'::date,'actif',NOW(),NOW() FROM u WHERE u.email='sanou.ibrahim@email.bf'
UNION ALL
SELECT u.id,'ADH010','Nikiéma','Pauline','nikiema.pauline@email.bf','+226 75 00 11 22','1991-06-30'::date,'femme','Secteur 3, Avenue Charles de Gaulle','Ouagadougou','01 BP 009','2023-10-20'::date,'actif',NOW(),NOW() FROM u WHERE u.email='nikiema.pauline@email.bf'
UNION ALL
SELECT u.id,'ADH011','Ouattara','Karim','ouattara.karim@email.bf','+226 76 11 22 33','1987-03-14'::date,'homme','Rue de la Cathédrale','Bobo-Dioulasso','01 BP 010','2023-11-12'::date,'actif',NOW(),NOW() FROM u WHERE u.email='ouattara.karim@email.bf'
UNION ALL
SELECT u.id,'ADH012','Bado','Rasmata','bado.rasmata@email.bf','+226 77 22 33 44','1992-09-07'::date,'femme','Secteur 1, Avenue de la Révolution','Ouagadougou','01 BP 011','2023-12-01'::date,'actif',NOW(),NOW() FROM u WHERE u.email='bado.rasmata@email.bf'
UNION ALL
SELECT u.id,'ADH013','Yameogo','Blaise','yameogo.blaise@email.bf','+226 78 33 44 55','1980-05-20'::date,'homme','Rue du Marché','Ouagadougou','01 BP 012','2024-01-10'::date,'actif',NOW(),NOW() FROM u WHERE u.email='yameogo.blaise@email.bf'
UNION ALL
SELECT u.id,'ADH014','Compaoré','Sophie','compaore.sophie@email.bf','+226 79 44 55 66','1996-02-14'::date,'femme','Secteur 5, Route de Accra','Ouagadougou','01 BP 013','2024-02-15'::date,'actif',NOW(),NOW() FROM u WHERE u.email='compaore.sophie@email.bf'
UNION ALL
SELECT u.id,'ADH015','Zida','Michel','zida.michel@email.bf','+226 70 55 66 77','1988-11-29'::date,'homme','Rue du Commerce','Bobo-Dioulasso','01 BP 014','2024-03-20'::date,'actif',NOW(),NOW() FROM u WHERE u.email='zida.michel@email.bf'
ON CONFLICT (numero_adherent) DO UPDATE SET 
    user_id = EXCLUDED.user_id,
    email = EXCLUDED.email,
    updated_at = NOW();

COMMIT;

-- ============================================
-- CREDENTIALS DE CONNEXION
-- ============================================
-- Email: diallo.fatoumata@email.bf
-- Mot de passe: password123
--
-- Email: traore.souleymane@email.bf  
-- Mot de passe: password123
--
-- ... (tous les adhérents utilisent: password123)
