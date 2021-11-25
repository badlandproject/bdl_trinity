local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPex = Tunnel.getInterface("bdl_market")

andamento = false
onMenu = false
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
	if data == "comprar-sanduiche" then
		TriggerServerEvent("departamento-comprar","sanduiche")

	elseif data == "comprar-rosquinha" then
		TriggerServerEvent("departamento-comprar","rosquinha")

	elseif data == "comprar-hotdog" then
		TriggerServerEvent("departamento-comprar","hotdog")

	elseif data == "comprar-xburguer" then
		TriggerServerEvent("departamento-comprar","xburguer")

	elseif data == "comprar-chips" then
		TriggerServerEvent("departamento-comprar","chips")

	elseif data == "comprar-batataf" then
		TriggerServerEvent("departamento-comprar","batataf")

	elseif data == "comprar-pizza" then
		TriggerServerEvent("departamento-comprar","pizza")

	elseif data == "comprar-tacos" then
		TriggerServerEvent("departamento-comprar","taco")

	elseif data == "comprar-agua" then
		TriggerServerEvent("departamento-comprar","agua")

	elseif data == "comprar-cola" then
		TriggerServerEvent("departamento-comprar","cola")

	elseif data == "comprar-sprunk" then
		TriggerServerEvent("departamento-comprar","sprunk")

	elseif data == "comprar-energetico" then
		TriggerServerEvent("departamento-comprar","energetico")

	elseif data == "comprar-leite" then
		TriggerServerEvent("departamento-comprar","leite")

	elseif data == "comprar-barracho" then
		TriggerServerEvent("departamento-comprar","barracho")

	elseif data == "comprar-patriot" then
		TriggerServerEvent("departamento-comprar","patriot")

	elseif data == "comprar-pibwassen" then
		TriggerServerEvent("departamento-comprar","pibwassen")
		
	elseif data == "comprar-mochila" then
		TriggerServerEvent("departamento-comprar","mochila")
		
	elseif data == "comprar-repair" then
		TriggerServerEvent("departamento-comprar","repairkit")
		
	elseif data == "comprar-britadeira" then
		TriggerServerEvent("departamento-comprar","britadeira")
		
	elseif data == "comprar-garrafa" then
		TriggerServerEvent("departamento-comprar","garrafavazia")
		
	elseif data == "comprar-semente" then
		TriggerServerEvent("departamento-comprar","s-blueberry")
		
	elseif data == "comprar-adubo" then
		TriggerServerEvent("departamento-comprar","adubo")
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)

-- [ TABELA DE LOCALIDADE ] --
local lojas = {
	{ ['x'] = 25.75, ['y'] = -1345.5, ['z'] = 29.5 },
	{ ['x'] = -48.42, ['y'] = -1757.87, ['z'] = 29.43 },
	{ ['x'] = -707.42, ['y'] = -914.59, ['z'] = 19.22 },
	{ ['x'] = -1222.27, ['y'] = -906.59, ['z'] = 12.33 },
	{ ['x'] = -1487.7, ['y'] = -378.6, ['z'] = 40.17 },
	{ ['x'] = 1163.61, ['y'] = -323.94, ['z'] = 69.21 },
	{ ['x'] = 374.21, ['y'] = 327.8, ['z'] = 103.57 },
	{ ['x'] = 2555.58, ['y'] = 382.11, ['z'] = 108.63 },
	{ ['x'] = -2967.83, ['y'] = 391.63, ['z'] = 15.05 },
	{ ['x'] = -3041.04, ['y'] = 585.14, ['z'] = 7.91 },
	{ ['x'] = -3243.91, ['y'] = 1001.32, ['z'] = 12.84 },
	{ ['x'] = 548.13, ['y'] = 2669.47, ['z'] = 42.16 },
	{ ['x'] = 1165.35, ['y'] = 2709.39, ['z'] = 38.16 },
	{ ['x'] = 1960.23, ['y'] = 3742.13, ['z'] = 32.35 },
	{ ['x'] = 1697.98, ['y'] = 4924.48, ['z'] = 42.07 },
	{ ['x'] = 2677.09, ['y'] = 3281.33, ['z'] = 55.25 },
	{ ['x'] = 1729.77, ['y'] = 6416.24, ['z'] = 35.04 },
 	{ ['x'] = 1048.36, ['y'] = 2662.58, ['z'] = 39.56 },
	{ ['x'] = -1820.46, ['y'] = 792.7, ['z'] = 138.12 },
	{ ['x'] = 1391.96, ['y'] = 3604.77, ['z'] = 34.99 },
	{ ['x'] = 1135.6, ['y'] = -981.6, ['z'] = 46.42 }
}

local robbery = {
	{ ['id'] = 1, ['x'] = 24.49, ['y'] = -1344.99, ['z'] = 29.49, ['h'] = 265.0 },
	{ ['id'] = 2, ['x'] = 24.50, ['y'] = -1347.34, ['z'] = 29.49, ['h'] = 267.0 },
	{ ['id'] = 3, ['x'] = 2554.90, ['y'] = 380.94, ['z'] = 108.62, ['h'] = 349.0 },
	{ ['id'] = 4, ['x'] = 2557.23, ['y'] = 380.83, ['z'] = 108.62, ['h'] = 354.0 },
	{ ['id'] = 5, ['x'] = 1165.07, ['y'] = -324.50, ['z'] = 69.20, ['h'] = 127.0 },
	{ ['id'] = 6, ['x'] = 1164.67, ['y'] = -322.76, ['z'] = 69.20, ['h'] = 94.0 },
	{ ['id'] = 7, ['x'] = -706.10, ['y'] = -915.43, ['z'] = 19.21, ['h'] = 116.0 },
	{ ['id'] = 8, ['x'] = -706.16, ['y'] = -913.65, ['z'] = 19.21, ['h'] = 85.0 },
	{ ['id'] = 9, ['x'] = -47.96, ['y'] = -1759.34, ['z'] = 29.42, ['h'] = 74.0 },
	{ ['id'] = 10, ['x'] = -46.80, ['y'] = -1757.94, ['z'] = 29.42, ['h'] = 45.0 },
	{ ['id'] = 11, ['x'] = 372.58, ['y'] = 326.39, ['z'] = 103.56, ['h'] = 252.0 },
	{ ['id'] = 12, ['x'] = 373.10, ['y'] = 328.64, ['z'] = 103.56, ['h'] = 255.0 },
	{ ['id'] = 13, ['x'] = -3242.24, ['y'] = 1000.01, ['z'] = 12.83, ['h'] = 352.0 },
	{ ['id'] = 14, ['x'] = -3244.56, ['y'] = 1000.20, ['z'] = 12.83, ['h'] = 354.0 },
	{ ['id'] = 15, ['x'] = 1727.88, ['y'] = 6415.21, ['z'] = 35.03, ['h'] = 239.0 },
	{ ['id'] = 16, ['x'] = 1728.90, ['y'] = 6417.25, ['z'] = 35.03, ['h'] = 240.0 },
	{ ['id'] = 17, ['x'] = 549.03, ['y'] = 2671.36, ['z'] = 42.15, ['h'] = 93.0 },
	{ ['id'] = 18, ['x'] = 549.33, ['y'] = 2669.04, ['z'] = 42.15, ['h'] = 93.0 },
	{ ['id'] = 19, ['x'] = 1958.96, ['y'] = 3742.01, ['z'] = 32.34, ['h'] = 298.0 },
	{ ['id'] = 20, ['x'] = 1960.12, ['y'] = 3740.01, ['z'] = 32.34, ['h'] = 295.0 },
	{ ['id'] = 21, ['x'] = 2678.07, ['y'] = 3279.42, ['z'] = 55.24, ['h'] = 327.0 },
	{ ['id'] = 22, ['x'] = 2676.03, ['y'] = 3280.56, ['z'] = 55.24, ['h'] = 327.0 },
	{ ['id'] = 23, ['x'] = 1696.57, ['y'] = 4923.95, ['z'] = 42.06, ['h'] = 353.0 },
	{ ['id'] = 24, ['x'] = 1698.06, ['y'] = 4922.96, ['z'] = 42.06, ['h'] = 323.0 },
	{ ['id'] = 25, ['x'] = -1818.89, ['y'] = 792.94, ['z'] = 138.08, ['h'] = 161.0 },
	{ ['id'] = 26, ['x'] = -1820.12, ['y'] = 794.16, ['z'] = 138.08, ['h'] = 129.0 },
	{ ['id'] = 27, ['x'] = 1392.87, ['y'] = 3606.39, ['z'] = 34.98, ['h'] = 195.0 },
	{ ['id'] = 28, ['x'] = -2966.44, ['y'] = 390.89, ['z'] = 15.04, ['h'] = 84.0 },
	{ ['id'] = 29, ['x'] = -3038.95, ['y'] = 584.55, ['z'] = 7.90, ['h'] = 16.0 },
	{ ['id'] = 30, ['x'] = -3041.19, ['y'] = 583.84, ['z'] = 7.90, ['h'] = 14.0 },
	{ ['id'] = 31, ['x'] = 1134.25, ['y'] = -982.47, ['z'] = 46.41, ['h'] = 273.0 },
	{ ['id'] = 32, ['x'] = 1165.93, ['y'] = 2710.77, ['z'] = 38.15, ['h'] = 177.0 },
	{ ['id'] = 33, ['x'] = -1486.29, ['y'] = -378.02, ['z'] = 40.16, ['h'] = 132.0 },
	{ ['id'] = 34, ['x'] = -1221.99, ['y'] = -908.29, ['z'] = 12.32, ['h'] = 28.0 },
	{ ['id'] = 35, ['x'] = 73.97, ['y'] = -1392.13, ['z'] = 29.37, ['h'] = 267.0 },
	{ ['id'] = 36, ['x'] = 74.86, ['y'] = -1387.70, ['z'] = 29.37, ['h'] = 182.0 },
	{ ['id'] = 37, ['x'] = 78.02, ['y'] = -1387.69, ['z'] = 29.37, ['h'] = 177.0 },
	{ ['id'] = 38, ['x'] = 426.96, ['y'] = -806.99, ['z'] = 29.49, ['h'] = 91.0 },
	{ ['id'] = 39, ['x'] = 426.08, ['y'] = -811.44, ['z'] = 29.49, ['h'] = 358.0 },
	{ ['id'] = 40, ['x'] = 422.91, ['y'] = -811.44, ['z'] = 29.49, ['h'] = 358.0 },
	{ ['id'] = 41, ['x'] = -816.56, ['y'] = -1073.25, ['z'] = 11.32, ['h'] = 122.0 },
	{ ['id'] = 42, ['x'] = -818.14, ['y'] = -1070.52, ['z'] = 11.32, ['h'] = 122.0 },
	{ ['id'] = 43, ['x'] = -822.41, ['y'] = -1071.94, ['z'] = 11.32, ['h'] = 206.0 },
	{ ['id'] = 44, ['x'] = -1195.24, ['y'] = -768.03, ['z'] = 17.31, ['h'] = 215.0 },
	{ ['id'] = 45, ['x'] = -1193.86, ['y'] = -767.00, ['z'] = 17.31, ['h'] = 215.0 },
	{ ['id'] = 46, ['x'] = -1192.44, ['y'] = -765.93, ['z'] = 17.31, ['h'] = 215.0 },
	{ ['id'] = 47, ['x'] = 5.21, ['y'] = 6510.88, ['z'] = 31.87, ['h'] = 41.0 },
	{ ['id'] = 48, ['x'] = 1.34, ['y'] = 6508.52, ['z'] = 31.87, ['h'] = 309.0 },
	{ ['id'] = 49, ['x'] = -0.80, ['y'] = 6510.80, ['z'] = 31.87, ['h'] = 309.0 },
	{ ['id'] = 50, ['x'] = 1695.38, ['y'] = 4822.23, ['z'] = 42.06, ['h'] = 92.0 },
	{ ['id'] = 51, ['x'] = 1695.10, ['y'] = 4817.71, ['z'] = 42.06, ['h'] = 4.0 },
	{ ['id'] = 52, ['x'] = 1691.98, ['y'] = 4817.31, ['z'] = 42.06, ['h'] = 4.0 },
	{ ['id'] = 53, ['x'] = 127.50, ['y'] = -222.58, ['z'] = 54.55, ['h'] = 70.0 },
	{ ['id'] = 54, ['x'] = 126.93, ['y'] = -224.18, ['z'] = 54.55, ['h'] = 70.0 },
	{ ['id'] = 55, ['x'] = 126.30, ['y'] = -225.88, ['z'] = 54.55, ['h'] = 70.0 },
	{ ['id'] = 56, ['x'] = 613.14, ['y'] = 2760.96, ['z'] = 42.08, ['h'] = 273.0 },
	{ ['id'] = 57, ['x'] = 612.99, ['y'] = 2762.69, ['z'] = 42.08, ['h'] = 273.0 },
	{ ['id'] = 58, ['x'] = 612.85, ['y'] = 2764.46, ['z'] = 42.08, ['h'] = 273.0 },
	{ ['id'] = 59, ['x'] = 1197.42, ['y'] = 2711.63, ['z'] = 38.22, ['h'] = 175.0 },
	{ ['id'] = 60, ['x'] = 1201.88, ['y'] = 2710.74, ['z'] = 38.22, ['h'] = 85.0 },
	{ ['id'] = 61, ['x'] = 1201.87, ['y'] = 2707.60, ['z'] = 38.22, ['h'] = 85.0 },
	{ ['id'] = 62, ['x'] = -3168.76, ['y'] = 1044.80, ['z'] = 20.86, ['h'] = 65.0 },
	{ ['id'] = 63, ['x'] = -3169.46, ['y'] = 1043.22, ['z'] = 20.86, ['h'] = 65.0 },
	{ ['id'] = 64, ['x'] = -3170.17, ['y'] = 1041.60, ['z'] = 20.86, ['h'] = 65.0 },
	{ ['id'] = 65, ['x'] = -1101.80, ['y'] = 2712.10, ['z'] = 19.10, ['h'] = 216.0 },
	{ ['id'] = 66, ['x'] = -1097.90, ['y'] = 2714.40, ['z'] = 19.10, ['h'] = 125.0 },
	{ ['id'] = 67, ['x'] = -1095.82, ['y'] = 2712.08, ['z'] = 19.10, ['h'] = 125.0 },
	{ ['id'] = 68, ['x'] = -821.91, ['y'] = -183.32, ['z'] = 37.56, ['h'] = 213.0 },
	{ ['id'] = 69, ['x'] = 134.39, ['y'] = -1707.83, ['z'] = 29.29, ['h'] = 136.0 },
	{ ['id'] = 70, ['x'] = -1284.26, ['y'] = -1115.05, ['z'] = 6.99, ['h'] = 89.0 },
	{ ['id'] = 71, ['x'] = 1930.56, ['y'] = 3727.93, ['z'] = 32.84, ['h'] = 205.0 },
	{ ['id'] = 72, ['x'] = 1211.52, ['y'] = -470.31, ['z'] = 66.20, ['h'] = 72.0 },
	{ ['id'] = 73, ['x'] = -30.42, ['y'] = -151.77, ['z'] = 57.07, ['h'] = 336.0 },
	{ ['id'] = 74, ['x'] = -277.76, ['y'] = 6230.73, ['z'] = 31.69, ['h'] = 38.0 }
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

-- [ THREAD DO ROUBO ] --
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(robbery) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
					sleep = 5
					DrawText3D(v.x,v.y,v.z, "[~r~E~w~] Para ~r~INICIAR~w~ o roubo.")
					if IsControlJustPressed(0,38) then
						vRPex.checkRobbery(v.id,v.x,v.y,v.z,v.h)
						isAndamento()
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- [ EVENTO DO ROUBO EM ANDAMENTO ] --
RegisterNetEvent("iniciandoregistradora")
AddEventHandler("iniciandoregistradora",function(head,x,y,z)
	segundos = 10
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	TriggerEvent('cancelando',true)
end)

function isAndamento()
	Citizen.CreateThread(function()
		while true do
			if andamento then
				segundos = segundos - 1
				if segundos <= 0 then
					andamento = false
					ClearPedTasks(PlayerPedId())
					TriggerEvent('cancelando',false)
				end
			else
				break
			end
			Citizen.Wait(1000)
		end
	end)
end

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