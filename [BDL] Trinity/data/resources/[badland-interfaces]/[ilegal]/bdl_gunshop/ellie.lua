local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

vRP._prepare("badland/get_prisioner","SELECT * FROM vrp_user_identities WHERE user_id = @user_id")
vRP._prepare("badland/set_prisioner","UPDATE vrp_user_identities SET license = @license WHERE user_id = @user_id")
vRP._prepare("badland/set_limit","UPDATE vrp_user_identities SET gunLimit = @gunLimit WHERE user_id = @user_id")

local valores = {
	{ item = "wbody|WEAPON_PISTOL_MK2", quantidade = 1, compra = 35000, license = true },
	{ item = "wbody|WEAPON_COMBATPISTOL", quantidade = 1, compra = 30000, license = true },
	{ item = "wbody|WEAPON_PISTOL", quantidade = 1, compra = 29000, license = true },
	{ item = "wbody|WEAPON_VINTAGEPISTOL", quantidade = 1, compra = 28000, license = true },
	{ item = "wbody|WEAPON_SNSPISTOL", quantidade = 1, compra = 22000, license = true},
	
	{ item = "wammo|WEAPON_PISTOL_MK2", quantidade = 50, compra = 9500, license = true, isAmmo = true },
	{ item = "wammo|WEAPON_COMBATPISTOL", quantidade = 50, compra = 8600, license = true, isAmmo = true},
	{ item = "wammo|WEAPON_PISTOL", quantidade = 50, compra = 8400, license = true, isAmmo = true },
	{ item = "wammo|WEAPON_VINTAGEPISTOL", quantidade = 50, compra = 8200, license = true, isAmmo = true},
	{ item = "wammo|WEAPON_SNSPISTOL", quantidade = 25, compra = 5100, license = true, isAmmo = true},


	{ item = "wbody|WEAPON_KNIFE", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_HATCHET", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_SWITCHBLADE", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_BAT", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_HAMMER", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_GOLFCLUB", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_CROWBAR", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_KNUCKLE", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_WRENCH", quantidade = 1, compra = 1000},
	{ item = "wbody|WEAPON_POOLCUE", quantidade = 1, compra = 1000},
}

local ammuBuyLog = "https://discordapp.com/api/webhooks/767775337877995550/78twveCWXCbHMBxHX461nYToS95ka15RyAexaXCERLuC0M7KcNiyzd8E8np_lhgCetg2"

RegisterServerEvent("bdl:ammunation-buy")
AddEventHandler("bdl:ammunation-buy",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local rows = vRP.query("badland/get_prisioner",{ user_id = parseInt(user_id) })
	local haveLicense = ""
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
					if v.license == true then
						if parseInt(rows[1].license) == 1 then
							haveLicense = "Sim"
							if v.isAmmo == true then
								if vRP.tryPayment(user_id,parseInt(v.compra)) then
									vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
									TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
									PerformHttpRequest(ammuBuyLog, function(err, text, headers) end, 'POST', json.encode({
											embeds = {
												{ 
													title = "REGISTRO DA AMMUNATION:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
													thumbnail = {
													url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
													}, 
													fields = {
														{ 
															name = "**Resgitro do usuário:**", 
															value = "` "..identity.name.." "..identity.firstname.." ` "
														},
														{ 
															name = "**Nº do ID:**", 
															value = "` "..user_id.." ` "
														},
														{ 
															name = "**Comprou:**", 
															value = "` "..vRP.itemNameList(v.item).." ` "
														},
														{ 
															name = "**Pagou a quantia de:**", 
															value = "` "..parseInt(v.compra).." ` "
														},
														{ 
															name = "**Possui porte:**", 
															value = "` Sim ` "
														},
													}, 
													footer = { 
														text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
														icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
													},
													color = 15914080 
												}
											}
										}), { ['Content-Type'] = 'application/json' })
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
								end
							else
								if parseInt(rows[1].gunLimit) == 1 then
									TriggerClientEvent('Notify',source,'negado',"Você atingiu seu limite de compra. Em caso de perda fale com a polícia.",5000)
								else
									if vRP.tryPayment(user_id,parseInt(v.compra)) then
										vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
										vRP.execute("badland/set_limit",{ user_id = parseInt(user_id), gunLimit = 1 })
										TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
										PerformHttpRequest(ammuBuyLog, function(err, text, headers) end, 'POST', json.encode({
											embeds = {
												{ 
													title = "REGISTRO DA AMMUNATION:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
													thumbnail = {
													url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
													}, 
													fields = {
														{ 
															name = "**Resgitro do usuário:**", 
															value = "` "..identity.name.." "..identity.firstname.." ` "
														},
														{ 
															name = "**Nº do ID:**", 
															value = "` "..user_id.." ` "
														},
														{ 
															name = "**Comprou:**", 
															value = "` "..vRP.itemNameList(v.item).." ` "
														},
														{ 
															name = "**Pagou a quantia de:**", 
															value = "` "..parseInt(v.compra).." ` "
														},
														{ 
															name = "**Possui porte:**", 
															value = "` Sim ` "
														},
													}, 
													footer = { 
														text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
														icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
													},
													color = 15914080 
												}
											}
										}), { ['Content-Type'] = 'application/json' })
									else
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
									end
								end
							end
						else
							haveLicense = "Não"
							TriggerClientEvent('Notify',source,'negado',"Você não possui uma licença legal para adquirir uma arma de fogo e/ou munição.",5000)
						end
					else
						if vRP.tryPayment(user_id,parseInt(v.compra)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
							PerformHttpRequest(ammuBuyLog, function(err, text, headers) end, 'POST', json.encode({
											embeds = {
												{ 
													title = "REGISTRO DA AMMUNATION:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
													thumbnail = {
													url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
													}, 
													fields = {
														{ 
															name = "**Resgitro do usuário:**", 
															value = "` "..identity.name.." "..identity.firstname.." ` "
														},
														{ 
															name = "**Nº do ID:**", 
															value = "` "..user_id.." ` "
														},
														{ 
															name = "**Comprou:**", 
															value = "` "..vRP.itemNameList(v.item).." ` "
														},
														{ 
															name = "**Pagou a quantia de:**", 
															value = "` "..parseInt(v.compra).." ` "
														},
														
													}, 
													footer = { 
														text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
														icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
													},
													color = 15914080
												}
											}
										}), { ['Content-Type'] = 'application/json' })
						else
							TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
						end
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)