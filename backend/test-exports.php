<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make('Illuminate\Contracts\Http\Kernel');

// Test Adherent
try {
    $adherents = \App\Models\Adherent::get();
    echo "✓ Adherents: " . $adherents->count() . " records\n";
} catch (\Exception $e) {
    echo "✗ Adherents Error: " . $e->getMessage() . "\n";
}

// Test Cotisation
try {
    $cotisations = \App\Models\Cotisation::get();
    echo "✓ Cotisations: " . $cotisations->count() . " records\n";
} catch (\Exception $e) {
    echo "✗ Cotisations Error: " . $e->getMessage() . "\n";
}

// Test Pret
try {
    $prets = \App\Models\Pret::with('adherent')->get();
    echo "✓ Prets: " . $prets->count() . " records\n";
} catch (\Exception $e) {
    echo "✗ Prets Error: " . $e->getMessage() . "\n";
}

// Test Sinistre
try {
    $sinistres = \App\Models\Sinistre::with('adherent')->get();
    echo "✓ Sinistres: " . $sinistres->count() . " records\n";
} catch (\Exception $e) {
    echo "✗ Sinistres Error: " . $e->getMessage() . "\n";
}
