local Salas = {}
Salas["default"] = "Link de uma sala para onde serão enviados todas logs que não ser definido uma sala pra ela"

--EXEMPLOS DE SALAS
--[[
Salas["Money"] = "Link do webhook para money"
Salas["NOCLIP"] = "LINK PARA LOG DO COMANDO NC"
]]

--EXEMPLOS DE ENVIO DE LOGS NO DISCORD CONSUMINDO AS SALAS ACIMA
--[[
vRP.Log("Esta mensagem será enviada para sala de logs do noclip","NOCLIP")
vRP.Log("Esta mensagem será enviada para sala de money","Money")
vRP.Log("Esta mensagem será enviada para sala default pois não estou passando a sala >")
]]

function vRP.log(mensagem,sala)
	if(sala==nil)then sala= "default" end
	if(Salas[sala]==nil)then
		mensagem = "**LOGINFO: Sala não reconhecida:"..sala.."**\n"..mensagem
		sala = "default"
	end
	PerformHttpRequest(Salas[sala], function(err, text, headers) end, 'POST', json.encode({content = mensagem}), { ['Content-Type'] = 'application/json' })
end

function vRP.addwebhook(nomesala,linkwebhook)
	if(nomesala~=nil and linkwebhook~=nil)then
		Salas[nomesala] = linkwebhook
	end
end