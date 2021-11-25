local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPex = Tunnel.getInterface("bdl_pdcloak")

RPex = {}
Tunnel.bindInterface("bdl_pdcloak",RPex)

cloakX = -1098.47
cloakY = -831.36
cloakZ = 14.29
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

function RPex.closeMenu()
	ToggleActionMenu()
end

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "vestir-curta" then
		TriggerServerEvent("default")
	
	elseif data == "vestir-longa" then
		TriggerServerEvent("default2")

	elseif data == "vestir-moto" then
		TriggerServerEvent("gtm")

	elseif data == "vestir-tatico" then
		TriggerServerEvent("tactical")

	elseif data == "vestir-canine" then
		TriggerServerEvent("k9trainor")

	elseif data == "vestir-transito" then
		TriggerServerEvent("transit")
		
	elseif data == "vestir-csi" then
		TriggerServerEvent("csi")

	elseif data == "vestir-aluno" then
		TriggerServerEvent("default")

	elseif data == "off-uniform" then
		TriggerServerEvent("off-uniform")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = Vdist(cloakX,cloakY,cloakZ,x,y,z)
		if distance < 6 then
			idle = 5
			if not onMenu then
			DrawMarker(27, cloakX,cloakY,cloakZ-0.99,0,0,0,0.0,0,0,0.9,0.9,0.4,0,140,255,90,0,0,0,1)
				if distance <= 2 then
					DrawText3D(cloakX,cloakY,cloakZ, "[~b~E~w~] Para ~b~ABRIR~w~ o armário.")
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							if vRPex.checkOfficer() then
								ToggleActionMenu()
								checkGender()
								SetEntityHeading(PlayerPedId(),215.0)
								SetEntityCoords(PlayerPedId(),cloakX,cloakY,cloakZ-1,false,false,false,false)
							end
						end
					end
				end
			end
		end
		Wait(idle)
	end
end)

RegisterCommand("cloakdebug",function(args)
	FreezeEntityPosition(ped, false)
	ClearPedTasks(PlayerPedId())
end)

function checkGender()
	local ped = PlayerPedId()
	if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
		SendNUIMessage({ gender = "male" })
		print("male")
	elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
		SendNUIMessage({ gender = "female" })
		print("female")
	end
end

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
