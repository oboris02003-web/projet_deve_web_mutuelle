<?php

namespace App\Http\Controllers;

use App\Models\Adherent;
use App\Models\Cotisation;
use App\Models\Pret;
use App\Models\Sinistre;
use App\Models\AyantDroit;
use App\Models\RemboursementPret;
use Illuminate\Http\Request;

class SeedController extends Controller
{
    /**
     * Semer les données de test
     * POST /api/admin/seed-test-data
     */
    public function seedTestData(Request $request)
    {
        // Vérifier que nous avons la clé secrète
        if ($request->header('X-Seed-Key') !== env('SEED_KEY', 'default-seed-key')) {
            return response()->json([
                'error' => 'Unauthorized',
                'message' => 'Invalid seed key'
            ], 401);
        }

        try {
            $stats = [
                'adherents' => 0,
                'cotisations' => 0,
                'prets' => 0,
                'sinistres' => 0,
                'ayants_droits' => 0,
            ];

            // =====================
            // 1. Créer 20 adhérents
            // =====================
            $noms = ['Traore', 'Diallo', 'Konaté', 'Sanogo', 'Cissé', 'Keita', 'Bah', 'Diop', 'Sow', 'Gueye'];
            $prenoms = ['Moussa', 'Fatimata', 'Seydou', 'Mariam', 'Ablassé', 'Brice', 'Issa', 'Ousmane', 'Aïssatou', 'Mamadou'];
            $villes = ['Ouagadougou', 'Bobo-Dioulasso', 'Koudougou', 'Ouahigouya', 'Tenkodogo'];
            
            $adherents = [];
            for ($i = 0; $i < 20; $i++) {
                $nom = $noms[$i % count($noms)];
                $prenom = $prenoms[$i % count($prenoms)];
                $email = strtolower("test{$i}.{$nom}@mamutuelle.bf");
                
                $adherent = Adherent::create([
                    'nom' => $nom,
                    'prenom' => $prenom,
                    'email' => $email,
                    'telephone' => '261' . rand(10000000, 99999999),
                    'numero_adherent' => 'ADH-' . (3000 + $i),
                    'adresse' => rand(1, 200) . ' Rue ' . $villes[rand(0, count($villes)-1)],
                    'ville' => $villes[rand(0, count($villes)-1)],
                    'statut' => 'actif',
                    'date_inscription' => now()->subMonths(rand(0, 12)),
                ]);
                $adherents[] = $adherent;
                $stats['adherents']++;
            }

            // =====================
            // 2. Créer 70 cotisations
            // =====================
            $cotMontants = [5000, 10000, 15000, 20000, 25000, 30000];
            
            foreach ($adherents as $adherent) {
                // Chaque adhérent a 3-4 cotisations
                $nbCot = rand(3, 4);
                for ($j = 0; $j < $nbCot; $j++) {
                    $moisRetro = rand(0, 12);
                    $dateCot = now()->subMonths($moisRetro);
                    
                    Cotisation::create([
                        'adherent_id' => $adherent->id,
                        'montant' => $cotMontants[rand(0, count($cotMontants)-1)],
                        'date_echeance' => $dateCot->copy()->addMonths(1),
                        'date_paiement' => $dateCot,
                        'statut' => rand(0, 100) > 20 ? 'payée' : 'impayée',
                        'periode' => $dateCot->format('Y-m'),
                    ]);
                    $stats['cotisations']++;
                }
            }

            // =====================
            // 3. Créer 20 prêts
            // =====================
            $montantsPrets = [100000, 200000, 350000, 500000, 750000, 1000000];
            $durees = [12, 24, 36, 48];
            
            foreach (array_slice($adherents, 0, 20) as $adherent) {
                $dateDebut = now()->subMonths(rand(6, 36));
                
                $pret = Pret::create([
                    'adherent_id' => $adherent->id,
                    'montant' => $montantsPrets[rand(0, count($montantsPrets)-1)],
                    'montant_approuve' => $montantsPrets[rand(0, count($montantsPrets)-1)],
                    'date_debut' => $dateDebut,
                    'duree_mois' => $durees[rand(0, count($durees)-1)],
                    'taux_interet' => rand(2, 8),
                    'statut' => ['approuvé', 'en cours', 'remboursé'][rand(0, 2)],
                    'motif' => ['Besoin de fonds', 'Investissement', 'Consommation', 'Santé'][rand(0, 3)],
                ]);
                
                // Ajouter des remboursements si en cours ou remboursé
                if (in_array($pret->statut, ['en cours', 'remboursé'])) {
                    $nbRemb = rand(1, $pret->duree_mois);
                    for ($k = 0; $k < $nbRemb; $k++) {
                        RemboursementPret::create([
                            'pret_id' => $pret->id,
                            'date_remboursement' => $dateDebut->copy()->addMonths($k + 1),
                            'montant_rembourse' => $pret->montant_approuve / $pret->duree_mois,
                        ]);
                    }
                }
                
                $stats['prets']++;
            }

            // =====================
            // 4. Créer 40 sinistres
            // =====================
            $typesSinistre = ['Hospitalisation', 'Accident', 'Maladie', 'Décès', 'Invalidité', 'Dommages'];
            $montantsSinistre = [50000, 100000, 150000, 200000, 300000, 500000];
            
            foreach (array_slice($adherents, 0, 20) as $adherent) {
                // 2 sinistres par adhérent
                for ($s = 0; $s < 2; $s++) {
                    $dateSin = now()->subMonths(rand(0, 24));
                    
                    Sinistre::create([
                        'adherent_id' => $adherent->id,
                        'type_sinistre' => $typesSinistre[rand(0, count($typesSinistre)-1)],
                        'date_sinistre' => $dateSin,
                        'date_declaration' => $dateSin->copy()->addDays(rand(1, 7)),
                        'montant_reclamation' => $montantsSinistre[rand(0, count($montantsSinistre)-1)],
                        'montant_approuve' => $montantsSinistre[rand(0, count($montantsSinistre)-1)],
                        'statut' => ['déclaré', 'en évaluation', 'approuvé', 'remboursé'][rand(0, 3)],
                        'description' => 'Sinistre de test',
                        'reference' => 'SIN-' . (5000 + $stats['sinistres']),
                    ]);
                    $stats['sinistres']++;
                }
            }

            // =====================
            // 5. Créer 20 ayants droits
            // =====================
            $relations = ['Épouse', 'Époux', 'Enfant', 'Parent', 'Frère', 'Sœur'];
            
            foreach (array_slice($adherents, 0, 20) as $adherent) {
                $ayantnoms = ['Diallo', 'Traoré', 'Cissé', 'Keita', 'Bah'];
                $ayantprenoms = ['Jean', 'Marie', 'Paul', 'Sophie', 'Pierre'];
                
                AyantDroit::create([
                    'adherent_id' => $adherent->id,
                    'nom' => $ayantnoms[rand(0, count($ayantnoms)-1)],
                    'prenom' => $ayantprenoms[rand(0, count($ayantprenoms)-1)],
                    'date_naissance' => now()->subYears(rand(5, 60)),
                    'relation' => $relations[rand(0, count($relations)-1)],
                    'statut' => 'actif',
                ]);
                $stats['ayants_droits']++;
            }

            return response()->json([
                'success' => true,
                'message' => 'Données de test semées avec succès !',
                'stats' => $stats,
                'total' => array_sum($stats),
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Seeding failed',
                'message' => $e->getMessage(),
                'trace' => env('APP_DEBUG') ? $e->getTraceAsString() : null
            ], 500);
        }
    }
}
