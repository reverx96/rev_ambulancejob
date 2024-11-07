
Citizen.CreateThread(function()
    Citizen.Wait(10)
    SzafkaMIAfunction()
    Citizen.Wait(10000)
    reloadlicences()
    DelBoxZone()
    SzafkaMIAfunction()
    end)
    
    function cleanPlayer(playerPed)
             SetPedArmour(playerPed, 0)
             ClearPedBloodDamage(playerPed)
             ResetPedVisibleDamage(playerPed)
             ClearPedLastWeaponDamage(playerPed)
             ResetPedMovementClipset(playerPed, 0)
    end
    
    function RespawnPed(ped, coords)
             TriggerEvent("csskrouble:niggerCheck", false)
             TriggerEvent("csskrouble:save")
             exports["death"]:setDeath(false)
             TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)
             SetEntityCoords(ped, coords.x, coords.y, coords.z)
             SetEntityHeading(ped, coords.heading)
             if ped == PlayerPedId() then
                      SetGameplayCamRelativeHeading(coords.heading)
             end
    
             SetEntityHealth(ped, GetEntityMaxHealth(ped))
    
             NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false)
             TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
             TriggerEvent('esx:onPlayerSpawn', coords.x, coords.y, coords.z)
             SetPlayerInvincible(ped, false)
             Citizen.InvokeNative(0x239528EACDC3E7DE, ped, false)
             ClearPedBloodDamage(ped)
    end
    exports('RespawnPed',RespawnPed)
    
    function areaCheck(x,y,z,r)
             local playerPed = PlayerPedId()
             local playerCoords = GetEntityCoords(playerPed)
             local distance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, x, y, z, true)
             local radius = r
    
             return distance <= radius
    end
    
    function DelBoxZone()
             exports['qtarget']:RemoveZone("Szafka MIA")
    end
    
    function stringsplit(inputstr, sep)
             if sep == nil then
                      sep = "%s"
             end
             local t={} ; i=1
             for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                      t[i] = str
                      i = i + 1
             end
             return t
    end
    
    function GetPlayerByEntityID(id)
             for _, player in ipairs(GetActivePlayers()) do
                      if id == GetPlayerPed(player) then
                               return player
                      end
             end
    end
    
    local cam = nil
    
    local angleY = 0.0
    local angleZ = 0.0
    
    
    function Winda(data)
             TriggerEvent('ambulance:winda', data)
    end
    

    function SzatniaEMS()
             refreshESX()
             Citizen.Wait(5)
             local job_nametmp2 = ESX.PlayerData.job.name
    
             ESX.UI.Menu.CloseAll()
             local playerPed = GetPlayerPed(-1)
             local sex = 0
             playerIDcheck = GetPlayerServerId(PlayerId())
             if (exports['fivem-appearance']:getPedModel(playerPed) == 'mp_f_freemode_01') then sex = 1 end
    
             local elements = {
                      { label = 'Ubranie Codzienne', value = 'citizen_wear' },
                      { label = 'Ubrania Służbowe', value = 'alluniforms'},
                      { label = 'Ubrania Jednostkowe', value = 'licenseuniforms'},
             }
    
             if ESX.PlayerData.job.grade >= 8 then
                      table.insert(elements, { label = 'Zarządzaj Ubraniami', value = 'setuniforms'})
             end
    
             ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
             {
                      title    = 'Szatnia',
                      align    = 'center',
                      elements = elements
             }, function(data, menu)
    
             cleanPlayer(playerPed)
    
             if data.current.value == 'ambulance_wear' then
                      menu.close()
                      setUniform('pielegniarz_wear', playerPed)
             end
    
             if data.current.value == 'citizen_wear' then
                      menu.close()
                      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                      TriggerEvent('skinchanger:loadSkin', skin)
                      end)
             end
    
             if data.current.value == 'alluniforms' then
                      elements2 = {}
                      if ESX.PlayerData.job.grade >= 0 then
                               table.insert(elements2,{label = "APPRENTICE", value = 'apprentice'})
                      end
                      if ESX.PlayerData.job.grade >= 1 then
                               table.insert(elements2,{label = "NURSE", value = 'nurse'})
                      end
                      if ESX.PlayerData.job.grade >= 2 then
                               table.insert(elements2,{label = "PARAMEDIC", value = 'paramedic'})
                      end
                      if ESX.PlayerData.job.grade >= 3 then
                               table.insert(elements2,{label = "SENIOR PARAMEDIC", value = 'seniorparamedic'})
                      end
                      if ESX.PlayerData.job.grade >= 4 then
                               table.insert(elements2,{label = "REZYDENT DOCTOR ", value = 'rezydentdoctor'})
                      end
                      if ESX.PlayerData.job.grade >= 5 then
                               table.insert(elements2,{label = "DOCTOR ", value = 'doctor'})
                      end
                      if ESX.PlayerData.job.grade >= 6 then
                               table.insert(elements2,{label = "SPECIALIST DOCTOR", value = 'specialistdoctor'})
                      end
                      if ESX.PlayerData.job.grade >= 7 then
                               table.insert(elements2,{label = "ASISTENT ORDINATOR", value = 'asistenordinator'})
                      end
                      if ESX.PlayerData.job.grade >= 8 then
                               table.insert(elements2,{label = "ORDINATOR ", value = 'ordinator'})
                      end
                      if ESX.PlayerData.job.grade >= 9 then
                               table.insert(elements2,{label = "ASSISTANT DIRECTOR ", value = 'assistantdirector'})
                      end
                      if ESX.PlayerData.job.grade >= 10 then
                               table.insert(elements2,{label = "DEUTY DIRECTOR ", value = 'deputydirector'})
                      end
                      if ESX.PlayerData.job.grade >= 11 then
                               table.insert(elements2,{label = "DIRECTOR ", value = 'director'})
                      end
    
    
    
                      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'alluniforms', {
                               title    = "Szatnia - EMS",
                               align    = 'center',
                               elements = elements2
                      }, function(data2, menu2)
                      TriggerServerEvent('rev:getciuchy',data2.current.value, playerIDcheck, sex,job_nametmp2)
                      --setUniform(data2.current.value, playerPed)
                      end, function(data2, menu2)
                      menu2.close()
                      end)
             end
    
             if data.current.value == 'licenseuniforms' then
                      elements2 = {}
                      if PlayerLicence['mia'] == true then
                               table.insert(elements2,{label = "MIA", value = 'mia'})
                      end
                      if PlayerLicence['pilot'] == true then
                               table.insert(elements2,{label = "AMS", value = 'ams'})
                      end
                      if PlayerLicence['coroner'] == true then
                               table.insert(elements2,{label = "CORONER", value = 'coroner'})
                      end
    
                      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'licenseuniforms', {
                               title    = "Szatnia - EMS",
                               align    = 'center',
                               elements = elements2
                      }, function(data2, menu2)

                      TriggerServerEvent('rev:getciuchy',data2.current.value, playerIDcheck, sex, job_nametmp2)

                      end, function(data2, menu2)
                      menu2.close()
                      end)
             end
    
             if data.current.value == 'setuniforms' then
                      local elements3 = {
                               {label = "APPRENTICE", value = 'apprentice'},
                               {label = "NURSE", value = 'nurse'},
                               {label = "PARAMEDIC", value = 'paramedic'},
                               {label = "SENIOR PARAMEDIC", value = 'seniorparamedic'},
                               {label = "REZYDENT DOCTOR ", value = 'rezydentdoctor'},
                               {label = "DOCTOR ", value = 'doctor'},
                               {label = "SPECIALIST DOCTOR", value = 'specialistdoctor'},
                               {label = "ASISTENT ORDINATOR", value = 'asistenordinator'},
                               {label = "ORDINATOR ", value = 'ordinator'},
                               {label = "ASSISTANT DIRECTOR ", value = 'assistantdirector'},
                               {label = "DEUTY DIRECTOR ", value = 'deputydirector'},
                               {label = "DIRECTOR ", value = 'director'},
                               {label = "MIA", value = 'mia'},
                               {label = "CORONER", value = 'coroner'},
                               {label = "AMS", value = 'ams'},
                      }
    
                      ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'setuniforms', {
                               title    = "Szatnia - EMS",
                               align    = 'center',
                               elements = elements3
                      }, function(data2, menu2)
                      setUniforms(data2.current.value, playerPed)
                      end, function(data2, menu2)
                      menu2.close()
                      end)
             end
    
             if
             data.current.value == 'REKRUT' or
             data.current.value == 'PIELEGNIARZ' or
             data.current.value == 'RATOWNIK_MED' or
             data.current.value == 'LEKARZ' or
             data.current.value == 'LEKARZ2' or
             data.current.value == 'ZASTEPCA_ORD' or
             data.current.value == 'ORDYNATOR' or
             data.current.value == 'ZASTEPCA_DYR' or
             data.current.value == 'DYREKTOR'
             then
                      setUniform(data.current.value, playerPed)
             end
    
             end, function(data, menu)
             menu.close()
    
             CurrentAction		= 'ambulance_actions_menu'
             CurrentActionMsg	= "Naciśnij ~INPUT_CONTEXT~, aby się przebrać"
             CurrentActionData	= {}
    
             end)
    end
    
    function OnPlayerDeath()
        local x = 1705.0
        local y = 2614.0
        local z = 59.0
        local h = 170.0
        if exports['rev_script']:areaCheck(PlayerPedId(), x, y, z, 200.0 ) then
            Citizen.Wait(5000)
            TriggerEvent('hypex_ambulancejob:hypexrevive', true, vector3(1758.8386230469, 2472.859375, 45.740730285645))
            ESX.ShowNotification('Medical Correction Unit udzielił Ci pomocy medycznej')
            return
        end
             if not IsDead then
                      IsDead = true
                      ESX.TriggerServerCallback('malina:checkBW', function(zycie)
                      zycie = IsDead
                      end, IsDead)
                      exports["gksphone"]:BlockOpenPhone(false)
                      ESX.UI.Menu.CloseAll()
                      TriggerServerEvent('esx_ambulancejob:setDeathStatus', 1)
                      exports["death"]:setDeath(true, Config.EarlyRespawnTimer/1000)
    
                      local playerPed = PlayerPedId()
                      if IsPedInAnyVehicle(playerPed, false) then
                               local vehicle = GetVehiclePedIsIn(playerPed, false)
                               if GetPedInVehicleSeat(vehicle, -1) == playerPed then
                                        SetVehicleEngineOn(vehicle, false, true, true)
                                        while GetEntitySpeed(vehicle) > 0.0 do
                                                 local vehSpeed = GetEntitySpeed(vehicle)
                                                 SetVehicleForwardSpeed(vehicle, (vehSpeed * 0.85))
                                                 Citizen.Wait(300)
                                        end
                               else
                                        SetEntityCoords(playerPed, GetEntityCoords(playerPed))
                               end
                      end
    
                      StartDeathTimer()
                      StartDistressSignal()
    
                      ClearPedTasks(PlayerPedId())
    
                      DeathFunc()
             else
                      SetEntityHealth(PlayerPedId(), GetPedMaxHealth(PlayerPedId()))
             end
    end
    
    function setUniform(job, playerPed)
             local sex = 0
             if (exports['fivem-appearance']:getPedModel(playerPed) == 'mp_f_freemode_01') then sex = 1 end
    
             for k, v in pairs(Config.Uniforms[job]) do
                      local drawable = v.male.drawable
                      local texture = v.male.texture
                      if (sex == 1) then
                               drawable = v.female.drawable
                               texture = v.female.texture
                      end
    
                      TriggerEvent('many-base:SetClothing', k, drawable, texture)
             end
    end
    
    function setUniforms(job_grade, playerPed)
             refreshESX()
             Citizen.Wait(5)
             local job_nametmp = ESX.PlayerData.job.name
             temp = {
                      GetPedDrawableVariation(playerPed, 1),
                      GetPedTextureVariation(playerPed, 1),
                      GetPedDrawableVariation(playerPed, 2),
                      GetPedTextureVariation(playerPed, 2),
                      GetPedDrawableVariation(playerPed, 3),
                      GetPedTextureVariation(playerPed, 3),
                      GetPedDrawableVariation(playerPed, 4),
                      GetPedTextureVariation(playerPed, 4),
                      GetPedDrawableVariation(playerPed, 5),
                      GetPedTextureVariation(playerPed, 5),
                      GetPedDrawableVariation(playerPed, 6),
                      GetPedTextureVariation(playerPed, 6),
                      GetPedDrawableVariation(playerPed, 8),
                      GetPedTextureVariation(playerPed, 8),
                      GetPedDrawableVariation(playerPed, 9),
                      GetPedTextureVariation(playerPed, 9),
                      GetPedDrawableVariation(playerPed, 10),
                      GetPedTextureVariation(playerPed, 10),
                      GetPedDrawableVariation(playerPed, 11),
                      GetPedTextureVariation(playerPed, 11),
                      GetPedPropIndex(playerPed, 0),
                      GetPedPropTextureIndex(playerPed, 0),
                      GetPedDrawableVariation(playerPed, 7),
                      GetPedTextureVariation(playerPed, 7),
             }
             tempstring=''

             for i=1, #temp do
                      tempstring= tempstring .. tostring(temp[i]) .. ' '
             end
    
             local sex = 0
             if (exports['fivem-appearance']:getPedModel(playerPed) == 'mp_f_freemode_01') then sex = 1 end
    
             TriggerServerEvent('rev:setciuchy',job_grade,tempstring,sex,job_nametmp)
    end
    
    function DeathFunc() 
        local playerPed = PlayerPedId()
        ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 2.0)
        CreateThread(function ()
            RequestAnimDict('dead')
            while not HasAnimDictLoaded('dead') do
                Citizen.Wait(0)
            end
    
            if IsPedInAnyVehicle(playerPed, false) then
                while IsPedInAnyVehicle(playerPed, true) do
                    Citizen.Wait(0)
                end
            else
                if GetEntitySpeed(playerPed) > 0.2 then
                    while GetEntitySpeed(playerPed) > 0.2 do
                        Citizen.Wait(0)
                    end
                end
            end
    
            local weapon = GetPedCauseOfDeath(playerPed)
            local sourceofdeath = GetPedSourceOfDeath(playerPed)
            local damagedbycar = false
            if weapon == 0 and sourceofdeath == 0 and HasEntityBeenDamagedByWeapon(playerPed, `WEAPON_RUN_OVER_BY_CAR`, 0) then
                damagedbycar = true
            end
            local coords = GetEntityCoords(playerPed)
            NetworkResurrectLocalPlayer(coords, 0.0, false, false)
            Citizen.Wait(1000)
            SetEntityCoords(playerPed, coords)
            SetPlayerInvincible(PlayerId(), true)
            SetPlayerCanUseCover(PlayerId(), false)
    
            
            local knockoutDuration = 15000
            if weapon == `WEAPON_UNARMED` or weapon == `WEAPON_NIGHTSTICK` then
                exports["death"]:setDeath(false)
                TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)
                obezwladniony = true
                TaskPlayAnim(playerPed, 'dead', 'dead_a', 1.0, 1.0, -1, 2, 0, 0, 0, 0)

                TriggerEvent("lastrp_hud:client:progress", {
                    duration = knockoutDuration,
                    label = 'Odzyskiwanie Sił...',
                    useWhileDead = false,
                    canCancel = false,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    }, function(status)
                        if not status then
                            LocalPlayer.state:set('isDead', false, true)
                            RespawnPed(PlayerPedId(), GetEntityCoords(GetPlayerPed(-1)))
                            Citizen.Wait(500)
                            SetEntityHealth(GetPlayerPed(PlayerId()), 200-85)
                        end
                    end)
            end


     
            while IsDead do
                local playerPed = PlayerPedId()
                SetEntityInvincible(playerPed, true)
                --SetEntityCanBeDamaged(playerPed, false)
                if not IsPedInAnyVehicle(playerPed, false) then
                    if not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3) then
                        TaskPlayAnim(playerPed, 'dead', 'dead_a', 1.0, 1.0, -1, 2, 0, 0, 0, 0)
                    end                    
                end
    
                Citizen.Wait(1)
            end
            obezwladniony = false
            SetPlayerInvincible(PlayerId(), false)
            SetPlayerCanUseCover(PlayerId(), true)
            SetEntityInvincible(playerPed, false)
            SetEntityCanBeDamaged(playerPed, true)
            StopAnimTask(PlayerPedId(), 'dead', 'dead_a', 4.0)
            RemoveAnimDict('dead')
            EnableAllControlActions(0)
        end)
    end

    function PayFine()
        ESX.TriggerServerCallback('esx_ambulancejob:payFine', function()
        --RemoveItemsAfterRPDeath()
        end)
    end

    Citizen.CreateThread(function()
        while true do
        Citizen.Wait(1000)
        while IsDead do
            local playerPed = PlayerPedId()
            SetEntityInvincible(playerPed, true)
            SetEntityCanBeDamaged(playerPed, false)
            if not IsPedInAnyVehicle(playerPed, false) then
                     if not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3) then
                              TaskPlayAnim(playerPed, 'dead', 'dead_a', 1.0, 1.0, -1, 2, 0, 0, 0, 0)
                     end
            end
        
            Citizen.Wait(1000)
        end
        end
        end)
        
    
    function secondsToClock(seconds)
    local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0
    
    if seconds <= 0 then
             return 0, 0
    else
             local hours = string.format('%02.f', math.floor(seconds / 3600))
             local mins = string.format('%02.f', math.floor(seconds / 60 - (hours * 60)))
             local secs = string.format('%02.f', math.floor(seconds - hours * 3600 - mins * 60))
    
             return secs, mins
    end
    end
    
    
    
    function CarListAmbulance()
    ESX.UI.Menu.CloseAll()
    local elements = {}
    for _, car in ipairs(Config.AmbulanceCars) do
             if car.licence == 'none' or PlayerLicence[car.licence] then
                      if car.grade <= ESX.PlayerData.job.grade then
                               table.insert(elements, car)
                      end
             end
    end
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'car_listAmbulance', {
             title    = "Garaż EMS",
             align    = 'right',
             elements = elements
    
    }, function(data, menu)
    TriggerEvent('esx_ambulancejob:vehicle', data.current.args)
    ESX.UI.Menu.CloseAll()
    end, function(data, menu)
    menu.close()
    end)
    end
    

    function TepekCwela(coordy)
        CreateThread(function()
       -- DoScreenFadeOut(800)
        ESX.UI.Menu.CloseAll()
        local gracz = PlayerPedId()
        --ESX.SetPlayerData('lastPosition', coordy)
       -- TriggerServerEvent('esx:updateCoords', coordy)
        --RespawnPed(gracz, coordy)
        
        --SetEntityHeading(gracz, 336.32443237305)
        
        DoScreenFadeIn(1200)
        TriggerEvent('hypex_ambulancejob:hypexrevive', true, coordy)   
        Citizen.Wait(1000)
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
                            dict = 'missfbi1',
                            clip = 'cpr_pumpchest_idle',
                            flag = 1
                    },
            }) then
            StopScreenEffect('DeathFailOut')
                 
               --TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)
            --print(GetPlayerServerId(PlayerId()))
            end
            end)


    end

    
    function StartDeathTimer()
        if TimerThreadId then
            TerminateThread(TimerThreadId)
        end

        local timer = ESX.Math.Round(Config.RespawnToHospitalDelay / 1000)
        local seconds,minutes = secondsToClock(timer)
        local firstScreen = true

        CreateThread(function()
            HasTimer = true

            while timer > 0 and IsDead do
                Citizen.Wait(1000)
                    if timer > 0 then
                            timer = timer - 1
                    end
                    seconds,minutes = secondsToClock(timer)
            end

            HasTimer = false
            firstScreen = false
            end)


            local pizda = false
        CreateThread(function()
            TimerThreadId = GetIdOfThisThread()
            pizda = false
            while firstScreen do
            Citizen.Wait(1)
            if obezwladniony then
                    return
            else
                    Wait(1)
            end
            end
            
            local pressStart = nil
            while IsDead do
            Citizen.Wait(1)
            if obezwladniony then
                    return
            else
                    exports["death"]:setDeath(true, Config.EarlyRespawnTimerr/1000)
                    
                    if IsControlPressed(0, Keys['E']) or IsDisabledControlPressed(0, Keys['E']) or IsControlJustReleased(0, 51) then
                        print(pizda)
                            if not pressStart then
                                    pressStart = GetGameTimer()
                            end
            
                            if GetGameTimer() - pressStart > 3000 then
                                if not pizda then
                                    TriggerServerEvent('esx_ambulance:tepeklog')
                                    TriggerEvent('esx_ambulancejob:tepek', source, vector3(314.19564819336, -582.41284179688, 43.965399932861))
                                    pizda = not pizda
                                end
                            end
                    end
            end
            end
        end)
    end
    
    
function reloadlicences()

	for k, v in pairs(PlayerLicence) do
		ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
			if hasLicense then
				PlayerLicence[k] = true
			end
			end, GetPlayerServerId(PlayerId()), k)
	end
end

    function revivePlayer(closestPlayer)
    isBusy = true
    ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
    if quantity > 0 then
    local closestPlayerPed = GetPlayerPed(closestPlayer)
    
    
    local playerPed = PlayerPedId()
    local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
    ESX.ShowNotification(TranslateCap('revive_inprogress'))
    
    for i=1, 15 do
             Wait(900)
    
             ESX.Streaming.RequestAnimDict(lib, function()
             TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
             RemoveAnimDict(lib)
             end)
    end
    
    TriggerServerEvent('esx_ambulancejob:removeItem', 'apteczka')
    TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
    TriggerServerEvent('esx_ambulancejob:setDeathStatus', 0)
    
    else
    ESX.ShowNotification(TranslateCap('not_enough_medikit'))
    end
    isBusy = false
    end, 'apteczka')
    end
    
    function ShowDeathTimer()
    if DistressThreadId then
    TerminateThread(DistressThreadId)
    end
    
    local respawnTimer = Config.RespawnDelayAfterRPDeath
    local allowRespawn = Config.RespawnDelayAfterRPDeath/2
    local fineAmount = Config.EarlyRespawnFineAmount
    local payFine = false
    
    if Config.EarlyRespawn and Config.EarlyRespawnFine then
    ESX.TriggerServerCallback('esx_ambulancejob:checkBalance', function(finePayable)
    if finePayable then
             payFine = true
    else
             payFine = false
    end
    end)
    end
    
    CreateThread(function()
    ClearPedTasksImmediately(PlayerPedId())
    while respawnTimer > 0 and IsDead do
    Citizen.Wait(0)
    if obezwladniony then
             return
    else
    
             raw_seconds = respawnTimer/1000
             raw_minutes = raw_seconds/60
             minutes = stringsplit(raw_minutes, ".")[1]
             seconds = stringsplit(raw_seconds-(minutes*60), ".")[1]
    
             SetTextFont(4)
             SetTextProportional(0)
             SetTextScale(0.0, 0.5)
             SetTextColour(255, 255, 255, 255)
             SetTextDropshadow(0, 0, 0, 0, 255)
             SetTextEdge(1, 1, 0, 0, 255)
             SetTextDropShadow()
             SetTextOutline()
    
             local text = _U('please_wait', minutes, seconds)
    
             if Config.EarlyRespawn then
                      if not Config.EarlyRespawnFine and respawnTimer <= allowRespawn then
                               text = text .. _U('press_respawn')
                      elseif Config.EarlyRespawnFine and respawnTimer <= allowRespawn and payFine then
                               text = text .. _U('respawn_now_fine', fineAmount)
                      else
                               text = text
                      end
             end
    
             SetTextCentre(true)
             SetTextEntry("STRING")
             AddTextComponentString(text)
             DrawText(0.5, 0.8)
    
             if Config.EarlyRespawn then
                      if not Config.EarlyRespawnFine then
                               if IsControlPressed(0, 46) then
                                        RemoveItemsAfterRPDeath()
                                        break
                               end
                      elseif Config.EarlyRespawnFine then
                               if respawnTimer <= allowRespawn and payFine then
                                        if IsControlPressed(0, 46) then
                                                 RemoveItemsAfterRPDeath()
                                                 break
                                        end
                               end
                      end
             end
             respawnTimer = respawnTimer - 15
    end
    end
    end)
    end
    
    function StartRespawnTimer()
    Citizen.SetTimeout(Config.RespawnDelayAfterRPDeath, function()
    if IsDead then
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rp_dead', {
             title = _U('rp_dead'),
             align = 'center',
             elements = {
                      { label = _U('yes'), value = 'yes' },
                      { label = _U('no'), value = 'no' },
             }
    }, function (data, menu)
    if data.current.value == 'yes' then
             --RemoveItemsAfterRPDeath()
    end
    menu.close()
    end, function (data, menu)
    menu.close()
    if data.current.value == 'no' and IsControlJustPressed(1, 178) then
             --RemoveItemsAfterRPDeath()
    end
    menu.close()
    end)
    end
    end)
    end
    
    
    
    function StartDistressSignal()
        CreateThread(function()
            local signal = 0
            while IsDead do
                if obezwladniony then
                    return
                else
                    if signal < GetGameTimer() then
                        -- Ustawienia tekstu można zrobić raz, poza pętlą
                        SetTextFont(4)
                        SetTextCentre(true)
                        SetTextProportional(1)
                        SetTextScale(0.45, 0.45)
                        SetTextColour(255, 255, 255, 255)
                        SetTextDropShadow(0, 0, 0, 0, 255)
                        SetTextEdge(1, 0, 0, 0, 255)
                        SetTextDropShadow()
                        SetTextOutline()
    
                        BeginTextCommandDisplayText('STRING')
                        --AddTextComponentSubstringPlayerName(_U('distress_send'))
                        EndTextCommandDisplayText(0.5, 0.905)
    
                        if IsDisabledControlPressed(0, Keys['G']) and not exports['esx_policejob']:IsCuffed() then
                            SendDistressSignal()
                            signal = GetGameTimer() + 90000 * 4
                        end
                    end
                end
                Citizen.Wait(500) -- Zwiększenie czasu oczekiwania
            end
        end)
    end
    
    
    function SearchInventory()
    local inventory = ESX.GetPlayerData().inventory
    
    for _, item in pairs(inventory) do
    if item.name == 'phone' then
             return 1
    end
    end
    end
    
    function SendDistressSignal()
    local qtty = SearchInventory()
    if qtty <= 0 then
    ESX.ShowNotification('~r~Nie posiadasz telefonu!')
    else
    local godzinaInt = GetClockHours()
    local godzina = ''
    if string.len(tostring(godzinaInt)) == 1 then
             godzina = '0'..godzinaInt
    else
             godzina = godzinaInt
    end
    local minutaInt = GetClockMinutes()
    local minuta = ''
    if string.len(tostring(minutaInt)) == 1 then
             minuta = '0'..minutaInt
    else
             minuta = minutaInt
    end
    godzina = godzina..":"..minuta
    
    ESX.ShowNotification('Sygnał alarmowy został wysłany!')
    
    local coords = GetEntityCoords(PlayerPedId())
    TriggerServerEvent('esx_addons_gcphone:startCall', 'ambulance', 'Ranny obywatel o godzienie: '..godzina, {
             x = coords.x,
             y = coords.y,
             z = coords.z
    })
    end
    end