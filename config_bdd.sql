DROP TABLE IF EXISTS `adherents`,
`benevoles`,
`partenaires`,
`jeux`,
`emprunts`,
`evenements`,
`tokens`,
`users`,
`tokens_users`;

CREATE TABLE
    `adherents` (
        `id` int (11) NOT NULL,
        `nom` varchar(255) NOT NULL,
        `prenom` varchar(255) NOT NULL,
        `date_naissance` date NOT NULL,
        `sexe` enum ('M', 'F') NOT NULL,
        'niveau' enum (
            'L1',
            'L2',
            'L3',
            'M1',
            'M2, D, BUT1, BUT2, BUT3, DU1, DU2, DU3'
        ) NOT NULL,
        'formation' varchar(255) NOT NULL,
        'composante' enum ('FST', 'FLLASH', 'FDSPM (DROIT - IAE)', 'IUT') NOT NULL,
        'mail' varchar(255) NOT NULL,
        'tel' varchar(255) NOT NULL,
        'date_adhesion' date NOT NULL DEFAULT CURRENT_TIMESTAMP,
        'date_delivrance' date NOT NULL DEFAULT CURRENT_TIMESTAMP,
        'date_fin_adhesion' date NOT NULL DEFAULT CURRENT_TIMESTAMP + INTERVAL 1 YEAR,
        'id_benevole' int (11),
        PRIMARY KEY (`id`),
        FOREIGN KEY (`id_benevole`) REFERENCES `benevoles` (`no_adherent`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `benevoles` (
        `no_adherent` int (11) NOT NULL,
        `fonction` varchar(255) NOT NULL,
        PRIMARY KEY (`no_adherent`),
        FOREIGN KEY (`no_adherent`) REFERENCES `adherents` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `partenaires` (
        `id` int (11) NOT NULL AUTO_INCREMENT,
        `nom` varchar(255) NOT NULL,
        `adresse` varchar(255) NOT NULL,
        `tel` varchar(255) NOT NULL,
        `mail` varchar(255) NOT NULL,
        `site_web` varchar(255),
        `representant` varchar(255) NOT NULL,
        `fonction` varchar(255) NOT NULL,
        `date_signature` date NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `date_debut` date NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `date_fin` date,
        `obligations_bde` text NOT NULL,
        `obligations_partenaire` text NOT NULL,
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `jeux` (
        `id` int (11) NOT NULL AUTO_INCREMENT,
        `nom` varchar(255) NOT NULL,
        `etat` enum (`NEUF`, `BON_ETAT`, `ENDOMMAGE`) NOT NULL,
        `proprietaire` varchar(255) NOT NULL DEFAULT 'BDE LRU',
        `dispobilite` enum (`DISPONIBLE`, `INDISPONIBLE`) NOT NULL,
        `nbre_joueurs_min` int (11) NOT NULL,
        `nbre_joueurs_max` int (11) NOT NULL,
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `emprunts` (
        `id` int (11) NOT NULL AUTO_INCREMENT,
        `id_jeu` int (11) NOT NULL,
        `id_adherent` int (11) NOT NULL,
        `date_emprunt` date NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `date_retour` date,
        `caution` int (11) NOT NULL,
        `caution_moyen` enum ('CHEQUE', 'ESPECES') NOT NULL,
        PRIMARY KEY (`id`),
        FOREIGN KEY (`id_jeu`) REFERENCES `jeux` (`id`),
        FOREIGN KEY (`id_adherent`) REFERENCES `adherents` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `evenements` (
        `code` varchar(255) NOT NULL,
        `titre` varchar(255) NOT NULL,
        `date` date NOT NULL,
        `heure` time NOT NULL,
        `lieu` varchar(255) NOT NULL,
        `description` text NOT NULL,
        `validation_lieu` enum ('EN ATTENTE', 'VALIDE', 'ANNULE') NOT NULL,
        `validation_bde` enum ('EN ATTENTE', 'VALIDE', 'ANNULE') NOT NULL,
        `date_limite_validation` date NOT NULL,
        `date_validation` date,
        `date_limite_visuel` date NOT NULL,
        `visuel_effectue` enum ('OUI', 'NON') NOT NULL,
        `date_lancement_com` date NOT NULL,
        `date_limite_com` date NOT NULL,
        `com_interne` text NOT NULL,
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `users` (
        `id` int (11) NOT NULL AUTO_INCREMENT,
        `username` varchar(255) NOT NULL,
        `password` varchar(255) NOT NULL,
        `role` JSON NOT NULL DEFAULT '["ROLE_USER"]',
        PRIMARY KEY (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `tokens` (
        `id` int (11) NOT NULL AUTO_INCREMENT,
        `token` varchar(255) NOT NULL,
        `permissions` JSON NOT NULL,
        `date_creation` date NOT NULL DEFAULT CURRENT_TIMESTAMP,
        `date_expiration` date NOT NULL,
        PRIMARY KEY (`id`),
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE
    `tokens_users` (
        `id_token` int (11) NOT NULL,
        `id_user` int (11) NOT NULL,
        PRIMARY KEY (`id_token`, `id_user`),
        FOREIGN KEY (`id_token`) REFERENCES `tokens` (`id`),
        FOREIGN KEY (`id_user`) REFERENCES `users` (`id`)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8;