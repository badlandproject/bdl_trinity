local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("bdl_gundeliver",src)

local gatilhoAmount = {}
function src.gatilhoAmount()
	local source = source
	local gatchance = math.random(0,100)
	if gatilhoAmount[source] == nil then
		if gatchance > 50 then
			gatilhoAmount[source] = tonumber(1)
		else
			gatilhoAmount[source] = tonumber(0)
		end
	end
end

local molaAmount = {}
function src.molaAmount()
	local source = source
	if molaAmount[source] == nil then
		molaAmount[source] = math.random(1,3)
	end
end

local placaAmount = {}
function src.placaAmount()
	local source = source
	if placaAmount[source] == nil then
		placaAmount[source] = math.random(2,4)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPermission()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"bratva.permission") or vRP.hasPermission(user_id,"lost.permission") then
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPayment()
	src.gatilhoAmount()
	src.molaAmount()
	src.placaAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("placa-metal")*placaAmount[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("gatilho")*gatilhoAmount[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("molas")*molaAmount[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"placa-metal",placaAmount[source])
			vRP.giveInventoryItem(user_id,"gatilho",gatilhoAmount[source])
			vRP.giveInventoryItem(user_id,"molas",molaAmount[source])
			placaAmount[source] = nil
			gatilhoAmount[source] = nil
			molaAmount[source] = nil
			return true
		end
	end
end
