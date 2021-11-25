local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("vrp_hospital")

src = {}
Tunnel.bindInterface("vrp_hospital",src)


-- [ MACAS ] --
local macas = {
	{ ['x'] = 318.49, ['y'] = -580.73, ['z'] = 43.29, ['x2'] = 319.37, ['y2'] = -581.0, ['z2'] = 44.21, ['h'] = 330.0 },
	{ ['x'] = 323.26, ['y'] = -582.81, ['z'] = 43.29, ['x2'] = 324.28, ['y2'] = -582.84, ['z2'] = 44.21, ['h'] = 330.0 },
	{ ['x'] = 321.95, ['y'] = -586.58, ['z'] = 43.29, ['x2'] = 322.49, ['y2'] = -587.32, ['z2'] = 44.21, ['h'] = 160.0 },
	{ ['x'] = 316.97, ['y'] = -584.84, ['z'] = 43.29, ['x2'] = 317.64, ['y2'] = -585.4, ['z2'] = 44.21, ['h'] = 160.0 },
	{ ['x'] = 313.71, ['y'] = -583.78, ['z'] = 43.29, ['x2'] = 314.39, ['y2'] = -584.21, ['z2'] = 44.21, ['h'] = 160.0 },
	{ ['x'] = 310.26, ['y'] = -582.5, ['z'] = 43.29, ['x2'] = 311.04, ['y2'] = -582.9, ['z2'] = 44.21, ['h'] = 160.0 },
	{ ['x'] = 308.71, ['y'] = -581.82, ['z'] = 43.29, ['x2'] = 307.64, ['y2'] = -581.77, ['z2'] = 44.21, ['h'] = 160.0 },
}
-- [ MACAS SEM TRATAMENTO ] --
local macas2 = {
	{ ['x'] = 320.27, ['y'] = -568.67, ['z'] = 43.29, ['x2'] = 321.16, ['y2'] = -568.56, ['z2'] = 44.26, ['h'] = 345.0 },
	{ ['x'] = 314.66, ['y'] = -565.92, ['z'] = 43.29, ['x2'] = 315.52, ['y2'] = -566.38, ['z2'] = 44.28, ['h'] = 345.0 },
}
-- [ MACAS THREAD ] --
isLying = false
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local macas = macas[k]
			if distance <= 1.5 then
				sleep = 5
				if distance <= 1.1 then
					drawTxt("~r~E~w~  DEITAR    ~r~G~w~  TRATAMENTO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
						isLying = true
					end
					if IsControlJustPressed(0,47) then
						if GetEntityHealth(ped) >= 300 then
							TriggerEvent("Notify","negado","Você não precisa de tratamento.")
						else
							if emP.checkServices() then
								TriggerEvent('cancelando',source,true)
								TriggerEvent("progress",150000)
								SetEntityCoords(ped,v.x2,v.y2,v.z2)
								SetEntityHeading(ped,v.h)
								vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
								SetTimeout(150000,function()
									TriggerEvent('cancelando',source,false)
									SetEntityHealth(ped,400)
									TriggerEvent("Notify","sucesso","Você já pode levantar.")
								end)
							else
								TriggerEvent("Notify","aviso","Existem médicos em serviço.")
							end
						end
					end
					if IsControlJustPressed(0,167) and isLying then
						ClearPedTasks(GetPlayerPed(-1))
					isLying = false
			end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-- [ MACAS SEM TRATAMENTO THREAD ] --
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		for k,v in pairs(macas2) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local macas2 = macas2[k]
			if distance <= 2 then
				sleep = 5
				if distance <= 1.1 then
					drawTxt("~r~E~w~  DEITAR",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) then
						SetEntityCoords(ped,v.x2,v.y2,v.z2)
						SetEntityHeading(ped,v.h)
						vRP._playAnim(false,{{"amb@world_human_sunbathe@female@back@idle_a","idle_a"}},true)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-- [ TRATAMENTO ] --
local tratamento = false
RegisterNetEvent("tratamento")
AddEventHandler("tratamento",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
    SetPedArmour(ped,armour)
	
	if isLying then
		if tratamento then
			return
		end

		tratamento = true
		TriggerEvent("Notify","sucesso","Tratamento iniciado, aguarde a liberação do <b>profissional médico.</b>.",8000)
		TriggerEvent('resetWarfarina')
		TriggerEvent('resetDiagnostic')
		

		if tratamento then
			repeat
				Citizen.Wait(600)
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+1)
				end
			until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 101
				TriggerEvent("Notify","sucesso","Tratamento concluido.",8000)
				tratamento = false
		end
	else
		TriggerEvent("Notify","negado","Você precisa estar deitado em uma maca para ser tratado.",8000)
	end
end)

-- [ REMEDIO ] --
local remedio = false
RegisterNetEvent("remedio")
AddEventHandler("remedio",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armour = GetPedArmour(ped)

    SetEntityHealth(ped,health)
    SetPedArmour(ped,armour)
	
	
		if remedio then
			return
		end

		remedio = true
		TriggerEvent('resetWarfarina')
		TriggerEvent('resetDiagnostic')
		

		if remedio then
			repeat
				Citizen.Wait(600)
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+1)
				end
			until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 101
				TriggerEvent("Notify","sucesso","Tratamento concluido.",8000)
				remedio = false
		end
end)
-- [ FUNÇÕES DE TEXTO ] --
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

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end