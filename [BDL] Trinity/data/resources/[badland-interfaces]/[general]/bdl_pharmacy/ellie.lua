-- [ TUNELAGEM ] --
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("bdl_pharmacy",vRPex)

-- [ TABELA ] --
local valores = {
	{ item = "dorflex", quantidade = 1, compra = 500, needed = "r-dorflex" },
	{ item = "voltaren", quantidade = 1, compra = 500, needed = "r-voltaren" },
	{ item = "tandrilax", quantidade = 1, compra = 500, needed = "r-trandrilax" },
	{ item = "buscopan", quantidade = 1, compra = 500, needed = "r-buscopan" },
	{ item = "paracetamol", quantidade = 1, compra = 500, needed = "r-paracetamol" },
}

-- [ EVENTO DE COMPRA ] --
RegisterServerEvent("ph-comprar")
AddEventHandler("ph-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						if vRP.tryGetInventoryItem(user_id,v.needed,1) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
						else
							TriggerClientEvent("Notify",source,"negado","Você não possui a <b>receita</b> do medicamento.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)