exports['qtarget']:AddBoxZone("AmbulanceVehicle", vector3(314.49044799805,  -1420.0496826172,  29.717629241943), 1.2, 1.2, {
	name="AmbulanceVehicle",
	heading=340,
	--debugPoly=false,
	minZ=28.0,
	maxZ=29.29,
	}, {
		options = {
			{
				event = "ambulance:getvechicle",
				icon = "fas fa-car",
				label = "Wyjmij Pojazd",
				job = "ambulance"
			},
			{
				event = "esx_ambulancejob:removevehicle",
				icon = "fas fa-car",
				label = "Schowaj Pojazd",
				job = "ambulance"
			},
		},
		distance = 3.5
})

exports['qtarget']:AddBoxZone("AmbulanceVehicle", vector3(332.36654663086,  -577.53961181641, 28.55830841064), 1.2, 1.2, {
	name="AmbulanceVehicle",
	heading=340,
	--debugPoly=false,
	minZ=28.0,
	maxZ=29.29,
	}, {
		options = {
			{
				event = "ambulance:getvechicle",
				icon = "fas fa-car",
				label = "Wyjmij Pojazd",
				job = "ambulance"
			},
			{
				event = "esx_ambulancejob:removevehicle",
				icon = "fas fa-car",
				label = "Schowaj Pojazd",
				job = "ambulance"
			},
		},
		distance = 3.5
})

exports['qtarget']:AddBoxZone("SzafkaPriv",vector3( 355.66802978516, -1413.9439208984, 30.504932403564), 1.7, 1.3, {
	name="SzafkaPriv",
	heading=3.1395,
	--debugPoly=false,
	minZ=30.02,
	maxZ=33.72,
	}, {
		options = {
			{
				action = function()
					exports.ox_inventory:openInventory('stash','emslocker')
				end,
				icon = "fas fa-box",
				label = "Szafka personalna",
				job = "ambulance",
			},
		},
		distance = 3.0
})


exports['qtarget']:AddBoxZone("AmbulanceVehicle", vector3(-253.51791381836,  6338.748046875,  31.426078796387), 0.8, 0.8, {
	name="AmbulanceVehicle",
	heading=340,
	--debugPoly=false,
	minZ=30.0,
	maxZ=32.29,
	}, {
		options = {
			{
				event = "ambulance:getvechicle",
				icon = "fas fa-car",
				label = "Wyjmij Pojazd",
				job = "ambulance"
			},
			{
				event = "esx_ambulancejob:removevehicle",
				icon = "fas fa-car",
				label = "Schowaj Pojazd",
				job = "ambulance"
			},
			{
				event = "esx_ambulancejob:heli",
				icon = "fas fa-helicopter",
				label = "Wyjmij Helikopter",
				job = 'ambulance',
				licence = 'pilot',
			},
			{
				event = "esx_ambulancejob:removeheli",
				icon = "fas fa-helicopter",
				label = "Schowaj Helikopter",
				job = 'ambulance',
			},
		},
		distance = 3.5
})

exports['qtarget']:AddBoxZone("AmbulanceVehicle", vector3(298.70867919922, -587.31231689453, 43.260845184326), 0.8, 0.8, {
	name="AmbulanceVehicle",
	heading=238.79023742676,
	--debugPoly=false,
	minZ=28.0,
	maxZ=29.29,
	}, {
		options = {
			{
				event = "esx_ambulancejob:removevehicle",
				icon = "fas fa-car",
				label = "Schowaj Pojazd",
				job = "ambulance"
			},
		},
		distance = 3.5
})

exports['qtarget']:AddBoxZone("AmbulanceHeli", vector3( 337.46530151367, -1433.4030761719,  46.513053894043), 0.8, 0.8, {
	name="AmbulanceHeli",
	heading=340,
	--debugPoly=false,
	minZ=74.16,
	maxZ=74.96,
	}, {
		options = {
			{
				event = "esx_ambulancejob:heli",
				icon = "fas fa-helicopter",
				label = "Wyjmij Helikopter",
				job = 'ambulance',
				licence = 'pilot',
			},
			{
				event = "esx_ambulancejob:removeheli",
				icon = "fas fa-helicopter",
				label = "Schowaj Helikopter",
				job = 'ambulance',
			},
		},
		distance = 2.5
})
exports['qtarget']:AddBoxZone("AmbulanceHeli", vector3( 337.69915771484,  -586.66815185547,  74.160102844238), 0.8, 0.8, {
	name="AmbulanceHeli",
	heading=340,
	--debugPoly=false,
	minZ=74.16,
	maxZ=74.96,
	}, {
		options = {
			{
				event = "esx_ambulancejob:heli",
				icon = "fas fa-helicopter",
				label = "Wyjmij Helikopter",
				job = 'ambulance',
				licence = 'pilot',
			},
			{
				event = "esx_ambulancejob:removeheli",
				icon = "fas fa-helicopter",
				label = "Schowaj Helikopter",
				job = 'ambulance',
			},
		},
		distance = 2.5
})

-- x = 351.59442138672, y = -1409.9361572266, z = 32.504909515381, h = 319.67617797852
exports['qtarget']:AddBoxZone("PrzebieralniaEMS", vector3(351.59442138672, -1409.9361572266, 32.304909515381), 1.7, 1.3, {
	name="PrzebieralniaEMS",
	heading=68.7154,
	--debugPoly=false,
	minZ=42.2841,
	maxZ=44.2841,
	}, {
		options = {
			{
				event = "fivem-appearance:clothingShop",
				icon = "fas fa-tshirt",
				label = "Przebierz się",
				job = "ambulance",
				price = 0,
				num = 1
			},
			{
				action = function()
					SzatniaEMS()
				end,
				icon = "fas fa-tshirt",
				label = "Wybierz strój",
				job = "ambulance",
				num = 2
			},
		},
		distance = 3.0
})

exports['qtarget']:AddBoxZone("PrzebieralniaEMS", vector3(313.31729125977,  -598.79089355469,  42.826538848877), 1.7, 1.3, {
	name="PrzebieralniaEMS",
	heading=68.7154,
	--debugPoly=false,
	minZ=42.2841,
	maxZ=44.2841,
	}, {
		options = {
			{
				event = "fivem-appearance:clothingShop",
				icon = "fas fa-tshirt",
				label = "Przebierz się",
				job = "ambulance",
				price = 0,
				num = 1
			},
			{
				action = function()
					SzatniaEMS()
				end,
				icon = "fas fa-tshirt",
				label = "Wybierz strój",
				job = "ambulance",
				num = 2
			},
		},
		distance = 3.0
})


function SzafkaMIAfunction()
    Citizen.CreateThread(function()
            Citizen.Wait(200)
        if PlayerLicence['mia'] then
        exports['qtarget']:AddCircleZone("Szafka MIA",vec3(367.19549560547, -1404.6831054688, 36.404941558838), 0.7, {
            name="Szafka MIA",
            debugPoly=false,
            }, {
                options = {
                    {
                        event = "esx_ambulancejob:miastash",
                        icon = "fas fa-briefcase",
                        label = "Szafka MIA",
                        job = "ambulance",
                        num = 1,
                    },
                    {
                        event = 'esx_policejob:kosz',
                        icon = "fas fa-box",
                        label = "Kosz",
                        job = "ambulance",
                    },
                    {
                        event = 'esx_policejob:dumpkosz',
                        icon = "fas fa-box",
                        label = "Opróżnij Kosz",
                        job = "ambulance",
                    },
                },
                distance = 3.0,
        })
        else
            exports['qtarget']:AddCircleZone("Szafka MIA",vec3(367.19549560547, -1404.6831054688, 36.404941558838), 1.0, {
                name="Szafka MIA",
                debugPoly=false,
                }, {
                    options = {
                        {
                            event = 'esx_ambulancejob:kosz',
                            icon = "fas fa-box",
                            label = "Kosz",
                            job = "ambulance",
                        },
                        {
                            event = 'esx_ambulancejob:dumpkosz',
                            icon = "fas fa-box",
                            label = "Opróżnij Kosz",
                            job = "ambulance",
                        },
                    },
                    distance = 3.0,
            })
        end
        end)
    end




    exports['qtarget']:AddCircleZone("Nadawanie odznak",vec3(380.24322509766, -1410.3818359375, 36.516063690186), 1.0, {
		name="Nadawanie odznak",
		debugPoly=false,
		}, {
			options = {
				{
					type = 'client',
					event = 'malina:client:nadajOdznakeEMS',
					icon = 'fas fa-box-open',
					label = 'Nadaj odznakę',
					canInteract = function()
						--print(ESX.PlayerData.job.name,ESX.PlayerData.job.grade)
						return ESX.PlayerData.job.name == 'ambulance' and ESX.PlayerData.job.grade >= 8
					end
				},
				{
					type = 'server',
					serverEvent = 'wyga:checkhours',
					icon = 'fas fa-clock',
					label = 'Pokaż godziny',
					canInteract = function()
						return ESX.PlayerData.job.name == 'ambulance' and ESX.PlayerData.job.grade >= 8
					end
				},
				{
					type = 'server',
					event = 'wyga:resethours',
					icon = 'fas fa-refresh',
					label = 'Resetuj godziny',
					canInteract = function()
						return ESX.PlayerData.job.name == 'ambulance' and ESX.PlayerData.job.grade >= 8
					end
				}
			},
			distance = 3.0,
	})

local newelements = {}
local newelements2 = {}
for k, v in ipairs(Config.WindaCruside) do
	table.insert(newelements, {label = v.label, value = v.winda, id = k, table = Config.WindaCruside})
	exports['qtarget']:AddCircleZone("Winda",v.guzik, 1.0, {
		name="Winda",
		debugPoly=false,
		}, {
			options = {
				{
					type = 'client',
					action = function()
						Winda(newelements)
					end,
					icon = "fas fa-door-closed",
					label = 'Winda',
				},
			},
			distance = 3.0,
	})
end

for k, v in ipairs(Config.WindaPillbox) do
	table.insert(newelements2, {label = v.label, value = v.winda, id = k, table = Config.WindaPillbox})
	exports['qtarget']:AddCircleZone("Winda",v.guzik, 1.0, {
		name="Winda",
		debugPoly=false,
		}, {
			options = {
				{
					type = 'client',
					action = function()
						Winda(newelements2)
					end,
					icon = "fas fa-door-closed",
					label = 'Winda',
				},
			},
			distance = 3.0,
	})
end


CreateThread(function()

	exports.qtarget:Player({
	options = {
		{
				 event = "esx_ambulancejob:client:ems_menu_revive",
				 icon = "fa-solid fa-briefcase-medical",
				 label = "Podnieś",
				 job = 'ambulance',
				 num = 0
		},
		{
				 event = "esx_ambulancejob:heal",
				 icon = "fa-solid fa-briefcase-medical",
				 label = "Ulecz",
				 job = 'ambulance',
				 num = 0
		},
		{

			icon = "fa-solid fa-search",
			label = "Zbadaj poszkodowanego",
			job = 'ambulance',
			num = 0,
			canInteract = function(entity)
				local flaga = false
				local p = promise.new()
					ESX.TriggerServerCallback('checkide', function(identifier)
						flaga = identifier.bool
						p:resolve()
					end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
				Citizen.Await(p)
				return flaga
			end,
			action = function(entity)
				ESX.TriggerServerCallback('checkide', function(identifier)
					--print(identifier, identifier.char, identifier.bool)
					local info = 'Badany przez Ciebie pacjent '..Config.dictionary_reson[GlobalState.DeathReasonCheck[identifier.char]]
		
		
					local ped = GetPlayerPed(-1) -- Pobierz aktualnego gracza (lub innego peda)
					local animDict, animName = 'amb@medic@standing@timeofdeath@idle_a', 'idle_c'
			
					if not HasAnimDictLoaded(animDict) then
						RequestAnimDict(animDict)
						while not HasAnimDictLoaded(animDict) do
							Citizen.Wait(0)
						end
					end
					ESX.ShowNotification('Sprawdzanie stanu pacjenta')
					-- Odtwórz animację
					TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, 16, 0, false, false, false)
					Wait(5000)
					ESX.ShowNotification(info)
				end, GetPlayerServerId(NetworkGetPlayerIndexFromPed(entity)))
			end,
   		},
		
	},
	distance = 2.0
	})
	end)
