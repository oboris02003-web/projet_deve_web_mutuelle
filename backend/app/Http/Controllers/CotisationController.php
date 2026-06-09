<?php

namespace App\Http\Controllers;

use App\Models\Cotisation;
use Illuminate\Http\Request;

class CotisationController extends Controller
{
    public function index()
    {
        return response()->json(Cotisation::with('adherent')->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'adherent_id' => 'required|exists:adherents,id',
            'montant' => 'required|numeric',
            'date_echeance' => 'required|date',
            'mode_paiement' => 'nullable|in:virement,cheque,especes,carte',
            'statut' => 'nullable|in:en attente,payée,en retard,annulée',
        ]);

        $cotisation = Cotisation::create($validated);
        return response()->json($cotisation, 201);
    }

    public function show($id)
    {
        $cotisation = Cotisation::with('adherent')->find($id);
        if (!$cotisation) {
            return response()->json(['error' => 'Cotisation non trouvée'], 404);
        }
        return response()->json($cotisation);
    }

    public function update(Request $request, $id)
    {
        $cotisation = Cotisation::find($id);
        if (!$cotisation) {
            return response()->json(['error' => 'Cotisation non trouvée'], 404);
        }

        $validated = $request->validate([
            'statut' => 'in:en attente,payée,en retard,annulée',
            'date_paiement' => 'date',
            'reference_paiement' => 'string',
        ]);

        $cotisation->update($validated);
        return response()->json($cotisation);
    }

    public function destroy($id)
    {
        $cotisation = Cotisation::find($id);
        if (!$cotisation) {
            return response()->json(['error' => 'Cotisation non trouvée'], 404);
        }
        $cotisation->delete();
        return response()->json(['message' => 'Cotisation supprimée']);
    }

    public function export(Request $request)
    {
        try {
            $format = $request->query('format', 'csv');
            $cotisations = Cotisation::with('adherent')->get();

            $data = [];
            $data[] = ['ID', 'Adhérent', 'Montant', 'Échéance', 'Statut', 'Date Paiement', 'Mode Paiement'];

            foreach ($cotisations as $cotisation) {
                $data[] = [
                    $cotisation->id ?? '',
                    $cotisation->adherent ? ($cotisation->adherent->nom ?? '') . ' ' . ($cotisation->adherent->prenom ?? '') : '',
                    $cotisation->montant ?? '',
                    $cotisation->date_echeance ? (is_string($cotisation->date_echeance) ? $cotisation->date_echeance : $cotisation->date_echeance->format('Y-m-d')) : '',
                    $cotisation->statut ?? '',
                    $cotisation->date_paiement ? (is_string($cotisation->date_paiement) ? $cotisation->date_paiement : $cotisation->date_paiement->format('Y-m-d')) : '',
                    $cotisation->mode_paiement ?? ''
                ];
            }

            return $this->generateExport($data, 'cotisations', $format);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Erreur export cotisations: ' . $e->getMessage()], 500);
        }
    }

    private function generateExport($data, $filename, $format)
    {
        $filename = $filename . '_' . date('Y-m-d_H-i-s');

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
