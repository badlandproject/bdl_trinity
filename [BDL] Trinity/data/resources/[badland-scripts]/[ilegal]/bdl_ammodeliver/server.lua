local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
src = {}
Tunnel.bindInterface("bdl_ammodeliver",src)

local capsulaAmount = {}
function src.capsulaAmount()
	local source = source
	if capsulaAmount[source] == nil then
		capsulaAmount[source] = math.random(1,3)
	end
end

local polvoraAmount = {}
function src.polvoraAmount()
	local source = source
	if polvoraAmount[source] == nil then
		polvoraAmount[source] = math.random(2,6)
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
	src.polvoraAmount()
	src.capsulaAmount()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capsulas")*capsulaAmount[source] and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("polvora")*polvoraAmount[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"capsulas",capsulaAmount[source])
			vRP.giveInventoryItem(user_id,"polvora",polvoraAmount[source])
			capsulaAmount[source] = nil
			polvoraAmount[source] = nil
			return true
		end
	end
end
