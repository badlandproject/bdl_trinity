-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("rob_market",src)
vCLIENT = Tunnel.getInterface("rob_market")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdepartamento = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[2] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[3] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[4] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[5] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[6] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[7] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[8] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 },
	[9] = { ['place'] = "Loja de Departamento", ['seconds'] = 25, ['rewmin'] = 100000, ['rewmax'] = 150000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("lspd.permission")
		if #policia < 2 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
			return false
		elseif (os.time()-timedown) <= 2000 then
			TriggerClientEvent("Notify",source,"aviso","Os cofres estão vazios, aguarde <b>"..vRP.format(parseInt((7200-(os.time()-timedown)))).." segundos</b> até que os civis efetuem depositos.",8000)
			return false
		end
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		robbery = true
		timedown = os.time()
		vCLIENT.startRobbery(source,robbers[id].seconds,x,y,z)
		TriggerClientEvent("vrp_sound:source",source,'alarm',0.7)
		vRPclient.setStandBY(source,parseInt(600))

		local policia = vRP.getUsersByPermission("lspd.permission")
		for k,v in pairs(policia) do
			local policial = vRP.getUserSource(v)
			if policial then
				async(function()
					vCLIENT.startRobberyPolice(policial,x,y,z,robbers[id].place)
					vRPclient.playSound(policial,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O roubo começou no ^1"..robbers[id].place.."^0, dirija-se até o local e intercepte os assaltantes.")
				end)
			end
		end
		SendWebhookMessage(webhookdepartamento,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		SetTimeout(robbers[id].seconds*1000,function()
			if robbery then
				robbery = false
				vRP.searchTimer(user_id,1800)
				vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(math.random(robbers[id].rewmin,robbers[id].rewmax)))
				for k,v in pairs(policia) do
					local policial = vRP.getUserSource(v)
					if policial then
						async(function()
							vCLIENT.stopRobberyPolice(policial)
							TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
						end)
					end
				end
			end
		end)

	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			robbery = false
			local policia = vRP.getUsersByPermission("lspd.permission")
			for k,v in pairs(policia) do
				local policial = vRP.getUserSource(v)
				if policial then
					async(function()
						vCLIENT.stopRobberyPolice(policial)
						TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
					end)
				end
			end
		end
	end
end