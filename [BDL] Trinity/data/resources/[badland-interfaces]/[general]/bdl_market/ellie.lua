-- [ TUNELAGEM ] --
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("bdl_market",vRPex)

local idgens = Tools.newIDGenerator()
local blips = {}
local marketLog = "yourlink"
local registradoraLog = "yourlink"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

-- [ TABELA ] --
local valores = {
	{ item = "sanduiche", quantidade = 1, compra = 50 },
	{ item = "rosquinha", quantidade = 1, compra = 50 },
	{ item = "hotdog", quantidade = 1, compra = 50 },
	{ item = "xburguer", quantidade = 1, compra = 50 },
    { item = "chips", quantidade = 1, compra = 50 },
    { item = "batataf", quantidade = 1, compra = 50 },
    { item = "pizza", quantidade = 1, compra = 50 },
	{ item = "taco", quantidade = 1, compra = 50 },
	{ item = "agua", quantidade = 1, compra = 50 },
	{ item = "cola", quantidade = 1, compra = 50 },
	{ item = "sprunk", quantidade = 1, compra = 50 },
	{ item = "energetico", quantidade = 1, compra = 150 },
    { item = "leite", quantidade = 1, compra = 25 },
    { item = "barracho", quantidade = 1, compra = 25 },
    { item = "patriot", quantidade = 1, compra = 50 },
    { item = "pibwassen", quantidade = 1, compra = 50 },
	
	{ item = "mochila", quantidade = 1, compra = 7000 },
	{ item = "repairkit", quantidade = 1, compra = 5000 },
	{ item = "britadeira", quantidade = 1, compra = 2800 },
	{ item = "garrafavazia", quantidade = 1, compra = 75 },
	{ item = "s-blueberry", quantidade = 1, compra = 125 },
	{ item = "adubo", quantidade = 1, compra = 250 },
}

-- [ EVENTO DE COMPRA ] --
RegisterServerEvent("departamento-comprar")
AddEventHandler("departamento-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.compra)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
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

local timers = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timers) do
			if v > 0 then
				timers[k] = v - 1
			end
		end
	end
end)

function vRPex.checkRobbery(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local policia = vRP.getUsersByPermission("lspd.permission")
		if #policia >= 2 then
			if timers[id] == 0 or not timers[id] then
				timers[id] = 600
				TriggerClientEvent('iniciandoregistradora',source,head,x,y,z)
				vRPclient._playAnim(source,false,{{"oddjobs@shop_robbery@rob_till","loop"}},true)
				local random = math.random(100)
				if random >= 50 then
					TriggerClientEvent("Notify",source,"aviso","A policia foi acionada.",8000)
					TriggerClientEvent("vrp_sound:source",source,'alarm',0.2)
					vRPclient.setStandBY(source,parseInt(60))
					for l,w in pairs(policia) do
						local player = vRP.getUserSource(parseInt(w))
						if player then
							async(function()
								local ids = idgens:gen()
								vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
								blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
								TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou na ^1Caixa Registradora^0, dirija-se até o local e intercepte o assaltante.")
								SetTimeout(20000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
							end)
						end
					end
				end
				SendWebhookMessage(registradoraLog,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				SetTimeout(10000,function()
					vRP.giveInventoryItem(user_id,"dinheiro-sujo",math.random(4000,7000))
				end)
			else
				TriggerClientEvent("Notify",source,"aviso","A registradora está vazia, aguarde <b>"..timers[id].." segundos</b> até que tenha dinheiro novamente.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		end
	end
end