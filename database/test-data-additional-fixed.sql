-- ============================================================
-- MaMutuelle - Données supplémentaires FINAL V2
-- Zéro sous-requête — IDs directs uniquement
-- ============================================================

BEGIN;

-- ============================================
-- 1. UTILISATEURS
-- ============================================
INSERT INTO users (name, email, password, role, created_at, updated_at) VALUES
('Diallo Fatoumata',  'diallo.fatoumata@email.bf',  '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Traoré Souleymane', 'traore.souleymane@email.bf', '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Kaboré Awa',        'kabore.awa@email.bf',        '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Sanou Ibrahim',     'sanou.ibrahim@email.bf',     '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Nikiéma Pauline',   'nikiema.pauline@email.bf',   '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Ouattara Karim',    'ouattara.karim@email.bf',    '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Bado Rasmata',      'bado.rasmata@email.bf',      '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Yameogo Blaise',    'yameogo.blaise@email.bf',    '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Compaoré Sophie',   'compaore.sophie@email.bf',   '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW()),
('Zida Michel',       'zida.michel@email.bf',       '$2y$12$K1kJm8F7t.RZV.LH2.dS0uEZr5xKHsxJqVlVz5QcH7K0y8qQu2EwK', 'adherent', NOW(), NOW())
ON CONFLICT (email) DO NOTHING;

-- ============================================
-- 2. ADHÉRENTS
-- Récupération des user_id via une CTE propre
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
SELECT u.id,'ADH012','Bado','Rasmata','bado.rasmata@email.bf','+226 77 22 33 44','1993-09-07'::date,'femme','Secteur 6, Rue 15.3','Ouagadougou','01 BP 011','2023-12-01'::date,'actif',NOW(),NOW() FROM u WHERE u.email='bado.rasmata@email.bf'
UNION ALL
SELECT u.id,'ADH013','Yameogo','Blaise','yameogo.blaise@email.bf','+226 78 33 44 55','1980-01-22'::date,'homme','Avenue de la Nation','Ouagadougou','01 BP 012','2024-01-08'::date,'actif',NOW(),NOW() FROM u WHERE u.email='yameogo.blaise@email.bf'
UNION ALL
SELECT u.id,'ADH014','Compaoré','Sophie','compaore.sophie@email.bf','+226 79 44 55 66','1996-12-11'::date,'femme','Secteur 11, Rue 7.14','Ouagadougou','01 BP 013','2024-02-15'::date,'actif',NOW(),NOW() FROM u WHERE u.email='compaore.sophie@email.bf'
UNION ALL
SELECT u.id,'ADH015','Zida','Michel','zida.michel@email.bf','+226 60 55 66 77','1978-07-05'::date,'homme','Rue de la Révolution','Ouagadougou','01 BP 014','2024-03-01'::date,'suspendu',NOW(),NOW() FROM u WHERE u.email='zida.michel@email.bf'
ON CONFLICT (numero_adherent) DO NOTHING;

-- ============================================
-- 3. AYANTS DROIT
-- adherent_id : ADH006=6, ADH007=7, ADH008=8,
--               ADH009=9, ADH010=10, ADH011=11,
--               ADH012=12, ADH013=13, ADH014=14
-- ============================================
INSERT INTO ayants_droit (adherent_id, nom, prenom, relation, date_naissance, created_at, updated_at) VALUES
(6,  'Diallo',   'Mamadou',   'conjoint', '1993-05-20', NOW(), NOW()),
(6,  'Diallo',   'Aminata',   'enfant',   '2018-02-15', NOW(), NOW()),
(7,  'Traoré',   'Mariam',    'conjoint', '1985-08-10', NOW(), NOW()),
(7,  'Traoré',   'Abdoulaye', 'enfant',   '2012-11-08', NOW(), NOW()),
(7,  'Traoré',   'Fatima',    'enfant',   '2015-03-22', NOW(), NOW()),
(8,  'Kaboré',   'Ousmane',   'conjoint', '1995-01-30', NOW(), NOW()),
(9,  'Sanou',    'Halimatou', 'conjoint', '1978-04-15', NOW(), NOW()),
(9,  'Sanou',    'Yacouba',   'enfant',   '2005-09-12', NOW(), NOW()),
(9,  'Sanou',    'Rokia',     'enfant',   '2008-06-28', NOW(), NOW()),
(10, 'Nikiéma',  'Jean',      'conjoint', '1988-11-05', NOW(), NOW()),
(10, 'Nikiéma',  'Lucie',     'enfant',   '2016-07-19', NOW(), NOW()),
(11, 'Ouattara', 'Zahra',     'conjoint', '1989-12-08', NOW(), NOW()),
(12, 'Bado',     'Issa',      'conjoint', '1990-03-25', NOW(), NOW()),
(12, 'Bado',     'Nadia',     'enfant',   '2019-10-14', NOW(), NOW()),
(13, 'Yameogo',  'Christelle','conjoint', '1983-07-18', NOW(), NOW()),
(13, 'Yameogo',  'Pierre',    'enfant',   '2010-12-03', NOW(), NOW()),
(13, 'Yameogo',  'Marie',     'enfant',   '2013-05-27', NOW(), NOW()),
(14, 'Compaoré', 'David',     'conjoint', '1994-02-14', NOW(), NOW());

-- ============================================
-- 4. COTISATIONS
-- ============================================
INSERT INTO cotisations (adherent_id, montant, date_echeance, date_paiement, statut, reference_paiement, mode_paiement, created_at, updated_at) VALUES
(6,  5000, '2024-01-31', '2024-01-30', 'payée',      'REF-2024-050', 'virement', NOW(), NOW()),
(6,  5000, '2024-02-29', '2024-02-28', 'payée',      'REF-2024-051', 'virement', NOW(), NOW()),
(6,  5000, '2024-03-31', NULL,          'en attente', '',             NULL,       NOW(), NOW()),
(7,  7500, '2024-01-31', '2024-02-02', 'payée',      'REF-2024-060', 'especes',  NOW(), NOW()),
(7,  7500, '2024-02-29', NULL,          'en retard',  '',             NULL,       NOW(), NOW()),
(7,  7500, '2024-03-31', NULL,          'en retard',  '',             NULL,       NOW(), NOW()),
(8,  5000, '2024-01-31', '2024-01-31', 'payée',      'REF-2024-070', 'carte',    NOW(), NOW()),
(8,  5000, '2024-02-29', '2024-02-28', 'payée',      'REF-2024-071', 'carte',    NOW(), NOW()),
(8,  5000, '2024-03-31', '2024-03-30', 'payée',      'REF-2024-072', 'carte',    NOW(), NOW()),
(9,  5000, '2024-01-31', '2024-01-28', 'payée',      'REF-2024-080', 'virement', NOW(), NOW()),
(9,  5000, '2024-02-29', '2024-02-26', 'payée',      'REF-2024-081', 'virement', NOW(), NOW()),
(9,  5000, '2024-03-31', NULL,          'en attente', '',             NULL,       NOW(), NOW()),
(10, 5000, '2024-01-31', NULL,          'en retard',  '',             NULL,       NOW(), NOW()),
(10, 5000, '2024-02-29', NULL,          'en retard',  '',             NULL,       NOW(), NOW()),
(10, 5000, '2024-03-31', NULL,          'en retard',  '',             NULL,       NOW(), NOW()),
(11, 7500, '2024-01-31', '2024-01-30', 'payée',      'REF-2024-090', 'cheque',   NOW(), NOW()),
(11, 7500, '2024-02-29', '2024-02-27', 'payée',      'REF-2024-091', 'cheque',   NOW(), NOW()),
(11, 7500, '2024-03-31', NULL,          'en attente', '',             NULL,       NOW(), NOW()),
(12, 5000, '2024-01-31', '2024-02-01', 'payée',      'REF-2024-100', 'especes',  NOW(), NOW()),
(12, 5000, '2024-02-29', '2024-03-02', 'payée',      'REF-2024-101', 'especes',  NOW(), NOW()),
(12, 5000, '2024-03-31', NULL,          'en attente', '',             NULL,       NOW(), NOW()),
(13, 5000, '2024-02-29', '2024-02-28', 'payée',      'REF-2024-110', 'virement', NOW(), NOW()),
(13, 5000, '2024-03-31', NULL,          'en attente', '',             NULL,       NOW(), NOW()),
(14, 5000, '2024-03-31', '2024-03-29', 'payée',      'REF-2024-120', 'carte',    NOW(), NOW());

-- ============================================
-- 5. PRÊTS
-- ============================================
INSERT INTO prets (adherent_id, montant, taux_interet, duree_mois, date_debut, date_fin, statut, created_at, updated_at) VALUES
(6,  200000, 2.5, 18, '2024-02-10', '2025-08-10', 'approuvé',   NOW(), NOW()),
(7,  350000, 3.0, 24, '2024-02-15', '2026-02-15', 'approuvé',   NOW(), NOW()),
(8,  100000, 2.5, 12, '2024-03-01', '2025-03-01', 'approuvé',   NOW(), NOW()),
(9,  250000, 3.0, 18, '2024-01-20', '2025-07-20', 'approuvé',   NOW(), NOW()),
(10,  80000, 3.5, 12, '2024-04-01', '2025-04-01', 'en attente', NOW(), NOW()),
(11, 175000, 3.0, 18, '2024-03-15', '2025-09-15', 'approuvé',   NOW(), NOW()),
(12,  50000, 4.0,  6, '2024-05-01', '2024-11-01', 'en attente', NOW(), NOW()),
(13, 120000, 2.5, 12, '2024-01-08', '2025-01-08', 'approuvé',   NOW(), NOW()),
(14,  90000, 3.5, 12, '2024-03-01', '2025-03-01', 'rejeté',     NOW(), NOW()),
(9,   30000, 2.0,  3, '2023-10-01', '2024-01-01', 'remboursé',  NOW(), NOW());

-- ============================================
-- 6. REMBOURSEMENTS PRÊTS
-- pret_id depuis la requête fournie :
--   ADH006 pret 200000 date_debut 2024-02-10 => id 6 (nouveau)
--   ADH007 pret 350000 date_debut 2024-02-15 => id 7 (nouveau)
--   ADH009 pret 250000 date_debut 2024-01-20 => id 9 (nouveau)
-- On récupère les IDs après insertion via currval
-- ============================================
INSERT INTO remboursements_prets (pret_id, numero_echeance, montant, date_echeance, date_paiement, statut, created_at, updated_at)
SELECT p.id, 1, 11500, '2024-03-10', '2024-03-09', 'payée',      NOW(), NOW() FROM prets p WHERE p.adherent_id = 6  AND p.date_debut = '2024-02-10'
UNION ALL
SELECT p.id, 2, 11500, '2024-04-10', NULL,          'en attente', NOW(), NOW() FROM prets p WHERE p.adherent_id = 6  AND p.date_debut = '2024-02-10'
UNION ALL
SELECT p.id, 1, 16000, '2024-03-15', '2024-03-14', 'payée',      NOW(), NOW() FROM prets p WHERE p.adherent_id = 7  AND p.date_debut = '2024-02-15'
UNION ALL
SELECT p.id, 2, 16000, '2024-04-15', '2024-04-13', 'payée',      NOW(), NOW() FROM prets p WHERE p.adherent_id = 7  AND p.date_debut = '2024-02-15'
UNION ALL
SELECT p.id, 3, 16000, '2024-05-15', NULL,          'en attente', NOW(), NOW() FROM prets p WHERE p.adherent_id = 7  AND p.date_debut = '2024-02-15'
UNION ALL
SELECT p.id, 1, 14500, '2024-02-20', '2024-02-19', 'payée',      NOW(), NOW() FROM prets p WHERE p.adherent_id = 9  AND p.date_debut = '2024-01-20'
UNION ALL
SELECT p.id, 2, 14500, '2024-03-20', '2024-03-18', 'payée',      NOW(), NOW() FROM prets p WHERE p.adherent_id = 9  AND p.date_debut = '2024-01-20'
UNION ALL
SELECT p.id, 3, 14500, '2024-04-20', NULL,          'en attente', NOW(), NOW() FROM prets p WHERE p.adherent_id = 9  AND p.date_debut = '2024-01-20';

-- ============================================
-- 7. SINISTRES
-- ============================================
INSERT INTO sinistres (adherent_id, description, date_sinistre, type_sinistre, statut, montant_reclamation, montant_remboursement, created_at, updated_at) VALUES
(6,  'Accouchement à la clinique, césarienne programmée',  '2024-01-25', 'hospitalisation', 'approuvé',  150000, 120000, NOW(), NOW()),
(7,  'Chute à vélo, entorse cheville droite',              '2024-03-10', 'accident',        'approuvé',   45000,  35000, NOW(), NOW()),
(8,  'Consultation ophtalmologique et lunettes',           '2024-02-15', 'maladie',         'approuvé',   25000,  20000, NOW(), NOW()),
(9,  'Décès de la mère, frais funéraires traditionnels',   '2024-01-05', 'décès',           'approuvé',  180000, 120000, NOW(), NOW()),
(11, 'Hospitalisation pour appendicite',                   '2024-04-20', 'hospitalisation', 'approuvé',   80000,  65000, NOW(), NOW()),
(13, 'Accident domestique, brûlure au bras',               '2024-03-28', 'accident',        'approuvé',   30000,  25000, NOW(), NOW()),
(10, 'Consultation cardiologique et examens',              '2024-04-10', 'maladie',         'en cours',   35000,   NULL, NOW(), NOW()),
(12, 'Hospitalisation enfant pour pneumonie',              '2024-05-05', 'hospitalisation', 'en cours',   60000,   NULL, NOW(), NOW()),
(14, 'Consultation dentaire et soins',                     '2024-04-15', 'maladie',         'déclaré',    20000,   NULL, NOW(), NOW()),
(7,  'Décès du frère, participation funérailles',          '2024-02-20', 'décès',           'déclaré',    50000,   NULL, NOW(), NOW());

-- ============================================
-- 8. PRESTATIONS
-- sinistre_id connus : 1=ADH001, 3=ADH003
-- Nouveaux sinistres récupérés via adherent_id + date_sinistre unique
-- ============================================
INSERT INTO prestations (sinistre_id, type_prestation, description, montant, date_demande, date_approbation, statut, created_at, updated_at) VALUES
(1, 'Remboursement hospitalisation', 'Frais clinique + médicaments paludisme',    70000, '2024-02-15', '2024-02-25', 'approuvé', NOW(), NOW()),
(3, 'Remboursement accident',        'Frais chirurgie et plâtre bras droit',      100000, '2024-01-25', '2024-02-05', 'approuvé', NOW(), NOW());

INSERT INTO prestations (sinistre_id, type_prestation, description, montant, date_demande, date_approbation, statut, created_at, updated_at)
SELECT s.id, 'Remboursement accouchement',        'Frais clinique + médicaments + suivi postnatal',              120000, '2024-01-30', '2024-02-10', 'approuvé', NOW(), NOW() FROM sinistres s WHERE s.adherent_id = 6  AND s.date_sinistre = '2024-01-25'
UNION ALL
SELECT s.id, 'Remboursement accident',            'Consultation + radio + médicaments + kinésithérapie',          35000, '2024-03-15', '2024-03-25', 'approuvé', NOW(), NOW() FROM sinistres s WHERE s.adherent_id = 7  AND s.date_sinistre = '2024-03-10'
UNION ALL
SELECT s.id, 'Remboursement optique',             'Consultation ophtalmologique + monture + verres',              20000, '2024-02-20', '2024-03-01', 'approuvé', NOW(), NOW() FROM sinistres s WHERE s.adherent_id = 8  AND s.date_sinistre = '2024-02-15'
UNION ALL
SELECT s.id, 'Remboursement décès',               'Participation aux frais funéraires traditionnels',            120000, '2024-01-10', '2024-01-20', 'approuvé', NOW(), NOW() FROM sinistres s WHERE s.adherent_id = 9  AND s.date_sinistre = '2024-01-05'
UNION ALL
SELECT s.id, 'Remboursement hospitalisation',     'Chirurgie appendicite + hospitalisation 3 jours',             65000, '2024-04-25', '2024-05-05', 'approuvé', NOW(), NOW() FROM sinistres s WHERE s.adherent_id = 11 AND s.date_sinistre = '2024-04-20'
UNION ALL
SELECT s.id, 'Remboursement accident domestique', 'Consultation + pansements + médicaments',                     25000, '2024-04-02', '2024-04-12', 'approuvé', NOW(), NOW() FROM sinistres s WHERE s.adherent_id = 13 AND s.date_sinistre = '2024-03-28';

COMMIT;

-- ============================================
-- VÉRIFICATION FINALE
-- ============================================
SELECT 'Users:'          AS table_name, COUNT(*) AS total FROM users
UNION ALL SELECT 'Adherents:',     COUNT(*) FROM adherents
UNION ALL SELECT 'Ayants droit:',  COUNT(*) FROM ayants_droit
UNION ALL SELECT 'Cotisations:',   COUNT(*) FROM cotisations
UNION ALL SELECT 'Prêts:',         COUNT(*) FROM prets
UNION ALL SELECT 'Remboursements:',COUNT(*) FROM remboursements_prets
UNION ALL SELECT 'Sinistres:',     COUNT(*) FROM sinistres
UNION ALL SELECT 'Prestations:',   COUNT(*) FROM prestations;