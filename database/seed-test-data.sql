-- ================================================================
-- 🌱 SCRIPT DE SEEDING - DONNÉES DE TEST
-- ================================================================
-- Ce script ajoute 150+ données de test à la base de données
-- Crée 20 adhérents, 70 cotisations, 20 prêts, 40 sinistres, 20 ayants-droit
--
-- Utilisation :
-- 1. Ouvrez pgAdmin
-- 2. Connectez-vous à votre database Railway
-- 3. Ouvrez l'éditeur SQL
-- 4. Copiez-collez ce script entier
-- 5. Appuyez sur Exécuter (F5)
-- ================================================================

BEGIN;

-- ================================================================
-- 🧹 NETTOYER LES DONNÉES EXISTANTES (OPTIONAL - DÉCOMMENTER SI BESOIN)
-- ================================================================
-- DELETE FROM remboursement_prets;
-- DELETE FROM prets;
-- DELETE FROM sinistres;
-- DELETE FROM ayant_droits;
-- DELETE FROM cotisations;
-- DELETE FROM adherents;
-- 
-- -- Réinitialiser les séquences
-- ALTER SEQUENCE adherents_id_seq RESTART WITH 1;
-- ALTER SEQUENCE cotisations_id_seq RESTART WITH 1;
-- ALTER SEQUENCE prets_id_seq RESTART WITH 1;
-- ALTER SEQUENCE sinistres_id_seq RESTART WITH 1;
-- ALTER SEQUENCE ayant_droits_id_seq RESTART WITH 1;
-- ALTER SEQUENCE remboursement_prets_id_seq RESTART WITH 1;

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
-- 3️⃣ CRÉER 20 PRÊTS
-- ================================================================

INSERT INTO prets (adherent_id, montant, montant_approuve, date_debut, duree_mois, taux_interet, statut, motif, created_at, updated_at) VALUES
(1, 100000, 100000, NOW() - INTERVAL '36 months', 12, 3, 'remboursé', 'Besoin de fonds', NOW(), NOW()),
(2, 200000, 200000, NOW() - INTERVAL '30 months', 24, 4, 'remboursé', 'Investissement', NOW(), NOW()),
(3, 350000, 350000, NOW() - INTERVAL '18 months', 36, 5, 'en cours', 'Consommation', NOW(), NOW()),
(4, 500000, 500000, NOW() - INTERVAL '12 months', 48, 6, 'en cours', 'Santé', NOW(), NOW()),
(5, 750000, 700000, NOW() - INTERVAL '10 months', 24, 4, 'en cours', 'Besoin de fonds', NOW(), NOW()),
(6, 100000, 100000, NOW() - INTERVAL '8 months', 12, 3, 'en cours', 'Investissement', NOW(), NOW()),
(7, 1000000, 950000, NOW() - INTERVAL '6 months', 36, 5, 'approuvé', 'Consommation', NOW(), NOW()),
(8, 200000, 200000, NOW() - INTERVAL '4 months', 24, 4, 'approuvé', 'Santé', NOW(), NOW()),
(9, 350000, 350000, NOW() - INTERVAL '2 months', 48, 6, 'approuvé', 'Besoin de fonds', NOW(), NOW()),
(10, 500000, 500000, NOW() - INTERVAL '1 month', 12, 3, 'approuvé', 'Investissement', NOW(), NOW()),
(11, 750000, 750000, NOW() - INTERVAL '3 months', 24, 5, 'en cours', 'Consommation', NOW(), NOW()),
(12, 100000, 100000, NOW() - INTERVAL '24 months', 36, 4, 'remboursé', 'Santé', NOW(), NOW()),
(13, 200000, 200000, NOW() - INTERVAL '20 months', 12, 3, 'remboursé', 'Besoin de fonds', NOW(), NOW()),
(14, 350000, 350000, NOW() - INTERVAL '15 months', 24, 5, 'en cours', 'Investissement', NOW(), NOW()),
(15, 500000, 500000, NOW() - INTERVAL '10 months', 48, 6, 'en cours', 'Consommation', NOW(), NOW()),
(16, 750000, 750000, NOW() - INTERVAL '8 months', 36, 5, 'en cours', 'Santé', NOW(), NOW()),
(17, 100000, 100000, NOW() - INTERVAL '5 months', 24, 4, 'en cours', 'Besoin de fonds', NOW(), NOW()),
(18, 200000, 200000, NOW() - INTERVAL '2 months', 12, 3, 'approuvé', 'Investissement', NOW(), NOW()),
(19, 350000, 350000, NOW() - INTERVAL '18 months', 36, 5, 'en cours', 'Consommation', NOW(), NOW()),
(20, 500000, 500000, NOW() - INTERVAL '6 months', 48, 6, 'en cours', 'Santé', NOW(), NOW());

-- ================================================================
-- 4️⃣ CRÉER REMBOURSEMENT DE PRÊTS (pour les prêts en cours/remboursés)
-- ================================================================

INSERT INTO remboursement_prets (pret_id, date_remboursement, montant_rembourse, created_at, updated_at) VALUES
-- Prêt 1 (remboursé)
(1, NOW() - INTERVAL '36 months' + INTERVAL '1 month', 8333.33, NOW(), NOW()),
(1, NOW() - INTERVAL '36 months' + INTERVAL '2 months', 8333.33, NOW(), NOW()),
(1, NOW() - INTERVAL '36 months' + INTERVAL '3 months', 8333.33, NOW(), NOW()),
-- Prêt 2 (remboursé)
(2, NOW() - INTERVAL '30 months' + INTERVAL '1 month', 8333.33, NOW(), NOW()),
(2, NOW() - INTERVAL '30 months' + INTERVAL '2 months', 8333.33, NOW(), NOW()),
-- Prêt 3 (en cours - 2 remboursements)
(3, NOW() - INTERVAL '18 months' + INTERVAL '1 month', 9722.22, NOW(), NOW()),
(3, NOW() - INTERVAL '18 months' + INTERVAL '2 months', 9722.22, NOW(), NOW()),
-- Prêt 4 (en cours - 3 remboursements)
(4, NOW() - INTERVAL '12 months' + INTERVAL '1 month', 10416.67, NOW(), NOW()),
(4, NOW() - INTERVAL '12 months' + INTERVAL '2 months', 10416.67, NOW(), NOW()),
(4, NOW() - INTERVAL '12 months' + INTERVAL '3 months', 10416.67, NOW(), NOW()),
-- Prêt 5 (en cours)
(5, NOW() - INTERVAL '10 months' + INTERVAL '1 month', 29166.67, NOW(), NOW()),
(5, NOW() - INTERVAL '10 months' + INTERVAL '2 months', 29166.67, NOW(), NOW()),
-- Prêt 6 (en cours)
(6, NOW() - INTERVAL '8 months' + INTERVAL '1 month', 8333.33, NOW(), NOW());

-- ================================================================
-- 5️⃣ CRÉER 40 SINISTRES (2 par adhérent)
-- ================================================================

INSERT INTO sinistres (adherent_id, type_sinistre, date_sinistre, date_declaration, montant_reclamation, montant_approuve, statut, description, reference, created_at, updated_at) VALUES
-- Adhérent 1
(1, 'Hospitalisation', NOW() - INTERVAL '24 months', NOW() - INTERVAL '23 months', 150000, 150000, 'remboursé', 'Hospitalisation suite accident', 'SIN-5000', NOW(), NOW()),
(1, 'Accident', NOW() - INTERVAL '12 months', NOW() - INTERVAL '11 months', 200000, 180000, 'approuvé', 'Accident de route', 'SIN-5001', NOW(), NOW()),
-- Adhérent 2
(2, 'Maladie', NOW() - INTERVAL '18 months', NOW() - INTERVAL '17 months', 100000, 100000, 'remboursé', 'Infection grave', 'SIN-5002', NOW(), NOW()),
(2, 'Hospitalisation', NOW() - INTERVAL '6 months', NOW() - INTERVAL '5 months', 250000, 250000, 'approuvé', 'Chirurgie programmée', 'SIN-5003', NOW(), NOW()),
-- Adhérent 3
(3, 'Décès', NOW() - INTERVAL '20 months', NOW() - INTERVAL '19 months', 500000, 500000, 'remboursé', 'Décès adhérent', 'SIN-5004', NOW(), NOW()),
(3, 'Invalidité', NOW() - INTERVAL '10 months', NOW() - INTERVAL '9 months', 300000, 300000, 'en évaluation', 'Invalidité permanente', 'SIN-5005', NOW(), NOW()),
-- Adhérent 4
(4, 'Hospitalisation', NOW() - INTERVAL '14 months', NOW() - INTERVAL '13 months', 180000, 160000, 'remboursé', 'Hospitalisation urgente', 'SIN-5006', NOW(), NOW()),
(4, 'Accident', NOW() - INTERVAL '4 months', NOW() - INTERVAL '3 months', 220000, 200000, 'approuvé', 'Accident au travail', 'SIN-5007', NOW(), NOW()),
-- Adhérent 5
(5, 'Maladie', NOW() - INTERVAL '16 months', NOW() - INTERVAL '15 months', 120000, 100000, 'remboursé', 'Pneumonie', 'SIN-5008', NOW(), NOW()),
(5, 'Dommages', NOW() - INTERVAL '8 months', NOW() - INTERVAL '7 months', 150000, 150000, 'en évaluation', 'Dommages matériels', 'SIN-5009', NOW(), NOW()),
-- Adhérent 6
(6, 'Hospitalisation', NOW() - INTERVAL '22 months', NOW() - INTERVAL '21 months', 200000, 200000, 'remboursé', 'Hospitalisation', 'SIN-5010', NOW(), NOW()),
(6, 'Décès', NOW() - INTERVAL '2 months', NOW() - INTERVAL '1 month', 450000, 450000, 'déclaré', 'Décès membre famille', 'SIN-5011', NOW(), NOW()),
-- Adhérent 7
(7, 'Invalidité', NOW() - INTERVAL '15 months', NOW() - INTERVAL '14 months', 350000, 350000, 'remboursé', 'Invalidité', 'SIN-5012', NOW(), NOW()),
(7, 'Maladie', NOW() - INTERVAL '7 months', NOW() - INTERVAL '6 months', 140000, 140000, 'approuvé', 'Fracture osseuse', 'SIN-5013', NOW(), NOW()),
-- Adhérent 8
(8, 'Accident', NOW() - INTERVAL '18 months', NOW() - INTERVAL '17 months', 210000, 190000, 'remboursé', 'Accident domestique', 'SIN-5014', NOW(), NOW()),
(8, 'Hospitalisation', NOW() - INTERVAL '9 months', NOW() - INTERVAL '8 months', 170000, 170000, 'en évaluation', 'Hospitalisation', 'SIN-5015', NOW(), NOW()),
-- Adhérent 9
(9, 'Maladie', NOW() - INTERVAL '12 months', NOW() - INTERVAL '11 months', 110000, 100000, 'remboursé', 'Gastroentérite', 'SIN-5016', NOW(), NOW()),
(9, 'Dommages', NOW() - INTERVAL '3 months', NOW() - INTERVAL '2 months', 160000, 150000, 'approuvé', 'Dommages divers', 'SIN-5017', NOW(), NOW()),
-- Adhérent 10
(10, 'Hospitalisation', NOW() - INTERVAL '10 months', NOW() - INTERVAL '9 months', 195000, 180000, 'remboursé', 'Hospitalisation', 'SIN-5018', NOW(), NOW()),
(10, 'Invalidité', NOW() - INTERVAL '5 months', NOW() - INTERVAL '4 months', 320000, 320000, 'en évaluation', 'Invalidité temporaire', 'SIN-5019', NOW(), NOW()),
-- Adhérent 11
(11, 'Accident', NOW() - INTERVAL '8 months', NOW() - INTERVAL '7 months', 225000, 210000, 'remboursé', 'Accident route', 'SIN-5020', NOW(), NOW()),
(11, 'Maladie', NOW() - INTERVAL '1 month', NOW() - INTERVAL '1 day', 135000, 135000, 'déclaré', 'Hépatite A', 'SIN-5021', NOW(), NOW()),
-- Adhérent 12
(12, 'Hospitalisation', NOW() - INTERVAL '6 months', NOW() - INTERVAL '5 months', 185000, 170000, 'approuvé', 'Hospitalisation', 'SIN-5022', NOW(), NOW()),
(12, 'Dommages', NOW() - INTERVAL '2 months', NOW() - INTERVAL '1 month', 140000, 140000, 'en évaluation', 'Sinistre bien', 'SIN-5023', NOW(), NOW()),
-- Adhérent 13
(13, 'Décès', NOW() - INTERVAL '11 months', NOW() - INTERVAL '10 months', 480000, 480000, 'remboursé', 'Décès', 'SIN-5024', NOW(), NOW()),
(13, 'Maladie', NOW() - INTERVAL '4 months', NOW() - INTERVAL '3 months', 125000, 125000, 'approuvé', 'Appendicite', 'SIN-5025', NOW(), NOW()),
-- Adhérent 14
(14, 'Invalidité', NOW() - INTERVAL '9 months', NOW() - INTERVAL '8 months', 330000, 310000, 'remboursé', 'Invalidité', 'SIN-5026', NOW(), NOW()),
(14, 'Accident', NOW() - INTERVAL '5 months', NOW() - INTERVAL '4 months', 230000, 230000, 'déclaré', 'Accident', 'SIN-5027', NOW(), NOW()),
-- Adhérent 15
(15, 'Hospitalisation', NOW() - INTERVAL '7 months', NOW() - INTERVAL '6 months', 175000, 160000, 'approuvé', 'Hospitalisation', 'SIN-5028', NOW(), NOW()),
(15, 'Maladie', NOW() - INTERVAL '2 months', NOW() - INTERVAL '1 month', 145000, 140000, 'en évaluation', 'Dengue', 'SIN-5029', NOW(), NOW()),
-- Adhérent 16
(16, 'Accident', NOW() - INTERVAL '13 months', NOW() - INTERVAL '12 months', 240000, 220000, 'remboursé', 'Accident', 'SIN-5030', NOW(), NOW()),
(16, 'Dommages', NOW() - INTERVAL '6 months', NOW() - INTERVAL '5 months', 155000, 155000, 'approuvé', 'Sinistre bien', 'SIN-5031', NOW(), NOW()),
-- Adhérent 17
(17, 'Maladie', NOW() - INTERVAL '11 months', NOW() - INTERVAL '10 months', 130000, 120000, 'remboursé', 'Paludisme', 'SIN-5032', NOW(), NOW()),
(17, 'Hospitalisation', NOW() - INTERVAL '8 months', NOW() - INTERVAL '7 months', 190000, 180000, 'en évaluation', 'Hospitalisation', 'SIN-5033', NOW(), NOW()),
-- Adhérent 18
(18, 'Décès', NOW() - INTERVAL '19 months', NOW() - INTERVAL '18 months', 500000, 500000, 'remboursé', 'Décès', 'SIN-5034', NOW(), NOW()),
(18, 'Invalidité', NOW() - INTERVAL '3 months', NOW() - INTERVAL '2 months', 340000, 340000, 'approuvé', 'Invalidité', 'SIN-5035', NOW(), NOW()),
-- Adhérent 19
(19, 'Accident', NOW() - INTERVAL '17 months', NOW() - INTERVAL '16 months', 215000, 200000, 'remboursé', 'Accident', 'SIN-5036', NOW(), NOW()),
(19, 'Maladie', NOW() - INTERVAL '9 months', NOW() - INTERVAL '8 months', 150000, 150000, 'déclaré', 'Tuberculose', 'SIN-5037', NOW(), NOW()),
-- Adhérent 20
(20, 'Hospitalisation', NOW() - INTERVAL '8 months', NOW() - INTERVAL '7 months', 200000, 190000, 'approuvé', 'Hospitalisation', 'SIN-5038', NOW(), NOW()),
(20, 'Dommages', NOW() - INTERVAL '1 month', NOW() - INTERVAL '1 day', 170000, 170000, 'en évaluation', 'Sinistre', 'SIN-5039', NOW(), NOW());

-- ================================================================
-- 6️⃣ CRÉER 20 AYANTS DROITS (1 par adhérent)
-- ================================================================

INSERT INTO ayant_droits (adherent_id, nom, prenom, date_naissance, relation, statut, created_at, updated_at) VALUES
(1, 'Traore', 'Aïssatou', NOW() - INTERVAL '25 years', 'Épouse', 'actif', NOW(), NOW()),
(2, 'Traore', 'Karim', NOW() - INTERVAL '8 years', 'Enfant', 'actif', NOW(), NOW()),
(3, 'Diallo', 'Aminata', NOW() - INTERVAL '30 years', 'Épouse', 'actif', NOW(), NOW()),
(4, 'Diallo', 'Mohamed', NOW() - INTERVAL '12 years', 'Enfant', 'actif', NOW(), NOW()),
(5, 'Konaté', 'Hawa', NOW() - INTERVAL '28 years', 'Épouse', 'actif', NOW(), NOW()),
(6, 'Konaté', 'Fatoumata', NOW() - INTERVAL '35 years', 'Mère', 'actif', NOW(), NOW()),
(7, 'Sanogo', 'Oumou', NOW() - INTERVAL '22 years', 'Épouse', 'actif', NOW(), NOW()),
(8, 'Sanogo', 'Ibrahim', NOW() - INTERVAL '15 years', 'Enfant', 'actif', NOW(), NOW()),
(9, 'Cissé', 'Djeneba', NOW() - INTERVAL '26 years', 'Épouse', 'actif', NOW(), NOW()),
(10, 'Cissé', 'Mamadou', NOW() - INTERVAL '10 years', 'Enfant', 'actif', NOW(), NOW()),
(11, 'Keita', 'Awa', NOW() - INTERVAL '24 years', 'Épouse', 'actif', NOW(), NOW()),
(12, 'Keita', 'Malik', NOW() - INTERVAL '20 years', 'Frère', 'actif', NOW(), NOW()),
(13, 'Bah', 'Fanta', NOW() - INTERVAL '29 years', 'Épouse', 'actif', NOW(), NOW()),
(14, 'Bah', 'Abdoulaye', NOW() - INTERVAL '9 years', 'Enfant', 'actif', NOW(), NOW()),
(15, 'Diop', 'Mariam', NOW() - INTERVAL '27 years', 'Épouse', 'actif', NOW(), NOW()),
(16, 'Diop', 'Sophie', NOW() - INTERVAL '40 years', 'Mère', 'actif', NOW(), NOW()),
(17, 'Sow', 'Hélène', NOW() - INTERVAL '23 years', 'Épouse', 'actif', NOW(), NOW()),
(18, 'Sow', 'Demba', NOW() - INTERVAL '11 years', 'Enfant', 'actif', NOW(), NOW()),
(19, 'Gueye', 'Khady', NOW() - INTERVAL '25 years', 'Épouse', 'actif', NOW(), NOW()),
(20, 'Gueye', 'Coumba', NOW() - INTERVAL '55 years', 'Mère', 'actif', NOW(), NOW());

-- ================================================================
-- ✅ VALIDATION
-- ================================================================

-- Vérifier les comptages
SELECT 
    (SELECT COUNT(*) FROM adherents WHERE numero_adherent LIKE 'ADH-30%') as adherents,
    (SELECT COUNT(*) FROM cotisations) as cotisations,
    (SELECT COUNT(*) FROM prets) as prets,
    (SELECT COUNT(*) FROM sinistres) as sinistres,
    (SELECT COUNT(*) FROM ayant_droits) as ayants_droits,
    (SELECT COUNT(*) FROM remboursement_prets) as remboursements;

COMMIT;
