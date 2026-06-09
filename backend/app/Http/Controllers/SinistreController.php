<?php

namespace App\Http\Controllers;

use App\Models\Sinistre;
use Illuminate\Http\Request;

class SinistreController extends Controller
{
    public function index()
    {
        return response()->json(Sinistre::with(['adherent', 'prestations'])->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'adherent_id' => 'required|exists:adherents,id',
            'description' => 'required|string',
            'date_sinistre' => 'required|date',
            'type' => 'nullable|in:maladie,accident,décès,hospitalisation,autre',
            'statut' => 'nullable|in:déclaré,en cours,approuvé,rejeté,remboursé',
        ]);

        // Map 'type' to 'type_sinistre' for database compatibility
        $validated['type_sinistre'] = $validated['type'] ?? 'autre';
        unset($validated['type']);
        
        $validated['statut'] = $validated['statut'] ?? 'déclaré';

        $sinistre = Sinistre::create($validated);
        return response()->json($sinistre, 201);
    }

    public function show($id)
    {
        $sinistre = Sinistre::with(['adherent', 'prestations'])->find($id);
        if (!$sinistre) {
            return response()->json(['error' => 'Sinistre non trouvé'], 404);
        }
        return response()->json($sinistre);
    }

    public function update(Request $request, $id)
    {
        $sinistre = Sinistre::find($id);
        if (!$sinistre) {
            return response()->json(['error' => 'Sinistre non trouvé'], 404);
        }

        $validated = $request->validate([
            'statut' => 'in:déclaré,en cours,approuvé,rejeté,remboursé',
            'montant_reclamation' => 'numeric',
            'montant_remboursement' => 'numeric',
        ]);

        $sinistre->update($validated);
        return response()->json($sinistre);
    }

    public function destroy($id)
    {
        $sinistre = Sinistre::find($id);
        if (!$sinistre) {
            return response()->json(['error' => 'Sinistre non trouvé'], 404);
        }
        $sinistre->delete();
        return response()->json(['message' => 'Sinistre supprimé']);
    }

    public function export(Request $request)
    {
        try {
            $format = $request->query('format', 'csv');
            $sinistres = Sinistre::with('adherent')->get();

            $data = [];
            $data[] = ['ID', 'Adhérent', 'Type', 'Description', 'Montant Réclamé', 'Statut', 'Date Déclaration'];

            foreach ($sinistres as $sinistre) {
                $data[] = [
                    $sinistre->id ?? '',
                    $sinistre->adherent ? ($sinistre->adherent->nom ?? '') . ' ' . ($sinistre->adherent->prenom ?? '') : '',
                    $sinistre->type_sinistre ?? '',
                    $sinistre->description ?? '',
                    $sinistre->montant_reclamation ?? '',
                    $sinistre->statut ?? '',
                    $sinistre->date_sinistre ? (is_string($sinistre->date_sinistre) ? $sinistre->date_sinistre : $sinistre->date_sinistre->format('Y-m-d')) : ''
                ];
            }

            return $this->generateExport($data, 'sinistres', $format);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Erreur export sinistres: ' . $e->getMessage()], 500);
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
