local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPex = Tunnel.getInterface("bdl_digitalden")

-- [ TOGGLEMENU ] --
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
		onMenu = true
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		TriggerEvent("bdl:triggerhud")
		SendNUIMessage({ hidemenu = true })
		onMenu = false
	end
end

-- [ CALLBACK ] --
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "comprar-celular" then
		TriggerServerEvent("dd-comprar","celular")

	elseif data == "comprar-radio" then
		TriggerServerEvent("dd-comprar","radio")
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)

-- [ TABELA DE LOCALIDADE ] --
local lojas = {
	{ ['x'] = -658.85, ['y'] = -854.59, ['z'] = 24.51 },
}

-- [ THREAD DO MENU ] --
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

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end