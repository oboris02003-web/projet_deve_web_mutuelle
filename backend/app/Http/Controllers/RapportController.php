<?php

namespace App\Http\Controllers;

use App\Models\Adherent;
use App\Models\Cotisation;
use App\Models\Pret;
use App\Models\Sinistre;
use App\Models\AyantDroit;
use Illuminate\Http\Request;

class RapportController extends Controller
{
    public function export(Request $request)
    {
        $format = $request->query('format', 'pdf');
        
        // Récupérer toutes les données
        $adherents = Adherent::with(['cotisations', 'prets', 'sinistres'])->get();
        $cotisations = Cotisation::with('adherent')->get();
        $prets = Pret::with('adherent')->get();
        $sinistres = Sinistre::with('adherent')->get();
        
        // Calculer les statistiques
        $stats = [
            'total_adherents' => $adherents->count(),
            'total_cotisations' => $cotisations->count(),
            'total_prets' => $prets->count(),
            'total_sinistres' => $sinistres->count(),
            'cotisations_payees' => $cotisations->where('statut', 'payée')->count(),
            'cotisations_en_retard' => $cotisations->where('statut', 'en retard')->count(),
            'prets_actifs' => $prets->where('statut', 'en_cours')->count(),
            'sinistres_approuves' => $sinistres->where('statut', 'approuvé')->count(),
            'montant_total_cotisations' => $cotisations->sum('montant'),
            'montant_total_prets' => $prets->sum('montant'),
            'montant_total_sinistres' => $sinistres->sum('montant_approuve'),
        ];
        
        if ($format === 'csv') {
            return $this->generateCSVReport($adherents, $cotisations, $prets, $sinistres, $stats);
        } elseif ($format === 'pdf' || $format === 'txt') {
            return $this->generateTextReport($adherents, $cotisations, $prets, $sinistres, $stats);
        }
        
        return response()->json(['error' => 'Format non supporté'], 400);
    }
    
    private function generateCSVReport($adherents, $cotisations, $prets, $sinistres, $stats)
    {
        $filename = 'rapport_complet_' . date('Y-m-d_H-i-s') . '.csv';
        
        $csv = "\xEF\xBB\xBF"; // BOM UTF-8
        
        // Statistiques générales
        $csv .= "RAPPORT COMPLET - " . date('Y-m-d H:i:s') . "\n\n";
        $csv .= "STATISTIQUES GLOBALES\n";
        $csv .= "Total Adhérents,Total Cotisations,Total Prêts,Total Sinistres\n";
        $csv .= $stats['total_adherents'] . "," . $stats['total_cotisations'] . "," . $stats['total_prets'] . "," . $stats['total_sinistres'] . "\n\n";
        
        // Détails adhérents
        $csv .= "ADHÉRENTS\n";
        $csv .= "Numéro,Nom,Prénom,Email,Téléphone,Statut\n";
        foreach ($adherents as $adherent) {
            $csv .= $this->escapeCsv($adherent->numero_adherent) . ","
                  . $this->escapeCsv($adherent->nom) . ","
                  . $this->escapeCsv($adherent->prenom) . ","
                  . $this->escapeCsv($adherent->email) . ","
                  . $this->escapeCsv($adherent->telephone) . ","
                  . $this->escapeCsv($adherent->statut) . "\n";
        }
        $csv .= "\n";
        
        // Détails cotisations
        $csv .= "COTISATIONS\n";
        $csv .= "ID,Adhérent,Montant,Échéance,Statut,Paiement\n";
        foreach ($cotisations as $cot) {
            $csv .= $cot->id . ","
                  . $this->escapeCsv($cot->adherent ? $cot->adherent->nom . ' ' . $cot->adherent->prenom : '') . ","
                  . $cot->montant . ","
                  . ($cot->date_echeance ? $cot->date_echeance->format('Y-m-d') : '') . ","
                  . $this->escapeCsv($cot->statut) . ","
                  . ($cot->date_paiement ? $cot->date_paiement->format('Y-m-d') : '') . "\n";
        }
        $csv .= "\n";
        
        // Détails prêts
        $csv .= "PRÊTS\n";
        $csv .= "ID,Adhérent,Montant,Durée,Taux,Statut\n";
        foreach ($prets as $pret) {
            $csv .= $pret->id . ","
                  . $this->escapeCsv($pret->adherent ? $pret->adherent->nom . ' ' . $pret->adherent->prenom : '') . ","
                  . $pret->montant . ","
                  . $pret->duree_mois . ","
                  . $pret->taux_interet . ","
                  . $this->escapeCsv($pret->statut) . "\n";
        }
        $csv .= "\n";
        
        // Détails sinistres
        $csv .= "SINISTRES\n";
        $csv .= "ID,Adhérent,Type,Montant Réclamé,Montant Approuvé,Statut\n";
        foreach ($sinistres as $sin) {
            $csv .= $sin->id . ","
                  . $this->escapeCsv($sin->adherent ? $sin->adherent->nom . ' ' . $sin->adherent->prenom : '') . ","
                  . $this->escapeCsv($sin->type_sinistre) . ","
                  . $sin->montant_reclamation . ","
                  . $sin->montant_approuve . ","
                  . $this->escapeCsv($sin->statut) . "\n";
        }
        
        return response($csv, 200)
            ->header('Content-Type', 'text/csv; charset=utf-8')
            ->header('Content-Disposition', 'attachment; filename="' . $filename . '"')
            ->header('Cache-Control', 'no-cache, no-store, must-revalidate')
            ->header('Pragma', 'no-cache')
            ->header('Expires', '0');
    }
    
    private function generateTextReport($adherents, $cotisations, $prets, $sinistres, $stats)
    {
        $filename = 'rapport_complet_' . date('Y-m-d_H-i-s') . '.txt';
        
        $text = "================================================================================\n";
        $text .= "RAPPORT COMPLET MAMUTUELLE - " . date('Y-m-d H:i:s') . "\n";
        $text .= "================================================================================\n\n";
        
        // Statistiques
        $text .= "STATISTIQUES GLOBALES\n";
        $text .= "─────────────────────\n";
        $text .= "Total Adhérents: " . $stats['total_adherents'] . "\n";
        $text .= "Total Cotisations: " . $stats['total_cotisations'] . " (Payées: " . $stats['cotisations_payees'] . ", En retard: " . $stats['cotisations_en_retard'] . ")\n";
        $text .= "Total Prêts: " . $stats['total_prets'] . " (Actifs: " . $stats['prets_actifs'] . ")\n";
        $text .= "Total Sinistres: " . $stats['total_sinistres'] . " (Approuvés: " . $stats['sinistres_approuves'] . ")\n";
        $text .= "Montant Total Cotisations: " . number_format($stats['montant_total_cotisations'], 2) . "\n";
        $text .= "Montant Total Prêts: " . number_format($stats['montant_total_prets'], 2) . "\n";
        $text .= "Montant Total Sinistres Approuvés: " . number_format($stats['montant_total_sinistres'], 2) . "\n\n";
        
        // Adhérents
        $text .= "================================================================================\n";
        $text .= "ADHÉRENTS (" . $adherents->count() . ")\n";
        $text .= "================================================================================\n";
        foreach ($adherents as $adherent) {
            $text .= "\n" . $adherent->numero_adherent . " | " . $adherent->nom . " " . $adherent->prenom . "\n";
            $text .= "Email: " . $adherent->email . " | Tél: " . $adherent->telephone . " | Statut: " . $adherent->statut . "\n";
            $text .= "Inscrit: " . ($adherent->date_inscription ? $adherent->date_inscription->format('Y-m-d') : '') . "\n";
        }
        
        // Cotisations
        $text .= "\n================================================================================\n";
        $text .= "COTISATIONS (" . $cotisations->count() . ")\n";
        $text .= "================================================================================\n";
        foreach ($cotisations as $cot) {
            $text .= "\nID: " . $cot->id . " | Adhérent: " . ($cot->adherent ? $cot->adherent->nom . ' ' . $cot->adherent->prenom : 'N/A') . "\n";
            $text .= "Montant: " . number_format($cot->montant, 2) . " | Échéance: " . ($cot->date_echeance ? $cot->date_echeance->format('Y-m-d') : '') . "\n";
            $text .= "Statut: " . $cot->statut . " | Paiement: " . ($cot->date_paiement ? $cot->date_paiement->format('Y-m-d') : 'Non payé') . "\n";
        }
        
        // Prêts
        $text .= "\n================================================================================\n";
        $text .= "PRÊTS (" . $prets->count() . ")\n";
        $text .= "================================================================================\n";
        foreach ($prets as $pret) {
            $text .= "\nID: " . $pret->id . " | Adhérent: " . ($pret->adherent ? $pret->adherent->nom . ' ' . $pret->adherent->prenom : 'N/A') . "\n";
            $text .= "Montant: " . number_format($pret->montant, 2) . " | Durée: " . $pret->duree_mois . " mois | Taux: " . $pret->taux_interet . "%\n";
            $text .= "Statut: " . $pret->statut . " | Motif: " . ($pret->motif ?? 'N/A') . "\n";
        }
        
        // Sinistres
        $text .= "\n================================================================================\n";
        $text .= "SINISTRES (" . $sinistres->count() . ")\n";
        $text .= "================================================================================\n";
        foreach ($sinistres as $sin) {
            $text .= "\nID: " . $sin->id . " | Adhérent: " . ($sin->adherent ? $sin->adherent->nom . ' ' . $sin->adherent->prenom : 'N/A') . "\n";
            $text .= "Type: " . $sin->type_sinistre . " | Montant Réclamé: " . number_format($sin->montant_reclamation, 2) . "\n";
            $text .= "Montant Approuvé: " . number_format($sin->montant_approuve ?? 0, 2) . " | Statut: " . $sin->statut . "\n";
            $text .= "Description: " . ($sin->description ?? 'N/A') . "\n";
        }
        
        $text .= "\n\n================================================================================\n";
        $text .= "FIN DU RAPPORT\n";
        $text .= "================================================================================\n";
        
        return response($text, 200)
            ->header('Content-Type', 'text/plain; charset=utf-8')
            ->header('Content-Disposition', 'attachment; filename="' . $filename . '"')
            ->header('Cache-Control', 'no-cache, no-store, must-revalidate')
            ->header('Pragma', 'no-cache')
            ->header('Expires', '0');
    }
    
    private function escapeCsv($field)
    {
        return '"' . str_replace('"', '""', (string)$field) . '"';
    }
}
