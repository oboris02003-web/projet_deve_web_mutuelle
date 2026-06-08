<?php
/**
 * SCRIPT DE SEEDING - Ajoute des données de test à la base
 * 
 * Usage: php backend/seed-test-data.php
 * 
 * Ajoute:
 * - 20 nouveaux adhérents
 * - 70 nouvelles cotisations
 * - 20 prêts
 * - 40 sinistres
 * - 20 ayants droits
 */

require __DIR__ . '/vendor/autoload.php';
require __DIR__ . '/bootstrap/app.php';

use App\Models\Adherent;
use App\Models\Cotisation;
use App\Models\Pret;
use App\Models\Sinistre;
use App\Models\AyantDroit;
use App\Models\RemboursementPret;

echo "🌱 Démarrage du seeding des données de test...\n\n";

try {
    // =====================
    // 1. Créer 20 adhérents
    // =====================
    echo "📝 Création de 20 adhérents...\n";
    
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
        echo "  ✓ {$adherent->nom} {$adherent->prenom} (ADH-" . (3000 + $i) . ")\n";
    }
    
    // =====================
    // 2. Créer 70 cotisations
    // =====================
    echo "\n💰 Création de 70 cotisations...\n";
    
    $cotMontants = [5000, 10000, 15000, 20000, 25000, 30000];
    $cotCreated = 0;
    
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
            $cotCreated++;
        }
    }
    echo "  ✓ {$cotCreated} cotisations créées\n";
    
    // =====================
    // 3. Créer 20 prêts
    // =====================
    echo "\n🏦 Création de 20 prêts...\n";
    
    $montantsPrets = [100000, 200000, 350000, 500000, 750000, 1000000];
    $durees = [12, 24, 36, 48];
    $pretCreated = 0;
    
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
        
        $pretCreated++;
    }
    echo "  ✓ {$pretCreated} prêts créés\n";
    
    // =====================
    // 4. Créer 40 sinistres
    // =====================
    echo "\n🆘 Création de 40 sinistres...\n";
    
    $typesSinistre = ['Hospitalisation', 'Accident', 'Maladie', 'Décès', 'Invalidité', 'Dommages'];
    $montantsSinistre = [50000, 100000, 150000, 200000, 300000, 500000];
    $sinistresCreated = 0;
    
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
                'reference' => 'SIN-' . (5000 + $sinistresCreated),
            ]);
            $sinistresCreated++;
        }
    }
    echo "  ✓ {$sinistresCreated} sinistres créés\n";
    
    // =====================
    // 5. Créer 20 ayants droits
    // =====================
    echo "\n👨‍👩‍👧 Création de 20 ayants droits...\n";
    
    $relations = ['Épouse', 'Époux', 'Enfant', 'Parent', 'Frère', 'Sœur'];
    $ayantCreated = 0;
    
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
        $ayantCreated++;
    }
    echo "  ✓ {$ayantCreated} ayants droits créés\n";
    
    echo "\n✅ Seeding complété avec succès !\n";
    echo "\n📊 Résumé:\n";
    echo "  • 20 adhérents créés\n";
    echo "  • {$cotCreated} cotisations créées\n";
    echo "  • {$pretCreated} prêts créés\n";
    echo "  • {$sinistresCreated} sinistres créés\n";
    echo "  • {$ayantCreated} ayants droits créés\n";
    
} catch (\Exception $e) {
    echo "❌ Erreur: " . $e->getMessage() . "\n";
    echo $e->getTraceAsString() . "\n";
    exit(1);
}
