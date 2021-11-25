local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("vrp_disassemble",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return true
end

function emP.checkVehicle()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,work = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(puser_id), vehicle = vname })
				if #vehicle <= 0 then
					TriggerClientEvent("Notify",source,"importante","Veículo não encontrado na lista do proprietário.",8000)
					return
				end
				if parseInt(vehicle[1].detido) == 1 then
					TriggerClientEvent("Notify",source,"aviso","Veículo encontra-se apreendido na seguradora.",8000)
					return
				end
				if banned then
					TriggerClientEvent("Notify",source,"negado","Veículos de serviço ou alugados não podem ser desmanchados.",8000)
					return
				end
			end
			local price = (vRP.vehiclePrice(vname)*0.1)
	        vRP.giveInventoryItem(user_id,"dinheiro-sujo",price)

			return true
		end
	end
end