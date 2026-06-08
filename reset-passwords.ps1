# Script pour réinitialiser les mots de passe des adhérents de test
# Mot de passe: password123

$BackendPath = "$PSScriptRoot\backend"
Set-Location $BackendPath

Write-Host "🔄 Réinitialisation des mots de passe en cours..." -ForegroundColor Cyan

$TinkerScript = @"
use App\Models\User;
use Illuminate\Support\Facades\Hash;

`$emails = [
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

`$password = Hash::make('password123');

foreach (`$emails as `$email) {
    User::where('email', `$email)->update(['password' => `$password]);
    echo "✓ Password reset for: `$email\n";
}

echo "\n✅ All passwords reset to: password123\n";
"@

# Exécuter via php artisan tinker
$TinkerScript | php artisan tinker

Write-Host "`n✅ Done! Vous pouvez maintenant vous connecter avec:" -ForegroundColor Green
Write-Host "Email: diallo.fatoumata@email.bf" -ForegroundColor Yellow
Write-Host "Mot de passe: password123" -ForegroundColor Yellow
