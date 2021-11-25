local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-- [ WEBHOOK ] --

local logAdmin = "SEULINK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end

local itemlist = {
	["mochila"] = { index = "mochila", nome = "Mochila" },
	["celular"] = { index = "celular", nome = "Celular" },
	["radio"] = { index = "radio", nome = "WalkTalk" },
	["militec"] = { index = "militec", nome = "Militec" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos" },
	["pneus"] = { index = "pneus", nome = "Pneus" },
	["melhoria"] = { index = "melhoria", nome = "Melhoria Nvl.1" },
	["identidade"] = { index = "identidade", nome = "Identidade" },
	["colete"] = { index = "colete", nome = "Colete Balístico" },
	["roupas"] = { index = "roupas", nome = "Roupas" },
	["algema"] = { index = "algema", nome = "Algema" },
	
	-- [ Empregos ] --
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia" },
	["garrafaleite"] = { index = "garrafaleite", nome = "Garrafa de Leite" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda" },
	["britadeira"] = { index = "britadeira", nome = "Britadeira"},
	["ferro"] = { index = "ferro", nome = "Ferro" },
	["bronze"] = { index = "bronze", nome = "Bronze" },
	["ouro"] = { index = "ouro", nome = "Ouro" },
	["diamante"] = { index = "diamante", nome = "Diamante" },
	["blueberry"] = { index = "blueberry", nome = "Blueberry" },
	["s-blueberry"] = { index = "s-blueberry", nome = "Sementes" },

	-- [ Ilegais ] --
	["blankcard"] = { index = "blankcard", nome = "Cartão" },
	["dinamite"] = { index = "dinamite", nome = "Dinamite" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira" },
	["dinheiro-sujo"] = { index = "dinheiro-sujo", nome = "Dinheiro Sujo" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick" },
	["capuz"] = { index = "capuz", nome = "Capuz" },
	--#Ballas
	["pe-maconha"] = { index = "pe-maconha", nome = "Pé de Maconha" },
	["adubo"] = { index = "adubo", nome = "Adubo" },
	["maconha"] = { index = "maconha", nome = "Maconha" },
	["maconha-embalada"] = { index = "maconha-embalada", nome = "Maconha Emb." },
	--#Grove
	["folha-coca"] = { index = "folha-coca", nome = "Folha de Coca" },
	["pasta-coca"] = { index = "pasta-coca", nome = "Pasta de Coca" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína" },
	["coca-embalada"] = { index = "coca-embalada", nome = "Cocaína Emb." },
	--#Vagos
	["comprimidos"] = { index = "comprimidos", nome = "Comprimidos" },
	["acido"] = { index = "acido", nome = "Ácido" },
	["composito"] = { index = "composito", nome = "Compósito" },
	["querosene"] = { index = "querosene", nome = "Querosene" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina" },
	["meta-embalada"] = { index = "meta-embalada", nome = "Metanf. Emb." },
	--#Bratva
	["polvora"] = { index = "polvora", nome = "Pólvora"},
	["capsulas"] = { index = "capsulas", nome = "Capsulas" },
	["molas"] = { index = "molas", nome = "Molas" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho" },
	["placa-metal"] = { index = "placa-metal", nome = "Placa de Metal" },
	["corpo-ak103"] = { index = "corpo-ak103", nome = "Corpo de AK-103" },
	["corpo-ak47"] = { index = "corpo-ak47", nome = "Corpo de AK-47" },
	["corpo-ak74"] = { index = "corpo-ak74", nome = "Corpo de AK-74" },
	["corpo-mp5"] = { index = "corpo-mp5", nome = "Corpo de MP-5" },
	["corpo-tec9"] = { index = "corpo-tec9", nome = "Corpo de Tec-9" },
	["corpo-m1911"] = { index = "corpo-m1911", nome = "Corpo de M1911" },
	["corpo-hk110"] = { index = "corpo-hk110", nome = "Corpo de HK110" },
	-- [ Remédios ] --
	["paracetamol"] = { index = "paracetamol", nome = "Paracetamol"},
	["voltaren"] = { index = "voltaren", nome = "Voltaren"},
	["tandrilax"] = { index = "tandrilax", nome = "Tandrilax"},
	["dorflex"] = { index = "dorflex", nome = "Dorflex"},
	["buscopan"] = { index = "buscopan", nome = "Buscopan"},
	["r-paracetamol"] = { index = "r-paracetamol", nome = "R. Paracetamol"},
	["r-voltaren"] = { index = "r-voltaren", nome = "R. Voltaren"},
	["r-tandrilax"] = { index = "r-tandrilax", nome = "R. Tandrilax"},
	["r-dorflex"] = { index = "r-dorflex", nome = "R. Dorflex"},
	["r-buscopan"] = { index = "r-buscopan", nome = "R. Buscopan"},

	-- [ Bebidas ] --
	["agua"] = { index = "agua", nome = "G. d'Água"},
	["energetico"] = { index = "energetico", nome = "Energético"},
	["sprunk"] = { index = "sprunk", nome = "Sprunk"},
	["cola"] = { index = "cola", nome = "Cola"},
	["leite"] = { index = "leite", nome = "Leite"},
	["barracho"] = { index = "barracho", nome = "Barracho"},
	["patriot"] = { index = "patriot", nome = "Patriot"},
	["pibwassen"] = { index = "pibwassen", nome = "Pibwassen"},

	-- [ Comidas ] --
	["xburguer"] = { index = "xburguer", nome = "X Burguer"},
	["sanduiche"] = { index = "sanduiche", nome = "Sanduiche"},
	["pizza"] = { index = "pizza", nome = "Pizza"},
	["batataf"] = { index = "batataf", nome = "Batata Frita"},
	["chips"] = { index = "chips", nome = "Chips"},
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha"},
	["hotdog"] = { index = "hotdog", nome = "HotDog"},
	["taco"] = { index = "taco", nome = "Taco"},
	
	-- [ Armas ] --
	-- UTILITÁRIOS
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor" },
	-- BRANCAS
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete" },
	-- PISTOLAS
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five-Seven" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock-19" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911"},
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m22", nome = "FN-M22" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hk110", nome = "HK 110" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser" },
	-- RIFLES DE ASSALTO
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak47", nome = "AK-47" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak103", nome = "AK-103" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "m4a4", nome = "M4-A4" },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4-A1" },
	["wbody|WEAPON_ADVANCEDRIFLE"] = { index = "aug", nome = "AUG-A3" },
	-- SMGs
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5" },
	["wbody|WEAPON_COMBATPDW"] = { index = "mpx", nome = "MPX" },
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "ak74u", nome = "AK-74u" },
	-- SHOTGUNS
	["wbody|WEAPON_PUMPSHOTGUN"] = { index = "remington12", nome = "Secutor.12" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington45", nome = "Executor.45" },
	-- RIFLES DE CAÇA
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22" },
	
	-- [ Munições ] --
	-- UTILITÁRIOS
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas"},
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível"},
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador"},
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor"},
	-- PISTOLAS
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "FN Five-Seven" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "Glock-19" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M1911" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m22", nome = "FN-M22" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hk110", nome = "HK-110" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "Taser" },
	-- RIFLES DE ASSALTO
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak47", nome = "AK-47" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak103", nome = "AK-103"},
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-m4a4", nome = "M4-A4" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "M4-A1"},
	["wammo|WEAPON_ADVANCEDRIFLE"] = { index = "m-aug", nome = "AUG-A3" },
	-- SMGs
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "MP5" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-mpx", nome = "MPX" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "Tec-9"},
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-ak74u", nome = "AK-74u"},
	-- SHOTGUNS
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-remington12", nome = "Secutor.12"},
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington45", nome = "Executor.45" },
	-- RIFLES DE CAÇA
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22" }
}
-- [ SPAWN ITEM ] --
RegisterCommand('item',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		if args[1] and args[2] and itemlist[args[1]] ~= nil then
			vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]))
			local cargo = ""
			if vRP.hasPermission(user_id,"founder.permission") then
				cargo = "Fundador"
			elseif vRP.hasPermission(user_id,"manager.permission") then
				cargo = "Manager"
			elseif vRP.hasPermission(user_id,"admin.permission") then
				cargo = "Administrador"
			elseif vRP.hasPermission(user_id,"mod.permission") then
				cargo = "Moderador"
			end
			local nomeItem = args[1]
			local quantItem = parseInt(args[2])
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /ITEM:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem pegou:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº de Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Item:**", value = "` "..nomeItem.." ` "},{ name = "**Quantidade:**", value = "` "..quantItem.." `\n⠀"}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-- [ CLEAR INVENTORY ] --
RegisterCommand('clearinv',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    local player = vRP.getUserSource(user_id)
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        local tuser_id = tonumber(args[1])
        local tplayer = vRP.getUserSource(tonumber(tuser_id))
        local tplayerID = vRP.getUserId (tonumber(tplayer))
		local identityP = vRP.getUserIdentity(tplayerID)
		local cargo = ""
		if vRP.hasPermission(user_id,"founder.permission") then
			cargo = "Fundador"
		elseif vRP.hasPermission(user_id,"manager.permission") then
			cargo = "Manager"
		elseif vRP.hasPermission(user_id,"admin.permission") then
			cargo = "Administrador"
		elseif vRP.hasPermission(user_id,"mod.permission") then
			cargo = "Moderador"
		end
        if tplayerID ~= nil then
				local ndata = vRP.getUserDataTable(tplayerID)
				local reason = vRP.prompt(source,"Motivo:","")
				if reason == "" then
					return
				else
					if ndata ~= nil then
						if ndata.inventory ~= nil then
							for k,v in pairs(ndata.inventory) do
								if vRP.tryGetInventoryItem(tplayerID,k,v.amount) then
									PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /CLEARINV:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº de Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Limpou o inventário de:**", value = "` "..identityP.name.." "..identityP.firstname.." ` "},{ name = "**Nº de Passaporte:**", value = "` "..tplayerID.." `\n⠀"},{ name = "*Motivo:**", value = "` "..reason.." `\n⠀"}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
								end
							end
						end
					end
				end
                TriggerClientEvent("Notify",source,"sucesso","Limpou inventario do <b>"..identityP.name.." "..identityP.firstname.."</b>.")
        else
			TriggerClientEvent("Notify",source,"negado","O usuário não foi encontrado ou está offline.")
        end
    end
end)
-- [ USERVEHS ] --
RegisterCommand('uservehs',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id,"staff.permission") then
        	local nuser_id = parseInt(args[1])
            if nuser_id > 0 then 
                local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(nuser_id) })
                local car_names = {}
                for k,v in pairs(vehicle) do
                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b>")
                end
                car_names = table.concat(car_names, ", ")
                local identity = vRP.getUserIdentity(nuser_id)
                TriggerClientEvent("Notify",source,"importante","Veículos de <b>"..identity.name.." " .. identity.firstname.. " ("..#vehicle..")</b>: "..car_names,10000)
            end
        end
    end
end)
--[ VROUPAS ]--
local player_customs = {}
RegisterCommand('vroupas',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local custom = vRPclient.getCustomization(source)
	
    if vRP.hasPermission(user_id,"staff.permission") then
        if player_customs[source] then
            player_customs[source] = nil
            vRPclient._removeDiv(source,"customization")
        else 
			local content = ""
			
            for k,v in pairs(custom) do
                content = content..k.." => "..json.encode(v).."<br/>" 
            end

            player_customs[source] = true
            vRPclient._setDiv(source,"customization",".div_customization{ margin: auto; padding: 4px; width: 250px; margin-top: 200px; margin-right: 50px; background: rgba(15,15,15,0.7); color: #ffff; font-weight: bold; }",content)
        end
    end
end)
-- [ BLIP CFG ] --
local blips = {}
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if first_spawn then
       blips[source] = { source }
       TriggerClientEvent("blips:updateBlips",-1,blips)
        if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
            TriggerClientEvent("blips:adminStart",source)
        end
     end
 end)
 
AddEventHandler("playerDropped",function()
	if blips[source] then
		blips[source] = nil
		TriggerClientEvent("blips:updateBlips",-1,blips)
	end
end)
-- [ MSG ADM ] --
RegisterCommand('adm',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
	if user_id then
		if vRP.hasPermission(user_id,"staff.permission") then
			local mensagem = vRP.prompt(source,"Mensagem:","")
			local nome = vRP.prompt(source,"Nome:","")
			if mensagem == "" or nome == "" then
				return
			end
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /ADM:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nome informado:**", value = "` "..nome.." ` "},{ name = "**Mensagem:**", value = "` "..mensagem.." ` "},{ name = "**Membro que enviou:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			TriggerClientEvent("Notify",-1,"negado",mensagem.."<br><b>Mensagem enviada por:</b> "..nome,60000)
		end
	end
end)
-- [ ADD CAR ] --
RegisterCommand('addcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        if args[1] and args[2] then
			local reason = vRP.prompt(source,"Motivo:","")
			if reason == "" then
				return
			else
				local nuser_id = vRP.getUserId(nplayer)
				local identity = vRP.getUserIdentity(user_id)
				local identitynu = vRP.getUserIdentity(nuser_id)
				vRP.execute("creative/add_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time()) }) 
				TriggerClientEvent("Notify",source,"sucesso","Voce adicionou o veículo <b>"..args[1].."</b> para o Passaporte: <b>"..parseInt(args[2]).."</b>.") 
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /ADDCAR:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Adicionou na conta de:**", value = "` "..identitynu.name.." "..identitynu.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..nuser_id.." ` "},{ name = "**O veículo:**", value = "` "..args[1].." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			end
        end
    end
end)
-- [ REM CAR ] --
RegisterCommand('remcar',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserId(parseInt(args[2]))
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        if args[1] and args[2] then
			local reason = vRP.prompt(source,"Motivo:","")
			if reason == "" then
				return
			else
				local nuser_id = vRP.getUserId(nplayer)
				local identity = vRP.getUserIdentity(user_id)
				local identitynu = vRP.getUserIdentity(nuser_id)
				vRP.execute("creative/rem_vehicle",{ user_id = parseInt(args[2]), vehicle = args[1], ipva = parseInt(os.time())  }) 
				TriggerClientEvent("Notify",source,"sucesso","Voce removeu o veículo <b>"..args[1].."</b> do Passaporte: <b>"..parseInt(args[2]).."</b>.") 
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /REMCAR:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Removeu da conta de:**", value = "` "..identitynu.name.." "..identitynu.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..nuser_id.." ` "},{ name = "**O veículo:**", value = "` "..args[1].." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			end
        end
    end
end)

-- [ SPAWN VEH ADMIN COMMAND ] --
RegisterCommand('veh',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
			if args[1] then
				TriggerClientEvent('spawnarveiculo',source,args[1])
				TriggerEvent("setPlateEveryone",identity.registration)
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /VEH:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Spawnou o veículo:**", value = "` "..args[1].." ` "}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)

-- [ UNCUFF ] --
RegisterCommand('uncuff',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
	if user_id then
		if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
			local reason = vRP.prompt(source,"Motivo","")
			if reason == "" then
				reason = "Não especificado."
			end
			TriggerClientEvent("admcuff",source)
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /UNCUFF:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-- [ CLEAR AREA ] --
RegisterCommand('limpararea',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local x,y,z = vRPclient.getPosition(source)
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        TriggerClientEvent("syncarea",-1,x,y,z)
    end
end)
-- [ APAGAO ] --
RegisterCommand('apagao',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
			if args[1] ~= nil then
				if args[1] == "1" then
					local reason = vRP.prompt(source,"Motivo:","")
					if reason == "" then
						reason = "Não especificado."
					end
					local cond = tonumber(args[1])
					TriggerClientEvent("cloud:setApagao",-1,cond)
					PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /APAGAO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "}}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
				else
					local cond = tonumber(args[1])
					TriggerClientEvent("cloud:setApagao",-1,cond)
				end
			end				
        end
    end
end)
-- [ RAIOS ] --
RegisterCommand('raios', function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id ~= nil then
        local player = vRP.getUserSource(user_id)
        if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
			if args[1] ~= nil then
				local vezes = tonumber(args[1])
				TriggerClientEvent("cloud:raios",-1,vezes)
			end
        end
    end
end)
-- [ SKIN ] --
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        if parseInt(args[1]) then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                TriggerClientEvent("skinmenu",nplayer,args[2])
                TriggerClientEvent("Notify",source,"sucesso","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.")
            end
        end
    end
end)
-- [ SHOWINFO ] --
RegisterCommand('showinfo',function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"staff.permission") then
			TriggerClientEvent("ToggleDebug",player)
		end
	end
end)
-- [ TRYDELETE EVENT ] --
RegisterServerEvent("trydeleteobj")
AddEventHandler("trydeleteobj",function(index)
    TriggerClientEvent("syncdeleteobj",-1,index)
end)
-- [ FIX ] --
RegisterCommand('fix',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
	local vehicle = vRPclient.getNearestVehicle(source,11)
	if vehicle then
		if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
			TriggerClientEvent('reparar',source)
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /FIX:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Reparou o veículo:**", value = "` "..vehicle.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-- [ GOD ] --
RegisterCommand('god',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
			local nuser_id = vRP.getUserId(nplayer)
			local identitynu = vRP.getUserIdentity(nuser_id)
            if nplayer then
                vRPclient.killGod(nplayer)
				vRPclient.setHealth(nplayer,400)
                TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
				vRP.varyThirst(nplayer,-15)
				vRP.varyHunger(nplayer,-15)
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /GOD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Reviveu o jogador:**", value = "` "..identitynu.name.." "..identitynu.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..nuser_id.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
            end
        else
            vRPclient.killGod(source)
			vRPclient.setHealth(source,400)
			vRPclient.setArmour(source,100)
			vRP.varyThirst(user_id,-100)
			vRP.varyHunger(user_id,-100)
            TriggerClientEvent("resetBleeding",source)
            TriggerClientEvent("resetDiagnostic",source)
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /GOD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
        end
    end
end)
-- [ GOD INSIDE CAR ] --
RegisterCommand('cargod',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
			local nuser_id = vRP.getUserId(nplayer)
			local identitynu = vRP.getUserIdentity(nuser_id)
            if nplayer then
				vRPclient.setHealth(nplayer,400)
                TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
				vRP.varyThirst(nplayer,-15)
				vRP.varyHunger(nplayer,-15)
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /CARGOD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Reviveu o jogador:**", value = "` "..identitynu.name.." "..identitynu.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..nuser_id.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
            end
        else
			vRPclient.setHealth(source,400)
			vRPclient.setArmour(source,100)
			vRP.varyThirst(user_id,-100)
			vRP.varyHunger(user_id,-100)
            TriggerClientEvent("resetBleeding",source)
            TriggerClientEvent("resetDiagnostic",source)
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /CARGOD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
        end
    end
end)
-- [ GOD ALL ] --
RegisterCommand('godall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	end
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		local reason = vRP.prompt(source,"Motivo:","")
		if reason == "" then
			return
		else
			local users = vRP.getUsers()
			for k,v in pairs(users) do
				local id = vRP.getUserSource(parseInt(k))
				if id then
					vRPclient.killGod(id)
					vRPclient.setHealth(id,400)
					PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /GODALL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
					
				end
			end
		end
    end
end)
-- [ TUNING ] --
RegisterCommand('tuning',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		TriggerClientEvent('vehtuning',source)
	end
end)
-- [ 100 FUEL ] --
RegisterCommand('100fuel',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"staff.permission") then
			TriggerClientEvent("100fuel",source)
		end	
	end
end)
-- [ WHITELIST ] --
RegisterCommand('wl',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	elseif vRP.hasPermission(user_id,"support.permission") then
		cargo = "Suporte"
	end
    if vRP.hasPermission(user_id,"staff.permission") then
        if args[1] then
			local state = vRP.prompt(source,"O passaporte foi aprovado na entrevista? Y/N","")
			if state == "Y" or state == "y" then
				state = "Aprovado"
				vRP.setWhitelisted(parseInt(args[1]),true)
				TriggerClientEvent("Notify",source,"sucesso","Voce aprovou o passaporte <b>"..args[1].."</b> na whitelist.")
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /WL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Aprovou o passaporte:**", value = "` "..args[1].." ` "},{ name = "**Status da Whitelist:**", value = "` "..state.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			else
				return
			end
        end
    end
end)
-- [ UN WHITELIST ] --
RegisterCommand('unwl',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	elseif vRP.hasPermission(user_id,"support.permission") then
		cargo = "Suporte"
	end
	if vRP.hasPermission(user_id,"staff.permission") then
		if args[1] then
			local reason = vRP.prompt(source,"Motivo:","")
			if reason == "" then
				return
			else
				vRP.setWhitelisted(parseInt(args[1]),false)
				TriggerClientEvent("Notify",source,"sucesso","Voce retirou o passaporte <b>"..args[1].."</b> da whitelist.")
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /UNWL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Retirou da WL o passaporte:**", value = "` "..args[1].." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)
-- [ KICK ] --
RegisterCommand('kick',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	elseif vRP.hasPermission(user_id,"support.permission") then
		cargo = "Suporte"
	end
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		if args[1] then
			local id = vRP.getUserSource(parseInt(args[1]))
			local nuser_id = vRP.getUserId(id)
			local identitynu = vRP.getUserIdentity(nuser_id)
			if id then
				local reason = vRP.prompt(source,"Motivo:","")
				if reason == "" then
					return
				else
					vRP.kick(id,"Você foi expulso da cidade.")
					TriggerClientEvent("Notify",source,"sucesso","Voce kickou o passaporte <b>"..args[1].."</b> da cidade.")
					PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /KICK:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Expulsou da cidade o passaporte:**", value = "` "..nuser_id.." ` "},{ name = "**Com o nome de:**", value = "` "..identitynu.name.." "..identitynu.firstname.." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
				end
			end
		end
	end
end)
-- [ KICK ALL ] --
RegisterCommand('kickall',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	elseif vRP.hasPermission(user_id,"support.permission") then
		cargo = "Suporte"
	end	
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        local users = vRP.getUsers()
        for k,v in pairs(users) do
            local id = vRP.getUserSource(parseInt(k))
            if id then
				local reason = vRP.prompt(source,"Motivo:","")
				if reason == "" then
					return
				else
					vRP.kick(id,"Você foi vitima do terremoto.")
					PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /KICKALL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
				end
            end
        end
    end
end)
-- [ BAN ] --
RegisterCommand('ban',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	elseif vRP.hasPermission(user_id,"support.permission") then
		cargo = "Suporte"
	end	
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		if args[1] then
			local id = vRP.getUserSource(args[1])
			local nuser_id = vRP.getUserId(id)
			local identitynu = vRP.getUserIdentity(nuser_id)
			local reason = vRP.prompt(source,"Motivo:","")
			if reason == "" then
				return
			else
				vRP.setBanned(parseInt(args[1]),true)
				TriggerClientEvent("Notify",source,"sucesso","Voce baniu o passaporte <b>"..args[1].."</b> da cidade.")
				SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /BAN:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Baniu o Passaporte:**", value = "` "..args[1].." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)
-- [ UNBAN ] --
RegisterCommand('unban',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	elseif vRP.hasPermission(user_id,"support.permission") then
		cargo = "Suporte"
	end	
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		if args[1] then
			local reason = vRP.prompt(source,"Motivo:","")
			if reason == "" then
				return
			else
				vRP.setBanned(parseInt(args[1]),false)
				TriggerClientEvent("Notify",source,"sucesso","Voce desbaniu o passaporte <b>"..args[1].."</b> da cidade.")
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /UNBAN:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Desbaniu o Passaporte:**", value = "` "..args[1].." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
			end
		end
	end
end)
-- [ MONEY ] --
RegisterCommand('money',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local cargo = ""
	if vRP.hasPermission(user_id,"founder.permission") then
		cargo = "Fundador"
	elseif vRP.hasPermission(user_id,"manager.permission") then
		cargo = "Manager"
	elseif vRP.hasPermission(user_id,"admin.permission") then
		cargo = "Administrador"
	elseif vRP.hasPermission(user_id,"mod.permission") then
		cargo = "Moderador"
	elseif vRP.hasPermission(user_id,"support.permission") then
		cargo = "Suporte"
	end	
	if vRP.hasPermission(user_id,"founder.permission") or vRP.hasPermission(user_id,"manager.permission") or vRP.hasPermission(user_id,"admin.permission") then
		if args[1] then
			local reason = vRP.prompt(source,"Motivo:","")
			if reason == "" then
				reason = "Não especificado."
			end
			vRP.giveMoney(user_id,parseInt(args[1]))
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /MONEY:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Cargo na equipe:**", value = "` "..cargo.." ` "},{ name = "**Pegou a quantia de:**", value = "` "..args[1].." ` "},{ name = "**Motivo:**", value = "` "..reason.." ` "},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080 }}}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-- [ NOCLIP ] --
RegisterCommand('nc',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		vRPclient.toggleNoclip(source)
	end
end)
-- [ TP COORDS ] --
RegisterCommand('tpcds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		local fcoords = vRP.prompt(source,"Cordenadas:","")
		if fcoords == "" then
			return
		end
		local coords = {}
		for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
			table.insert(coords,parseInt(coord))
		end
		vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
	end
end)
-- [ COORDS ] --
RegisterCommand('cds',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		local x,y,z = vRPclient.getPosition(source)
		heading = GetEntityHeading(GetPlayerPed(-1))
		vRP.prompt(source,"Cordenadas:","['x'] = "..tD(x)..", ['y'] = "..tD(y)..", ['z'] = "..tD(z))
	end
end)

RegisterCommand('cds2',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		local x,y,z = vRPclient.getPosition(source)
		vRP.prompt(source,"Cordenadas:",tD(x)..","..tD(y)..","..tD(z))
	end
end)

function tD(n)
    n = math.ceil(n * 100) / 100
    return n
end
-- [ GROUP ] --
RegisterCommand('group',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"founder.permission") or vRP.hasPermission(user_id,"manager.permission") then
		if args[1] and args[2] then
			vRP.addUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Voce setou o passaporte <b>"..parseInt(args[1]).."</b> no grupo <b>"..args[2].."</b>.")
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /GROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**",value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Setou o Passaporte:**", value = "` "..args[1].." ` "},{ name = "**No grupo:**", value = "` "..args[2].." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-- [ UNGROUP ] --
RegisterCommand('ungroup',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"founder.permission") or vRP.hasPermission(user_id,"manager.permission") then
		if args[1] and args[2] then
			vRP.removeUserGroup(parseInt(args[1]),args[2])
			TriggerClientEvent("Notify",source,"sucesso","Voce removeu o passaporte <b>"..parseInt(args[1]).."</b> do grupo <b>"..args[2].."</b>.")
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /UNGROUP:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**",value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Tirou o Passaporte:**", value = "` "..args[1].." ` "},{ name = "**Do grupo:**", value = "` "..args[2].." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
		end
	end
end)
-- [ TP TO ME ] --
RegisterCommand('tptome',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			local x,y,z = vRPclient.getPosition(source)
			if tplayer then
				vRPclient.teleport(tplayer,x,y,z)
			end
		end
	end
end)
-- [ TP TO ] --
RegisterCommand('tpto',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		if args[1] then
			local tplayer = vRP.getUserSource(parseInt(args[1]))
			if tplayer then
				vRPclient.teleport(source,vRPclient.getPosition(tplayer))
			end
		end
	end
end)
-- [ TP WAYPOINT ] --
RegisterCommand('tpway',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		TriggerClientEvent('tptoway',source)
	end
end)
-- [ DELETE NPCS ] --
RegisterCommand('delnpcs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		TriggerClientEvent('delnpcs',source)
	end
end)
-- [ PLAYERS ONLINE ] --
RegisterCommand('players',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"staff.permission") then
        local users = vRP.getUsers()
        local players = ""
        local quantidade = 0
        for k,v in pairs(users) do
            if k ~= #users then
                players = players..", "
            end
            players = players..k
            quantidade = quantidade + 1
        end
        TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{255,160,0},quantidade)
        TriggerClientEvent('chatMessage',source,"ID's ONLINE",{255,160,0},players)
    end
end)
-- [ CARCOLOR ] --
RegisterCommand('carcolor',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
		local vehicle,vehNet = vRPclient.vehList(source,5)
		if vehicle then
            local rgb = vRP.prompt(source,"RGB Color(255 255 255):"," ")
            rgb = sanitizeString(rgb,"\"[]{}+=?!_()#@%/\\|,.",false)
            local r,g,b = table.unpack(splitString(rgb," "))
			--TriggerClientEvent('vcolorv',source,vehicle,vehNet,tonumber(r),tonumber(g),tonumber(b))
			TriggerClientEvent('vcolorv',source,vehicle,tonumber(r),tonumber(g),tonumber(b))
			TriggerClientEvent('chatMessage',source,"ALERTA",{255,70,50},"Cor ^1alterada")
        end
    end
end)
-- [ KILL ALL ] --
RegisterCommand('killall',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"founder.permission") then
    	local nusers = vRP.getUsers()
        for k,v in pairs(nusers) do
			local nplayer = vRP.getUserSource(parseInt(k))
            if nplayer then
				vRPclient.setHealth(nplayer,0)
				vRP.updateThirst(parseInt(args[1]),0)
				vRP.updateHunger(parseInt(args[1]),0)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
            end
        end
    end
end)
-- [ KILL ] --
RegisterCommand('kill',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"staff.permission") and not vRP.hasPermission(user_id,"trial.permission") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.setHealth(nplayer,0)
				TriggerClientEvent("Notify",source,"importante","Você matou o passaporte "..args[1])
				PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /KILL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Matou o passaporte:**", value = "` "..args[1].." `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
			end
		else
			args[1] = user_id
            vRPclient.setHealth(source,0)
			PerformHttpRequest(logAdmin, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE COMANDO /KILL:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Quem usou o comando:**", value = "` "..identity.name.." "..identity.firstname.." ` "},{ name = "**Nº do Passaporte:**", value = "` "..user_id.." ` "},{ name = "**Ação:**", value = "` Matou a si mesmo. `"},}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 15914080}}}), { ['Content-Type'] = 'application/json' })
		end	
	end
end)