local SpamDelay = 0
local SpamDelay13 = 0
Citizen.CreateThread(function()
while true do
Citizen.Wait(1000)
	if SpamDelay > 0 then
		SpamDelay = SpamDelay - 1
	else
		SpamDelay = 0
	end

	if SpamDelay13 > 0 then
		SpamDelay13 = SpamDelay13 - 1
	else
		SpamDelay13 = 0
	end
end
end)


--[[          Komenda 10-13          ]]

RegisterCommand('10-13', function()
	local Dane = nil
	ESX.TriggerServerCallback('ambulance:getName', function(cb)
		Dane = cb

	--print(json.encode(ESX.GetPlayerData()))
	if ESX.PlayerData.job.name == 'ambulance' then
		if SpamDelay13 == 0 then
			--SpamDelay13 = 30
			local coords = GetEntityCoords(PlayerPedId())
			local Panic2 = {
				code = "10-13",
				street = Dane,
				id = exports['esx_dispatch']:randomId(),
				priority = 2,
				title = "Ranny medyk",
				duration = 9000,
				blipname = "# Ranny medyk",
				color = 75,
				sprite = 280,
				fadeOut = 180,
				position = {
					x = coords.x,
					y = coords.y,
					z = coords.z
				},
				job = "police"
			}
			local Panic3 = {
				code = "10-13",
				street = Dane,
				id = exports['esx_dispatch']:randomId(),
				priority = 2,
				title = "Ranny medyk",
				duration = 9000,
				blipname = "# Ranny medyk",
				color = 75,
				sprite = 280,
				fadeOut = 180,
				position = {
					x = coords.x,
					y = coords.y,
					z = coords.z
				},
				job = "ambulance"
			}
			TriggerServerEvent("dispatch:svNotify", Panic2)
			TriggerServerEvent("dispatch:svNotify", Panic3)
		else
			Many:Notify('inform', 'Musisz odczekać '..SpamDelay13..'s zanim wyślesz kolejną 13stke')
		end
	else
		Many:Notify('inform', 'Nie jesteś w wymaganej frakcji!')
	end
end)
end)

RegisterCommand('ds', function(source, args)

	if ESX.PlayerData.job.name == 'ambulance'then
		messagetag = table.concat(args, " ")
		local coords = GetEntityCoords(PlayerPedId())
		mix = messagetag
		local Panic2 = {
			code = "dispatch",
			street = messagetag,
			--street = exports['esx_dispatch']:GetStreetAndZone(),
			id = exports['esx_dispatch']:randomId(),
			priority = 2,
			title = "DISPATCH",
			duration = 9000,
			blipname = "Dispatch",
			color = 75,
			sprite = 280,
			fadeOut = 180,
			position = {
				x = coords.x,
				y = coords.y,
				z = coords.z
			},
			job = "ambulance"
		}
		TriggerServerEvent("dispatch:svNotify", Panic2)
	else
		if ESX.PlayerData.job.name ~= 'police' then
		Many:Notify('inform', 'Nie jesteś w wymaganej frakcji!')
		end
	end

	if ESX.PlayerData.job.name == 'police' then

		message = table.concat(args, " ")
		local coords = GetEntityCoords(PlayerPedId())
		local Panic3 = {
			code = "dispatch",
			street = message,
			--street = exports['esx_dispatch']:GetStreetAndZone(),
			id = exports['esx_dispatch']:randomId(),
			priority = 2,
			title = "DISPATCH",
			duration = 9000,
			blipname = "Dispatch",
			color = 75,
			sprite = 280,
			fadeOut = 180,
			position = {
				x = coords.x,
				y = coords.y,
				z = coords.z
			},
			job = "police"
		}
		
		TriggerServerEvent("dispatch:svNotify", Panic3)
	else
		if ESX.PlayerData.job.name ~= 'ambulance' then
		Many:Notify('inform', 'Nie jesteś w wymaganej frakcji!')
		end
	end
end)



--[[         Komenda /911            ]]
RegisterCommand('911', function()
		if IsEntityPlayingAnim(PlayerPedId(), "dead", "dead_a", 3) or IsDead then
			if SpamDelay == 0 then
			local coords = GetEntityCoords(PlayerPedId())
			local Panic = {
				code = "10-14",
				street = exports['esx_dispatch']:GetStreetAndZone(),
				id = exports['esx_dispatch']:randomId(),
				priority = 2,
				title = "Ranny obywatel",
				duration = 10000,
				blipname = "# Ranny obywatel",
				color = 75,
				sprite = 1,
				fadeOut = 180,
				position = {
					x = coords.x,
					y = coords.y,
					z = coords.z
				},
				job = "ambulance"
			}
			TriggerServerEvent("dispatch:svNotify", Panic)
			SpamDelay = 60
			Many:Notify('inform', 'Wysłano zgłoszenie!')
			else
				Many:Notify('inform', 'Następne zgłoszenie możesz wysłać za! '..SpamDelay..'s')
			end
		else
			Many:Notify('inform', 'Nie jesteś ranny!')
		end
end)
