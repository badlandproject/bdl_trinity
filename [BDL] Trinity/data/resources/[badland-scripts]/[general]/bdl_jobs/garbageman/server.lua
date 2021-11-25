local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

garbage = {}
Tunnel.bindInterface("garbageman",garbage)

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

function garbage.payment()
	local source = source
	local user_id = vRP.getUserId(source)
	local payment = 20 + math.random(5,40)
	
	if user_id then
		vRP.giveMoney(user_id,payment)
		TriggerClientEvent("Notify",source,"sucesso","<b>Lixo coletado!</b> | Ganhos: <b>$"..payment.." dólares</b>.")
	end
end

function garbage.checkPlate(modelo)
	local source = source
	local user_id = vRP.getUserId(source)
	local veh,vhash,vplaca,vname = vRPclient.vehListHash(source,4)
	if veh and vhash == modelo then
		local placa_user_id = vRP.getUserByRegistration(vplaca)
		if user_id == placa_user_id then
			return true
		end
	end
end
