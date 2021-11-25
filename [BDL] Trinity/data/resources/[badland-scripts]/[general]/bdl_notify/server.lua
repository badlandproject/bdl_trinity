local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
local webhookadmin = ""

RegisterCommand('adm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"staff.permission")then
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
    --    SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MENSAGEM]: "..mensagem.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        TriggerClientEvent("NotifyAdm",-1,identity.name,mensagem)
    end
end)

RegisterCommand('anuncio',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	if vRP.hasPermission(user_id,"staff.permission") then
        local mensagem = vRP.prompt(source,"Mensagem:","")
        if mensagem == "" then
            return
        end
        --SendWebhookMessage(webhookadmin,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[MENSAGEM]: "..mensagem.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
        TriggerClientEvent("NotifyPol",-1,identity.name,mensagem)
    end
end)

RegisterCommand('callback',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"staff.permission") then
        if args[1] then
        	local id = vRP.getUserSource(parseInt(args[1]))
            local mensagem = vRP.prompt(source,"Mensagem:","")
            if mensagem == "" then
                return
            end
            TriggerClientEvent("NotifyAdmCallback",id,identity.name,mensagem)
        end
    end
end)