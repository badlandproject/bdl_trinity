local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

milkd = {}
Tunnel.bindInterface("milkman-delivery",milkd)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local amount = {}

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function milkd.startPayments()
	local source = source

	if amount[source] == nil then
		amount[source] = math.random(3,6)
	end

	local user_id = vRP.getUserId(source)
	if user_id then
	
		local data = vRP.getUserAptitudes(user_id)
		if data then
			if vRP.tryGetInventoryItem(user_id,"garrafaleite",amount[source]) then
				local price = math.random(25,75)
				vRP.giveMoney(user_id,parseInt(price*amount[source]))
				TriggerClientEvent("vrp_sound:source",source,'coin',0.2)
				TriggerClientEvent("Notify",source,"sucesso","Entrega concluída, recebido <b>$"..vRP.format(parseInt(price*amount[source])).." dólares</b>.",8000)

				amount[source] = nil
				return true
			else
				TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..amount[source].."x Garrafas de Leite</b>.",8000)
			end
		end
		return false
	end
end