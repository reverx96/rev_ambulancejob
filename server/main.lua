local playersHealing, deadPlayers = {}, {}
GlobalState.DeathReasonCheck = {}

math.randomseed(os.time())
ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('SendGlobalData')
AddEventHandler('SendGlobalData',function(char, reson, reson2)
	local tmp = {}
	tmp[char] = reson2 
	GlobalState.DeathReasonCheck = tmp
	--print(json.encode(tmp),json.encode(GlobalState.DeathReasonCheck), reson2, char)
end)


RegisterServerEvent('esx_ambulancejob:checkServ')
AddEventHandler('esx_ambulancejob:checkSerc',function(data)
	local tmp = {}
	tmp[char] = reson 
	GlobalState.DeathReasonCheck = tmp
	--print(json.encode(tmp),json.encode(GlobalState.DeathReasonCheck), reson, char)
end)

ESX.RegisterServerCallback('checkide', function(source,cb,player)
	
	local xPlayer = ESX.GetPlayerFromId(player) 
	--print(player)
	--print(player, xPlayer.identifier, GlobalState.DeathReasonCheck[xPlayer.identifier] )
	if GlobalState.DeathReasonCheck[xPlayer.identifier] ~= nil then
	cb({bool = true,char = xPlayer.identifier})
	return 
	else
	cb({bool = false, char = nil})
	end
end)


TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

local date = os.date('*t')
if date.month < 10 then date.month = '0' .. tostring(date.month) end
if date.day < 10 then date.day = '0' .. tostring(date.day) end
if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
if date.min < 10 then date.min = '0' .. tostring(date.min) end
if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
local date = (''..date.day .. '.' .. date.month .. '.' .. date.year .. ' o godz: ' .. date.hour .. ':' .. date.min .. ':' .. date.sec..'')

RegisterServerEvent('hypex_ambulancejob:hypexrevive')
AddEventHandler('hypex_ambulancejob:hypexrevive', function(target, bucket)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xTarget = ESX.GetPlayerFromId(target)
	GlobalState.DeathReasonCheck[xTarget.identifier] = nil
	--xPlayer.addInventoryItem('money', Config.ReviveReward  )

	--deadPlayers[target] = nil
	print(target, bucket)

		if bucket ~= nil then
			SetPlayerRoutingBucket(target, bucket)
		else
			if xPlayer then
			xPlayer.addAccountMoney('bank', Config.ReviveReward, 'Premia za udzielenie pomocy' )
			end
		end
		TriggerClientEvent('hypex_ambulancejob:hypexrevive', target)
end)


RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal3', target)
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:checkEMS', function(source, cb)
    local src = source
    local players = ESX.GetPlayers()
    local emsCount = 0
    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player['job']['name'] == 'ambulance' then
            emsCount = emsCount + 1
        end
    end
	print(emsCount, Config.BasiaOff, emsCount >= Config.BasiaOff )
    if emsCount >= Config.BasiaOff then
		cb(true)
    else
		cb(false)
		TriggerClientEvent('esx:showNotification', source, 'Jest zbyt wielu medyków na służbie')
    end
end)

ESX.RegisterServerCallback('esx_ambulancejob:hasItem', function(source, cb, item)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local playerItem = player.getInventoryItem(item)

    if player and playerItem ~= nil then
        if playerItem.count >= 1 then
            cb(true, playerItem.label)
			player.removeInventoryItem(item, 1)
        else
            cb(false, playerItem.label)
            TriggerClientEvent('esx:showNotification', source, 'Nie masz potrzebnych przedmiotów!')
        end
    else
        print('[many-info] Nie znaleziono przedmiotów w bazie danych')
    end
end)

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer ~= nil then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				if xPlayer.inventory[i].type ~= 'sim_card' then
					xPlayer.removeInventoryItem(xPlayer.inventory[i].name, xPlayer.inventory[i].count)
				end
			end
		end
	end

	cb()
end)


RegisterServerEvent('hospital:price')
AddEventHandler('hospital:price', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local src = source
	xPlayer.removeAccountMoney('bank', 500)
	exports['many-logs']:SendLog(src, ' otrzymał wsparcie medyczne w szpitalu od Baśki! ' ,'baskalog')
end)

if Config.EarlyRespawn and Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)

		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money
		local finePayable = false

		if bankBalance >= Config.EarlyRespawnFineAmount then
			finePayable = true
		else
			finePayable = false
		end

		cb(finePayable)
	end)

	ESX.RegisterServerCallback('esx_ambulancejob:payFine', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_fine', Config.EarlyRespawnFineAmount))
		xPlayer.removeAccountMoney('bank', Config.EarlyRespawnFineAmount)
		cb()
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local qtty = xPlayer.getInventoryItem(item).count
	cb(qtty)
end)

RegisterNetEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(playerId)

	playerId = tonumber(playerId)
		local xPlayer = source and ESX.GetPlayerFromId(source)
		if xPlayer and xPlayer.job.name == 'ambulance' then
			local xTarget = ESX.GetPlayerFromId(playerId)
			GlobalState.DeathReasonCheck[xTarget.identifier] = nil
			if xTarget then
					if Config.ReviveReward > 0 then
						xPlayer.showNotification(TranslateCap('revive_complete_award', xTarget.name, Config.ReviveReward))
						xPlayer.addMoney(Config.ReviveReward, "Revive Reward")
						xTarget.triggerEvent('hypex_ambulancejob:hypexrevive')
					else
						xPlayer.showNotification(TranslateCap('revive_complete', xTarget.name))
						xTarget.triggerEvent('esx_ambulancejob:revive')
					end
					local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")

					for _, xPlayer in pairs(Ambulance) do
						if xPlayer.job.name == 'ambulance' then
							xPlayer.triggerEvent('esx_ambulancejob:PlayerNotDead', playerId)
						end
					end

			else
				xPlayer.showNotification(TranslateCap('revive_fail_offline'))
			end
		end
end)


RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	local source = source
	local Ambulance = ESX.GetExtendedPlayers("job", "ambulance")
	for _, xPlayer in pairs(Ambulance) do
			xPlayer.triggerEvent('esx_ambulancejob:PlayerDead', source)
	end
end)


RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem(item, 1)
	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(item, count, token)
	local _source = source
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local playerName = GetPlayerName(src)

	exports['rev_script']:TriggerAC2(src, token, 'Ambulance-giveitem', item, count)

	if item == 'medikit' or item == 'bandage' or item == 'gps' or item == 'bodycam' or item == 'radio' then
		local limit = xPlayer.getInventoryItem(item).limit
		
		local delta = 1
		local qtty = xPlayer.getInventoryItem(item).count
		if limit ~= -1 then
			delta = limit - qtty
		end
		if qtty < limit then
			xPlayer.addInventoryItem(item, count ~= nil and count or delta)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('max_item'))
		end
	end
end)

RegisterCommand('revive', function(source, args, user)
	if source == 0 then
		TriggerClientEvent('hypex_ambulancejob:hypexrevive', tonumber(args[1]), true)
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		local xD = tonumber(args[1]) or source
		local xTarget = ESX.GetPlayerFromId(xD)
		--print('Tutaj chuju jebany',xTarget.identifier)
		GlobalState.DeathReasonCheck[xTarget.identifier] = nil
		if (xPlayer.group == 'best' or xPlayer.group == 'superadmin' or xPlayer.group == 'admin' or xPlayer.group == 'mod' or xPlayer.group == 'moderator' or xPlayer.group == 'support' or xPlayer.group == 'trialsupport') then
			local playerName = GetPlayerName(source)
			if args[1] ~= nil then
				if GetPlayerName(tonumber(args[1])) ~= nil then
					TriggerClientEvent("esx:showNotification", tonumber(args[1]), "Zostałeś ożywiony przez administratora " ..GetPlayerName(xPlayer.source).."!")
					TriggerClientEvent('hypex_ambulancejob:hypexrevive', tonumber(args[1]), true)
					exports['many-logs']:SendLogCzat(source, playerName.." użył **/revive" .. tonumber(args[1]).."**", "admin_commands", '15158332', playerName)
				end
			else
				TriggerClientEvent("esx:showNotification", source, "Zostałeś ożywiony przez administratora!")
				TriggerClientEvent('hypex_ambulancejob:hypexrevive', source, true)
				exports['many-logs']:SendLogCzat(source, playerName.." użył **/revive**", "admin_commands", '15158332', playerName)
			end
		else
			xPlayer.showNotification('Nie posiadasz permisji')
		end
	end
end, false)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.getIdentifier(),
	}, function(isDead)

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		MySQL.Sync.execute("UPDATE users SET isDead=@isDead WHERE identifier=@identifier", {
			['@identifier'] = xPlayer.identifier,
			['@isDead'] = isDead
		})
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	local playerId = source
	local src = source
	local xPlayer = ESX.GetPlayerFromId(playerId)
	Citizen.Wait(2000)
    if xPlayer ~= nil and xPlayer.getIdentifier ~= nil then
		MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.getIdentifier(),
		}, function(isDead)
            if not isDead or isDead == 0 then 
                MySQL.Async.fetchAll("SELECT health, armour FROM users WHERE identifier = ?", {xPlayer.identifier}, function(data)
                    if data[1].health ~= nil and data[1].armour ~= nil then
                        TriggerClientEvent('esx_healthnarmour:set', playerId, data[1].health, data[1].armour)
                    end
                end)
            else
                TriggerClientEvent('esx_healthnarmour:set', playerId, 0, 0)
				exports['many-logs']:SendLog(src, '\n ForceDeath on ID: '..playerId..'\n isDeath: '..tostring(isDead) ,'rev_log')
            end
        end)
    end
end)


RegisterNetEvent('esx_ambulance:tepeklog')
AddEventHandler('esx_ambulance:tepeklog',function()
	--print('Teleport Log',source)
	local src = source
	exports['many-logs']:SendLog(src, ' Teleportuje się na szpital! ' ,'tepeklog')
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
  local src = source
  local xPlayer = ESX.GetPlayerFromId(playerId)
  local name = GetPlayerName(playerId)
  local channels = 'https://discord.com/api/webhooks/1144006496108171334/ItjBq9bLdFCimy37LB4ZFgKaFCG6cU1mWwpN7wVQYgkZLxLA_hnJQK2_yiPpJTYYewE9'
		--https://discord.com/api/webhooks/1144006496108171334/ItjBq9bLdFCimy37LB4ZFgKaFCG6cU1mWwpN7wVQYgkZLxLA_hnJQK2_yiPpJTYYewE9
  if xPlayer ~= nil then
		local health = GetEntityHealth(GetPlayerPed(xPlayer.source))
		local armour = GetPedArmour(GetPlayerPed(xPlayer.source))
			MySQL.Async.fetchScalar('SELECT isDead FROM users WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier,
			}, function(isDead)
					MySQL.Async.execute('UPDATE users SET health = @health, armour = @armour, isDead=@isDead WHERE identifier = @identifier', {
					['@health'] = health,
					['@armour'] = armour,
					['@identifier'] = xPlayer.identifier,
					['@isDead'] = isDead})

						if isDead then
							--exports['many-logs']:SendLog(playerId, ' wychodzi z serwera na BW' ,'quitbw')
							exports['many-logs']:RevLog(playerId, channels, 'isDead', name ,isDead)
						end
			end)
		end
end)

RegisterNetEvent('esx_ambulancejob:addLicense')
AddEventHandler('esx_ambulancejob:addLicense', function(target, type)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xtarget = ESX.GetPlayerFromId(target)
	if type == 'weapon' then
	--print(json.encode(xtarget))
	--print(xtarget['firstName'], xtarget.getName())
		exports['many-logs']:SendLog(_source, '\n wystawił licencję na broń dla gracza \n ID: '..target..'\n Licencja:  ***'..xtarget.identifier..'***'..'\n Dane IC: '..xtarget.getName() ,'lickiweapon')
	end
	TriggerEvent('esx_license:addLicense', target, type, function()
		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			xPlayer.showNotification('Dodałeś licencje '..type..' dla ID : '..target)
			xtarget.showNotification('Otrzymałeś licencje '..type)
		end)
	end)


end)

RegisterNetEvent('esx_ambulancejob:removeLicense')
AddEventHandler('esx_ambulancejob:removeLicense', function(target, type)
	print(source, target, type)
	local _source = source
	print(_source,target,type)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xtarget = ESX.GetPlayerFromId(target)
	if xPlayer ~= nil then
		if xtarget ~= nil then
			TriggerEvent('esx_license:removeLicense', target, type, function()
		        TriggerEvent('esx_license:getLicenses', target, function(licenses)
					xPlayer.showNotification('Usunąłeś licencje '..type..' dla ID : '..target)
					xtarget.showNotification('Zabrano ci licencje '..type)
		        end)
	        end)
		else
			print('Nie ma xtargeta')
		end
	else
		print('Nie ma xPLayera')
	end

end)

RegisterServerEvent('esx_ambulancejob:nurekitemdodaj')
AddEventHandler('esx_ambulancejob:nurekitemdodaj', function(item,token )
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local playerName = GetPlayerName(src)

	exports['rev_script']:TriggerAC2(src, token, 'Add Ciuchynurka')

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item, 1)
end)

RegisterServerEvent('esx_ambulancejob:nurekitemusun')
AddEventHandler('esx_ambulancejob:nurekitemusun', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)

RegisterServerEvent('rev:setciuchy')
AddEventHandler('rev:setciuchy',function(job_grade, temp,sex,job_name)
--print(job_grade,temp,sex,job_name)
local xPlayer = ESX.GetPlayerFromId(source)

	if job_name == 'ambulance' then
if sex == 0 then
    MySQL.Async.execute('UPDATE job_clothes SET skin_male = @skin WHERE job_name = @nazwa AND job_grade = @identifier', {
        ['@skin'] = temp,
        ['@nazwa'] = 'ambulance',
        ['@identifier'] = job_grade
    })
else
    MySQL.Async.execute('UPDATE job_clothes SET skin_female = @skin WHERE job_name = @nazwa AND job_grade = @identifier', {
        ['@skin'] = temp,
        ['@nazwa'] = 'ambulance',
        ['@identifier'] = job_grade
    })
end
end

if job_name == 'police' then
	if sex == 0 then
		MySQL.Async.execute('UPDATE job_clothes SET skin_male = @skin WHERE job_grade = @identifier', {
			['@skin'] = temp,
			['@nazwa'] = 'police',
			['@identifier'] = job_grade
		})
	else
		MySQL.Async.execute('UPDATE job_clothes SET skin_female = @skin WHERE job_name = @nazwa AND job_grade = @identifier', {
			['@skin'] = temp,
			['@nazwa'] = 'police',
			['@identifier'] = job_grade
		})
	end
end

xPlayer.showNotification('Dodano ubranie do szafki!')
end)

RegisterServerEvent('rev:getciuchy')
AddEventHandler('rev:getciuchy',function(job_grade, playerID, sex, job_name)
	--print('SERVER-SIDE', job_grade, sex, source, playerID, job_name)
	
	if job_name == 'ambulance' then
		if sex == 0 then
		  MySQL.Async.fetchScalar('SELECT skin_male FROM job_clothes WHERE job_name = @nazwa AND job_grade = @identifier', {
			['@nazwa'] = 'ambulance',
			['@identifier'] = job_grade
		  	}, function(skin_male)
			if skin_male then
			  --print(skin_male, playerID)
			  TriggerClientEvent('esx_ambulancejob:getciuchyclient', playerID, skin_male)
			end
		  end)
		else
		  MySQL.Async.fetchScalar('SELECT skin_female FROM job_clothes WHERE job_name = @nazwa AND job_grade = @identifier', {
			['@nazwa'] = 'ambulance',
			['@identifier'] = job_grade
		  }, function(skin_female)
			if skin_female then
			  --print(skin_female)
			  TriggerClientEvent('esx_ambulancejob:getciuchyclient', playerID, skin_female)
			end
		  end)
		end
	else
		if sex == 0 then
		  MySQL.Async.fetchScalar('SELECT skin_male FROM job_clothes WHERE job_name = @nazwa AND job_grade = @identifier', {
			['@nazwa'] = 'police',
			['@identifier'] = job_grade
		  }, function(skin_male)
			if skin_male then
			 -- print(skin_male, playerID)
			  TriggerClientEvent('esx_ambulancejob:getciuchyclient', playerID, skin_male)
			end
		  end)
		else
		  MySQL.Async.fetchScalar('SELECT skin_female FROM job_clothes WHERE job_name = @nazwa AND job_grade = @identifier', {
			['@nazwa'] = 'police',
			['@identifier'] = job_grade
		  }, function(skin_female)
			if skin_female then
			  --print(skin_female)
			  TriggerClientEvent('esx_ambulancejob:getciuchyclient', playerID, skin_female)
			end
		  end)
		end
	end
	  
end)

RegisterServerEvent('malina:server:nadajOdznakeEMS')
AddEventHandler('malina:server:nadajOdznakeEMS', function(ssn, number)
	--print(source,ssn,number)
	local _source = source
	MySQL.update('UPDATE users SET badge = @badge WHERE id = @ssn', {
		['@badge'] = '['.. number ..']',
		['@ssn'] = ssn
	}, function(rows)
		TriggerClientEvent('esx:showNotification', _source, 'Dodano odznakę <br>SSN: '..ssn..'<br>Odznaka: ['..number..']')
		exports['an_badges']:updateBadge(ssn, '['.. number ..']')
	end)
end)

RegisterCommand("openbaydoors", function(source, args, raw)
	local player = source 
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:opendoors", source)
		CancelEvent()
	end
end, false)

RegisterCommand("togglestr", function(source, args, raw)
	local player = source 
	if (player > 0) then
		TriggerClientEvent("ARPF-EMS:togglestrincar", source)
		CancelEvent()
	end
end, false)

ESX.RegisterUsableItem('stretcher', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('stretcher', 1)
    TriggerClientEvent('wasabi_ambulance:useStretcher', source)
end)

ESX.RegisterServerCallback('wasabi_ambulance:gItem', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xJob = xPlayer.job.name
    if xJob == 'ambulance' or xJob == 'police' then
        xPlayer.addInventoryItem(item, 1)
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('wasabi_ambulance:removeObj')
AddEventHandler('wasabi_ambulance:removeObj', function(netObj)
    TriggerClientEvent('wasabi_ambulance:syncObj', -1, netObj)
end)

RegisterServerEvent('wasabi_ambulance:placeOnStretcher')
AddEventHandler('wasabi_ambulance:placeOnStretcher', function(target)
    TriggerClientEvent('wasabi_ambulance:placeOnStretcher', target)
end)

RegisterServerEvent('esx_ambulancejob:dumpkoszserver')
AddEventHandler('esx_ambulancejob:dumpkoszserver', function()
	--exports.ox_inventory:ClearInventory('stash', 'dumpster_lspd')
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	--print(source,_source)
	xPlayer.showNotification('Usunięto zawartość kosza!')
	exports.ox_inventory:ClearInventory('dumpster_ems', false)

end)

ESX.RegisterServerCallback('ambulance:getName',function(source, cb)
local xPlayer = ESX.GetPlayerFromId(source)
cb(xPlayer.getName())
end)