ESX = exports["es_extended"]:getSharedObject()
stretcher, stretcherMoving = nil, nil


RegisterNetEvent('wasabi_ambulance:placeOnStretcher', function()
    placeOnStretcher()
end)

AddEventHandler('wasabi_ambulance:loadStretcher', function()
    loadStretcher()
end)

RegisterNetEvent('wasabi_ambulance:useStretcher')
AddEventHandler('wasabi_ambulance:useStretcher', function()
    useStretcher()
end)

AddEventHandler('wasabi_ambulance:pickupStretcher', function()
    pickupStretcher()
end)

AddEventHandler('wasabi_ambulance:moveStretcher', function()
    moveStretcher()
end)


local placedOnStretcher
local stretcherObj
placeOnStretcher = function()
	if  not placedOnStretcher then
		local coords = GetEntityCoords(cache.ped)
		local objHash = `prop_ld_binbag_01`
		local stretcherObj = GetClosestObjectOfType(coords, 1.5, objHash, false)
		local objCoords = GetEntityCoords(stretcherObj)
		lib.requestAnimDict('anim@gangops@morgue@table@', 100)
		TaskPlayAnim(cache.ped, "anim@gangops@morgue@table@", "body_search", 8.0, 8.0, -1, 33, 0, 0, 0, 0)
		AttachEntityToEntity(cache.ped, stretcherObj, 0, 0, 0.0, 1.0, 195.0, 0.0, 180.0, 0.0, false, false, false, false, 2, true)
		placedOnStretcher = true
	elseif placedOnStretcher then
		RemoveAnimDict('anim@gangops@morgue@table@')
		lib.requestAnimDict('mini@cpr@char_b@cpr_def', 100)
		DetachEntity(cache.ped)
		ClearPedTasks(cache.ped)
		placedOnStretcher = false
		stretcherObj = nil
	end
end

loadStretcher = function()
	local player, dist = ESX.Game.GetClosestPlayer()
	if player ~= -1 and dist < 4 then
	TriggerServerEvent('wasabi_ambulance:placeOnStretcher', GetPlayerServerId(player))
	else
		TriggerEvent('wasabi_ambulance:notify','Nie znaleziono', 'Nie ma nikogo w pobliżu', 'error')
	end
end

exports('loadStretcher', loadStretcher)

moveStretcher = function()
	local ped = cache.ped
	stretcherMoving = true
	local textUI
	lib.requestAnimDict('anim@heists@box_carry@', 100)
	AttachEntityToEntity(stretcher, ped, GetPedBoneIndex(ped,  28422), 0.0, -0.9, -0.52, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
    while IsEntityAttachedToEntity(stretcher, ped) do
        Wait(0)
        if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
            TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
        end
		if not textUI then
			lib.showTextUI('[E] - Puść Nosze')
			textUI = true
		end
        if IsPedDeadOrDying(ped) then
            DetachEntity(stretcher, true, true)
			lib.hideTextUI()
			textUI = false
        end
        if IsControlJustPressed(0, 38) then
            DetachEntity(stretcher, true, true)
            ClearPedTasks(ped)
            stretcherMoving = false
			lib.hideTextUI()
			textUI = false

        end
    end
    RemoveAnimDict('anim@heists@box_carry@')

end


RegisterNetEvent('wasabi_ambulance:syncObj', function(netObj)
    local obj = NetToObj(netObj)
    deleteObj(obj)
end)

deleteObj = function(bag)
	if DoesEntityExist(bag) then
		SetEntityAsMissionEntity(bag, true, true)
		DeleteObject(bag)
		DeleteEntity(bag)
	end
end

pickupStretcher = function()
	local ped = cache.ped
	local coords = GetEntityCoords(ped)
	local stretchHash = `prop_ld_binbag_01`
	local obj = GetClosestObjectOfType(coords, 3.0, stretchHash, false)
    print(obj, ObjToNet(obj), obj == 0)

    if obj ~= 0 then
        local objCoords = GetEntityCoords(obj)
        TaskTurnPedToFaceCoord(ped, objCoords.x, objCoords.y, objCoords.z, 2000)
        ESX.TriggerServerCallback('wasabi_ambulance:gItem', function(cb, item)
            if cb then
                TriggerEvent('wasabi_ambulance:notify','Udało Się!','Podniosłeś Nosze', 'success')
            end
        end, 'stretcher')
        TriggerServerEvent('wasabi_ambulance:removeObj', ObjToNet(obj))
    end
end

useStretcher = function()
	local ped = cache.ped
	local x, y, z = table.unpack(GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.5))
	local textUI = false
	lib.requestModel('prop_ld_binbag_01', 100)
	lib.requestAnimDict('anim@heists@box_carry@', 100)
	stretcher = CreateObjectNoOffset('prop_ld_binbag_01', x, y, z, true, false)
	SetModelAsNoLongerNeeded('prop_ld_binbag_01')
	AttachEntityToEntity(stretcher, ped, GetPedBoneIndex(ped,  28422), 0.0, -0.9, -0.52, 195.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
	while IsEntityAttachedToEntity(stretcher, ped) do
		Wait(0)
		if not IsEntityPlayingAnim(ped, 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(ped, 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end
		if not textUI then
			lib.showTextUI('[E] - Puść Nosze')
			textUI = true
		end
		if IsPedDeadOrDying(ped) then
			RemoveAnimDict('anim@heists@box_carry@')
			DetachEntity(stretcher, true, true)
			lib.hideTextUI()
			textUI = false
		end
		if IsControlJustPressed(0, 38) then
            DetachEntity(stretcher, true, true)
            ClearPedTasks(ped)
			RemoveAnimDict('anim@heists@box_carry@')
			lib.hideTextUI()
			textUI = false

        end
	end
end

CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(1000)
    end
    ESX.PlayerData.job = ESX.GetPlayerData().job
exports.qtarget:Vehicle({
    options = {
        {
            event = "ARPF-EMS:opendoors",
            icon = "fas fa-box",
            label = "Otwórz/Zamknij pake",
            job = "ambulance",
        },
        {
            --event = "ARPF-EMS:togglestrincar",
            action = function()
                ExecuteCommand('togglestr')
            end,
            icon = "fas fa-hand-sparkles",
            label = "Wsadź/Wyciągnij nosze do auta",
            job = "ambulance",
        },

    },
    distance = 2
})
end)




























function VehicleInFront()
  local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

local open = false
RegisterNetEvent("ARPF-EMS:opendoors")
AddEventHandler("ARPF-EMS:opendoors", function()
veh = VehicleInFront()
if open == false then
    open = true
    SetVehicleDoorOpen(veh, 2, false, false)
    Citizen.Wait(1000)
    SetVehicleDoorOpen(veh, 3, false, false)
elseif open == true then
    open = false
    SetVehicleDoorShut(veh, 2, false)
    SetVehicleDoorShut(veh, 3, false)
end
end)

local incar = false
RegisterNetEvent("ARPF-EMS:togglestrincar")
AddEventHandler("ARPF-EMS:togglestrincar", function()
	
	local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if IsEntityAttachedToAnyVehicle(closestObject) then
    	incar = true
    elseif IsEntityAttachedToEntity(closestObject, veh) then 
    	incar = true
    end
    if incar == false then 
        StreachertoCar()
        incar = true
    elseif incar == true then
        incar = false
        StretcheroutCar()
    end
end)



function StreachertoCar()
    local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if GetVehiclePedIsIn(ped, false) == 0 and DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            AttachEntityToEntity(closestObject, veh, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
            FreezeEntityPosition(closestObject, true)
        else
            --print("car dose not exist ")
        end
    else
        --print("nothing around here dumb ass")
    end
end

function StretcheroutCar()
    local veh = VehicleInFront()
    local ped = GetPlayerPed(-1)
    local pedCoords = GetEntityCoords(ped)
    local closestObject = GetClosestObjectOfType(pedCoords, 3.0, GetHashKey("prop_ld_binbag_01"), false)
    if DoesEntityExist(closestObject) then
        if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
            DetachEntity(closestObject, true, true)
            FreezeEntityPosition(closestObject, false)
            local coords = GetEntityCoords(closestObject, false)
        SetEntityCoords(closestObject, coords.x ,coords.y-3.0,(coords.z+5.5))
        PlaceObjectOnGroundProperly(closestObject)
        else
            --print("dosenot exist car")
        end
    else
       -- print("nothing around here dumb ass")
    end
end




