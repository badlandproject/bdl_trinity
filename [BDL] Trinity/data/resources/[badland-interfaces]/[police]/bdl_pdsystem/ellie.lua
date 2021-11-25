local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPex = {}
Tunnel.bindInterface("bdl_pdsystem",vRPex)

local onServicePD = "SEULINK"
local offServicePD = "SEULINK"
local actionsLog = "SEULINK"

function vRPex.checkPermission(permission)
	local src = source
    local user_id = vRP.getUserId(src)
    if user_id then
        return vRP.hasPermission(user_id,permission)
    end
end

function vRPex.checkOfficer()
	local src = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"lspd.permission") or vRP.hasPermission(user_id,"off-lspd.permission") then
		return true
	end
end

RegisterNetEvent('bdl:onarmor')
AddEventHandler('bdl:onarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lspd.permission") then
			vRPclient.setArmour(source,100)
			return true
		end
	end
end)

RegisterNetEvent('bdl:offarmor')
AddEventHandler('bdl:offarmor',function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lspd.permission") then
			vRPclient.setArmour(source,0)
			return true
		end
	end
end)

function vRPex.remEquip()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRPclient.setArmour(source,0)
		vRPclient._replaceWeapons(source,{["WEAPON_UNARMED"] = { ammo = 0 }})
	end
end

RegisterServerEvent("bdl:onduty")
AddEventHandler("bdl:onduty",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"off-lspd.permission") then
        vRP.addUserGroup(user_id,"lspd")
		TriggerEvent('eblips:add',{ name = "Policial", src = source, color = 47 })
        TriggerClientEvent("Notify",source,"sucesso","Você entrou em serviço.",5000)
		PerformHttpRequest(onServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Entrou em serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Polícia `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent("Notify",source,"negado","Você já está em serviço.",5000)
    end
end)

RegisterServerEvent("bdl:offduty")
AddEventHandler("bdl:offduty",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)

    if vRP.hasPermission(user_id,"lspd.permission") then
        vRP.addUserGroup(user_id,"off-lspd")
		TriggerEvent('eblips:remove',source)
		vRPex.remEquip()
        TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
		TriggerClientEvent("Notify",source,"aviso","Seus equipamentos foram automáticamente guardados.",5000)
		PerformHttpRequest(offServicePD, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = identity.name.." "..identity.firstname, description = "Saiu de serviço.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nº Passaporte:**", value = "` Número "..user_id.." `\n⠀" }, { name = "**Organização:**", value = "` LS - Polícia `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent("Notify",source,"negado","Você já está fora de serviço.",5000)
    end
end)

RegisterServerEvent("bdl:takekitlog")
AddEventHandler("bdl:takekitlog",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Ação executada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Retirou kit de defesa pessoal `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("bdl:remkitlog")
AddEventHandler("bdl:remkitlog",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Ação executada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Guardou kit de defesa pessoal `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("bdl:remWeaponsLog")
AddEventHandler("bdl:remWeaponsLog",function()
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Ação executada.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Guardou todo o armamento no arsenal `" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("bdl:takeWeapons")
AddEventHandler("bdl:takeWeapons",function(weapon)
	local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	PerformHttpRequest(actionsLog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "LSPD - Arsenal", description = "Registro de retirada de armamento.\n⠀", thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png"}, fields = {{ name = "**Nome: **", value = "` "..identity.name.." "..identity.firstname.." `\n⠀" }, { name = "**Passaporte: **", value = "` "..user_id.." `" }, { name = "**Ação: **", value = "` Pegou uma "..weapon.." do arsenal`" }}, footer = { text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757143959394058300/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
end)
