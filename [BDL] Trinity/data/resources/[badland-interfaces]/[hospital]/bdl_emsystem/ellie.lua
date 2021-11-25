local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

EMS = {}
Tunnel.bindInterface("bdl_emsystem",EMS)

local items = {
   { item = 'dorflex', name = 'Dorflex', quantidade = 1 },
   { item = 'voltaren', name = 'Voltaren', quantidade = 1 },
   { item = 'tandrilax', name = 'Tandrilax', quantidade = 1 },
   { item = 'buscopan', name = 'Buscopan', quantidade = 1 },
   { item = 'paracetamol', name = 'Paracetamol', quantidade = 1 },
   { item = 'r-dorflex', name = 'Receita de Dorflex', quantidade = 1 },
   { item = 'r-voltaren', name = 'Receita de Voltaren', quantidade = 1 },
   { item = 'r-tandrilax', name = 'Receita de Tandrilax', quantidade = 1 },
   { item = 'r-buscopan', name = 'Receita de Buscopan', quantidade = 1 },
   { item = 'r-paracetamol', name = 'Receita de Paracetamol', quantidade = 1 },
}

local onServiceHP = "SEULINK"
local offServiceHP = "SEULINK"
local actionsLog = "SEULINK"

RegisterNetEvent('bdl:emsystem')
AddEventHandler('bdl:emsystem',function(item)
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    for k,v in pairs(items) do
        if user_id then
            if item == v.item then
                TriggerClientEvent("Notify",source,"sucesso","Você pegou um(a) <b>" ..v.name.. "</b>",5000)
                vRP.giveInventoryItem(user_id,v.item,v.quantidade)
				PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "EMS - Prontuário", description = "Registro de retirada de medicamentos.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Funcionário:**", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Ação:**", value = "` Pegou "..v.name.." do prontuário médico. `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 16399934 }}}), { ['Content-Type'] = 'application/json' })
            end
        end
    end
end)

RegisterNetEvent('bdl:clearmed')
AddEventHandler('bdl:clearmed',function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        vRP.tryGetInventoryItem(user_id,"dorflex",1)
        vRP.tryGetInventoryItem(user_id,"voltaren",1)
        vRP.tryGetInventoryItem(user_id,"tandrilax",1)
        vRP.tryGetInventoryItem(user_id,"buscopan",1)
        vRP.tryGetInventoryItem(user_id,"paracetamol",1)
        vRP.tryGetInventoryItem(user_id,"r-dorflex",1)
        vRP.tryGetInventoryItem(user_id,"r-voltaren",1)
        vRP.tryGetInventoryItem(user_id,"r-tandrilax",1)
        vRP.tryGetInventoryItem(user_id,"r-buscopan",1)
        vRP.tryGetInventoryItem(user_id,"r-paracetamol",1)
    end
end)

RegisterServerEvent("bdl:onservice")
AddEventHandler("bdl:onservice",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"off-ems.permission") then
        vRP.addUserGroup(user_id,"ems")
		TriggerEvent('eblips:add',{ name = "EMS", src = source, color = 47 })
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.")
		PerformHttpRequest(onServiceHP, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Entrou em serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Hospital `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16399934 }}}), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.")
    end
end)

RegisterServerEvent("bdl:offservice")
AddEventHandler("bdl:offservice",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"ems.permission") then
        vRP.addUserGroup(user_id,"off-ems")
		TriggerEvent('eblips:remove',source)
		EMS.remEquip()
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.")
		PerformHttpRequest(offServiceHP, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Hospital `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 16399934 }}}), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.")
    end
end)

function EMS.remEquip()
	local src = source
    local user_id = vRP.getUserId(src)
	if user_id then
		vRPclient.setArmour(source,0)
		vRPclient._replaceWeapons(source,{["WEAPON_UNARMED"] = { ammo = 0 }})
	end
end

function EMS.checkPermission(permission)
    local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.hasPermission(user_id,permission)
    end
end

function EMS.checkEms()
	local src = source
	local user_id = vRP.getUserId(src)
	if vRP.hasPermission(user_id,"ems.permission") or vRP.hasPermission(user_id,"off-ems.permission") then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você não tem permissão.")
	end
end