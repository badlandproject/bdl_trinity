local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONEXÃO ]-----------------------------------------------------------------------------------------------------------------------------------------------------------

src = {}
Tunnel.bindInterface("bdl_chest",src)
vCLIENT = Tunnel.getInterface("bdl_chest")

--[ VARIAVEIS ]---------------------------------------------------------------------------------------------------------------------------------------------------------

local lspdlog = "SEULINK"
local emslog = "SEULINK"
local bennyslog = "SEULINK"
local grovelog = "SEULINK"
local ballaslog = "SEULINK"
local vagoslog = "SEULINK"
local bratvalog = "SEULINK"

--[ CHEST ]-------------------------------------------------------------------------------------------------------------------------------------------------------------

local chest = {
	["lspd"] = { 5000,"lspd.permission" },
	["ems"] = { 5000,"ems.permission" },
	["bennys"] = { 5000,"bennys.permission" },
	
	["grove"] = { 5000,"grove.permission" },
	["ballas"] = { 5000,"ballas.permission" },
	["vagos"] = { 5000,"vagos.permission" },
	
	["bratva"] = { 5000,"bratva.permission" },
	["motoclub"] = { 5000,"lost.permission" },
}

--[ VARIÁVEIS ]---------------------------------------------------------------------------------------------------------------------------------------------------------

local actived = {}

--[ ACTIVEDOWNTIME ]----------------------------------------------------------------------------------------------------------------------------------------------------

local actived = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1
				if actived[k] <= 0 then
					actived[k] = nil
				end
			end
		end
		Citizen.Wait(100)
	end
end)

--[ CHECKINTPERMISSIONS ]-----------------------------------------------------------------------------------------------------------------------------------------------

function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			if vRP.hasPermission(user_id,"staff.permission") then
				return true
			end

			if vRP.hasPermission(user_id,chest[chestName][2]) then
				return true
			end
		end
	end
	return false
end

--[ OPENCHEST ]---------------------------------------------------------------------------------------------------------------------------------------------------------

function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
		local result = json.decode(data) or {}
		if result then
			for k,v in pairs(result) do
				if vRP.itemBodyList(k) then
					table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
				end
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				if vRP.itemBodyList(k) then
					table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
				end
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])
	end
	return false
end

--[ STOREITEM ]---------------------------------------------------------------------------------------------------------------------------------------------------------

function src.storeItem(chestName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
			if vRP.storeChestItem(user_id,"chest:"..tostring(chestName),itemName,amount,chest[tostring(chestName)][1]) then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					if chestName == "lspd" then
						PerformHttpRequest(lspdlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "ems" then
						PerformHttpRequest(emslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ title = "REGISTRO DE BAÚ - EMS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"),icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16399934 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "bennys" then
						PerformHttpRequest(bennyslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BENNY'S:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "grove" then
						PerformHttpRequest(grovelog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - GROVE ST.:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "ballas" then
						PerformHttpRequest(ballaslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BALLAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "vagos" then
						PerformHttpRequest(vagoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VAGOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					elseif chestName == "bratva" then
						PerformHttpRequest(bratvalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BRATVA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM GUARDOU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM GUARDADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })	
					end
				end
				TriggerClientEvent("Chest:UpdateChest",source,"updateChest")
			else
				TriggerClientEvent("Notify",source,"negado","Quantidade inválida e/ou baú cheio.",10000)
            end
        end
    end
end

--[ TAKEITEM ]----------------------------------------------------------------------------------------------------------------------------------------------------------

function src.takeItem(chestName,itemName,amount)
    if itemName then
        local source = source
        local user_id = vRP.getUserId(source)
        if user_id then
			if vRP.tryChestItem(user_id,"chest:"..tostring(chestName),itemName,amount) then
				local identity = vRP.getUserIdentity(user_id)
				if identity then
					if chestName == "lspd" then
						PerformHttpRequest(lspdlog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - LSPD:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 4360181 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "ems" then
						PerformHttpRequest(emslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - EMS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16399934 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "bennys" then
						PerformHttpRequest(bennyslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BENNY'S:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 16757504 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "grove" then
						PerformHttpRequest(grovelog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - GROVE ST.:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "ballas" then
						PerformHttpRequest(ballaslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BALLAS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "vagos" then
						PerformHttpRequest(vagoslog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - VAGOS:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })
					elseif chestName == "bratva" then
						PerformHttpRequest(bratvalog, function(err, text, headers) end, 'POST', json.encode({embeds = {{ 	title = "REGISTRO DE BAÚ - BRATVA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀\n⠀",thumbnail = {url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"}, fields = {{ name = "**QUEM RETIROU:**", value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**]"},{ name = "**ITEM RETIRADO:**", value = "[ **Item: "..vRP.itemNameList(itemName).."** ][ **Quantidade: "..parseInt(amount).."** ]\n⠀⠀"}}, footer = {text = "BADLAND - "..os.date("%d/%m/%Y | %H:%M:%S"), icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" },color = 7462510 }}}), { ['Content-Type'] = 'application/json' })
					end
				end
				TriggerClientEvent("Chest:UpdateChest",source,"updateChest")
			else
				TriggerClientEvent("Notify",source,"negado","Quantidade inválida e/ou inventário cheio.",10000)
            end
        end
    end
end