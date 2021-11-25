local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
inProgress = {}

vRPex = {}
Tunnel.bindInterface("minerman-foundry", vRPex)

local itemName = {
	{ item = "ferro" },
	{ item = "bronze" },
	{ item = "ouro" },
	{ item = "diamante" },
}

RegisterServerEvent("bdlCraftMac:fundir")
AddEventHandler("bdlCraftMac:fundir",function(item)
	local src = source
	local user_id = vRP.getUserId(src)
	if user_id then
		for e,g in pairs(itemName) do
			if item == g.item then
				if not inProgress[src] then
					if item == "ferro" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("ferro") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"ferro") >= 5 then
								if vRP.tryGetInventoryItem(user_id,"ferro",5) then
									TriggerClientEvent("progress",src,135000,"Fundindo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(135000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveMoney(user_id,1000)
										TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$1.000</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem ferro o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "bronze" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("bronze") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"bronze") >= 5 then
								if vRP.tryGetInventoryItem(user_id,"bronze",5) then
									TriggerClientEvent("progress",src,147000,"Fundindo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(147000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveMoney(user_id,1500)
										TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$1.500</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem bronze o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "ouro" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("ouro") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"ouro") >= 5 then
								if vRP.tryGetInventoryItem(user_id,"ouro",5) then
									TriggerClientEvent("progress",src,75000,"Fundindo")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(75000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveMoney(user_id,4000)
										TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$4.000</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem ouro o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "diamante" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("diamante") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"diamante") >= 2 then
								if vRP.tryGetInventoryItem(user_id,"diamante",2) then
									TriggerClientEvent("progress",src,192000,"Garimpando")
									vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
									inProgress[src] = true
									TriggerClientEvent("F6Cancel",src,true)
									SetTimeout(192000,function()
										vRPclient._stopAnim(src,false)
										vRP.giveMoney(user_id,10000)
										TriggerClientEvent("Notify",src,"sucesso","Você ganhou <b>$10.000</b>.")
										inProgress[src] = false
										TriggerClientEvent("F6Cancel",src,false)
									end)
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem diamante o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					end
				else
					TriggerClientEvent("Notify",src,"negado","Termine a produção em progresso para iniciar outra.")
				end
			end
		end
	end
end)