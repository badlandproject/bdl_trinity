local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRPex = Tunnel.getInterface("minerman-foundry")

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
	if data == "fundir-ferro" then
		TriggerServerEvent("bdlCraftMac:fundir","ferro")
		
	elseif data == "fundir-bronze" then
		TriggerServerEvent("bdlCraftMac:fundir","bronze")
		
	elseif data == "fundir-ouro" then
		TriggerServerEvent("bdlCraftMac:fundir","ouro")
		
	elseif data == "garimpar" then
		TriggerServerEvent("bdlCraftMac:fundir","diamante")
		
	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent('closeMenuOnYourEyes')
AddEventHandler('closeMenuOnYourEyes',function()
	if onmenu then
		ToggleActionMenu()
		onmenu = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local lojas = {
	{ ['x'] = 1087.83, ['y'] = -2001.85, ['z'] = 30.89 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(lojas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]
			
			if distance <= 15 and not onmenu then
				idle = 5
				DrawMarker(27, lojas.x, lojas.y, lojas.z-0.98,0,0,0,0.0,0,0,0.8,0.8,0.4,0,255,0,90,0,0,0,1)
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
			if distance <= 1.5 and not onmenu then
				idle = 5
				DrawText3Ds(lojas.x,lojas.y,lojas.z,"Pressione [~g~E~w~] para ~g~FUNDIR~w~ os minérios.")
			end
		end
		Citizen.Wait(idle)
	end
end)

function destroyText()
	
end

-- [ FUNÇÃO DO TEXTO 3D ] --
function DrawText3Ds(x,y,z,text)
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