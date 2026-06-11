Config = {}

Config.Locale = {
    noLicenseTitle = 'Licença',
    noLicense = 'Não tens esse tipo de licença.',

    sex = {
        m = 'Masculino',
        f = 'Feminino'
    }
}

-- Tipos que o comando/evento pode pedir:
-- nil      = cartão cidadão
-- driver  = carta condução
-- weapon  = porte de arma
-- hunt    = licença caça
-- boat    = licença barco
-- police  = licença polícia
-- aviation = licença aviação
Config.CardTypes = {
    driver = {
        required = {'drive', 'drive_bike', 'drive_truck'}
    },

    weapon = {
        required = {'weapon'}
    },

    hunt = {
        required = {'hunt'}
    },

    boat = {
        required = {'boat'}
    },

    police = {
        required = {'police'}
    },

    aviation = {
        required = {'plane', 'helicopter', 'aviation_theory'}
    }
}

Config.LicenseLabels = {
    drive = 'Ligeiros',
    drive_bike = 'Mota',
    drive_truck = 'Pesados',

    weapon = 'Porte de Arma',
    hunt = 'Caça',
    boat = 'Barco',
    police = 'Polícia',

    plane = 'Avião',
    helicopter = 'Helicóptero',
    aviation_theory = 'Teórico Aviação'
}
