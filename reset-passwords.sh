#!/bin/bash
# Script pour réinitialiser les mots de passe des adhérents de test
# Mot de passe: password123

cd backend

# Utilisez la console Laravel pour générer les hashs et mettre à jour
php artisan tinker << 'EOF'
use App\Models\User;
use Illuminate\Support\Facades\Hash;

$emails = [
    'diallo.fatoumata@email.bf',
    'traore.souleymane@email.bf',
    'kabore.awa@email.bf',
    'sanou.ibrahim@email.bf',
    'nikiema.pauline@email.bf',
    'ouattara.karim@email.bf',
    'bado.rasmata@email.bf',
    'yameogo.blaise@email.bf',
    'compaore.sophie@email.bf',
    'zida.michel@email.bf'
];

$password = Hash::make('password123');

foreach ($emails as $email) {
    User::where('email', $email)->update(['password' => $password]);
    echo "✓ Password reset for: $email\n";
}

echo "\n✅ All passwords reset to: password123\n";
EOF
