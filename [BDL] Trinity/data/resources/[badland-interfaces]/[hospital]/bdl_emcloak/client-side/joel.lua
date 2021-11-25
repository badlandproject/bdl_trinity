local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPex = Tunnel.getInterface("bdl_emcloak")

RPex = {}
Tunnel.bindInterface("bdl_emcloak",RPex)

cloakX = 301.54
cloakY = -599.59
cloakZ = 43.29
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
	if data == "vestir-enfermeiro" then
		TriggerServerEvent("enfermeiro")
	
	elseif data == "vestir-paramedico" then
		TriggerServerEvent("paramedico")

	elseif data == "vestir-medico" then
		TriggerServerEvent("medico")

	elseif data == "vestir-clinico" then
		TriggerServerEvent("clinico")

	elseif data == "vestir-diretor" then
		TriggerServerEvent("diretor")

	elseif data == "vestir-resgate" then
		TriggerServerEvent("resgate")

	elseif data == "off-uniform-ems" then
		TriggerServerEvent("off-uniform-ems")

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
			DrawMarker(27, cloakX,cloakY,cloakZ-0.99,0,0,0,0.0,0,0,0.9,0.9,0.4,255,25,25,90,0,0,0,1)
				if distance <= 2 then
					DrawText3D(cloakX,cloakY,cloakZ, "[~r~E~w~] Para ~r~ABRIR~w~ o armário.")
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							if vRPex.checkOfficer() then
								ToggleActionMenu()
								checkGender()
								SetEntityHeading(PlayerPedId(),340.0)
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
