local webhook_antiflood = ""


--Comando: vRP.antiflood(source,key,limite)
-- source 	-> player que acionou o evento/comando
-- key 		-> origem do flood, uma forma de identificar onde ele floodou, uma dica é colocar o comando q ta sendo usado o antiflood ou o evento onde está o antiflood
-- limite 	-> tolerancia para o antiflood banir o kr, isso varia de caso pra caso,
--				um comando como o ilegal por exemplo, é bom colocar um valor alto, por volta de 10 pra evitar banir o pessoal que manda mt mensagem picotada no ilegal.
--				em um evento/função que vc sabe q n tem como floodar, tipo, tirar item do bau por exemplo, isso vc pode colocar uma tolerancia baixa, tipo 2 pois você sabe que no intervalor de 1seg o kr n consegue fazer mais requisições que isso.



--Exemplos de uso:
--[[
--antiflood no comando ilegal evitando que o povo floode
RegisterCommand('ilegal', function(source, args, rawCommand)
	vRP.antiflood(source,"/ilegal",10)
	
	
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if not vRP.hasPermission(user_id,"policia.permissao") then
			Citizen.CreateThread(function()
				print("[Anonimo] " ..GetPlayerName(player).. " - " ..user_id .. ':' .. rawCommand:sub(7))					
			end)
			TriggerClientEvent('chatMessage', -1, "[@Anonimo]", {255, 255, 255}, rawCommand:sub(7))			
		end
	end
end)


--antiflood em um evento de spawn de dinheiro
RegisterServerEvent("reanimar:pagamento_")
AddEventHandler("reanimar:pagamento_",function()
	vRP.antiflood(source,"/ilegal",3)
	local user_id = vRP.getUserId(source)
	if user_id then
		pagamento = math.random(50,80)
		vRP.giveMoney(user_id,pagamento)
		TriggerClientEvent("Notify",source,"sucesso","Recebeu <b>$"..pagamento.." dólares</b> de gorjeta do americano.")
	end
end)
]]




local delayflood = {}
local flood = {}
function vRP.antiflood(source,key,limite)
	if(flood[key]==nil or delayflood[key] == nil)then 
		flood[key]={}
		delayflood[key]={}
	end
    if(flood[key][source]==nil)then
        flood[key][source] = 1
        delayflood[key][source] = os.time()
    else
        if(os.time()-delayflood[key][source]<1)then
            flood[key][source]= flood[key][source] + 1
            if(flood[key][source]==limite)then
                local user_id = vRP.getUserId(source)
                vRP.setBanned(user_id,true)    
                DropPlayer(source, "Hoje não!")
				
				mensagem = "[ID]: "..user_id.."\n[ANTI-FLOOD]: "..key..os.date("\n[DATA]: %d/%m/%Y [Hora]: %H:%M:%S")
				PerformHttpRequest(webhook_antiflood, function(err, text, headers) end, 'POST', json.encode({content = mensagem}), { ['Content-Type'] = 'application/json' })
            end
        else
            flood[key][source]=nil
            delayflood[key][source] = nil
        end
        delayflood[key][source] = os.time()
    end
end