onMenu = false

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("hideHud")
		onMenu = true
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("showHud")
		onMenu = false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "confirm-five" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_PISTOL_MK2")
	elseif data == "confirm-glock" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_COMBATPISTOL")
	elseif data == "confirm-m1911" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_PISTOL")
	elseif data == "confirm-m22" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_VINTAGEPISTOL")
	elseif data == "confirm-hk110" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_SNSPISTOL")

	elseif data == "confirm-muni-five" then
		TriggerServerEvent("bdl:ammunation-buy","wammo|WEAPON_PISTOL_MK2")
	elseif data == "confirm-muni-glock" then
		TriggerServerEvent("bdl:ammunation-buy","wammo|WEAPON_COMBATPISTOL")
	elseif data == "confirm-muni-m1911" then
		TriggerServerEvent("bdl:ammunation-buy","wammo|WEAPON_PISTOL")
	elseif data == "confirm-muni-m22" then
		TriggerServerEvent("bdl:ammunation-buy","wammo|WEAPON_VINTAGEPISTOL")
	elseif data == "confirm-muni-hk110" then
		TriggerServerEvent("bdl:ammunation-buy","wammo|WEAPON_SNSPISTOL")

	elseif data == "confirm-faca" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_KNIFE")
	elseif data == "confirm-machado" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_HATCHET")
	elseif data == "confirm-canivete" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_SWITCHBLADE")
	elseif data == "confirm-beisebol" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_BAT")
	elseif data == "confirm-martelo" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_HAMMER")
	elseif data == "confirm-golf" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_GOLFCLUB")
	elseif data == "confirm-pecabra" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_CROWBAR")
	elseif data == "confirm-socoingles" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_KNUCKLE")
	elseif data == "confirm-chaveing" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_WRENCH")
	elseif data == "confirm-sinuca" then
		TriggerServerEvent("bdl:ammunation-buy","wbody|WEAPON_POOLCUE")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local lojas = {
	{ ['x'] = 22.2, ['y'] = -1106.71, ['z'] = 29.8 },
	{ ['x'] = 810.12, ['y'] = -2157.76, ['z'] = 29.62 },
	{ ['x'] = 1693.26, ['y'] = 3760.19, ['z'] = 34.71 },
	{ ['x'] = 252.64, ['y'] = -50.11, ['z'] = 69.95 },
	{ ['x'] = 842.38, ['y'] = -1034.01, ['z'] = 28.2},
	{ ['x'] = -330.69, ['y'] = 6084.02, ['z'] = 31.46 },
	{ ['x'] = -662.3, ['y'] = -934.85, ['z'] = 21.83 },
	{ ['x'] = -1305.33, ['y'] = -394.27, ['z'] = 36.7 },
	{ ['x'] = -1118.22, ['y'] = 2698.75, ['z'] = 18.56 },
	{ ['x'] = 2567.87, ['y'] = 293.96, ['z'] = 108.74 },
	{ ['x'] = -3172.32, ['y'] = 1088.01, ['z'] = 20.84 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local sleep = 1000

		for k,v in pairs(lojas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local lojas = lojas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), lojas.x, lojas.y, lojas.z, true ) <= 2 then
				sleep = 5
				if not onMenu then
					DrawText3D(lojas.x, lojas.y, lojas.z, "[~g~E~w~] Para ~g~ABRIR~w~ o menu.")
				end
			end
			
			if distance <= 4 then
				sleep = 5
				if not onMenu then
					DrawMarker(20, lojas.x, lojas.y, lojas.z-0.75,0,0,0,0.0,0,0,0.5,0.5,0.4,75,255,0,90,0,0,0,1)
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							ToggleActionMenu()
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- [ FUNÇÃO DO TEXTO 3D ] --
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