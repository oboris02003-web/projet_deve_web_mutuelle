<?php

namespace App\Http\Controllers;

use App\Models\Adherent;
use App\Models\AyantDroit;
use Illuminate\Http\Request;

class AdherentController extends Controller
{
    public function index()
    {
        return response()->json(Adherent::with(['cotisations', 'prets', 'sinistres', 'ayantsDroit'])->get());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'nom' => 'required|string',
            'prenom' => 'required|string',
            'email' => 'required|email|unique:adherents',
            'telephone' => 'required|string',
            'numero_adherent' => 'required|unique:adherents',
            'date_inscription' => 'required|date',
        ]);

        $adherent = Adherent::create($validated);
        return response()->json($adherent, 201);
    }

    public function show($id)
    {
        $adherent = Adherent::with(['cotisations', 'prets', 'sinistres', 'ayantsDroit'])->find($id);
        if (!$adherent) {
            return response()->json(['error' => 'Adhérent non trouvé'], 404);
        }
        return response()->json($adherent);
    }

    public function update(Request $request, $id)
    {
        $adherent = Adherent::find($id);
        if (!$adherent) {
            return response()->json(['error' => 'Adhérent non trouvé'], 404);
        }

        $validated = $request->validate([
            'nom' => 'string',
            'prenom' => 'string',
            'email' => 'email|unique:adherents,email,' . $id,
            'telephone' => 'string',
            'statut' => 'in:actif,suspendu,retraite',
        ]);

        $adherent->update($validated);
        return response()->json($adherent);
    }

    public function destroy($id)
    {
        $adherent = Adherent::find($id);
        if (!$adherent) {
            return response()->json(['error' => 'Adhérent non trouvé'], 404);
        }
        $adherent->delete();
        return response()->json(['message' => 'Adhérent supprimé']);
    }

    // ── Ayants droit ──────────────────────────────────────────────
    public function getAyantsDroit($adherent_id)
    {
        $adherent = Adherent::find($adherent_id);
        if (!$adherent) {
            return response()->json(['error' => 'Adhérent non trouvé'], 404);
        }
        return response()->json($adherent->ayantsDroit);
    }

    public function storeAyantDroit(Request $request, $adherent_id)
    {
        $adherent = Adherent::find($adherent_id);
        if (!$adherent) {
            return response()->json(['error' => 'Adhérent non trouvé'], 404);
        }

        $validated = $request->validate([
            'nom' => 'required|string',
            'prenom' => 'required|string',
            'relation' => 'required|string|in:epoux,conjoint,enfant,parent,autre',
            'date_naissance' => 'nullable|date',
        ]);

        $ayantDroit = $adherent->ayantsDroit()->create($validated);
        return response()->json($ayantDroit, 201);
    }

    public function updateAyantDroit(Request $request, $adherent_id, $id)
    {
        $adherent = Adherent::find($adherent_id);
        if (!$adherent) {
            return response()->json(['error' => 'Adhérent non trouvé'], 404);
        }

        $ayantDroit = $adherent->ayantsDroit()->find($id);
        if (!$ayantDroit) {
            return response()->json(['error' => 'Ayant droit non trouvé'], 404);
        }

        $validated = $request->validate([
            'nom' => 'string',
            'prenom' => 'string',
            'relation' => 'string|in:epoux,conjoint,enfant,parent,autre',
            'date_naissance' => 'nullable|date',
        ]);

        $ayantDroit->update($validated);
        return response()->json($ayantDroit);
    }

    public function destroyAyantDroit($adherent_id, $id)
    {
        $adherent = Adherent::find($adherent_id);
        if (!$adherent) {
            return response()->json(['error' => 'Adhérent non trouvé'], 404);
        }

        $ayantDroit = $adherent->ayantsDroit()->find($id);
        if (!$ayantDroit) {
            return response()->json(['error' => 'Ayant droit non trouvé'], 404);
        }

        $ayantDroit->delete();
        return response()->json(['message' => 'Ayant droit supprimé']);
    }

    public function export(Request $request)
    {
        try {
            $format = $request->query('format', 'csv');
            $adherents = Adherent::get();

            $data = [];
            $data[] = ['Numéro Adhérent', 'Nom', 'Prénom', 'Email', 'Téléphone', 'Statut', 'Date Inscription'];

            foreach ($adherents as $adherent) {
                $data[] = [
                    $adherent->numero_adherent ?? '',
                    $adherent->nom ?? '',
                    $adherent->prenom ?? '',
                    $adherent->email ?? '',
                    $adherent->telephone ?? '',
                    $adherent->statut ?? '',
                    $adherent->date_inscription ? (is_string($adherent->date_inscription) ? $adherent->date_inscription : $adherent->date_inscription->format('Y-m-d')) : ''
                ];
            }

            return $this->generateExport($data, 'adherents', $format);
        } catch (\Exception $e) {
            return response()->json(['error' => 'Erreur export adhérents: ' . $e->getMessage()], 500);
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
