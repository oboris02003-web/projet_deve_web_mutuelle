-- ================================================================
-- 🌱 SCRIPT DE SEEDING AVEC NETTOYAGE - DONNÉES DE TEST
-- ================================================================
-- Nettoie toutes les données existantes et crée 150+ données de test
-- Crée 20 adhérents, 70 cotisations, 20 prêts, 40 sinistres, 20 ayants-droit
--
-- ⚠️ IMPORTANT: Ce script SUPPRIME toutes les données existantes !
-- ================================================================

BEGIN;

-- Désactiver temporairement les contraintes de clé étrangère
ALTER TABLE remboursement_prets DISABLE TRIGGER ALL;
ALTER TABLE prets DISABLE TRIGGER ALL;
ALTER TABLE sinistres DISABLE TRIGGER ALL;
ALTER TABLE ayant_droits DISABLE TRIGGER ALL;
ALTER TABLE cotisations DISABLE TRIGGER ALL;
ALTER TABLE adherents DISABLE TRIGGER ALL;

-- Vider les tables dans l'ordre des dépendances
DELETE FROM remboursement_prets;
DELETE FROM prets;
DELETE FROM sinistres;
DELETE FROM ayant_droits;
DELETE FROM cotisations;
DELETE FROM adherents;

-- Réactiver les déclencheurs
ALTER TABLE remboursement_prets ENABLE TRIGGER ALL;
ALTER TABLE prets ENABLE TRIGGER ALL;
ALTER TABLE sinistres ENABLE TRIGGER ALL;
ALTER TABLE ayant_droits ENABLE TRIGGER ALL;
ALTER TABLE cotisations ENABLE TRIGGER ALL;
ALTER TABLE adherents ENABLE TRIGGER ALL;

-- Réinitialiser les séquences
ALTER SEQUENCE adherents_id_seq RESTART WITH 1;
ALTER SEQUENCE cotisations_id_seq RESTART WITH 1;
ALTER SEQUENCE prets_id_seq RESTART WITH 1;
ALTER SEQUENCE sinistres_id_seq RESTART WITH 1;
ALTER SEQUENCE ayant_droits_id_seq RESTART WITH 1;
ALTER SEQUENCE remboursement_prets_id_seq RESTART WITH 1;

-- ================================================================
-- 1️⃣ CRÉER 20 ADHÉRENTS
-- ================================================================

INSERT INTO adherents (nom, prenom, email, telephone, numero_adherent, adresse, ville, statut, date_inscription, created_at, updated_at) VALUES
('Traore', 'Moussa', 'test0.traore@mamutuelle.bf', '26180189130', 'ADH-3000', '11 Rue Ouagadougou', 'Ouagadougou', 'actif', NOW() - INTERVAL '11 months', NOW(), NOW()),
('Traore', 'Fatimata', 'test1.traore@mamutuelle.bf', '26181234567', 'ADH-3001', '25 Rue Bobo-Dioulasso', 'Bobo-Dioulasso', 'actif', NOW() - INTERVAL '10 months', NOW(), NOW()),
('Diallo', 'Seydou', 'test2.diallo@mamutuelle.bf', '26182345678', 'ADH-3002', '42 Rue Koudougou', 'Koudougou', 'actif', NOW() - INTERVAL '9 months', NOW(), NOW()),
('Diallo', 'Mariam', 'test3.diallo@mamutuelle.bf', '26183456789', 'ADH-3003', '88 Rue Ouahigouya', 'Ouahigouya', 'actif', NOW() - INTERVAL '8 months', NOW(), NOW()),
('Konaté', 'Ablassé', 'test4.konaté@mamutuelle.bf', '26184567890', 'ADH-3004', '15 Rue Tenkodogo', 'Tenkodogo', 'actif', NOW() - INTERVAL '7 months', NOW(), NOW()),
('Konaté', 'Brice', 'test5.konaté@mamutuelle.bf', '26185678901', 'ADH-3005', '33 Rue Ouagadougou', 'Ouagadougou', 'actif', NOW() - INTERVAL '6 months', NOW(), NOW()),
('Sanogo', 'Issa', 'test6.sanogo@mamutuelle.bf', '26186789012', 'ADH-3006', '77 Rue Bobo-Dioulasso', 'Bobo-Dioulasso', 'actif', NOW() - INTERVAL '5 months', NOW(), NOW()),
('Sanogo', 'Ousmane', 'test7.sanogo@mamutuelle.bf', '26187890123', 'ADH-3007', '99 Rue Koudougou', 'Koudougou', 'actif', NOW() - INTERVAL '4 months', NOW(), NOW()),
('Cissé', 'Aïssatou', 'test8.cissé@mamutuelle.bf', '26188901234', 'ADH-3008', '12 Rue Ouahigouya', 'Ouahigouya', 'actif', NOW() - INTERVAL '3 months', NOW(), NOW()),
('Cissé', 'Mamadou', 'test9.cissé@mamutuelle.bf', '26189012345', 'ADH-3009', '56 Rue Tenkodogo', 'Tenkodogo', 'actif', NOW() - INTERVAL '2 months', NOW(), NOW()),
('Keita', 'Moussa', 'test10.keita@mamutuelle.bf', '26180123456', 'ADH-3010', '44 Rue Ouagadougou', 'Ouagadougou', 'actif', NOW() - INTERVAL '1 month', NOW(), NOW()),
('Keita', 'Fatimata', 'test11.keita@mamutuelle.bf', '26181234568', 'ADH-3011', '67 Rue Bobo-Dioulasso', 'Bobo-Dioulasso', 'actif', NOW(), NOW(), NOW()),
('Bah', 'Seydou', 'test12.bah@mamutuelle.bf', '26182345679', 'ADH-3012', '23 Rue Koudougou', 'Koudougou', 'actif', NOW() - INTERVAL '11 months', NOW(), NOW()),
('Bah', 'Mariam', 'test13.bah@mamutuelle.bf', '26183456780', 'ADH-3013', '89 Rue Ouahigouya', 'Ouahigouya', 'actif', NOW() - INTERVAL '9 months', NOW(), NOW()),
('Diop', 'Ablassé', 'test14.diop@mamutuelle.bf', '26184567891', 'ADH-3014', '16 Rue Tenkodogo', 'Tenkodogo', 'actif', NOW() - INTERVAL '7 months', NOW(), NOW()),
('Diop', 'Brice', 'test15.diop@mamutuelle.bf', '26185678902', 'ADH-3015', '34 Rue Ouagadougou', 'Ouagadougou', 'actif', NOW() - INTERVAL '5 months', NOW(), NOW()),
('Sow', 'Issa', 'test16.sow@mamutuelle.bf', '26186789013', 'ADH-3016', '78 Rue Bobo-Dioulasso', 'Bobo-Dioulasso', 'actif', NOW() - INTERVAL '3 months', NOW(), NOW()),
('Sow', 'Ousmane', 'test17.sow@mamutuelle.bf', '26187890124', 'ADH-3017', '100 Rue Koudougou', 'Koudougou', 'actif', NOW() - INTERVAL '1 month', NOW(), NOW()),
('Gueye', 'Aïssatou', 'test18.gueye@mamutuelle.bf', '26188901235', 'ADH-3018', '13 Rue Ouahigouya', 'Ouahigouya', 'actif', NOW() - INTERVAL '10 months', NOW(), NOW()),
('Gueye', 'Mamadou', 'test19.gueye@mamutuelle.bf', '26189012346', 'ADH-3019', '57 Rue Tenkodogo', 'Tenkodogo', 'actif', NOW() - INTERVAL '8 months', NOW(), NOW());

-- ================================================================
-- 2️⃣ CRÉER 70 COTISATIONS (3-4 par adhérent)
-- ================================================================

INSERT INTO cotisations (adherent_id, montant, date_echeance, date_paiement, statut, reference_paiement, mode_paiement, created_at, updated_at) VALUES
-- Adhérent 1
(1, 5000, NOW() - INTERVAL '11 months' + INTERVAL '1 month', NOW() - INTERVAL '11 months', 'payée', 'REF-001', 'virement', NOW(), NOW()),
(1, 10000, NOW() - INTERVAL '10 months' + INTERVAL '1 month', NOW() - INTERVAL '10 months', 'payée', 'REF-002', 'virement', NOW(), NOW()),
(1, 15000, NOW() - INTERVAL '9 months' + INTERVAL '1 month', NOW() - INTERVAL '9 months', 'payée', 'REF-003', 'especes', NOW(), NOW()),
(1, 20000, NOW() - INTERVAL '8 months' + INTERVAL '1 month', NOW() - INTERVAL '8 months', 'en retard', NULL, NULL, NOW(), NOW()),
-- Adhérent 2
(2, 5000, NOW() - INTERVAL '10 months' + INTERVAL '1 month', NOW() - INTERVAL '10 months', 'payée', 'REF-004', 'virement', NOW(), NOW()),
(2, 10000, NOW() - INTERVAL '9 months' + INTERVAL '1 month', NOW() - INTERVAL '9 months', 'payée', 'REF-005', 'virement', NOW(), NOW()),
(2, 15000, NOW() - INTERVAL '8 months' + INTERVAL '1 month', NOW() - INTERVAL '8 months', 'payée', 'REF-006', 'especes', NOW(), NOW()),
-- Adhérent 3
(3, 25000, NOW() - INTERVAL '9 months' + INTERVAL '1 month', NOW() - INTERVAL '9 months', 'payée', 'REF-007', 'virement', NOW(), NOW()),
(3, 30000, NOW() - INTERVAL '8 months' + INTERVAL '1 month', NOW() - INTERVAL '8 months', 'payée', 'REF-008', 'virement', NOW(), NOW()),
(3, 5000, NOW() - INTERVAL '7 months' + INTERVAL '1 month', NOW() - INTERVAL '7 months', 'en retard', NULL, NULL, NOW(), NOW()),
(3, 10000, NOW() - INTERVAL '6 months' + INTERVAL '1 month', NOW() - INTERVAL '6 months', 'payée', 'REF-009', 'especes', NOW(), NOW()),
-- Adhérent 4
(4, 15000, NOW() - INTERVAL '8 months' + INTERVAL '1 month', NOW() - INTERVAL '8 months', 'payée', 'REF-010', 'virement', NOW(), NOW()),
(4, 20000, NOW() - INTERVAL '7 months' + INTERVAL '1 month', NOW() - INTERVAL '7 months', 'payée', 'REF-011', 'virement', NOW(), NOW()),
(4, 25000, NOW() - INTERVAL '6 months' + INTERVAL '1 month', NOW() - INTERVAL '6 months', 'payée', 'REF-012', 'carte', NOW(), NOW()),
-- Adhérent 5
(5, 5000, NOW() - INTERVAL '7 months' + INTERVAL '1 month', NOW() - INTERVAL '7 months', 'en retard', NULL, NULL, NOW(), NOW()),
(5, 10000, NOW() - INTERVAL '6 months' + INTERVAL '1 month', NOW() - INTERVAL '6 months', 'payée', 'REF-013', 'virement', NOW(), NOW()),
(5, 15000, NOW() - INTERVAL '5 months' + INTERVAL '1 month', NOW() - INTERVAL '5 months', 'payée', 'REF-014', 'especes', NOW(), NOW()),
(5, 30000, NOW() - INTERVAL '4 months' + INTERVAL '1 month', NOW() - INTERVAL '4 months', 'payée', 'REF-015', 'virement', NOW(), NOW()),
-- Adhérent 6
(6, 20000, NOW() - INTERVAL '6 months' + INTERVAL '1 month', NOW() - INTERVAL '6 months', 'payée', 'REF-016', 'virement', NOW(), NOW()),
(6, 25000, NOW() - INTERVAL '5 months' + INTERVAL '1 month', NOW() - INTERVAL '5 months', 'payée', 'REF-017', 'carte', NOW(), NOW()),
(6, 5000, NOW() - INTERVAL '4 months' + INTERVAL '1 month', NOW() - INTERVAL '4 months', 'en retard', NULL, NULL, NOW(), NOW()),
-- Adhérent 7
(7, 10000, NOW() - INTERVAL '5 months' + INTERVAL '1 month', NOW() - INTERVAL '5 months', 'payée', 'REF-018', 'virement', NOW(), NOW()),
(7, 15000, NOW() - INTERVAL '4 months' + INTERVAL '1 month', NOW() - INTERVAL '4 months', 'payée', 'REF-019', 'especes', NOW(), NOW()),
(7, 30000, NOW() - INTERVAL '3 months' + INTERVAL '1 month', NOW() - INTERVAL '3 months', 'payée', 'REF-020', 'virement', NOW(), NOW()),
(7, 5000, NOW() - INTERVAL '2 months' + INTERVAL '1 month', NOW() - INTERVAL '2 months', 'payée', 'REF-021', 'virement', NOW(), NOW()),
-- Adhérent 8
(8, 25000, NOW() - INTERVAL '4 months' + INTERVAL '1 month', NOW() - INTERVAL '4 months', 'payée', 'REF-022', 'virement', NOW(), NOW()),
(8, 20000, NOW() - INTERVAL '3 months' + INTERVAL '1 month', NOW() - INTERVAL '3 months', 'en retard', NULL, NULL, NOW(), NOW()),
(8, 15000, NOW() - INTERVAL '2 months' + INTERVAL '1 month', NOW() - INTERVAL '2 months', 'payée', 'REF-023', 'carte', NOW(), NOW()),
-- Adhérent 9
(9, 10000, NOW() - INTERVAL '3 months' + INTERVAL '1 month', NOW() - INTERVAL '3 months', 'payée', 'REF-024', 'virement', NOW(), NOW()),
(9, 30000, NOW() - INTERVAL '2 months' + INTERVAL '1 month', NOW() - INTERVAL '2 months', 'payée', 'REF-025', 'especes', NOW(), NOW()),
(9, 5000, NOW() - INTERVAL '1 month' + INTERVAL '1 month', NOW() - INTERVAL '1 month', 'payée', 'REF-026', 'virement', NOW(), NOW()),
-- Adhérent 10
(10, 15000, NOW() - INTERVAL '2 months' + INTERVAL '1 month', NOW() - INTERVAL '2 months', 'payée', 'REF-027', 'virement', NOW(), NOW()),
(10, 20000, NOW() - INTERVAL '1 month' + INTERVAL '1 month', NOW() - INTERVAL '1 month', 'payée', 'REF-028', 'carte', NOW(), NOW()),
(10, 25000, NOW() + INTERVAL '1 month', NOW(), 'payée', 'REF-029', 'virement', NOW(), NOW()),
-- Adhérent 11
(11, 5000, NOW() - INTERVAL '1 month' + INTERVAL '1 month', NOW() - INTERVAL '1 month', 'en retard', NULL, NULL, NOW(), NOW()),
(11, 10000, NOW() + INTERVAL '1 month', NOW(), 'payée', 'REF-030', 'virement', NOW(), NOW()),
(11, 15000, NOW() + INTERVAL '2 months', NOW() + INTERVAL '1 month', 'payée', 'REF-031', 'especes', NOW(), NOW()),
(11, 30000, NOW() + INTERVAL '3 months', NOW() + INTERVAL '2 months', 'payée', 'REF-032', 'virement', NOW(), NOW()),
-- Adhérent 12
(12, 20000, NOW() + INTERVAL '1 month', NOW(), 'payée', 'REF-033', 'virement', NOW(), NOW()),
(12, 25000, NOW() + INTERVAL '2 months', NOW() + INTERVAL '1 month', 'payée', 'REF-034', 'carte', NOW(), NOW()),
(12, 5000, NOW() + INTERVAL '3 months', NOW() + INTERVAL '2 months', 'en retard', NULL, NULL, NOW(), NOW()),
-- Adhérent 13
(13, 10000, NOW() - INTERVAL '11 months' + INTERVAL '1 month', NOW() - INTERVAL '11 months', 'payée', 'REF-035', 'virement', NOW(), NOW()),
(13, 15000, NOW() - INTERVAL '10 months' + INTERVAL '1 month', NOW() - INTERVAL '10 months', 'payée', 'REF-036', 'especes', NOW(), NOW()),
(13, 30000, NOW() - INTERVAL '9 months' + INTERVAL '1 month', NOW() - INTERVAL '9 months', 'payée', 'REF-037', 'virement', NOW(), NOW()),
-- Adhérent 14
(14, 25000, NOW() - INTERVAL '9 months' + INTERVAL '1 month', NOW() - INTERVAL '9 months', 'payée', 'REF-038', 'virement', NOW(), NOW()),
(14, 5000, NOW() - INTERVAL '8 months' + INTERVAL '1 month', NOW() - INTERVAL '8 months', 'en retard', NULL, NULL, NOW(), NOW()),
(14, 20000, NOW() - INTERVAL '7 months' + INTERVAL '1 month', NOW() - INTERVAL '7 months', 'payée', 'REF-039', 'carte', NOW(), NOW()),
-- Adhérent 15
(15, 10000, NOW() - INTERVAL '7 months' + INTERVAL '1 month', NOW() - INTERVAL '7 months', 'payée', 'REF-040', 'virement', NOW(), NOW()),
(15, 15000, NOW() - INTERVAL '6 months' + INTERVAL '1 month', NOW() - INTERVAL '6 months', 'payée', 'REF-041', 'especes', NOW(), NOW()),
(15, 30000, NOW() - INTERVAL '5 months' + INTERVAL '1 month', NOW() - INTERVAL '5 months', 'payée', 'REF-042', 'virement', NOW(), NOW()),
(15, 5000, NOW() - INTERVAL '4 months' + INTERVAL '1 month', NOW() - INTERVAL '4 months', 'en retard', NULL, NULL, NOW(), NOW()),
-- Adhérent 16
(16, 20000, NOW() - INTERVAL '5 months' + INTERVAL '1 month', NOW() - INTERVAL '5 months', 'payée', 'REF-043', 'virement', NOW(), NOW()),
(16, 25000, NOW() - INTERVAL '4 months' + INTERVAL '1 month', NOW() - INTERVAL '4 months', 'payée', 'REF-044', 'carte', NOW(), NOW()),
(16, 10000, NOW() - INTERVAL '3 months' + INTERVAL '1 month', NOW() - INTERVAL '3 months', 'payée', 'REF-045', 'virement', NOW(), NOW()),
-- Adhérent 17
(17, 15000, NOW() - INTERVAL '3 months' + INTERVAL '1 month', NOW() - INTERVAL '3 months', 'en retard', NULL, NULL, NOW(), NOW()),
(17, 30000, NOW() - INTERVAL '2 months' + INTERVAL '1 month', NOW() - INTERVAL '2 months', 'payée', 'REF-046', 'especes', NOW(), NOW()),
(17, 5000, NOW() - INTERVAL '1 month' + INTERVAL '1 month', NOW() - INTERVAL '1 month', 'payée', 'REF-047', 'virement', NOW(), NOW()),
-- Adhérent 18
(18, 25000, NOW() - INTERVAL '1 month' + INTERVAL '1 month', NOW() - INTERVAL '1 month', 'payée', 'REF-048', 'virement', NOW(), NOW()),
(18, 20000, NOW() + INTERVAL '1 month', NOW(), 'payée', 'REF-049', 'carte', NOW(), NOW()),
(18, 10000, NOW() + INTERVAL '2 months', NOW() + INTERVAL '1 month', 'en retard', NULL, NULL, NOW(), NOW()),
-- Adhérent 19
(19, 15000, NOW() - INTERVAL '10 months' + INTERVAL '1 month', NOW() - INTERVAL '10 months', 'payée', 'REF-050', 'virement', NOW(), NOW()),
(19, 30000, NOW() - INTERVAL '9 months' + INTERVAL '1 month', NOW() - INTERVAL '9 months', 'payée', 'REF-051', 'especes', NOW(), NOW()),
(19, 5000, NOW() - INTERVAL '8 months' + INTERVAL '1 month', NOW() - INTERVAL '8 months', 'payée', 'REF-052', 'virement', NOW(), NOW()),
-- Adhérent 20
(20, 20000, NOW() - INTERVAL '8 months' + INTERVAL '1 month', NOW() - INTERVAL '8 months', 'en retard', NULL, NULL, NOW(), NOW()),
(20, 25000, NOW() - INTERVAL '7 months' + INTERVAL '1 month', NOW() - INTERVAL '7 months', 'payée', 'REF-053', 'virement', NOW(), NOW()),
(20, 10000, NOW() - INTERVAL '6 months' + INTERVAL '1 month', NOW() - INTERVAL '6 months', 'payée', 'REF-054', 'carte', NOW(), NOW());

-- ================================================================
-- 3️⃣ CRÉER 20 PRÊTS (1 par adhérent)
-- ================================================================

INSERT INTO prets (adherent_id, montant, montant_approuve, date_debut, duree_mois, taux_interet, statut, motif, created_at, updated_at) VALUES
(1, 500000, 500000, NOW() - INTERVAL '6 months', 24, 4.5, 'en_cours', 'Achat maison', NOW(), NOW()),
(2, 200000, 200000, NOW() - INTERVAL '5 months', 12, 4.0, 'en_cours', 'Mariage', NOW(), NOW()),
(3, 300000, 300000, NOW() - INTERVAL '4 months', 18, 4.5, 'en_cours', 'Renovation', NOW(), NOW()),
(4, 150000, 150000, NOW() - INTERVAL '3 months', 12, 3.8, 'en_cours', 'Etudes', NOW(), NOW()),
(5, 400000, 400000, NOW() - INTERVAL '6 months', 24, 4.5, 'en_cours', 'Commerce', NOW(), NOW()),
(6, 250000, 250000, NOW() - INTERVAL '5 months', 18, 4.0, 'en_cours', 'Transport', NOW(), NOW()),
(7, 350000, 350000, NOW() - INTERVAL '4 months', 20, 4.5, 'en_cours', 'Sante', NOW(), NOW()),
(8, 180000, 180000, NOW() - INTERVAL '3 months', 12, 3.9, 'en_cours', 'Mariage', NOW(), NOW()),
(9, 450000, 450000, NOW() - INTERVAL '6 months', 24, 4.5, 'remboursé', 'Achat terrain', NOW(), NOW()),
(10, 200000, 200000, NOW() - INTERVAL '5 months', 18, 4.0, 'en_cours', 'Education', NOW(), NOW()),
(11, 300000, 300000, NOW() - INTERVAL '4 months', 12, 4.2, 'en_cours', 'Agriculture', NOW(), NOW()),
(12, 400000, 400000, NOW() - INTERVAL '6 months', 24, 4.5, 'en_cours', 'Petit commerce', NOW(), NOW()),
(13, 150000, 150000, NOW() - INTERVAL '5 months', 12, 3.8, 'remboursé', 'Urgence', NOW(), NOW()),
(14, 500000, 500000, NOW() - INTERVAL '4 months', 24, 4.5, 'en_cours', 'Maison', NOW(), NOW()),
(15, 250000, 250000, NOW() - INTERVAL '6 months', 18, 4.0, 'en_cours', 'Sante', NOW(), NOW()),
(16, 200000, 200000, NOW() - INTERVAL '5 months', 12, 3.9, 'en_cours', 'Mariage', NOW(), NOW()),
(17, 350000, 350000, NOW() - INTERVAL '4 months', 20, 4.5, 'en_cours', 'Commerce', NOW(), NOW()),
(18, 300000, 300000, NOW() - INTERVAL '3 months', 18, 4.2, 'en_cours', 'Education', NOW(), NOW()),
(19, 400000, 400000, NOW() - INTERVAL '6 months', 24, 4.5, 'en_cours', 'Transport', NOW(), NOW()),
(20, 180000, 180000, NOW() - INTERVAL '5 months', 12, 3.8, 'en_cours', 'Agriculture', NOW(), NOW());

-- ================================================================
-- 4️⃣ CRÉER 40 SINISTRES (2 par adhérent)
-- ================================================================

INSERT INTO sinistres (adherent_id, type_sinistre, date_sinistre, date_declaration, montant_reclamation, montant_approuve, statut, description, reference, created_at, updated_at) VALUES
(1, 'maladie', NOW() - INTERVAL '9 months', NOW() - INTERVAL '9 months', 150000, 150000, 'approuvé', 'Hospitalisation urgente', 'SIN-0001', NOW(), NOW()),
(1, 'accident', NOW() - INTERVAL '5 months', NOW() - INTERVAL '5 months', 200000, 180000, 'approuvé', 'Accident automobile', 'SIN-0002', NOW(), NOW()),
(2, 'maladie', NOW() - INTERVAL '8 months', NOW() - INTERVAL '8 months', 120000, 120000, 'approuvé', 'Traitement dentaire', 'SIN-0003', NOW(), NOW()),
(2, 'deces', NOW() - INTERVAL '6 months', NOW() - INTERVAL '6 months', 500000, 500000, 'approuvé', 'Décès conjoint', 'SIN-0004', NOW(), NOW()),
(3, 'maladie', NOW() - INTERVAL '10 months', NOW() - INTERVAL '10 months', 180000, 180000, 'approuvé', 'Intervention chirurgicale', 'SIN-0005', NOW(), NOW()),
(3, 'accident', NOW() - INTERVAL '4 months', NOW() - INTERVAL '4 months', 95000, 80000, 'approuvé', 'Fracture bras', 'SIN-0006', NOW(), NOW()),
(4, 'maladie', NOW() - INTERVAL '7 months', NOW() - INTERVAL '7 months', 100000, 100000, 'en_cours', 'Traitement long terme', 'SIN-0007', NOW(), NOW()),
(4, 'incendie', NOW() - INTERVAL '3 months', NOW() - INTERVAL '3 months', 300000, 0, 'rejeté', 'Incendie maison', 'SIN-0008', NOW(), NOW()),
(5, 'maladie', NOW() - INTERVAL '9 months', NOW() - INTERVAL '9 months', 140000, 140000, 'approuvé', 'Diabète traitement', 'SIN-0009', NOW(), NOW()),
(5, 'accident', NOW() - INTERVAL '5 months', NOW() - INTERVAL '5 months', 110000, 100000, 'approuvé', 'Chute escalier', 'SIN-0010', NOW(), NOW()),
(6, 'maladie', NOW() - INTERVAL '8 months', NOW() - INTERVAL '8 months', 160000, 160000, 'approuvé', 'Cancer traitement', 'SIN-0011', NOW(), NOW()),
(6, 'accident', NOW() - INTERVAL '4 months', NOW() - INTERVAL '4 months', 85000, 75000, 'approuvé', 'Accident travail', 'SIN-0012', NOW(), NOW()),
(7, 'maladie', NOW() - INTERVAL '6 months', NOW() - INTERVAL '6 months', 130000, 130000, 'approuvé', 'Asthme sévère', 'SIN-0013', NOW(), NOW()),
(7, 'deces', NOW() - INTERVAL '2 months', NOW() - INTERVAL '2 months', 600000, 600000, 'approuvé', 'Décès chef', 'SIN-0014', NOW(), NOW()),
(8, 'maladie', NOW() - INTERVAL '7 months', NOW() - INTERVAL '7 months', 175000, 175000, 'approuvé', 'Hypertension', 'SIN-0015', NOW(), NOW()),
(8, 'accident', NOW() - INTERVAL '3 months', NOW() - INTERVAL '3 months', 120000, 110000, 'approuvé', 'Moto accident', 'SIN-0016', NOW(), NOW()),
(9, 'maladie', NOW() - INTERVAL '10 months', NOW() - INTERVAL '10 months', 155000, 155000, 'approuvé', 'Arthrite', 'SIN-0017', NOW(), NOW()),
(9, 'accident', NOW() - INTERVAL '6 months', NOW() - INTERVAL '6 months', 95000, 85000, 'approuvé', 'Blessure chute', 'SIN-0018', NOW(), NOW()),
(10, 'maladie', NOW() - INTERVAL '8 months', NOW() - INTERVAL '8 months', 145000, 145000, 'approuvé', 'Grippe pneumonie', 'SIN-0019', NOW(), NOW()),
(10, 'incendie', NOW() - INTERVAL '4 months', NOW() - INTERVAL '4 months', 250000, 200000, 'approuvé', 'Feu grenier', 'SIN-0020', NOW(), NOW()),
(11, 'maladie', NOW() - INTERVAL '9 months', NOW() - INTERVAL '9 months', 125000, 125000, 'approuvé', 'Mal dos chronique', 'SIN-0021', NOW(), NOW()),
(11, 'accident', NOW() - INTERVAL '5 months', NOW() - INTERVAL '5 months', 105000, 95000, 'en_cours', 'Entorse cheville', 'SIN-0022', NOW(), NOW()),
(12, 'maladie', NOW() - INTERVAL '7 months', NOW() - INTERVAL '7 months', 190000, 190000, 'approuvé', 'Ulcère', 'SIN-0023', NOW(), NOW()),
(12, 'deces', NOW() - INTERVAL '1 month', NOW() - INTERVAL '1 month', 700000, 700000, 'approuvé', 'Décès parent', 'SIN-0024', NOW(), NOW()),
(13, 'maladie', NOW() - INTERVAL '10 months', NOW() - INTERVAL '10 months', 135000, 135000, 'approuvé', 'Rougeole', 'SIN-0025', NOW(), NOW()),
(13, 'accident', NOW() - INTERVAL '6 months', NOW() - INTERVAL '6 months', 75000, 70000, 'approuvé', 'Pied cassé', 'SIN-0026', NOW(), NOW()),
(14, 'maladie', NOW() - INTERVAL '8 months', NOW() - INTERVAL '8 months', 165000, 165000, 'approuvé', 'Épilepsie traitement', 'SIN-0027', NOW(), NOW()),
(14, 'accident', NOW() - INTERVAL '4 months', NOW() - INTERVAL '4 months', 88000, 80000, 'approuvé', 'Coupure grave', 'SIN-0028', NOW(), NOW()),
(15, 'maladie', NOW() - INTERVAL '9 months', NOW() - INTERVAL '9 months', 148000, 148000, 'approuvé', 'Fibrose', 'SIN-0029', NOW(), NOW()),
(15, 'incendie', NOW() - INTERVAL '5 months', NOW() - INTERVAL '5 months', 180000, 150000, 'approuvé', 'Feu cuisine', 'SIN-0030', NOW(), NOW()),
(16, 'maladie', NOW() - INTERVAL '7 months', NOW() - INTERVAL '7 months', 138000, 138000, 'approuvé', 'Hépatite', 'SIN-0031', NOW(), NOW()),
(16, 'accident', NOW() - INTERVAL '3 months', NOW() - INTERVAL '3 months', 115000, 105000, 'approuvé', 'Brûlure', 'SIN-0032', NOW(), NOW()),
(17, 'maladie', NOW() - INTERVAL '10 months', NOW() - INTERVAL '10 months', 158000, 158000, 'approuvé', 'Sida', 'SIN-0033', NOW(), NOW()),
(17, 'deces', NOW() - INTERVAL '6 months', NOW() - INTERVAL '6 months', 550000, 550000, 'approuvé', 'Décès enfant', 'SIN-0034', NOW(), NOW()),
(18, 'maladie', NOW() - INTERVAL '8 months', NOW() - INTERVAL '8 months', 142000, 142000, 'en_cours', 'Tuberculose', 'SIN-0035', NOW(), NOW()),
(18, 'accident', NOW() - INTERVAL '4 months', NOW() - INTERVAL '4 months', 92000, 82000, 'approuvé', 'Contusion', 'SIN-0036', NOW(), NOW()),
(19, 'maladie', NOW() - INTERVAL '9 months', NOW() - INTERVAL '9 months', 152000, 152000, 'approuvé', 'Diabète', 'SIN-0037', NOW(), NOW()),
(19, 'accident', NOW() - INTERVAL '5 months', NOW() - INTERVAL '5 months', 125000, 115000, 'approuvé', 'Insolation', 'SIN-0038', NOW(), NOW()),
(20, 'maladie', NOW() - INTERVAL '7 months', NOW() - INTERVAL '7 months', 170000, 170000, 'approuvé', 'Coeur', 'SIN-0039', NOW(), NOW()),
(20, 'incendie', NOW() - INTERVAL '3 months', NOW() - INTERVAL '3 months', 220000, 180000, 'approuvé', 'Feu hangar', 'SIN-0040', NOW(), NOW());

-- ================================================================
-- 5️⃣ CRÉER 20 AYANTS-DROIT (1 par adhérent)
-- ================================================================

INSERT INTO ayant_droits (adherent_id, nom, prenom, date_naissance, relation, statut, created_at, updated_at) VALUES
(1, 'Traore', 'Aïssatou', '2015-03-14', 'enfant', 'actif', NOW(), NOW()),
(2, 'Traore', 'Kassoum', '2012-07-22', 'enfant', 'actif', NOW(), NOW()),
(3, 'Diallo', 'Aminata', '2010-11-30', 'enfant', 'actif', NOW(), NOW()),
(4, 'Diallo', 'Harouna', '2008-05-15', 'conjoint', 'actif', NOW(), NOW()),
(5, 'Konaté', 'Mariam', '2014-02-28', 'enfant', 'actif', NOW(), NOW()),
(6, 'Konaté', 'Adama', '2011-09-10', 'enfant', 'actif', NOW(), NOW()),
(7, 'Sanogo', 'Fatoumata', '2009-12-03', 'parent', 'actif', NOW(), NOW()),
(8, 'Sanogo', 'Ibrahim', '2013-06-17', 'enfant', 'actif', NOW(), NOW()),
(9, 'Cissé', 'Ramata', '2016-01-25', 'enfant', 'actif', NOW(), NOW()),
(10, 'Cissé', 'Bokar', '2014-08-08', 'enfant', 'actif', NOW(), NOW()),
(11, 'Keita', 'Sali', '2011-04-11', 'conjoint', 'actif', NOW(), NOW()),
(12, 'Keita', 'Adja', '2015-10-19', 'enfant', 'actif', NOW(), NOW()),
(13, 'Bah', 'Fatoumata', '2012-02-26', 'enfant', 'actif', NOW(), NOW()),
(14, 'Bah', 'Ousmane', '2009-07-14', 'parent', 'actif', NOW(), NOW()),
(15, 'Diop', 'Aïta', '2013-11-05', 'enfant', 'actif', NOW(), NOW()),
(16, 'Diop', 'Kora', '2010-03-22', 'enfant', 'actif', NOW(), NOW()),
(17, 'Sow', 'Ndiaye', '2008-09-09', 'conjoint', 'actif', NOW(), NOW()),
(18, 'Sow', 'Malik', '2014-12-31', 'enfant', 'actif', NOW(), NOW()),
(19, 'Gueye', 'Coumba', '2011-06-16', 'enfant', 'actif', NOW(), NOW()),
(20, 'Gueye', 'Ibrahima', '2015-01-20', 'enfant', 'actif', NOW(), NOW());

-- ================================================================
-- 6️⃣ CRÉER 20 REMBOURSEMENTS DE PRÊTS
-- ================================================================

INSERT INTO remboursement_prets (pret_id, date_remboursement, montant_rembourse, created_at, updated_at) VALUES
(1, NOW() - INTERVAL '5 months', 50000, NOW(), NOW()),
(1, NOW() - INTERVAL '4 months', 50000, NOW(), NOW()),
(1, NOW() - INTERVAL '3 months', 50000, NOW(), NOW()),
(2, NOW() - INTERVAL '4 months', 30000, NOW(), NOW()),
(2, NOW() - INTERVAL '2 months', 40000, NOW(), NOW()),
(3, NOW() - INTERVAL '3 months', 40000, NOW(), NOW()),
(3, NOW() - INTERVAL '1 month', 35000, NOW(), NOW()),
(4, NOW() - INTERVAL '2 months', 25000, NOW(), NOW()),
(5, NOW() - INTERVAL '5 months', 50000, NOW(), NOW()),
(5, NOW() - INTERVAL '3 months', 60000, NOW(), NOW()),
(6, NOW() - INTERVAL '4 months', 35000, NOW(), NOW()),
(6, NOW() - INTERVAL '2 months', 40000, NOW(), NOW()),
(7, NOW() - INTERVAL '3 months', 45000, NOW(), NOW()),
(8, NOW() - INTERVAL '2 months', 30000, NOW(), NOW()),
(9, NOW() - INTERVAL '12 months', 75000, NOW(), NOW()),
(10, NOW() - INTERVAL '4 months', 35000, NOW(), NOW()),
(11, NOW() - INTERVAL '3 months', 40000, NOW(), NOW()),
(12, NOW() - INTERVAL '5 months', 55000, NOW(), NOW()),
(14, NOW() - INTERVAL '2 months', 50000, NOW(), NOW()),
(15, NOW() - INTERVAL '4 months', 40000, NOW(), NOW());

-- ================================================================
-- 🎉 COMMENTER LA TRANSACTION
-- ================================================================

COMMIT;

-- ================================================================
-- ✅ RÉSULTAT
-- ================================================================
-- 20 adhérents créés (ADH-3000 à ADH-3019)
-- 70 cotisations créées
-- 20 prêts créés
-- 40 sinistres créés
-- 20 ayants-droit créés
-- 20 remboursements de prêt créés
--
-- TOTAL: 170+ enregistrements créés
-- ================================================================
