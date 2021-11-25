local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRPex = Tunnel.getInterface("bdl_pdsystem")

systemX = -1098.73
systemY = -826.12
systemZ = 14.29
onMenu = false

local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		onMenu = true
		StartScreenEffect("MenuMGSelectionIn", 0, true)
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
	else
		onMenu = false
		StopScreenEffect("MenuMGSelectionIn")
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("bdl:triggerhud")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "m4a1" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"),150,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma M4A1 do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","M4-A1")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end

	elseif data == "m4a4" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_CARBINERIFLE_MK2"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_CARBINERIFLE"),150,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma M4A4 do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","M4-A4")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end

	elseif data == "mp5" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPDW"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_SMG"),130,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma MP5 do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","MP5")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end

	elseif data == "mpx" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_SMG"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPDW"),130,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma MPX do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","SS-MPX")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end

	elseif data == "shot45" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"),10,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma Executor .45 do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","Executor.45")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end

	elseif data == "shot12" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_PUMPSHOTGUN"),10,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma Secutor .12 do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","Secutor.12")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end

	elseif data == "fiveseven" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_COMBATPISTOL"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_PISTOL_MK2"),75,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma FiveSeven do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","FN Five-Seven")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end

	elseif data == "glock18" then
		if vRPex.checkPermission("lspd.permission") then
			RemoveWeaponFromPed(ped,GetHashKey("WEAPON_PISTOL_MK2"))
			GiveWeaponToPed(ped,GetHashKey("WEAPON_COMBATPISTOL"),75,0,0)
			TriggerEvent("Notify","sucesso","Você pegou uma Glock18 do arsenal.",9000)
			TriggerServerEvent("bdl:takeWeapons","Glock-18")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end
		
	elseif data == "take-kit" then
		if vRPex.checkPermission("lspd.permission") then
			GiveWeaponToPed(ped,GetHashKey("WEAPON_NIGHTSTICK"),0,0,0)
			GiveWeaponToPed(ped,GetHashKey("WEAPON_STUNGUN"),0,0,0)
			GiveWeaponToPed(ped,GetHashKey("WEAPON_FLASHLIGHT"),0,0,0)
			TriggerEvent("Notify","sucesso","Você pegou seu kit de defesa pessoal.",9000)
			TriggerServerEvent("bdl:takekitlog")
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end
		
	elseif data == "rem-kit" then
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_NIGHTSTICK"))
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_STUNGUN"))
		RemoveWeaponFromPed(ped,GetHashKey("WEAPON_FLASHLIGHT"))
		TriggerEvent("Notify","sucesso","Você guardou seu kit de defesa pessoal.",9000)
		TriggerServerEvent("bdl:remkitlog")
	elseif data == "clear" then
		RemoveAllPedWeapons(ped,0)
		TriggerEvent("Notify","sucesso","Você guardou todos os equipamentos no arsenal.")
		TriggerServerEvent("bdl:remWeaponsLog")
	elseif data == "on-duty" then
		TriggerServerEvent('bdl:onduty')

	elseif data == "off-duty" then
		RemoveAllPedWeapons(ped,true)
		SetPedArmour(ped,0)
		TriggerServerEvent('bdl:offduty')
		
	elseif data == "onarmor" then
		if vRPex.checkPermission("lspd.permission") then
			TriggerServerEvent('bdl:onarmor')
		else
			TriggerEvent("Notify","negado","Você precisa entrar em serviço para isso.",9000)
		end
		
	elseif data == "offarmor" then
		TriggerServerEvent('bdl:offarmor')
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local system = {
	{ ['x'] = -1098.73, ['y'] = -826.12, ['z'] = 14.29 },
}


-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = Vdist(systemX,systemY,systemZ,x,y,z)
		if distance <= 6 then
			idle = 5
			if not onMenu then
				DrawMarker(30, systemX,systemY,systemZ-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,140,255,90,0,0,0,1)
				if distance <= 2 then
					DrawText3D(systemX,systemY,systemZ, "[~b~E~w~] Para ~b~ABRIR~w~ o sistema.")
					if distance <= 1.2 then
						if IsControlJustPressed(0,38) then
							if vRPex.checkOfficer() then
								ToggleActionMenu()
							else
								TriggerEvent("Notify","negado","Você não tem permissão.")
							end
						end
					end
				end
			end
		end
		Wait(idle)
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