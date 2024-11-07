Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

 PlayerData				= {}
 FirstSpawn				= true
 IsDead					= false
 TimerThreadId	   = nil
 DistressThreadId	= nil
 HasAlreadyEnteredMarker	= false
 LastZone					= nil
 CurrentAction				= nil
 obezwladniony = false
 CurrentActionMsg			= ''
 CurrentActionData			= {}
 IsBusy					= false
 blockShooting = GetGameTimer()
 CurrentTask = {}
 Melee = { `WEAPON_UNARMED`, `WEAPON_KNUCKLE`, `WEAPON_BAT`, `WEAPON_FLASHLIGHT`, `WEAPON_HAMMER`, `WEAPON_CROWBAR`, `WEAPON_PIPEWRENCH`, `WEAPON_NIGHTSTICK`, `WEAPON_GOLFCLUB`, `WEAPON_WRENCH` }
 Knife = { `WEAPON_KNIFE`, `WEAPON_DAGGER`, `WEAPON_MACHETE`, `WEAPON_HATCHET`, `WEAPON_SWITCHBLADE`, `WEAPON_BATTLEAXE`, `WEAPON_BATTLEAXE`, `WEAPON_STONE_HATCHET` }
 Bullet = { `WEAPON_SNSPISTOL`, `WEAPON_SNSPISTOL_MK2`, `WEAPON_PISTOL50`, `WEAPON_VINTAGEPISTOL`, `WEAPON_PISTOL`, `WEAPON_MILITARYRIFLE`, `WEAPON_PISTOL_MK2`, `WEAPON_GADGETPISTOL`, `WEAPON_DOUBLEACTION`, `WEAPON_COMBATPISTOL`, `WEAPON_HEAVYPISTOL`, `WEAPON_DBSHOTGUN`, `WEAPON_SAWNOFFSHOTGUN`, `WEAPON_PUMPSHOTGUN`, `WEAPON_PUMPSHOTGUN_MK2`, `WEAPON_BULLPUPSHOTGUN`, `WEAPON_MICROSMG`, `WEAPON_SMG`, `WEAPON_SMG_MK2`, `WEAPON_ASSAULTSMG`, `WEAPON_COMBATPDW`, `WEAPON_GUSENBERG`, `WEAPON_COMPACTRIFLE`, `WEAPON_ASSAULTRIFLE`, `WEAPON_ASSAULTRIFLE`, `WEAPON_EMPLAUNCHER`, `WEAPON_FERTILIZERCAN`, `WEAPON_CARBINERIFLE`, `WEAPON_MARKSMANRIFLE`, `WEAPON_SNIPERRIFLE`, `WEAPON_NAVYREVOLVER`, `WEAPON_RPG` }
 Electricity = { `WEAPON_STUNGUN`, `WEAPON_STUNGUN_MP` }
 Animal = { -100946242, 148160082 }
 FallDamage = { -842959696 }
 Explosion = { -1568386805, 1305664598, -1312131151, 375527679, 324506233, 1752584910, -1813897027, 741814745, -37975472, 539292904, 341774354, -1090665087 }
 Gas = { -1600701090 }
 Burn = { 615608432, 883325847, -544306709 }
 Drown = { -10959621, 1936677264 }
 Car = { 133987706, -1553120962 }
 tekst = 0
 isUsing = false
 cam = nil

 PlayerLicence = {
	['pilot'] = false,
	['wsr'] = false,
	['msr'] = false,
	['mia'] = false,
	['coroner'] = false,
	['psycholog'] = false,
	['rru'] = false,
}


RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",	function(xPlayer)
  LocalPlayer.state:set('isDead', false, true)
    end)

  

 choosedHospital = nil
 heli = false
 qtarget = exports.qtarget
Many = exports['many-base']


ESX = exports['es_extended']:getSharedObject();
Citizen.CreateThread(function()
while ESX.GetPlayerData == nil do
	Citizen.Wait(10)
end

while ESX.GetPlayerData().job == nil do
	Citizen.Wait(10)
end

ESX.PlayerData = ESX.GetPlayerData()

Wait(5000)
end)

--[[RegisterCommand('tescik', function()
	print(json.encode(GlobalState.DeathReasonCheck))
end)]]
	
function isDead()
	return IsDead
end

function checkArray(array, val)
	for _, value in ipairs(array) do
			 local v = value
			 if type(v) == 'string' then
					  v = GetHashKey(v)
			 end

			 if v == val then
					  return true
			 end
	end

	return false
end

function refreshESX()
	ESX = exports['es_extended']:getSharedObject()


	while ESX.GetPlayerData().job == nil do
			 Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 270
	DrawRect(_x, _y + 0.015, 0.005 + factor, 0.03, 31, 31, 31, 155)
	--endplayerSpawned
end





RegisterNetEvent('esx_ambulancejob:heal2')
AddEventHandler('esx_ambulancejob:heal2', function(closestPlayerPed, maxHealth)
local playerPed = PlayerPedId()
local currenthealth = GetEntityHealth(playerPed)
local maxHealth = GetEntityMaxHealth(playerPed)
local waruneczek = maxHealth - currenthealth + 100
local healing = currenthealth + 80

if lib.progressBar({
	duration = 10000,
	label = 'Trwa leczenie...',
	useWhileDead = true,
	canCancel = false,
	disable = {
			 car = true,
			 move = true,
			 combat = true
	},
	anim = {
			 dict = 'missheistdockssetup1clipboard@idle_a',
			 clip = 'idle_a',
			 flag = 1
	},
}) then

if waruneczek <= 80 then
	SetEntityHealth(playerPed, maxHealth)
else
	SetEntityHealth(playerPed, healing)
end

TriggerServerEvent('esx_ambulancejob:removeItem', 'apteczka_case')
end
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(_type)
local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(qtty)
if qtty > 0 then
local closestPlayerPed = GetPlayerPed(closestPlayer)
local health = GetEntityHealth(closestPlayerPed)

if health > 0 then
	local playerPed = PlayerPedId()

	isBusy = true
	ESX.ShowNotification('Leczenie w toku...')

	local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

	for i=1, 15 do
			 Wait(500)

			 ESX.Streaming.RequestAnimDict(lib, function()
			 TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
			 RemoveAnimDict(lib)
			 end)
	end



	TriggerServerEvent('esx_ambulancejob:removeItem', 'apteczka')
	TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer))
	ESX.ShowNotification('Uleczono!', GetPlayerName(closestPlayer))
	isBusy = false
else
	ESX.ShowNotification('Obywatel jest nieprzytomny!')
end
else
ESX.ShowNotification('Nie masz apteczek przy sobie!')
end
end, 'apteczka')
end)

RegisterNetEvent('esx_ambulancejob:heal3')
AddEventHandler('esx_ambulancejob:heal3', function()
local playerPed = PlayerPedId()
local maxHealth = GetEntityMaxHealth(playerPed)

SetEntityHealth(playerPed, maxHealth)
end)

RegisterNetEvent('esx_ambulancejob:tepek')
AddEventHandler('esx_ambulancejob:tepek', function(source, coord)
TepekCwela(coord)
end)


----------------------   Korzystanie z baśki w szpitalu
local punkty = {
{x = 309.06008911133, y = -580.17327880859, z = 43.265377044678, id = 1, coords = vector3(314.19564819336, -582.41284179688, 43.965399932861)}, -- kordy baski
{x = -256.18618774414, y = 6329.2827148438, z = 32.408905029297, id = 2, coords = vector3( -267.9855,  6317.7475,  33.3023)},
}


-- Zakładamy, że mamy funkcję, która zwraca true, gdy gracz jest w pobliżu jakiegokolwiek punktu
-- i false w przeciwnym przypadku. Ta funkcja będzie optymalizować sprawdzanie odległości.
local function IsPlayerNearAnyPoint()
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    for _, item in pairs(punkty) do
        if GetDistanceBetweenCoords(playerCoords, item.x, item.y, item.z, true) <= 2 then
            return true, item
        end
    end
    return false
end

-- Główna pętla, która teraz będzie sprawdzać tylko, czy gracz jest blisko punktu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Zwiększenie czasu oczekiwania, aby zmniejszyć obciążenie

        local isNear, nearbyPoint = IsPlayerNearAnyPoint()

        if isNear then
            -- Wykonaj logikę tylko wtedy, gdy gracz jest blisko punktu
            TriggerEvent('HelpNotification:Show', "Naciśnij ~INPUT_CONTEXT~ aby uzyskać pomoc (500$)")
            if IsControlJustPressed(1, 38) then
                ESX.ShowNotification('Lekarze się tobą zajmują!')
                TriggerServerEvent('hospital:price')
                ESX.ShowNotification('Pobrano 500$ z twojego konta!')
				TriggerServerEvent('esx_ambulance:baskalog')
                TriggerEvent('esx_ambulancejob:tepek', source, nearbyPoint.coords)
                SetEntityHealth(GetPlayerPed(-1), 200)
            end

		end
    end
end)



RegisterCommand('reloadlicenceems', function()
	if ESX.GetPlayerData().job.name == 'ambulance' then
		reloadlicences()
		DelBoxZone()
		SzafkaMIAfunction()
		ESX.ShowNotification('Przeładowano Licencje')
	end
end)

wsradd = false
msradd = false

RegisterNetEvent('ambulance:getvechicle')
AddEventHandler('ambulance:getvechicle', function()
	CarListAmbulance()
end)

RegisterNetEvent('esx_ambulancejob:client:ems_menu_revive', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 2.0 then
		ESX.ShowNotification(TranslateCap('no_players'))
	else
		revivePlayer(closestPlayer)
	end
end)




-- Disable przyciski podczas śmierci

local function disableControls()
    DisableAllControlActions(0)
    -- Lista aktywowanych kontroli
    local controlsToEnable = {1, 2, Keys['G'], Keys['T'], Keys['E'], Keys['F5'], Keys['N'], Keys['DELETE'], Keys['H'], 21, Keys['Z'], Keys['F5'], Keys['F1'], Keys['F2']}
    for _, control in ipairs(controlsToEnable) do
        EnableControlAction(0, control, true)
    end
    exports['ox_target']:disableTargeting(true)
end

local function enableControls()
    exports['ox_target']:disableTargeting(false)
end

CreateThread(function()
    while true do
        if IsDead then
            disableControls()
            Citizen.Wait(1000) -- krótki czas oczekiwania, gdy gracz jest martwy
        else
            enableControls()
            Citizen.Wait(1000) -- dłuższy czas oczekiwania, gdy gracz żyje
        end
    end
end)





-- Zapisywanie / Nakladanie Ciuchów
RegisterNetEvent('esx_ambulancejob:getciuchyclient')
AddEventHandler('esx_ambulancejob:getciuchyclient', function(skin_male)
new_tab = {}
local player = PlayerPedId()

for number in skin_male:gmatch("%S+") do
table.insert(new_tab, tonumber(number))
end

SetPedComponentVariation(player, 1, new_tab[1], new_tab[2], 2) --# Maska
--SetPedComponentVariation(player, 0, new_tab[3], new_tab[4], 2) --# włosy
SetPedComponentVariation(player, 3, new_tab[5], new_tab[6], 2)
SetPedComponentVariation(player, 4, new_tab[7], new_tab[8], 2)
SetPedComponentVariation(player, 5, new_tab[9], new_tab[10], 2)
SetPedComponentVariation(player, 6, new_tab[11], new_tab[12], 2)
SetPedComponentVariation(player, 8, new_tab[13], new_tab[14], 2)
SetPedComponentVariation(player, 9, new_tab[15], new_tab[16], 2)
SetPedComponentVariation(player, 10, new_tab[17], new_tab[18], 2)
SetPedComponentVariation(player, 11, new_tab[19], new_tab[20], 2)

if new_tab[21]==-1 or new_tab[21]==0 then
SetPedPropIndex(player, 0, -1, 0, true)
ClearPedProp(player, 0)
else
SetPedPropIndex(player, 0, new_tab[21], new_tab[22], false)
end

if new_tab[23] == -1 or new_tab[23] == 0 or new_tab[23] == nil then
SetPedComponentVariation(player, 7, new_tab[23], new_tab[24], 2)
else
SetPedComponentVariation(player, 7, new_tab[23], new_tab[24], 2)
end

end)




AddEventHandler('playerSpawned', function()
--EndDeathCam()
IsDead = false
ESX.TriggerServerCallback('malina:checkBW', function(zycie)
zycie = IsDead
end, IsDead)

if FirstSpawn then
FirstSpawn = false
CreateThread(function()
local status = 0
while true do
	if status == 0 then
			 status = 1
			 if result == 3 then
					  status = 2
			 else
					  status = 0
			 end
	end

	Citizen.Wait(200)
	if status == 2 then
			 break
	end
end

exports.spawnmanager:setAutoSpawn(false)
end)
end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
while ESX.PlayerData.job == nil do
Citizen.Wait(10)
end
Citizen.Wait(10000)
reloadlicences()
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
ESX.PlayerData.job = job
reloadlicences()
end)

AddEventHandler('esx:onPlayerDeath', function(reason)
OnPlayerDeath()
LocalPlayer.state:set('isDead', true, true)
end)

RegisterNetEvent('esx_healthnarmour:set')
AddEventHandler('esx_healthnarmour:set', function(health, armour)
SetEntityHealth(PlayerPedId(), tonumber(health))
SetPedArmour(PlayerPedId(), tonumber(armour))
if tonumber(health) == 0 then
ESX.ShowNotification('Jesteś nieprzytomny, ponieważ przed wyjściem z serwera Twoja postać miała BW')
end
end)

RegisterCommand('test', function()
	local Sleep = false
print(Sleep and 1500 or 0)
end)

RegisterNetEvent('hypex_ambulancejob:hypexrevive')
AddEventHandler('hypex_ambulancejob:hypexrevive', function(notBlock, reviveCoords)
	LocalPlayer.state:set('isDead', false, true)
	if notBlock == nil then
		notBlock = false
	end
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)


	DoScreenFadeOut(800)

	Citizen.Wait(800)
	local formattedCoords = nil
	if reviveCoords then
		formattedCoords = {
			x = ESX.Math.Round(reviveCoords.x, 1),
			y = ESX.Math.Round(reviveCoords.y, 1),
			z = ESX.Math.Round(reviveCoords.z, 1)
			}
	else
		formattedCoords = {
		x = ESX.Math.Round(coords.x, 1),
		y = ESX.Math.Round(coords.y, 1),
		z = ESX.Math.Round(coords.z, 1)
		}
	end

	ESX.SetPlayerData('lastPosition', formattedCoords)
	ESX.SetPlayerData('loadout', {})
	TriggerServerEvent('esx:updateCoords', formattedCoords)
	RespawnPed(playerPed, formattedCoords, 0.0)

	StopScreenEffect('DeathFailOut')
	DoScreenFadeIn(800)

	Citizen.Wait(1000)
	TriggerServerEvent('SendGlobalData', ESX.PlayerData.identifier, nil, nil)
	exports["death"]:setDeath(false)
	TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)

end)

CreateThread(function()
	local lastHealth = GetEntityHealth(PlayerPedId())
	while true do
		Citizen.Wait(1000)
		local myPed = PlayerPedId()
		local health = GetEntityHealth(myPed)
		if HasEntityBeenDamagedByWeapon(myPed, 'WEAPON_RAMMED_BY_CAR', 0) then
			ClearEntityLastDamageEntity(myPed)
			if (health ~= lastHealth) then
					SetEntityHealth(myPed, lastHealth)
			end
		end
		lastHealth = health
	end
end)


CreateThread(function()
	local blip = AddBlipForCoord(vector3(300.8911, -585.2526, 43.2841))
	SetBlipSprite(blip, Config.Sprite)
	SetBlipDisplay(blip, Config.Display)
	SetBlipScale(blip, Config.Scale)
	SetBlipColour(blip, Config.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Szpital")
	EndTextCommandSetBlipName(blip)

	local blip = AddBlipForCoord(vector3( -249.0859375,  6316.3676757813,  32.408905029297))
	SetBlipSprite(blip, Config.Sprite)
	SetBlipDisplay(blip, Config.Display)
	SetBlipScale(blip, Config.Scale)
	SetBlipColour(blip, Config.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Szpital")
	EndTextCommandSetBlipName(blip)

	local blip = AddBlipForCoord(vector3(352.03005981445, -1410.6302490234, 32.504932403564))
	SetBlipSprite(blip, Config.Sprite)
	SetBlipDisplay(blip, Config.Display)
	SetBlipScale(blip, Config.Scale)
	SetBlipColour(blip, Config.Colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Szpital")
	EndTextCommandSetBlipName(blip)
end)


local hasVehicle = false
RegisterNetEvent('esx_ambulancejob:vehicle', function(data)
	if not hasVehicle then
		local coords = nil
		local vehicle = data

		-- Szpital Główny
		if 	areaCheck(300.8911, -585.2526, 43.2841, 150.0) then
			coords = vector4(331.20343017578,  -570.40600585938,  28.758291244507, 332.14178466797)
			-- Szpital Paleto
		elseif areaCheck(-249.0859375,  6316.3676757813,  32.408905029297, 150.0) then
			coords = vector4( -241.25587463379,  6336.31640625,  32.351188659668,  223.44947814941)
		elseif areaCheck(312.0895690918,  -1427.7489013672, 29.917629241943, 150.0) then
			coords = vector4( 312.0895690918,  -1427.7489013672, 29.917629241943,141.94050598145)
		end


		local TR = PlayerPedId()
		RequestModel(vehicle)
		while not HasModelLoaded(vehicle) do
			Wait(0)
		end
		if not IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			local JobVehicle = CreateVehicle(vehicle, coords, 45.0, true, false)
			SetVehicleHasBeenOwnedByPlayer(JobVehicle, true)
			SetEntityAsMissionEntity(JobVehicle, true, true)
			local num = math.random(10, 999)
			local carplate = SetVehicleNumberPlateText(JobVehicle, 'EMS'..num)
			hasVehicle = true
			SetVehicleFuelLevel(JobVehicle, 100.0)
			local id = NetworkGetNetworkIdFromEntity(JobVehicle)
			Wait(500)
			SetNetworkIdCanMigrate(id, true)
			TaskWarpPedIntoVehicle(TR, JobVehicle, -1)
			local plate = GetVehicleNumberPlateText(JobVehicle)
			TriggerServerEvent('many-addkeys', plate)

			-- Dodaj poniższe linie, aby ustawić maksymalny tuning dla pojazdu
			SetVehicleModKit(JobVehicle, 0) -- Ustawia mod kit na 0 (maksymalne tuningi)
			ToggleVehicleMod(JobVehicle, 18, true) -- Włącza silnik turbo
			SetVehicleMod(JobVehicle, 11, GetNumVehicleMods(JobVehicle, 11) - 1, true) -- Silnik
			SetVehicleMod(JobVehicle, 12, GetNumVehicleMods(JobVehicle, 12) - 1, true) -- Hamulce
			SetVehicleMod(JobVehicle, 13, GetNumVehicleMods(JobVehicle, 13) - 1, true) -- Skrzynia
			SetVehicleMod(JobVehicle, 16, GetNumVehicleMods(JobVehicle, 16) - 1, true)  -- Armor
			SetVehicleMod(JobVehicle, 17, GetNumVehicleMods(JobVehicle, 17) - 1, true)  -- Nitro
			SetVehicleMod(JobVehicle, 18, GetNumVehicleMods(JobVehicle, 18) - 1, true) -- Turbo
			--if Config.   ms_jeep
			-- Sprawdź dostępne dodatkowe elementy w pojeździe

			if data == 'ms_jeep' then
				SetVehicleLivery(JobVehicle,0)
			end

		
		else
			ESX.ShowNotification('Miejsce wyjmowania pojazdu jest zastawione!')
		end
	else
		ESX.ShowNotification('Musisz schować poprzedni pojazd przed wyjęciem kolejnego!')
	end
end)

	RegisterNetEvent('esx_ambulancejob:removevehicle', function()

	if hasVehicle then
		local TR92 = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(TR92,true)
		SetEntityAsMissionEntity(TR92,true)
		local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
		TriggerServerEvent('many-removekeys', plate)
		DeleteVehicle(vehicle)
		ESX.ShowNotification('Schowano służbowy pojazd!')
		hasVehicle = false
	else
		ESX.ShowNotification('Nie wyjąłeś żadnego pojazdu!')
	end
end)

local hasHeli = false
local coords = nil

	RegisterNetEvent('esx_ambulancejob:heli', function(data)
	licence = data.licence
	ESX.TriggerServerCallback('esx_license:checkLicense', function(license)
		if license then
			if not hasHeli then
				local vehicle = 'supervolito'

				-- Szpital Główny
				if 	areaCheck(300.8911, -585.2526, 43.2841, 100.0) then
						coords = vector4(351.6902, -588.2372, 74.1617, 283.1264)
						-- Szpital Paleto
				elseif areaCheck(-249.0859375,  6316.3676757813,  32.408905029297, 150.0) then
						coords = vector4( -270.99816894531,  6333.158203125,  32.42610168457,  134.77436828613)
						-- Crusaid
				elseif areaCheck( 313.38558959961, -1465.0905761719, 46.513053894043, 150.0) then
						coords = vector4( 313.38558959961, -1465.0905761719, 46.513053894043, 143.45050048828)
				end



				local TR = PlayerPedId()
				RequestModel(vehicle)
				while not HasModelLoaded(vehicle) do
						Wait(0)
				end
				if not IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
						local EmsHELI = CreateVehicle(vehicle, coords, 45.0, true, false)
						SetVehicleHasBeenOwnedByPlayer(EmsHELI, true)
						SetEntityAsMissionEntity(EmsHELI, true, true)
						local num = math.random(10, 999)
						local carplate = SetVehicleNumberPlateText(EmsHELI, 'EMS'..num)
						hasHeli = true
						SetVehicleFuelLevel(EmsHELI, 100.0)
						local id = NetworkGetNetworkIdFromEntity(EmsHELI)
						Wait(500)
						SetNetworkIdCanMigrate(id, true)
						TaskWarpPedIntoVehicle(TR, EmsHELI, -1)
						local plate = GetVehicleNumberPlateText(EmsHELI)
						TriggerServerEvent('many-addkeys', plate)
						--SetVehicleLivery(EmsHELI, 2)

				else
						ESX.ShowNotification('Miejsce wyjmowania helikopteru jest zastawione!')
				end
			else
				ESX.ShowNotification('Musisz schować poprzedni helikopter przed wyjęciem kolejnego!')
			end
		else
		exports['many-base']:Notify('inform', 'Nie jesteś upoważniony do wyjmowania helikopterów!')
		end
	end, GetPlayerServerId(PlayerId()), 'pilot')
end)

RegisterNetEvent('esx_ambulancejob:removeheli', function()
	if hasHeli then
		local TR92 = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(TR92,true)
		SetEntityAsMissionEntity(TR92,true)
		local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
		TriggerServerEvent('many-removekeys', plate)
		DeleteVehicle(vehicle)
		ESX.ShowNotification('Schowano służbowy helikopter!')
		hasHeli = false
	else
		ESX.ShowNotification('Nie wyjąłeś żadnego helikopteru!')
	end
end)


RegisterNetEvent('esx_ambulancejob:miastash')
AddEventHandler('esx_ambulancejob:miastash', function()
	exports['ox_inventory']:openInventory('stash', 'szafeczkamia')
end)

local treatment = false
local timer = false

RegisterNetEvent('esx_ambulancejob:AddLicenceMain')
AddEventHandler('esx_ambulancejob:AddLicenceMain', function(data)
	licence = data.data
	if data.data == 'weapon' then
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'ambulance_menu',
			{
				title    = 'Nadaj licencję',
				align    = 'center',
				elements = {
					{ label = 'Akceptuj', value = 'accept' },
					{ label = 'Zamknij', value = 'close' },
				}
			},
			function(data, menu)
				if data.current.value == 'accept' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					closestPlayerPed = GetPlayerPed(closestPlayer)
					targetplayer = GetPlayerServerId(closestPlayer)
					
					print(licence)
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
						if hasLicense then
							exports['many-base']:Notify('inform', 'Ta osoba ma już licencje tego typu!')
						else
		
							if closestPlayer ~= -1 and closestDistance <= 3.0 then
								TriggerServerEvent('esx_ambulancejob:addLicense', targetplayer, licence)
							else
								exports['many-base']:Notify('inform', 'Nie ma nikogo w pobliżu!')
							end
						end
					end, targetplayer, licence)
					
					menu.close()
				elseif data.current.value == 'close' then
					return
					menu.close()
				end
			end,
			function(data, menu)
				menu.close()
			end
		)
	else

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			closestPlayerPed = GetPlayerPed(closestPlayer)
			targetplayer = GetPlayerServerId(closestPlayer)
			local licence = data.data
			ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
				if hasLicense then
					exports['many-base']:Notify('inform', 'Ta osoba ma już licencje tego typu!')
				else

					if closestPlayer ~= -1 and closestDistance <= 3.0 then
						TriggerServerEvent('esx_ambulancejob:addLicense', targetplayer, licence)
					else
						exports['many-base']:Notify('inform', 'Nie ma nikogo w pobliżu!')
					end
				end
			end, targetplayer, licence)
	end
end)

RegisterNetEvent('esx_ambulancejob:RemoveLicenceMain')
AddEventHandler('esx_ambulancejob:RemoveLicenceMain', function(data)
local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
local licence = data.data
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		closestPlayerPed = GetPlayerPed(closestPlayer)
		targetplayer = GetPlayerServerId(closestPlayer)
		TriggerServerEvent('esx_ambulancejob:removeLicense', targetplayer, licence)
	else
		exports['many-base']:Notify('inform', 'Nie ma nikogo w pobliżu!')
	end
end)


RegisterNetEvent('esx_ambulancejob:nurek')
AddEventHandler('esx_ambulancejob:nurek', function ()
local ped = GetPlayerPed(-1)

ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(itemName)
if itemName > 0 then
TriggerEvent('pNotify:SendNotification', {text = "Trwa przebieranie sie"})
if lib.progressBar({
	duration = 10000,
	label = 'Trwa przebieranie...',
	useWhileDead = false,
	canCancel = true,
	disable = {
			 car = false,
			 move = false,
			 combat = true
	}
}) then
TriggerServerEvent('esx_ambulancejob:nurekitemusun', 'wetsuit')
TriggerServerEvent('esx_ambulancejob:nurekitemdodaj', 'drysuit', exports['rev_script']:TokenSys())
TriggerEvent('skinchanger:getSkin', function(skin)
if skin.sex == 0 then
	if Config.Uniforms["strojnurek"].male then
			 TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms["strojnurek"].male)
			 SetPedMaxTimeUnderwater(GetPlayerPed(-1), 250.00)
	end
else
	if Config.Uniforms["strojnurek"].female then
			 TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms["strojnurek"].female)
			 SetPedMaxTimeUnderwater(GetPlayerPed(-1), 250.00)
	end
end
end)
end
else

ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(itemName)
if itemName > 0 then
TriggerEvent('pNotify:SendNotification', {text = "Trwa przebieranie sie"})
if lib.progressBar({
	duration = 10000,
	label = 'Trwa przebieranie...',
	useWhileDead = false,
	canCancel = true,
	disable = {
			 car = false,
			 move = false,
			 combat = true
	}
}) then
TriggerServerEvent('esx_ambulancejob:nurekitemdodaj', 'wetsuit', exports['rev_script']:TokenSys())
TriggerServerEvent('esx_ambulancejob:nurekitemusun', 'drysuit')
ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
TriggerEvent('skinchanger:loadSkin', skin)
end)
TriggerEvent('esx_ciuchy:wear')
end
else
TriggerEvent('pNotify:SendNotification', {text = "Nie masz ciuchów"})
end
end, 'drysuit')
end
end, 'wetsuit')
end)

RegisterNetEvent('malina:client:nadajOdznakeEMS', function()
local input = lib.inputDialog('Wydaj odznakę', {
{ type = "input", label = "SSN", placeholder = "SSN" },
{ type = "input", label = "Numer odznaki", placeholder = "Numer" },
})
if input then
if input[1] and input[2] then

TriggerServerEvent('malina:server:nadajOdznakeEMS', input[1], input[2])
end
end
end)

RegisterNetEvent('ambulance:winda')
AddEventHandler('ambulance:winda',function(data)
ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Ambulance_Winda', {
title = 'Winda',
align = 'center',
elements = data
}, function (data, menu)

local label = data.current.label
local val = data.current.value
local id = data.current.id
local table = data.current.table
local ped = PlayerPedId()

DoScreenFadeOut(1000)
Wait(1000)
SetEntityCoords(ped, val.x, val.y, val.z)
SetEntityHeading(ped, table[id].hedding)
Wait(500)
DoScreenFadeIn(1000)
menu.close()
end, function (data2, menu2)
menu2.close()
end)
end)


RegisterNetEvent('esx_ambulancejob:kosz')
AddEventHandler('esx_ambulancejob:kosz', function()
exports['ox_inventory']:openInventory('stash', 'dumpster_ems')
end)

RegisterNetEvent('esx_ambulancejob:dumpkosz')
AddEventHandler('esx_ambulancejob:dumpkosz', function()
	TriggerServerEvent('esx_ambulancejob:dumpkoszserver')
end)




