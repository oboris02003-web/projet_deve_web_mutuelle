<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class HistoriqueController extends Controller
{
    /**
     * Retourne l'historique combiné (inscriptions, cotisations, prêts, sinistres)
     */
    public function index()
    {
        $historique = [];

        // Dernières inscriptions d'adhérents
        $inscriptions = DB::table('adherents')
            ->select(
                DB::raw("'inscription' as type"),
                DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom, ' inscrite comme adhérente (', adherents.numero_adherent, ')') as message"),
                'adherents.date_inscription as date_action',
                DB::raw("'green' as color"),
                DB::raw("'fa-user-plus' as icon")
            )
            ->orderBy('adherents.date_inscription', 'DESC')
            ->limit(50)
            ->get();

        // Dernières cotisations enregistrées
        $cotisations = DB::table('cotisations')
            ->join('adherents', 'cotisations.adherent_id', '=', 'adherents.id')
            ->select(
                DB::raw("'cotisation' as type"),
                DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                DB::raw("CONCAT('Cotisation de ', adherents.nom, ' ', adherents.prenom, ' enregistrée — ', cotisations.montant, ' FCFA') as message"),
                'cotisations.created_at as date_action',
                DB::raw("'gold' as color"),
                DB::raw("'fa-coins' as icon")
            )
            ->where('cotisations.statut', 'payée')
            ->orderBy('cotisations.created_at', 'DESC')
            ->limit(50)
            ->get();

        // Derniers prêts approuvés
        $prets = DB::table('prets')
            ->join('adherents', 'prets.adherent_id', '=', 'adherents.id')
            ->select(
                DB::raw("'pret' as type"),
                DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                DB::raw("CONCAT('Prêt de ', prets.montant, ' FCFA approuvé pour ', adherents.nom, ' ', adherents.prenom) as message"),
                'prets.date_debut as date_action',
                DB::raw("'indigo' as color"),
                DB::raw("'fa-hand-holding-usd' as icon")
            )
            ->where('prets.statut', 'approuvé')
            ->orderBy('prets.date_debut', 'DESC')
            ->limit(50)
            ->get();

        // Derniers sinistres déclarés
        $sinistres = DB::table('sinistres')
            ->join('adherents', 'sinistres.adherent_id', '=', 'adherents.id')
            ->select(
                DB::raw("'sinistre' as type"),
                DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                DB::raw("CONCAT('Sinistre ', sinistres.type_sinistre, ' déclaré pour ', adherents.nom, ' ', adherents.prenom) as message"),
                'sinistres.date_sinistre as date_action',
                DB::raw("'red' as color"),
                DB::raw("'fa-shield-alt' as icon")
            )
            ->orderBy('sinistres.date_sinistre', 'DESC')
            ->limit(50)
            ->get();

        // Combiner tous les événements et trier par date
        $events = collect()
            ->merge($inscriptions)
            ->merge($cotisations)
            ->merge($prets)
            ->merge($sinistres)
            ->sortByDesc('date_action')
            ->values()
            ->take(100);

        return response()->json($events);
    }

    /**
     * Filtre l'historique par type
     */
    public function filter($type = null)
    {
        if (!$type || !in_array($type, ['inscription', 'cotisation', 'pret', 'sinistre'])) {
            return $this->index();
        }

        $historique = [];

        if ($type === 'inscription') {
            return response()->json(
                DB::table('adherents')
                    ->select(
                        DB::raw("'inscription' as type"),
                        DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                        DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom, ' inscrite comme adhérente (', adherents.numero_adherent, ')') as message"),
                        'adherents.date_inscription as date_action',
                        DB::raw("'green' as color"),
                        DB::raw("'fa-user-plus' as icon")
                    )
                    ->orderBy('adherents.date_inscription', 'DESC')
                    ->get()
            );
        }

        if ($type === 'cotisation') {
            return response()->json(
                DB::table('cotisations')
                    ->join('adherents', 'cotisations.adherent_id', '=', 'adherents.id')
                    ->select(
                        DB::raw("'cotisation' as type"),
                        DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                        DB::raw("CONCAT('Cotisation de ', adherents.nom, ' ', adherents.prenom, ' enregistrée — ', cotisations.montant, ' FCFA') as message"),
                        'cotisations.created_at as date_action',
                        DB::raw("'gold' as color"),
                        DB::raw("'fa-coins' as icon")
                    )
                    ->where('cotisations.statut', 'payée')
                    ->orderBy('cotisations.created_at', 'DESC')
                    ->get()
            );
        }

        if ($type === 'pret') {
            return response()->json(
                DB::table('prets')
                    ->join('adherents', 'prets.adherent_id', '=', 'adherents.id')
                    ->select(
                        DB::raw("'pret' as type"),
                        DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                        DB::raw("CONCAT('Prêt de ', prets.montant, ' FCFA approuvé pour ', adherents.nom, ' ', adherents.prenom) as message"),
                        'prets.date_debut as date_action',
                        DB::raw("'indigo' as color"),
                        DB::raw("'fa-hand-holding-usd' as icon")
                    )
                    ->where('prets.statut', 'approuvé')
                    ->orderBy('prets.date_debut', 'DESC')
                    ->get()
            );
        }

        if ($type === 'sinistre') {
            return response()->json(
                DB::table('sinistres')
                    ->join('adherents', 'sinistres.adherent_id', '=', 'adherents.id')
                    ->select(
                        DB::raw("'sinistre' as type"),
                        DB::raw("CONCAT(adherents.nom, ' ', adherents.prenom) as description"),
                        DB::raw("CONCAT('Sinistre ', sinistres.type_sinistre, ' déclaré pour ', adherents.nom, ' ', adherents.prenom) as message"),
                        'sinistres.date_sinistre as date_action',
                        DB::raw("'red' as color"),
                        DB::raw("'fa-shield-alt' as icon")
                    )
                    ->orderBy('sinistres.date_sinistre', 'DESC')
                    ->get()
            );
        }

        return response()->json([]);
    }
}
