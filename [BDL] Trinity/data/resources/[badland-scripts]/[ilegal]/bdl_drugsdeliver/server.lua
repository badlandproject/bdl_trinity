local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
local idgens = Tools.newIDGenerator()
Tunnel.bindInterface("bdl_drugsdeliver",src)

local quantidade = {}
function src.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(2,8)
	end
end

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"lspd.permission") and not vRP.hasPermission(user_id,"ems.permission") then
		return true
	end
end

function src.checkItens()
	src.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"lspd.permission") then
            return vRP.getInventoryItemAmount(user_id,"maconha-embalada") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"coca-embalada") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"meta-embalada") >= quantidade[source]
		end
		return
	end
end

function src.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    local value = 100
    if user_id then
        local policia = vRP.getUsersByPermission("lspd.permission")
		local pdamount = 0
        local sold = 0
		local multiplier = 0
		local haveWeed = false
		local haveCoca = false
     
        if vRP.tryGetInventoryItem(user_id,"maconha-embalada",quantidade[source]) then
            sold = sold + 1
        end
        if vRP.tryGetInventoryItem(user_id,"coca-embalada",quantidade[source]) then
            sold = sold + 1
        end
		if vRP.tryGetInventoryItem(user_id,"meta-embalada",quantidade[source]) then
            sold = sold + 1
        end 

        if sold > 0 then
			for k,v in pairs(policia) do
				pdamount = pdamount + 1
			end
			if parseInt(pdamount) >= 1 and parseInt(pdamount) <= 4 then
				multiplier = 0.05
			elseif parseInt(pdamount) > 4 and parseInt(pdamount) <= 8 then
				multiplier = 0.1
			elseif parseInt(pdamount) > 8 and parseInt(pdamount) <= 12 then
				multiplier = 0.2
			elseif parseInt(pdamount) > 12 and parseInt(pdamount) <= 16 then
				multiplier = 0.3
			elseif parseInt(pdamount) > 16 then
				multiplier = 0.4
			else
				multiplier = 0
			end
			local amount_drugs = sold
			local payment = parseInt(value*quantidade[source]*sold)
			vRP.giveInventoryItem(user_id,"dinheiro-sujo", payment+payment*multiplier)
			quantidade[source] = nil
        end
        return true
    end
end

local blips = {}
function src.setPoliceWarn()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("lspd.permission")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Recebemos uma denuncia de tráfico, verifique o ocorrido.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
	end
end

function src.setSearchTimer()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,parseInt(60))
	end
end