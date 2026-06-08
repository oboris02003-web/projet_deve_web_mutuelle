<?php

namespace App\Console\Commands;

use App\Models\User;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Hash;

class ResetTestPasswords extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'db:reset-test-passwords';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Réinitialise les mots de passe des adhérents de test à "password123"';

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $this->info('🔄 Réinitialisation des mots de passe des adhérents...');

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
            'zida.michel@email.bf',
        ];

        $password = Hash::make('password123');
        $count = 0;

        foreach ($emails as $email) {
            $updated = User::where('email', $email)->update(['password' => $password]);
            if ($updated) {
                $this->line("  ✓ <fg=green>Password reset for: $email</>");
                $count++;
            } else {
                $this->line("  ✗ <fg=red>User not found: $email</>");
            }
        }

        $this->newLine();
        $this->info("✅ $count utilisateurs réinitialisés");
        $this->info("Mot de passe: <fg=yellow>password123</>");
        
        return 0;
    }
}
