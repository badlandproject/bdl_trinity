local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

EMS = Tunnel.getInterface("bdl_emsystem")

sysX = 311.53
sysY = -594.32
sysZ = 43.29
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
	if data == "dorflex" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","dorflex")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end
	
	elseif data == "voltaren" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","voltaren")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "tandrilax" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","tandrilax")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "buscopan" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","buscopan")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "paracetamol" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","paracetamol")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "r-dorflex" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","r-dorflex")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end
		
	elseif data == "r-voltaren" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","r-voltaren")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "r-tandrilax" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","r-tandrilax")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "r-buscopan" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","r-buscopan")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "r-paracetamol" then
		if EMS.checkPermission("ems.permission") then
			TriggerServerEvent("bdl:emsystem","r-paracetamol")
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer receita do prontuário médico.',5000)
		end

	elseif data == "on-service" then
		TriggerServerEvent('bdl:onservice')

	elseif data == "off-service" then
		TriggerServerEvent('bdl:offservice')
		
	elseif data == "take-kit" then
		if EMS.checkPermission("ems.permission") then
			SetPedArmour(ped,100)
			GiveWeaponToPed(ped,"WEAPON_STUNGUN",0,0,0)
			GiveWeaponToPed(ped,"WEAPON_FLASHLIGHT",0,0,0)
		else
			TriggerEvent('Notify','negado','Você precisa entrar em serviço para pegar qualquer equipamento do estoque do EMS.',5000)
		end
		
	elseif data == "rem-kit" then
		SetPedArmour(ped,0)
		RemoveAllPedWeapons(ped,0)

	elseif data == "clear-med" then
		TriggerServerEvent('bdl:clearmed')
		TriggerEvent('Notify','sucesso','Você guardou seus <b> Receituários </b> de volta no prontuário',5000)

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = Vdist(sysX,sysY,sysZ,x,y,z)
		if distance <= 5 then
			sleep = 5
			if not onMenu then
				DrawMarker(30, sysX,sysY,sysZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,25,25,90,0,0,0,1)
				if distance <= 2 then
					if distance <= 1.2 then
						DrawText3D(sysX,sysY,sysZ, "[~r~E~w~] Para ~r~ABRIR~w~ o sistema.")
						if IsControlJustPressed(0,38) and EMS.checkEms() then
							ToggleActionMenu()
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
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