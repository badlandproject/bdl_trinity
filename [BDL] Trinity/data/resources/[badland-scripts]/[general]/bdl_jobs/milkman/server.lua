local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

milkman = {}
Tunnel.bindInterface("milkman",milkman)

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function milkman.checkPayment()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("garrafaleite")*3 <= vRP.getInventoryMaxWeight(user_id) then
		if vRP.tryGetInventoryItem(user_id,"garrafavazia",3) then
			vRP.giveInventoryItem(user_id,"garrafaleite",3)
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui <b>Garrafas vazias</b> o suficiente.")
		end
	else
		TriggerClientEvent("Notify",source,"negado","Mochila cheia.")
	end
end
