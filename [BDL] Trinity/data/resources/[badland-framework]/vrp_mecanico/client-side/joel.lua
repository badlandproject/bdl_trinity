local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPex = Tunnel.getInterface("vrp_mecanico")

pontoX = -206.96
pontoY = -1341.75
pontoZ = 34.9
systemX = -196.51
systemY = -1319.46
systemZ = 31.09
onMenu = false

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		onMenu = true
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
	else
		onMenu = false
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("bdl:triggerhud")
	end
end


RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "repairkit" then
        TriggerServerEvent("bennys-comprar","repairkit")
		
	elseif data == "militec" then
		TriggerServerEvent("bennys-comprar","militec")
		
	elseif data == "pneus" then
		TriggerServerEvent("bennys-comprar","pneus")
		
	elseif data == "melhoria" then
		TriggerServerEvent("bennys-comprar","melhoria")
		
	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        local ped = PlayerPedId()
        local x,y,z = table.unpack(GetEntityCoords(ped))
        local distance = Vdist(pontoX,pontoY,pontoZ,x,y,z)
        local distance2 = Vdist(systemX,systemY,systemZ,x,y,z)
        if distance <= 4 then
            sleep = 5
            DrawMarker(30, pontoX,pontoY,pontoZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,180,0,90,0,0,0,1)
            if distance <= 2 then
                DrawText3D(pontoX,pontoY,pontoZ, "[~y~E~w~] Para ~y~BATER~w~ seu ponto.")
                if distance <= 1.1 then
                    if IsControlJustPressed(0,38) then
                        vRPex.checkBennys()
                    end
                end
            end
        end
        if distance2 <= 4 then
            sleep = 5
            if not onMenu then
                DrawMarker(30, systemX,systemY,systemZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,180,0,90,0,0,0,1)
                if distance2 <= 2 then
                    DrawText3D(systemX,systemY,systemZ, "[~y~E~w~] Para ~y~ABRIR~w~ o sistema.")
                    if distance2 <= 1.1 then
                        if IsControlJustPressed(0,38) and vRPex.checkPermission() then
                            ToggleActionMenu()
                        end
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

local reboque = nil
local rebocado = nil
RegisterCommand("tow",function(source,args)
    local vehicle = GetPlayersLastVehicle()
    local vehicletow = IsVehicleModel(vehicle,GetHashKey("flatbed"))

    if vehicletow and not IsPedInAnyVehicle(PlayerPedId()) then
        rebocado = getVehicleInDirection(GetEntityCoords(PlayerPedId()),GetOffsetFromEntityInWorldCoords(PlayerPedId(),0.0,5.0,0.0))
        if IsEntityAVehicle(vehicle) and IsEntityAVehicle(rebocado) then
            TriggerServerEvent("trytow",VehToNet(vehicle),VehToNet(rebocado))
        end
    end
end)

RegisterNetEvent('synctow')
AddEventHandler('synctow',function(vehid,rebid)
    if NetworkDoesNetworkIdExist(vehid) and NetworkDoesNetworkIdExist(rebid) then
        local vehicle = NetToVeh(vehid)
        local rebocado = NetToVeh(rebid)
        if DoesEntityExist(vehicle) and DoesEntityExist(rebocado) then
            if reboque == nil then
                if vehicle ~= rebocado then
                    local min,max = GetModelDimensions(GetEntityModel(rebocado))
                    AttachEntityToEntity(rebocado,vehicle,GetEntityBoneIndexByName(vehicle,"bodyshell"),0,-2.2,0.4-min.z,0,0,0,1,1,0,1,0,1)
                    reboque = rebocado
                end
            else
                AttachEntityToEntity(reboque,vehicle,20,-0.5,-15.0,-0.3,0.0,0.0,0.0,false,false,true,false,20,true)
                DetachEntity(reboque,false,false)
                PlaceObjectOnGroundProperly(reboque)
                reboque = nil
                rebocado = nil
            end
        end
    end
end)

function getVehicleInDirection(coordsfrom,coordsto)
	local handle = CastRayPointToPoint(coordsfrom.x,coordsfrom.y,coordsfrom.z,coordsto.x,coordsto.y,coordsto.z,10,PlayerPedId(),false)
	local a,b,c,d,vehicle = GetRaycastResult(handle)
	return vehicle
end

RegisterNetEvent('repararmotor')
AddEventHandler('repararmotor',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trymotor",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncmotor')
AddEventHandler('syncmotor',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleEngineHealth(v,1000.0)
			end
		end
	end
end)

RegisterNetEvent('reparar')
AddEventHandler('reparar',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("tryreparar",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncreparar')
AddEventHandler('syncreparar',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleFixed(v)
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
				SetVehicleOnGroundProperly(v)
				SetVehicleFuelLevel(v,fuel)
			end
		end
	end
end)

RegisterNetEvent('pneus')
AddEventHandler('pneus',function()
	local vehicle = vRP.getNearestVehicle(3)
	if IsEntityAVehicle(vehicle) then
		TriggerServerEvent("trypneus",VehToNet(vehicle))
	end
end)

RegisterNetEvent('syncpneus')
AddEventHandler('syncpneus',function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		local fuel = GetVehicleFuelLevel(v)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				local tyreamount = GetVehicleNumberOfWheels(v)
				if tyreamount == 2 then
					SetVehicleTyreFixed(v,0)
					SetVehicleTyreFixed(v,4)
					print(tyreamount)
				elseif tyreamount == 4 then
					SetVehicleTyreFixed(v,0)
					SetVehicleTyreFixed(v,1)
					SetVehicleTyreFixed(v,4)
					SetVehicleTyreFixed(v,5)
					print(tyreamount)
				elseif tyreamount == 6 then
					SetVehicleTyreFixed(v,0)
					SetVehicleTyreFixed(v,2)
					SetVehicleTyreFixed(v,3)
					SetVehicleTyreFixed(v,4)
					SetVehicleTyreFixed(v,5)
					SetVehicleTyreFixed(v,6)
					SetVehicleTyreFixed(v,7)
					SetVehicleTyreFixed(v,8)
					print(tyreamount)
				else
					print(tyreamount)
				end
			end
		end
	end
end)

-- [ TUNING ] --
RegisterNetEvent("melhoria")
AddEventHandler("melhoria",function(vehicle)
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    if IsEntityAVehicle(vehicle) then
        SetVehicleModKit(vehicle,0)
        SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-3,false)
    end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end