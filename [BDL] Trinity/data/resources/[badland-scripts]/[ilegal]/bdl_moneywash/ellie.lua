local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local idgens = Tools.newIDGenerator()
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("bdl_moneywash",src)


function src.tryWashMoney()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"lc.permission") then
		amount = vRP.prompt(source,"Coloque a quantidade: ","")
		if vRP.tryGetInventoryItem(user_id,"dinheiro-sujo",parseInt(amount)) then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Valor inválido")
		end
	else
		TriggerClientEvent("Notify",source,"negado","Sem permissão")
	end
end

function src.tryDeclareMoney()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"lc.permission") then
		vRP.giveMoney(user_id,amount*0.9)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Sem permissão")
	end
end