local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

postd = {}
Tunnel.bindInterface("postman-delivery",postd)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local ammount = {}

--[ DELIVERY ORDER | FUNCTION ]-------------------------------------------------------------------------------------------------

function postd.startPayments()
	local source = source
	local user_id = vRP.getUserId(source)
	if ammount[source] == nil then
		ammount[source] = math.random(2,6)
	end
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"encomenda",ammount[source]) then
			local price = math.random(25,75)
			vRP.giveMoney(user_id,parseInt(price*ammount[source]))
			TriggerClientEvent("Notify",source,"sucesso","Você entregou <b>x"..ammount[source].." encomendas</b>, recebendo <b>$"..vRP.format(parseInt(price*ammount[source])).." dólares</b>.",8000)
			ammount[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..ammount[source].."x Encomendas</b>.",8000)
		end
	end
end