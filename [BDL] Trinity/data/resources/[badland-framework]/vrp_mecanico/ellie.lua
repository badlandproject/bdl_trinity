local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("vrp_mecanico", src)

-- [ WEBHOOK ] --
local onServiceBN = "SEULINK"
local offServiceBN = "SEULINK"
local positionBennys = "SEULINK"
-- [ COMPRAR ARRAY ] --
local forSale = {
    { item = "repairkit", name = "Kit de Reparos", price = 5000, amount = 1 },
    { item = "militec", name = "Militec-9", price = 3500, amount = 1 },
    { item = "pneus", name = "Pneus", price = 1500, amount = 1 },
    { item = "melhoria", name = "Melhoria", price = 7500, amount = 1 }
}
-- [ COMPRAR ] --
RegisterServerEvent("bennys-comprar")
AddEventHandler("bennys-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(forSale) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.price)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.amount))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.amount).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.price)).." dólares</b>.")
						PerformHttpRequest(bennysLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DA BENNYS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Registro do usuário:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do ID:**", value = "` "..user_id.." ` "},{ name = "**Comprou:**", value = "` "..vRP.itemNameList(v.item).." `"},{ name = "**Pagou a quantia:**", value = "` "..parseInt(v.compra).." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
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

-- [ EVENTO TOW ] --
RegisterServerEvent("trytow")
AddEventHandler("trytow",function(nveh,rveh)
	TriggerClientEvent("synctow",-1,nveh,rveh)
end)
-- [ EVENTO REPARAR ] --
RegisterServerEvent("tryreparar")
AddEventHandler("tryreparar",function(nveh)
	TriggerClientEvent("syncreparar",-1,nveh)
end)
-- [ EVENTO MOTOR ] --
RegisterServerEvent("trymotor")
AddEventHandler("trymotor",function(nveh)
	TriggerClientEvent("syncmotor",-1,nveh)
end)
-- [ EVENTO PNEUS ] --
RegisterServerEvent("trypneus")
AddEventHandler("trypneus",function(nveh)
	TriggerClientEvent("syncpneus",-1,nveh)
end)
-- [ ENTRAR/SAIR DE SERVIÇO ] --
function src.checkBennys()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if user_id then
        if vRP.hasPermission(user_id,"bennys.permission") then
            vRP.addUserGroup(user_id,"off-bennys")
            TriggerClientEvent("Notify",source,"importante","Você saiu de serviço")
            PerformHttpRequest(offServiceBN, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Bennys `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
        elseif vRP.hasPermission(user_id,"off-bennys.permission") then
            vRP.addUserGroup(user_id,"bennys")
            TriggerClientEvent("Notify",source,"importante","Você entrou em serviço")
            PerformHttpRequest(onServiceBN, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Entrou em serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Bennys `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
        else
			TriggerClientEvent("Notify",source,"negado","Você não faz parte da bennys.")
		end
    end
end

-- [ MECS EM SERVIÇO ] --
RegisterCommand('mecs', function(source,args,rawCommand)
 	local user_id = vRP.getUserId(source)
 	local player = vRP.getUserSource(user_id)
 	local oficiais = vRP.getUsersByPermission("bennys.permission")
 	local paramedicos = 0
 	local oficiais_nomes = ""
 	if vRP.hasPermission(user_id,"bennys.permission") or vRP.hasPermission(user_id,"staff.permission") then
 		for k,v in ipairs(oficiais) do
 			local identity = vRP.getUserIdentity(parseInt(v))
 			oficiais_nomes = oficiais_nomes .. "<b>" .. v .. "</b>: " .. identity.name .. " " .. identity.firstname .. "<br>"
 			paramedicos = paramedicos + 1
 		end
 		TriggerClientEvent("Notify",source,"importante", "Atualmente <b>"..paramedicos.." Mecânicos</b> em serviço.",10000)
 		if parseInt(paramedicos) > 0 then
 			TriggerClientEvent("Notify",source,"importante", oficiais_nomes,10000)
 		end
 	end
end)

-- [ BENNYS CHAT ] --
RegisterCommand('bnns',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"bennys.permission") then
			if user_id then
				TriggerClientEvent('chatMessage',-1,"[ BENNY'S ] "..identity.name.." "..identity.firstname,{255,180,0},rawCommand:sub(5))
				SendWebhookMessage(webhookchatlspd,"**[ BENNY'S ] "..identity.name.." "..identity.firstname..":** "..rawCommand:sub(5)..os.date("  **|**  ` [Data]: %d/%m/%Y [Hora]: %H:%M:%S `"))
			end
		end
	end
end)
-- [ INTERNO ] --
RegisterCommand('br',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local permission = "bennys.permission"
		if vRP.hasPermission(user_id,permission) then
			local soldado = vRP.getUsersByPermission(permission)
			for l,w in pairs(soldado) do
				local player = vRP.getUserSource(parseInt(w))
				if player then
					async(function()
						TriggerClientEvent('chatMessage',player,"[ INTERNO ] "..identity.name.." "..identity.firstname,{255,80,0},rawCommand:sub(3))
					end)
				end
			end
		end
	end
end)
-- [ CONTRATAR ] --
RegisterCommand('contratar',function(source,args,rawCommand)
	if args[1] and args[2] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource_ = vRP.getUserSource(parseInt(args[1]))
		local nplayer_ = vRP.getUserId(nsource_)
		local identitynu = vRP.getUserIdentity(parseInt(nplayer_))
		local hirePosition = ""
		if vRP.hasPermission(user_id,"bennysceo.permission") or vRP.hasPermission(user_id,"staff.permission") then
			if nplayer_ == nil then
				TriggerClientEvent("Notify",source,"negado","Passaporte inválido ou indisponível.")
			else
				if args[1] == tostring(user_id) then
					TriggerClientEvent("Notify",source,"negado","Você não pode contratar a si mesmo.")
				else
					local yes = vRP.request(nsource_,"O responsável <b>"..identity.name.." "..identity.firstname.."</b> deseja realizar um processo de contratação, deseja aceitar ?",30)
					if args[2] == 'tow' then
						if yes then
							hirePosition = "Guincho"
							vRP.addUserGroup(nplayer_,"bennys")
							vRP.addUserGroup(nplayer_,"bennys-tow")
							TriggerClientEvent("Notify",source,"sucesso","Contratou <b>"..identitynu.name.." "..identitynu.firstname.."</b> na posição <b>"..hirePosition.."</b>")
							TriggerClientEvent("Notify",nsource_,"sucesso","O responsável <b>"..identity.name.." "..identity.firstname.."</b> realizou sua contratação na posição <b>"..hirePosition.."</b>")
							PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Contratação", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem contratou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário contratado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
						end
					elseif args[2] == 'mec' then
						if yes then
							hirePosition = "Mecânico"
							vRP.addUserGroup(nplayer_,"bennys")
							vRP.addUserGroup(nplayer_,"bennys-mechanic")
							TriggerClientEvent("Notify",source,"sucesso","Contratou <b>"..identitynu.name.." "..identitynu.firstname.."</b> na posição <b>"..hirePosition.."</b>")
							TriggerClientEvent("Notify",nsource_,"sucesso","O responsável <b>"..identity.name.." "..identity.firstname.."</b> realizou sua contratação na posição <b>"..hirePosition.."</b>")
							PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Contratação", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem contratou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário contratado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
						end
					elseif args[2] == 'manager' then
						if yes then
							hirePosition = "Gerente"
							vRP.addUserGroup(nplayer_,"bennys")
							vRP.addUserGroup(nplayer_,"bennys-manager")
							TriggerClientEvent("Notify",source,"sucesso","Contratou <b>"..identitynu.name.." "..identitynu.firstname.."</b> na posição <b>"..hirePosition.."</b>")
							TriggerClientEvent("Notify",nsource_,"sucesso","O responsável <b>"..identity.name.." "..identity.firstname.."</b> realizou sua contratação na posição <b>"..hirePosition.."</b>")
							PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Contratação", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem contratou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário contratado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }, { name = "**Na posição:**", value = "` "..hirePosition.." `\n⠀" },}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
						end
					else
						TriggerClientEvent("Notify",source,"negado","Posição inválida.")
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
		end
	else
		TriggerClientEvent("Notify",source,"importante","Utilize /contratar <b> passaporte posição </b>")
	end
end)

RegisterCommand('promover',function(source,args,rawCommand)
	if args[1] then
		local currentPos = 0
		local posNumber = 0
		local currentString = ""
		local stringPos = ""
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource_ = vRP.getUserSource(parseInt(args[1]))
		local nplayer_ = vRP.getUserId(nsource_)
		local identitynu = vRP.getUserIdentity(parseInt(nplayer_))
		if vRP.hasPermission(user_id,"bennysceo.permission") or vRP.hasPermission(user_id,"staff.permission") then
			if vRP.hasPermission(nplayer_,"bennys.permission") then
				if vRP.hasPermission(nplayer_,"tow.permission") then
					currentPos = 1
					currentString = "Guincho"
				elseif vRP.hasPermission(nplayer_,"mechanic.permission") then
					currentPos = 2
					currentString = "Mecânico"
				elseif vRP.hasPermission(nplayer_,"manager.permission") then
					currentPos = 3
					currentString = "Gerente"
				end
				local yes = vRP.request(source,"Você deseja realmente promover o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> ?",30)
				local confirmRandom = math.random(1,6)
				local confirmText = ""
				if confirmRandom >= 1 and confirmRandom < 3 then
					confirmText = "badland"
				elseif confirmRandom >= 3 and confirmRandom < 5 then
					confirmText = "notrobot"
				elseif confirmRandom >= 5 then
					confirmText = "bebetter"
				end
				if args[2] == "mec" then
					if yes then
						local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
						if confirm == tostring(confirmText) then
							posNumber = 2
							if posNumber <= currentPos then
								TriggerClientEvent("Notify",source,"negado","Você não pode promover um funcionário para uma posição inferior da atual.")
							else
								vRP.addUserGroup(nplayer_,"bennys-mechanic")
								TriggerClientEvent("Notify",source,"sucesso","Promoveu o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> para a posição <b> Mecânico </b>")
								TriggerClientEvent("Notify",nsource_,"sucesso","Você foi promovido pelo responsável <b>"..identity.name.." "..identity.firstname.."</b> para a posição <b> Mecânico </b>")
								stringPos = "Mecânico"
							end
						end
					end
				elseif args[2] == "manager" then
					if yes then
						local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
						if confirm == tostring(confirmText) then
							posNumber = 3
							if posNumber <= currentPos then
								TriggerClientEvent("Notify",source,"negado","Você não pode promover um funcionário para uma posição inferior da atual.")
							else
								vRP.addUserGroup(nplayer_,"bennys-manager")
								TriggerClientEvent("Notify",source,"sucesso","Promoveu o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> para a posição <b> Gerente </b>")
								TriggerClientEvent("Notify",nsource_,"sucesso","Você foi promovido pelo responsável <b>"..identity.name.." "..identity.firstname.."</b> para a posição <b> Gerente </b>")
								stringPos = "Gerente"
							end
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Posição inválida.")
				end
			else
				TriggerClientEvent("Notify",source,"negado","Passaporte não pertence a um funcionário da Bennys.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
		end
	else
		TriggerClientEvent("Notify",source,"importante","Utilize /promover <b> passaporte posição </b>")
	end
end)

-- [ EXONERAR ] --
RegisterCommand('demitir',function(source,args,rawCommand)
	if args[1] then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local nsource_ = vRP.getUserSource(parseInt(args[1]))
		local nplayer_ = vRP.getUserId(nsource_)
		local identitynu = vRP.getUserIdentity(parseInt(nplayer_))
		if vRP.hasPermission(user_id,"bennysceo.permission") or vRP.hasPermission(user_id,"staff.permission") then
			if args[1] ~= tostring(user_id) then
				local yes = vRP.request(source,"Você deseja realmente demitir o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b> ?",30)
				local confirmRandom = math.random(1,6)
				local confirmText = ""
				if confirmRandom >= 1 and confirmRandom < 3 then
					confirmText = "badland"
				elseif confirmRandom >= 3 and confirmRandom < 5 then
					confirmText = "notrobot"
				elseif confirmRandom >= 5 then
					confirmText = "bebetter"
				end
				if yes then
					local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
					if confirm == tostring(confirmText) then
						exonerar(nplayer_)
						TriggerClientEvent("Notify",source,"sucesso","Você exonerou o funcionário <b>"..identitynu.name.." "..identitynu.firstname.."</b>")
						TriggerClientEvent("Notify",nsource_,"negado","Você foi exonerado pelo responsável <b>"..identity.name.." "..identity.firstname.."</b>")
						PerformHttpRequest(positionBennys, function(err, text, headers) end, 'POST', json.encode({ embeds = {{ title = "Benny's - Exoneração", description = "Administração de cargos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem exonerou:**", value = "` "..identity.name.." "..identity.firstname.." `\n" }, { name = "**Nº Passaporte:**", value = "` "..user_id.." ` \n" }, { name = "**Usuário exonerado:**", value = "` "..identitynu.name.." "..identitynu.firstname.." `\n⠀" }, { name = "**Nº Passaporte:**", value = "` "..nplayer_.." `\n⠀" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
					else
						TriggerClientEvent("Notify",nsource_,"negado","Você falhou na verificação")
					end
				end
			else
				local yes = vRP.request(source,"Você deseja realmente se demitir ?",30)
				local confirmRandom = math.random(1,6)
				local confirmText = ""
				if confirmRandom >= 1 and confirmRandom < 3 then
					confirmText = "badland"
				elseif confirmRandom >= 3 and confirmRandom < 5 then
					confirmText = "notrobot"
				elseif confirmRandom >= 5 then
					confirmText = "bebetter"
				end
				if yes then
					local confirm = vRP.prompt(source,"Digite <b>' "..confirmText.." '</b> para confirmar.","")
					if confirm == tostring(confirmText) then
						vRP.removeUserGroup(user_id,"bennys")
						vRP.removeUserGroup(user_id,"off-bennys")
						vRP.removeUserGroup(user_id,"bennys-ceo")
						TriggerClientEvent("Notify",source,"sucesso","Você se demitiu.")
					else
						TriggerClientEvent("Notify",source,"negado","Você falhou na verificação")
						return
					end
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
		end
	else
		TriggerClientEvent("Notify",source,"importante","Utilize /demitir <b> passaporte </b>")
	end
end)
function exonerar(employee)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(employee,"tow.permission") then
		vRP.removeUserGroup(employee,"bennys")
		vRP.removeUserGroup(employee,"off-bennys")
		vRP.removeUserGroup(employee,"bennys-tow")
	elseif vRP.hasPermission(employee,"mechanic.permission") then
		vRP.removeUserGroup(employee,"bennys")
		vRP.removeUserGroup(employee,"off-bennys")
		vRP.removeUserGroup(employee,"bennys-mechanic")
	elseif vRP.hasPermission(employee,"manager.permission") then
		vRP.removeUserGroup(employee,"bennys")
		vRP.removeUserGroup(employee,"off-bennys")
		vRP.removeUserGroup(employee,"bennys-manager")
	end
end

-- [ PERMISSÃO ] --
function src.checkPermission()
	local source = source
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"bennys.permission") then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
	end
end