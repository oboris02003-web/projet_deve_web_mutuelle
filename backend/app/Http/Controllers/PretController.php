<?php

namespace App\Http\Controllers;

use App\Models\Pret;
use Illuminate\Http\Request;

class PretController extends Controller
{
    public function index()
    {
        return response()->json(Pret::with(['adherent', 'remboursements'])->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'adherent_id' => 'required|exists:adherents,id',
            'montant' => 'required|numeric',
            'taux_interet' => 'numeric',
            'duree_mois' => 'required|integer',
            'date_debut' => 'required|date',
        ]);

        $pret = Pret::create($validated);
        return response()->json($pret, 201);
    }

    public function show($id)
    {
        $pret = Pret::with(['adherent', 'remboursements'])->find($id);
        if (!$pret) {
            return response()->json(['error' => 'Prêt non trouvé'], 404);
        }
        return response()->json($pret);
    }

    public function update(Request $request, $id)
    {
        $pret = Pret::find($id);
        if (!$pret) {
            return response()->json(['error' => 'Prêt non trouvé'], 404);
        }

        $validated = $request->validate([
            'statut' => 'in:en attente,approuvé,remboursé,rejeté',
            'date_fin' => 'date',
        ]);

        $pret->update($validated);
        return response()->json($pret);
    }

    public function destroy($id)
    {
        $pret = Pret::find($id);
        if (!$pret) {
            return response()->json(['error' => 'Prêt non trouvé'], 404);
        }
        $pret->delete();
        return response()->json(['message' => 'Prêt supprimé']);
    }

    public function export(Request $request)
    {
        try {
            $format = $request->query('format', 'csv');
            $prets = Pret::with('adherent')->get();

            $data = [];
            $data[] = ['ID', 'Adhérent', 'Montant', 'Taux', 'Durée', 'Statut', 'Date Demande'];

            foreach ($prets as $pret) {
                $data[] = [
                    $pret->id ?? '',
                    $pret->adherent ? ($pret->adherent->nom ?? '') . ' ' . ($pret->adherent->prenom ?? '') : '',
                    $pret->montant ?? '',
                    $pret->taux_interet ?? '',
                    $pret->duree_mois ?? '',
                    $pret->statut ?? '',
                    $pret->date_debut ? (is_string($pret->date_debut) ? $pret->date_debut : $pret->date_debut->format('Y-m-d')) : ''
                ];
            }

            return $this->generateExport($data, 'prets', $format);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Erreur export prets: ' . $e->getMessage()], 500);
        }
    }

    private function generateExport($data, $filename, $format)
    {
        $filename = $filename . '_' . date('Y-m-d_H-i-s');
        // Export fix v2
        if ($format === 'csv') {
            $csv = '';
            // BOM pour UTF-8
            $csv .= "\xEF\xBB\xBF";
            foreach ($data as $row) {
                $csv .= implode(',', array_map(function($field) {
                    return '"' . str_replace('"', '""', (string)$field) . '"';
                }, $row)) . "\n";
            }

            return response($csv, 200)
                ->header('Content-Type', 'text/csv; charset=utf-8')
                ->header('Content-Disposition', 'attachment; filename="' . $filename . '.csv"')
                ->header('Cache-Control', 'no-cache, no-store, must-revalidate')
                ->header('Pragma', 'no-cache')
                ->header('Expires', '0');
        }

        if ($format === 'xlsx' || $format === 'excel') {
            $csv = '';
            foreach ($data as $row) {
                $csv .= implode("\t", array_map(function($field) {
                    return (string)$field;
                }, $row)) . "\n";
            }

            return response($csv, 200)
                ->header('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet; charset=utf-8')
                ->header('Content-Disposition', 'attachment; filename="' . $filename . '.xlsx"')
                ->header('Cache-Control', 'no-cache, no-store, must-revalidate')
                ->header('Pragma', 'no-cache')
                ->header('Expires', '0');
        }

        if ($format === 'pdf') {
            $pdfContent = "Export des données - " . ucfirst($filename) . "\n\n";
            foreach ($data as $row) {
                $pdfContent .= implode(' | ', array_map(function($field) {
                    return (string)$field;
                }, $row)) . "\n";
            }

            return response($pdfContent, 200)
                ->header('Content-Type', 'text/plain; charset=utf-8')
                ->header('Content-Disposition', 'attachment; filename="' . $filename . '.txt"')
                ->header('Cache-Control', 'no-cache, no-store, must-revalidate')
                ->header('Pragma', 'no-cache')
                ->header('Expires', '0');
        }

        return response()->json(['error' => 'Format non supporté'], 400);
    }
}
