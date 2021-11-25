local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRPN = {}
Tunnel.bindInterface("vrp_trunkchest",vRPN)
Proxy.addInterface("vrp_trunkchest",vRPN)

vCLIENT = Tunnel.getInterface("vrp_garages")

local inventory = module("vrp","cfg/inventory")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local carrolog = "SEULINK"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local uchests = {}
local vchests = {}
local actived = {}
local beingUsed = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BANDAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle then
			local placa_user_id = vRP.getUserByRegistration(placa)
			if placa_user_id then
				local myinventory = {}
				local myvehicle = {}

				local mala = "chest:u"..parseInt(placa_user_id).."veh_"..vname
				local data = vRP.getSData(mala)
				local sdata = json.decode(data) or {}
				
				if sdata then
					for k,v in pairs(sdata) do
						if vRP.itemBodyList(k) then
							table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
						end
					end
				end

				local inv = vRP.getInventory(parseInt(user_id))
				for k,v in pairs(inv) do
					if vRP.itemBodyList(k) then
						table.insert(myvehicle,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
					end
				end

				uchests[parseInt(user_id)] = mala
				vchests[parseInt(user_id)] = vname

				return myinventory,myvehicle,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(sdata),parseInt(vRP.vehicleChest(vname))
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.storeItem(itemName,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local max_veh = vRP.vehicleChest(vchests[user_id]) or 20
		if user_id then
			if itemName == "item" then
				TriggerClientEvent("Notify",source,"importante","Não pode guardar este item.",8000)
				return
			end
			if vRP.storeChestItem(user_id,uchests[parseInt(user_id)],itemName,amount,parseInt(max_veh)) then
				TriggerClientEvent('vrp_trunkchest:Update',source,'updateMochila')
				PerformHttpRequest(carrolog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VEÍCULO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
			else
				TriggerClientEvent("Notify",source,"negado","Algo deu errado. Verifique se o baú não está cheio e se a quantidade foi colocada corretamente.",3000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.takeItem(itemName,amount)
	if itemName then
		local source = source
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id then
			if vRP.tryChestItem(user_id,uchests[parseInt(user_id)],itemName,amount) then
				TriggerClientEvent('vrp_trunkchest:Update',source,'updateMochila')
				PerformHttpRequest(carrolog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VEÍCULO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })
			else
				TriggerClientEvent("Notify",source,"negado","Algo deu errado. Verifique se o inventário não está cheio e se a quantidade foi colocada corretamente.",3000)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if vehicle then
			local placa_user_id = vRP.getUserByRegistration(placa)
			vCLIENT.vehicleClientTrunk(-1,vnetid,true)
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function vRPN.chestOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,trunk = vRPclient.vehList(source,7)
		if vehicle then
			if lock == 1 then
				if banned then
					return
				end
				local placa_user_id = vRP.getUserByRegistration(placa)
				if placa_user_id then
					local concat_used = placa.."-"..vname
					--if not beingUsed[concat_used] then
					--	beingUsed[concat_used] = true
						vCLIENT.vehicleClientTrunk(-1,vnetid,false)
						TriggerClientEvent("trunkchest:Open",source)
					--else
					--	TriggerClientEvent("Notify",source,"importante","Você não pode utilizar este porta-malas agora.",8000)
					--end
				end
			end
		end
	end
end