local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

farmer = {}
Tunnel.bindInterface("farmer",farmer)
cFARMER = Tunnel.getInterface("farmer")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local locates = {}
local ammount = {}

--[ RANDOM AMMOUNT | FUNCTION ]-------------------------------------------------------------------------------------------------

function farmer.ammount()
	local source = source
	if ammount[source] == nil then
		ammount[source] = math.random(1,3)
	end
end

--[ PLANTING AND COLLECT | FUNCTION ]-------------------------------------------------------------------------------------------

function farmer.startPlanting(id,receive)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not locates[id] then		
			if receive == "blueberry" then		
				if vRP.getInventoryItemAmount(user_id,"s-blueberry") >= 1 then
					if vRP.getInventoryItemAmount(user_id,"adubo") >= 1 then
						vRP.tryGetInventoryItem(user_id,"adubo",1)
						vRP.tryGetInventoryItem(user_id,"s-blueberry",1)
						locates[id] = 0
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent("progress",source,9000,"plantando")
						vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
						Citizen.Wait(9000)
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("cancelando",source,false)
					else
						TriggerClientEvent("Notify",source,"negado","Você precisa de: <b>Adubo</b>.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Você precisa de: <b>Sementes</b>.")
				end
			end
		else
			if locates[id] >= 100 then
				farmer.ammount()
				if receive == "blueberry" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("blueberry")*parseInt(ammount[source]) <= vRP.getInventoryMaxWeight(user_id) then
						locates[id] = nil
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent("progress",source,10000,"colhendo")
						vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
						Citizen.Wait(10000)
						vRPclient._stopAnim(source,false)
						cFARMER.returnPlanting(-1,locates)
						TriggerClientEvent("cancelando",source,false)
						vRP.giveInventoryItem(user_id,"blueberry",parseInt(ammount[source]))
						ammount[source] = nil
					end
				end
			end
		end
	end
end

Citizen.CreateThread(function()
	while true do
		for k,v in pairs(locates) do
			if v ~= nil and v < 100 then
				locates[k] = v + 1
				cFARMER.returnPlanting(-1,locates)
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(1000)
	end
end)