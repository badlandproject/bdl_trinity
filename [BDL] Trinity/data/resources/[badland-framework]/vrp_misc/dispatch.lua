-- [ DISPATCH ] --
Citizen.CreateThread(function()
	for i = 1,120 do
		EnableDispatchService(i,false)
	end
end)

Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped)
			if GetPedInVehicleSeat(vehicle,0) == ped and GetVehicleClass(vehicle) == 8 then
				sleep = 5
				DisableControlAction(0,73,true)
			end
		end
		Citizen.Wait(sleep)
	end
end)
-- [ REMOVER CORONHADA ] --
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        if IsPedArmed(ped,6) then
			sleep = 5
            DisableControlAction(0,140,true)
            DisableControlAction(0,141,true)
            DisableControlAction(0,142,true)
        end
		Citizen.Wait(sleep)
    end
end)
-- [ DESABILITAR ARMA ACIMA DE 40MPH ] --
Citizen.CreateThread(function()
	while true do
		local sleep = 2000
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			sleep = 1000
			local vehicle = GetVehiclePedIsIn(PlayerPedId())
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				local speed = GetEntitySpeed(vehicle)*2.236936
				if speed >= 40 then
					SetPlayerCanDoDriveBy(PlayerId(),false)
				else
					SetPlayerCanDoDriveBy(PlayerId(),true)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-- [ TANKAR HS ] --
Citizen.CreateThread(function()
    while true do
        Wait(5)
        SetPedSuffersCriticalHits(PlayerPedId(-1), true)
    end
end)
-- [ REMOVER O COVER ] --
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if health >= 101 then
			sleep = 5
			DisableControlAction(0,44,true)
        end
		Citizen.Wait(sleep)
    end
end)
-- [ CONTROLE DO CARRO AO VOAR ] --
Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local veh = GetVehiclePedIsIn(PlayerPedId(),false)
        if DoesEntityExist(veh) and not IsEntityDead(veh) then
			sleep = 5
            local model = GetEntityModel(veh)
            if not IsThisModelABoat(model) and not IsThisModelAHeli(model) and not IsThisModelAPlane(model) and not IsThisModelABicycle(model) and not IsThisModelABike(model) and not IsThisModelAQuadbike(model) and IsEntityInAir(veh) then
                DisableControlAction(0,59)
                DisableControlAction(0,60)
                --DisableControlAction(0,73)
            end
        end
		Citizen.Wait(sleep)
    end
end)

-- [ IR DO P2 PRO P1 ] --
local disableShuffle = true
function disableSeatShuffle(flag)
    disableShuffle = flag
end

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if disableShuffle then
			sleep = 5
			if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
				if GetPedInVehicleSeat(GetVehiclePedIsIn(GetPlayerPed(-1), false), 0) == GetPlayerPed(-1) then
					if GetIsTaskActive(GetPlayerPed(-1), 165) then
						SetPedIntoVehicle(GetPlayerPed(-1), GetVehiclePedIsIn(GetPlayerPed(-1), false), 0)
					end
				end
			end
        end
		Citizen.Wait(sleep)
    end
end)

RegisterNetEvent("SeatShuffle")
AddEventHandler("SeatShuffle", function()
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
        disableSeatShuffle(false)
        Citizen.Wait(5000)
        disableSeatShuffle(true)
    else
        CancelEvent()
    end
end)

RegisterCommand("seat", function(source, args, raw) --change command here
    TriggerEvent("SeatShuffle")
end, false)

-- [ BLACKLIST DE OBJETOS NO MAPA ] --
local blackObjects = {
	--"apa_mp_apa_yacht",
    "stt_prop_stunt_jump45",
    "prop_const_fence02b",
    "apa_prop_flag_brazil",
   --"prop_c4_final_green"
}

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local handle,object = FindFirstObject()
		local finished = false
		repeat
			Citizen.Wait(10)
			for i=1,#blackObjects do
				if GetEntityModel(object) == GetHashKey(blackObjects[i]) then
					ReqAndDelete(object,false)
				end
			end
			finished,object = FindNextObject(handle)
		until not finished
		EndFindObject(handle)
		Citizen.Wait(1000)
	end
end)

function ReqAndDelete(object,detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		while not NetworkHasControlOfEntity(object) do
			Citizen.Wait(1)
		end

		if detach then
			DetachEntity(object,0,false)
		end

		SetEntityCollision(object,false,false)
		SetEntityAlpha(object,0.0,true)
		SetEntityAsMissionEntity(object,true,true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
	end
end
-- [ DRIFT ] --
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(PlayerPedId())
		if IsPedInAnyVehicle(ped) then
			local speed = GetEntitySpeed(vehicle)*2.236936
			if GetPedInVehicleSeat(vehicle,-1) == ped and (GetEntityModel(vehicle) ~= GetHashKey("coach") and GetEntityModel(vehicle) ~= GetHashKey("bus") and GetEntityModel(vehicle) ~= GetHashKey("youga2") and GetEntityModel(vehicle) ~= GetHashKey("ratloader") and GetEntityModel(vehicle) ~= GetHashKey("taxi") and GetEntityModel(vehicle) ~= GetHashKey("boxville4") and GetEntityModel(vehicle) ~= GetHashKey("trash2") and GetEntityModel(vehicle) ~= GetHashKey("tiptruck") and GetEntityModel(vehicle) ~= GetHashKey("rebel") and GetEntityModel(vehicle) ~= GetHashKey("speedo") and GetEntityModel(vehicle) ~= GetHashKey("phantom") and GetEntityModel(vehicle) ~= GetHashKey("packer") and GetEntityModel(vehicle) ~= GetHashKey("paramedicoambu")) then
					sleep = 100
					if speed <= 100.0 then
					if IsControlPressed(1,21) then
						SetVehicleReduceGrip(vehicle,true)
					else
						SetVehicleReduceGrip(vehicle,false)
					end
				end    
			end
		end
		Citizen.Wait(sleep)
	end
end)
-- [ BLIPS ] --
local blips = {}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,v.sprite)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v.color)
		SetBlipScale(blip,v.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.nome)
		EndTextCommandSetBlipName(blip)
	end
end)
-- [ TASER ] --
local tasertime = false
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		if IsPedBeingStunned(ped) then
			sleep = 100
			SetPedToRagdoll(ped,10000,10000,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			sleep = 100
			tasertime = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			sleep = 100
			tasertime = false
			SetTimeout(5000,function()
				SetTimecycleModifier("hud_def_desat_Trevor")
				SetTimeout(10000,function()
					SetTimecycleModifier("")
					SetTransitionTimecycleModifier("")
					StopGameplayCamShaking()
				end)
			end)
		end
		Citizen.Wait(sleep)
	end
end)
-- [ ANDAR MACHUCADO ] --
local hurt = false
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		if not IsEntityInWater(ped) then
			if GetEntityHealth(ped) <= 199 then
				sleep = 5
				setHurt()
			elseif hurt and GetEntityHealth(ped) > 200 then
				sleep = 5
				setNotHurt()
			end
		end
		Wait(sleep)
	end
end)

function setHurt()
    hurt = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(PlayerPedId(),"move_m@injured",true)
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
	DisableControlAction(0,21) 
	DisableControlAction(0,22)
end

function setNotHurt()
    hurt = false
	SetPlayerHealthRechargeMultiplier(PlayerId(),0.0)
    ResetPedMovementClipset(PlayerPedId())
    ResetPedWeaponMovementClipset(PlayerPedId())
    ResetPedStrafeClipset(PlayerPedId())
end
-- [ COOLDOWN DE PULO ] --
local bunnyhop = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if bunnyhop > 0 then
            bunnyhop = bunnyhop - 5
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if IsPedJumping(ped) and bunnyhop <= 0 then
            bunnyhop = 5
        end
        if bunnyhop > 0 then
            DisableControlAction(0,22,true)
        end
        Citizen.Wait(5)
    end
end)
-- [ SEM SONS DO AMBIENTE ] --
CreateThread(function()
	while true do
		StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE");
		SetAudioFlag("PoliceScannerDisabled",true);
		Wait(0)
	end
end)