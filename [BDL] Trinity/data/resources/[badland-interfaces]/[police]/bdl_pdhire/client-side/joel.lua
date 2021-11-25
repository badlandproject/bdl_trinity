local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vSERVER = Tunnel.getInterface("bdl_inventory")
vRPex = Tunnel.getInterface("bdl_pdhire")

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
	if data == "fechar" then
		ToggleActionMenu()
	end
end)

RegisterNUICallback('contratar', function(data)
	TriggerServerEvent('system:hire', data.position, data.passport)
end)

RegisterNUICallback('demitir', function(data)
	TriggerServerEvent('system:fire', data.passport)
end)

RegisterNUICallback('promover', function(data)
	TriggerServerEvent('system:promote', data.position, data.passport)
end)

RegisterNUICallback('pegarUser', function(data, cb)
    local userId = data.id
    TriggerServerEvent('Policia:procurarPlayer', userId)
end)

hireX = -1113.11
hireY = -833.04
hireZ = 34.37

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(hireX,hireY,hireZ,x,y,z)
			if distance <= 6 then
				idle = 5
				if not onMenu then
					DrawMarker(30, hireX,hireY,hireZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,140,255,90,0,0,0,1)
					if distance <= 2 then
						DrawText3D(hireX,hireY,hireZ, "[~b~E~w~] Para ~b~ABRIR~w~ o sistema.")
					end
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							if vRPex.checkCaptain() then
								ToggleActionMenu()
								local carteira,banco,disabled,nome,sobrenome,idade,user_id,identidade,telefone,job,cargo,vip,disabled,multas,mypaypal = vRPex.playerInfo()
								SendNUIMessage({type = 'open',nome = nome,sobrenome = sobrenome,carteira = carteira,banco = banco,vip = vip,emprego = job,cargo = cargo,id = user_id,documento = identidade,idade = idade,telefone = telefone,multas = multas,mypaypal = mypaypal})
							else
								TriggerEvent("Notify","negado","Você não tem permissão")
							end
						end
					end
				end
			end
		
		Wait(idle)
	end
end)

RegisterNetEvent('Policia:infoPlayer')
AddEventHandler('Policia:infoPlayer', function(nome,age,job,registration)
	SendNUIMessage({infoShowUser = true, nome = nome, age = age, job = job, registration = registration})
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