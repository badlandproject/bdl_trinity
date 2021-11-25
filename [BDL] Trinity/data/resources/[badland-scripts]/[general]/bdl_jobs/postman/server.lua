local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

post = {}
Tunnel.bindInterface("postman",post)

--[ COLLECT | FUNCTION ]--------------------------------------------------------------------------------------------------------

function post.checkWeight()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("encomenda")*3 <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"encomenda",3)
			return true
		else
			TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.",10000)
			return false
		end
	end
end
