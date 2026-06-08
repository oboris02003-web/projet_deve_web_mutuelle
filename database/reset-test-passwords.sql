-- Réinitialise les mots de passe des adhérents de test
-- Mot de passe: "password123"
-- Hash bcrypt généré avec Laravel Hash::make('password123')

UPDATE users 
SET password = '$2y$12$oqvHK2iiO2fKsEqJBYsRdeCfhP.kCwHrLGJ7dzb9vvDVJLWlDTBE.'
WHERE email IN (
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
);

-- Vérification
SELECT email, name FROM users WHERE email LIKE '%.bf' ORDER BY email;
