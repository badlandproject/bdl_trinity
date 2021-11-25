local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("bdl_ammofactory")

onmenu = false

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		TriggerEvent("bdl:triggerhud")
		onmenu = true
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		TriggerEvent("bdl:triggerhud")
		SetNuiFocus(false)
		onmenu = false
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "ammo-ak103" then
		TriggerServerEvent("bdl_ammofactory:ammofactory","ak103")
		
	elseif data == "ammo-ak47" then
		TriggerServerEvent("bdl_ammofactory:ammofactory","ak47")
		
	elseif data == "ammo-ak74" then
		TriggerServerEvent("bdl_ammofactory:ammofactory","ak74")
		
	elseif data == "ammo-mp5" then
		TriggerServerEvent("bdl_ammofactory:ammofactory","mp5")
		
	elseif data == "ammo-tec9" then
		TriggerServerEvent("bdl_ammofactory:ammofactory","tec9")
		
	elseif data == "ammo-m1911" then
		TriggerServerEvent("bdl_ammofactory:ammofactory","m1911")
		
	elseif data == "ammo-hk110" then
		TriggerServerEvent("bdl_ammofactory:ammofactory","hk110")
		
	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local factory = {
	{ ['x'] = 1402.28, ['y'] = 1136.55, ['z'] = 109.75 },
	{ ['x'] = 987.85, ['y'] = -129.6, ['z'] = 78.9 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(factory) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(v.x,v.y,v.z,x,y,z)
			local factory = factory[k]
			
			if distance <= 15 and not onmenu then
				idle = 5
				DrawMarker(27, factory.x, factory.y, factory.z-0.98,0,0,0,0.0,0,0,0.8,0.8,0.4,45,45,45,90,0,0,0,1)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						if vSERVER.checkPermission() then
							ToggleActionMenu()
						end
					end
				end
			end
			if distance <= 1.5 and not onmenu then
				idle = 5
				DrawText3D(factory.x,factory.y,factory.z,"Pressione [~c~E~w~] para ~c~FABRICAR~w~ munição.")
			end
		end
		Citizen.Wait(idle)
	end
end)

-- [ FUNÇÃO DO TEXTO 3D ] --
function DrawText3D(x,y,z,text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end