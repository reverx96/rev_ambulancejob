Config                            = {}
Config.DrawDistance               = 15.0
Config.MarkerColor                = { r = 56, g = 197, b = 201 }
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.Sprite  = 61
Config.Display = 4
Config.Scale   = 1.0
Config.Colour  = 11

Config.LoadIpl                    = false
Config.Locale = 'en'
Config.RespawnToHospitalDelay		= 300 000
Config.EarlyRespawnTimer = 60000*5
Config.EarlyRespawnTimerr = 1000

Config.ReviveReward               = 50
Config.BasiaOff                   = -1
 
bedNames = {
	'v_med_bed2',
    'gn_med_bed_prop',
    'gn_med_bed_tray_prop',
}
 
local second = 1000
local minute = 60 * second
 
-- How much time before auto respawn at hospital
Config.RespawnDelayAfterRPDeath   = 5 * minute
 
Config.EnablePlayerManagement       = true
Config.EnableSocietyOwnedVehicles   = false
 
Config.RemoveWeaponsAfterRPDeath    = false
Config.RemoveCashAfterRPDeath       = false
Config.RemoveItemsAfterRPDeath      = false
 
Config.ShowDeathTimer               = false
 
Config.EarlyRespawn                 = false

Config.EarlyRespawnFine                  = false
Config.EarlyRespawnFineAmount            = 3000

Config.AmbulanceCars= {
    {
        label = 'Lodówa',
        grade = 0,
        licence = 'none',
        args = 'ambulance4',
    },
    {
        label = 'Speedo',
        grade = 2,
        licence = 'none',
        args = 'emsexpress',
    },
    {
        label = 'Explorer',
        grade = 0,
        licence = 'msr',
        args = 'ranchopdscout',
    },
    {
        label = 'Caracara WSR',
        grade = 0,
        licence = 'wsr',
        args = 'safeteam',
    },
    {
        label = 'Jeep RRU',
        grade = 2,
        licence = 'rru',
        args = 'ms_jeep',
    },

    {
        label = 'GMC Zarząd',
        grade = 8,
        licence = 'none',
        args = 'gmcat4',
    },
    
}

Config.WindaCruside = {
	{
		label = 'Garaż',
		winda = vector3( 319.49185180664, -1421.2459716797, 29.918966293335),
		hedding = 132.66716003418,
		guzik = vector3(319.62609863281,  -1424.0573730469, 29.9176197052),
	},
	{
		label = '1wsze Piętro',
		winda = vector3(348.04833984375, -1408.0795898438, 32.510498046875),
		hedding = 50.002895355225,
		guzik = vector3(345.48477172852, -1407.5559082031, 32.504928588867),
	},
	{
		label = '2gie Piętro',
		winda = vector3(348.37423706055, -1407.8934326172, 36.511722564697),
		hedding = 50.002895355225,
		guzik = vector3(345.49395751953,-1407.4763183594, 36.516036987305),
	},
	{
		label = 'Helipad',
		winda = vector3(340.32034301758,  -1423.8021240234,  46.509273529053),
		hedding = 136.56834411621,
		guzik = vector3(339.67330932617, -1426.8190917969, 46.507053375244),
	},

}

Config.WindaPillbox = {
	{
		label = 'Garaż',
		winda = vector3( 326.87454223633, -578.92987060547, 28.759746551514),
		hedding = 338.34536743164,
		guzik = vector3(325.67929077148, -575.97229003906, 28.758306503296),
	},
	{
		label = '1wsze Piętro',
		winda = vector3(306.28695678711,  -591.75604248047, 43.270980834961),
		hedding = 66.212028503418,
		guzik = vector3(303.66061401367, -592.17742919922,  43.265365600586),
	},
	{
		label = '2gie Piętro',
		winda = vector3(306.38717651367,  -591.90588378906, 47.276748657227),
		hedding = 69.625205993652,
		guzik = vector3(303.66638183594, -592.10339355469, 47.276550292969),
	},
	{
		label = 'Helipad',
		winda = vector3(329.71740722656,  -581.80889892578,  74.18041229248),
		hedding = 243.7278137207,
		guzik = vector3(332.28408813477,  -581.58172607422,  74.178276062012),
	},

}

Config.Uniforms = {
    strojnurek = {
        male = {
            ['tshirt_1'] = 151,  ['tshirt_2'] = 0,
            ['torso_1'] = 243,  ['torso_2'] = 0,
            ['decals_1'] = 0,  ['decals_2'] = 0,
            ['arms'] = 17,  ['arms_2'] = 0,
            ['pants_1'] = 94,  ['pants_2'] = 0,
            ['shoes_1'] = 67,  ['shoes_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['chain_1'] = 0,  ['chain_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['mask_1'] = 56,  ['mask_2'] = 1,
            ['glasses_1'] = 25,  ['glasses_2'] = 4,
            ['parachute_1'] = 0,  ['parachute_2'] = 0
        },
        female = {
            ['tshirt_1'] = 187,  ['tshirt_2'] = 0,
            ['torso_1'] = 251,  ['torso_2'] = 0,
            ['decals_1'] = 0,  ['decals_2'] = 0,
            ['arms'] = 18,  ['arms_2'] = 0,
            ['pants_1'] = 97,  ['pants_2'] = 0,
            ['shoes_1'] = 70,  ['shoes_2'] = 0,
            ['bproof_1'] = 0,  ['bproof_2'] = 0,
            ['chain_1'] = 0,  ['chain_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['bags_1'] = 0,  ['bags_2'] = 0,
            ['mask_1'] = 56,  ['mask_2'] = 1,
            ['glasses_1'] = 27,  ['glasses_2'] = 4,
            ['parachute_1'] = 0,  ['parachute_2'] = 0
        }
    },

}

Config.dictionary_reson = {
['suicide'] = 'próbował popełnić samobójstwo', 
['died'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn', 
['murdered'] = 'wygląda na pobitego',
['torched'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['knifed'] = 'posiada rany cięte prawdopodobnie od noża', 
['pistoled'] = 'posiada rany postrzałowe',
['riddled'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['rifled'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['machinegunned'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['pulverized'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['sniped'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['shredded'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['bombed'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['movedover'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['flattened'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
['killed'] = 'otrzymał obrażenia z niewyjaśnionych przyczyn',
}