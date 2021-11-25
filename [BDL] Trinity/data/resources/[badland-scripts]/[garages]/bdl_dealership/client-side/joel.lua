-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("bdl_dealership",src)
vSERVER = Tunnel.getInterface("bdl_dealership")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local dealerOpen = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERS
-----------------------------------------------------------------------------------------------------------------------------------------
local dealers = {
	{ ['x'] = -56.85, ['y'] = -1096.84, ['z'] = 26.43 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN DEALER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(dealers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance <= 10.5 then
					sleep = 5
					if not dealerOpen then
						DrawMarker(36,v.x,v.y,v.z,0,0,0,0,0,0,1.0,1.0,1.0,255,50,50,155,1,30,30,30)
						if distance <= 1.5 and IsControlJustPressed(0,38) then
							SetNuiFocus(true,true)
							TriggerEvent('bdl:triggerhud')
							TransitionToBlurred(1000)
							SendNUIMessage({ action = "showMenu" })
							dealerOpen = true
							vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEALERCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("dealerClose",function(data)
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "hideMenu" })
	TransitionFromBlurred(1000)
	TriggerEvent('bdl:triggerhud')
	dealerOpen = false
	vRP._DeletarObjeto()
	vRP._stopAnim(false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCARROS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestCarros",function(data,cb)
	local veiculos = vSERVER.Carros()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTMOTOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestMotos",function(data,cb)
	local veiculos = vSERVER.Motos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTIMPORT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestImport",function(data,cb)
	local veiculos = vSERVER.Import()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPOSSUIDOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestPossuidos",function(data,cb)
	local veiculos = vSERVER.Possuidos()
	if veiculos then
		cb({ veiculos = veiculos })
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUYDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyDealer",function(data)
	if data.name ~= nil then
		vSERVER.buyDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELLDEALER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellDealer",function(data)
	if data.name ~= nil then
		vSERVER.sellDealer(data.name)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AUTO-UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("dealership:Update")
AddEventHandler("dealership:Update",function(action)
	SendNUIMessage({ action = action })
end)

function DrawText3D(x,y,z, text)
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