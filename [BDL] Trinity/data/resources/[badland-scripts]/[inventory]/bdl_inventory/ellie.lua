------------------------------------------------------------------------------------------------------
-- [ PRODUTO ADQUIRIDO EM E&G VENDAS (discord.gg/bABGBEX) ]   										--
-- [ DESENVOLVIDO POR Edu#0069 // BACK-END POR ALLSTAR BASE ]   									--
-- [ SE VOCÊ ADQUIRIU ESSE PRODUTO, VOCÊ TEM DIREITO A SUPORTE GRATUITO ]   						--
-- [ OBRIGADO PELA CONFIANÇA // CONTATO: Edu#0069 // GITHUB: https://github.com/badlandproject  ]   --
------------------------------------------------------------------------------------------------------

-- [ TUNELAGEM / VARIÁVEIS PRINCIPAIS] --
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
local idgens = Tools.newIDGenerator()
local cfg = module("vrp","cfg/groups")
vRPex = {}
Tunnel.bindInterface("bdl_inventory",vRPex)
Proxy.addInterface("bdl_inventory",vRPex)
local actived = {}

vCLIENT = Tunnel.getInterface("bdl_inventory")
vGARAGE = Tunnel.getInterface("bdl_garages")
vHOSPITAL = Tunnel.getInterface("vrp_hospital")
vPLAYER = Tunnel.getInterface("vrp_player")
vPOLICIA = Tunnel.getInterface("vrp_policia")
vDRUGS = Tunnel.getInterface("bdl_drugs")
vHUD = Tunnel.getInterface("vrp_hud")
vHOMES = Tunnel.getInterface("vrp_homes")
vRPclient = Tunnel.getInterface("vRP")

local bandagem = {}

-- [ DESATIVADO ] --
local slots = {
	["Admin"] = 100,
	["SlotP"] = 9,
	["SlotM"] = 12,
	["SlotG"] = 15
}

local dropLog = "https://discordapp.com/api/webhook/yoururl"
local sendLog = "https://discordapp.com/api/webhook/yoururl"
local equipLog = "https://discordapp.com/api/webhook/yoururl"
local ammoLog = "https://discordapp.com/api/webhook/yoururl"

-- [ FUNÇÃO DO WEBHOOK (EM BREVE) ] --
function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end


-- [ TABELAS E VARIÁVEIS GENÉRICAS ] --
local active = {}
local amountUse = {}
local blips = {}
local groups = cfg.groups

-- [ TIMER ] --
local registerBlips = {}
local registerTimers = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(registerTimers) do
			if v[4] > 0 then
				v[4] = v[4] - 1
				if v[4] <= 0 then
					table.remove(registerTimers,k)
					vCLIENT.updateRegister(-1,registerTimers)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)

-- [ VARIÁVEIS DOS DADOS DO JOGADOR (SE COMUNICA COM O CLIENT QUE FAZ A CONEXÃO DIRETA COM JS ATRAVÉS DO JSON) ] --
function vRPex.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local cash = vRP.getMoney(user_id)
		local banco = vRP.getBankMoney(user_id)
		local coins = vRP.getCoins(user_id)
		local identity = vRP.getUserIdentity(user_id)
		local foto = identity.foto
		local multas = vRP.getUData(user_id,"vRP:multas")
		local mymultas = json.decode(multas) or 0
		local paypal = vRP.getUData(user_id,"vRP:paypal")
		local mypaypal = json.decode(paypal) or 0
		local bills = vRP.getBills(user_id)
		local job = vRPex.getUserGroupByType(user_id,"job")
		local cargo = vRPex.getUserGroupByType(user_id,"cargo")
		local vip = vRPex.getUserGroupByType(user_id,"vip")
		local position = vRPex.getUserGroupByType(user_id,"position")
		if identity then
			return vRP.format(parseInt(cash)),vRP.format(parseInt(banco)),vRP.format(parseInt(coins)),identity.name,identity.firstname,identity.age,identity.user_id,identity.registration,identity.phone,job,cargo,vip,vRP.format(parseInt(mybills)),multas,mypaypal,position
		end
	end
end
-- [ PEGAR GRUPO DO USUÁRIO POR TIPO ("job") ] --
function vRPex.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end

function vRPex.returnPermission(permission)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		return vRP.hasPermission(user_id,permission)
	end
end

-- [ DESATIVADO ] --
function vRPex.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local inventory = {}
		local inv = vRP.getInventory(user_id)
		if inv then
			local tSlot = vRPex.verifySlots(user_id)
			if tSlot ~= nil then
				tSlot = tSlot
			else
				tSlot = 11
			end
			for k,v in pairs(inv) do
				tSlot = tSlot - 1
				if vRP.itemBodyList(k) then
					if tSlot >= 0 then
						table.insert(inventory,{
							amount = parseInt(v.amount),
							name = vRP.itemNameList(k),
							index = vRP.itemIndexList(k),
							key = k,
							type = vRP.itemTypeList(k),
							peso = vRP.getItemWeight(k),
							desc = vRP.itemDescList(k)
						})
					end
				end
			end
			return inventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),tSlot
		end
	end
end

-- [ DESATIVADO ] --
function vRPex.NearMochila()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,2)
		if nplayer then
			local nearinventory = {}
			local nuser_id = vRP.getUserId(nplayer)
			local nearinv = vRP.getInventory(nuser_id)
			if nearinv then
				for k,v in pairs(nearinv) do
					if vRP.itemBodyList(k) then
						table.insert(nearinventory,{
							amount = parseInt(v.amount),
							name = vRP.itemNameList(k),
							index = vRP.itemIndexList(k),
							key = k,
							type = vRP.itemTypeList(k),
							peso = vRP.getItemWeight(k),
							desc = vRP.itemDescList(k)
						})
					end
				end
				return nearinventory
			end
		end
	end
end

function vRPex.Armamento()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local armamento = {}
		local armas = vRPclient.getWeapons(source)
		if armas then
			for k,v in pairs(armas) do
				table.insert(armamento,{
					weapon = vRP.itemNameList("wbody|"..k),
					wammo = vRP.format(parseInt(v.ammo)),
					index = vRP.itemIndexList("wbody|"..k),
					type = vRP.itemTypeList(k),
					key = "wbody|"..k
				})
			end
			return armamento
		end
	end
end

-- [ FUNÇÃO DE ENVIAR ITEM AO JOGADOR PRÓXIMO ] --
function vRPex.sendItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local nplayer = vRPclient.getNearestPlayer(source,2)
		local nuser_id = vRP.getUserId(nplayer)
		local identity = vRP.getUserIdentity(user_id)
		local identitynu = vRP.getUserIdentity(nuser_id)
		if nuser_id and vRP.itemIndexList(itemName) and item ~= vRP.itemIndexList("identidade") then
			if parseInt(amount) > 0 then
				if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * amount <= vRP.getInventoryMaxWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id,itemName,amount) then
						vRP.giveInventoryItem(nuser_id,itemName,amount)
						vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
						vCLIENT.closeInventory(source)
						TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(amount).."x "..vRP.itemNameList(itemName).."</b>.",8000)
						vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
						local itemAmount = vRP.format(parseInt(amount))
						
						PerformHttpRequest(sendLog, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "ENVIADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
									thumbnail = {
									url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
									}, 
									fields = {
										{ 
											name = "**Registro do usuário que enviou:**", 
											value = "` "..identity.name.." "..identity.firstname.." ` "
										},
										{ 
											name = "**Registro do usuário que recebeu:**", 
											value = "` "..identitynu.name.." "..identitynu.firstname.." ` "
										},
										{ 
											name = "**Nº do ID que enviou:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**Nº do ID que recebeu:**", 
											value = "` "..nuser_id.." ` "
										},
										{ 
											name = "**Nome do item:**", 
											value = "` "..vRP.itemNameList(itemName).." ` "
										},
										{ 
											name = "**Quantidade do item:**", 
											value = "` "..itemAmount.." ` "
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
						
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
						return true
					end
				end
			else
				local data = vRP.getUserDataTable(user_id)
				for k,v in pairs(data.inventory) do
					if itemName == k then
						if vRP.getInventoryWeight(nuser_id) + vRP.getItemWeight(itemName) * parseInt(v.amount) <= vRP.getInventoryMaxWeight(nuser_id) then
							if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
								vRP.giveInventoryItem(nuser_id,itemName,parseInt(v.amount))
								vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
								vCLIENT.closeInventory(source)
								TriggerClientEvent("Notify",source,"sucesso","Enviou <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								TriggerClientEvent("Notify",nplayer,"sucesso","Recebeu <b>"..vRP.format(parseInt(v.amount)).."x "..vRP.itemNameList(itemName).."</b>.",8000)
								vRPclient._playAnim(nplayer,true,{{"mp_common","givetake1_a"}},false)
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('Creative:Update',nplayer,'updateMochila')
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
	end

-- [ DESATIVADO ] --
function vRPex.roubItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		if user_id and vRPex.getRemaingSlots(user_id) > 0 then
				local nplayer = vRPclient.nearestPlayer(source,1.5)
				local nuser_id = vRP.getUserId(nplayer)
				if nuser_id and vRP.itemBodyList(itemName) then
					if parseInt(amount) > 0 then
						if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(itemName) * parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.tryGetInventoryItem(nuser_id,itemName,parseInt(amount)) then
								vRP.giveInventoryItem(user_id,itemName,parseInt(amount))
								vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
								TriggerClientEvent("bdl_inventory:Update",source,"updateMochila")
								TriggerClientEvent("bdl_inventory:Update",nplayer,"updateMochila")
								TriggerClientEvent("bdl_inventory:Update",source,"updateNearMochila")
								TriggerClientEvent("bdl_inventory:Update",nplayer,"updateNearMochila")
							end
						else
							TriggerClientEvent("Notify",source,"negado","Espaço insuficiente")
						end
					else
						local inv = vRP.getInventory(nuser_id)
						if inv and inv[itemName] ~= nil then
							if vRP.getInventoryWeight(user_id) + vRP.getItemWeight(itemName) * parseInt(inv[itemName].amount) <= vRP.getInventoryMaxWeight(user_id) then
								if vRP.tryGetInventoryItem(nuser_id,itemName,parseInt(inv[itemName].amount)) then
									vRP.giveInventoryItem(user_id,itemName,parseInt(inv[itemName].amount))
									vRPclient._playAnim(source,true,{"mp_common","givetake1_a"},false)
									TriggerClientEvent("bdl_inventory:Update",source,"updateMochila")
									TriggerClientEvent("bdl_inventory:Update",nplayer,"updateMochila")
									TriggerClientEvent("bdl_inventory:Update",source,"updateNearMochila")
									TriggerClientEvent("bdl_inventory:Update",nplayer,"updateNearMochila")
								end
							else
								TriggerClientEvent("Notify",source,"negado","Espaço insuficiente")
						end
					end
				end
			end
		end
	end
end

-- [ FUNÇÃO DE DROPAR O ITEM ] --
function vRPex.dropItem(itemName,amount)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		local x,y,z = vRPclient.getPosition(source)
		if parseInt(amount) > 0 and vRP.tryGetInventoryItem(user_id,itemName,amount) then
			TriggerEvent("DropSystem:create",itemName,amount,x,y,z,3600)
			TriggerClientEvent("bdl_inventory:Update",source,"updateMochila")
			vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
			local itemAmount = vRP.format(parseInt(amount))
			
			
			PerformHttpRequest(dropLog, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
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
								name = "**Nome do item:**", 
								value = "` "..vRP.itemNameList(itemName).." ` "
							},
							{ 
								name = "**Quantidade do item:**", 
								value = "` "..itemAmount.." `\n⠀"
							}
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
						},
						color = 15914080 
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			
			TriggerClientEvent('Creative:Update',source,'updateMochila')
			return true
		else
			local data = vRP.getUserDataTable(user_id)
			for k,v in pairs(data.inventory) do
				if itemName == k then
					if vRP.tryGetInventoryItem(user_id,itemName,parseInt(v.amount)) then
						TriggerEvent("DropSystem:create",itemName,parseInt(v.amount),x,y,z,3600)
						TriggerClientEvent("bdl_inventory:Update",source,"updateMochila")
						vRPclient._playAnim(source,true,{{"pickup_object","pickup_low"}},false)
						
						local itemAmount = vRP.format(parseInt(amount))
						
						PerformHttpRequest(dropLog, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "DROPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
									thumbnail = {
									url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
									}, 
									fields = {
										{ 
											name = "**Registro do usuário:**", 
											value = "` "..identity.name.." "..identity.firstname.." ` "
										},
										{ 
											name = "**Nº do ID:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**Nome do item:**", 
											value = "` "..vRP.itemNameList(itemName).." ` "
										},
										{ 
											name = "**Quantidade do item:**", 
											value = "` "..itemAmount.." `\n⠀"
										}
									}, 
									footer = { 
										text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
										icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
									},
									color = 15914080 
								}
							}
						}), { ['Content-Type'] = 'application/json' })
						
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						
						return true
					end
				end
			end
		end
	end
	return false
	end

-- [ PEGAR DADO DO ARMAMENTO DA SOURCE ] --
function vRPex.getWeapon(itemName)
	local source = source
	if itemName then
		local user_id = vRP.getUserId(source)
		local identity = vRP.getUserIdentity(user_id)
		if user_id and vRPex.getRemaingSlots(user_id) > 0 then
			local uWeapons = vRPclient.getWeapons(source)
			local iName = string.gsub(itemName,"wbody|","")
			if uWeapons[iName] then
				vRP.giveInventoryItem(user_id,"wammo|"..iName,parseInt(uWeapons[iName].ammo))
				vRP.giveInventoryItem(user_id,"wbody|"..iName,1)
				local uTest = uWeapons
				uTest[iName] = nil
				vRPclient._giveWeapons(source,uTest,true)
				TriggerClientEvent("bdl_inventory:Update",source,"updateMochila")
				TriggerClientEvent("bdl_inventory:Update",source,"updateArmamento")
			end
		end
	end
end
-- [ DESATIVADO ] --
function vRPex.Mochila()
	local source = source
	local user_id = vRP.getUserId(source)
	local data = vRP.getUserDataTable(user_id)
	local inventario = {}
	if data and data.inventory then
		for k,v in pairs(data.inventory) do
			if vRP.itemBodyList(k) then
				table.insert(inventario,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, type = vRP.itemTypeList(k), peso = vRP.getItemWeight(k) })
			end
		end
		return inventario,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id)
	end
end
-- [ FUNÇÃO DE USAR OS ITEMS (CONFIGURAR) ] --
function vRPex.useItem(itemName,type,ramount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and ramount ~= nil and parseInt(ramount) >= 0 and not actived[user_id] and actived[user_id] == nil then
		if type == "usar" then
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ ULTILITÁRIOS ]--------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------
			if itemName == "mochila" then
				if vRP.getInventoryMaxWeight(user_id) >= 90 then
					TriggerClientEvent("Notify",source,"negado","Você não pode equipar mais mochilas.",8000)
				else
					if vRP.tryGetInventoryItem(user_id,"mochila",1) then
						TriggerClientEvent('Creative:Update',source,'updateMochila')
						vRP.varyExp(user_id,"physical","strength",650)
						TriggerClientEvent("Notify",source,"sucesso","Mochila equipada.",8000)
					end
				end
			elseif itemName == "identidade" then
				local nplayer = vRPclient.getNearestPlayer(source,2)
				if nplayer then
					local identity = vRP.getUserIdentity(user_id)
					if identity then
						TriggerClientEvent("Identity2",nplayer,identity.name,identity.firstname,identity.user_id,identity.registration)
					end
				end
			elseif itemName == "colete" then
				if vRP.tryGetInventoryItem(user_id,"colete",1) then
					vRPclient.setArmour(source,100)
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vCLIENT.closeInventory(source)
				end
				
			elseif itemName == "bandagem" then
				if vRPclient.getHealth(source) > 101 and vRPclient.getHealth(source) < 250 then
	
					--if vDIAGNOSTIC.getBleeding(source) >= 4 then
						--TriggerClientEvent("Notify",source,"importante","Você está com um sangramento grave, você não pode utilizar a <b>Bandagem</b>, chame um paramédico ou vá até o <b>Hospital</b> mais próximo receber atendimento.",8000)
						--return
					--end
	
					if bandagem[user_id] == 0 or not bandagem[user_id] then
						if vRP.tryGetInventoryItem(user_id,"bandagem",1) then
							bandagem[user_id] = 120
							actived[user_id] = true
							vRPclient._CarregarObjeto(source,"amb@world_human_clipboard@male@idle_a","idle_c","v_ret_ta_firstaid",49,60309)
							TriggerClientEvent('vrp_inventario:Update',source,'updateMochila')
							TriggerClientEvent('cancelando',source,true)
							TriggerClientEvent("progress",source,20000,"bandagem")
							SetTimeout(20000,function()
								actived[user_id] = nil
								TriggerClientEvent('bandagem',source)
								TriggerClientEvent('cancelando',source,false)
								vRPclient._DeletarObjeto(source)
								TriggerClientEvent("itensNotify", source, "sucesso", "Bandagem", "bandagem" )
								Citizen.Wait(10000)
								TriggerEvent('resetWarfarina')
                                TriggerEvent('resetBleeding')
                                TriggerEvent('resetDiagnostic')
							end)
						end
					else
						TriggerClientEvent("Notify",source,"aviso","Aguarde, você acabou de utilizar a mesma.",8000)
					end
				else
				TriggerClientEvent("Notify",source,"negado","Você não pode utilizar de vida cheia ou nocauteado.",8000)
			end
				
			elseif itemName == "militec" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"bennys.permission") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vCLIENT.closeInventory(source)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,30000,"reparando motor")
							SetTimeout(30000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('repararmotor',source,vehicle)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"militec",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando motor")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('repararmotor',source,vehicle)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end
			elseif itemName == "repairkit" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.hasPermission(user_id,"bennys.permission") then
							actived[user_id] = true
							TriggerClientEvent('cancelando',source,true)
							vCLIENT.closeInventory(source)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,30000,"reparando veículo")
							SetTimeout(30000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('reparar',source)
								vRPclient._stopAnim(source,false)
							end)
						else
							if vRP.tryGetInventoryItem(user_id,"repairkit",1) then
								actived[user_id] = true
								TriggerClientEvent('Creative:Update',source,'updateMochila')
								TriggerClientEvent('cancelando',source,true)
								vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
								TriggerClientEvent("progress",source,30000,"reparando veículo")
								SetTimeout(30000,function()
									actived[user_id] = nil
									TriggerClientEvent('cancelando',source,false)
									TriggerClientEvent('reparar',source)
									vRPclient._stopAnim(source,false)
								end)
							end
						end
					end
				end
			elseif itemName == "pneus" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.tryGetInventoryItem(user_id,"pneus",1) then
							actived[user_id] = true
							TriggerClientEvent('Creative:Update',source,'updateMochila')
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"amb@world_human_vehicle_mechanic@male@idle_a","idle_a"}},true)
							TriggerClientEvent("progress",source,25000,"colocando pneus")
							SetTimeout(25000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('pneus',source)
								vRPclient._stopAnim(source,false)
							end)
						end
					end
				end
			elseif itemName == "melhoria" then
				if not vRPclient.isInVehicle(source) then
					local vehicle = vRPclient.getNearestVehicle(source,3.5)
					if vehicle then
						if vRP.tryGetInventoryItem(user_id,"melhoria",1) then
							actived[user_id] = true
							TriggerClientEvent('Creative:Update',source,'updateMochila')
							TriggerClientEvent('cancelando',source,true)
							vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_player"}},true)
							TriggerClientEvent("progress",source,5000,"melhorando")
							SetTimeout(5000,function()
								actived[user_id] = nil
								TriggerClientEvent('cancelando',source,false)
								TriggerClientEvent('melhoria',vehicle)
								print(vehicle)
								vRPclient._stopAnim(source,false)
							end)
						end
					end
				end
				
			elseif itemName == "dorflex" or itemName == "voltaren" or itemName == "tandrilax" or itemName == "buscopan" or itemName == "paracetamol" then
				if (vRP.tryGetInventoryItem(user_id,"dorflex",1) or vRP.tryGetInventoryItem(user_id,"voltaren",1) or vRP.tryGetInventoryItem(user_id,"tandrilax",1) or vRP.tryGetInventoryItem(user_id,"buscopan",1) or vRP.tryGetInventoryItem(user_id,"paracetamol",1)) then
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_intdrink","loop_bottle"}},true)	
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent("progress",source,5000,"remedio")	
					SetTimeout(5000,function()
							TriggerClientEvent('remedio',source)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent('cancelando',source,false)
							TriggerClientEvent("Notify",source,"sucesso","Remédio utilizado com sucesso.",8000)
					end)
				end
				
			elseif itemName == "maconha" then
				if vRP.tryGetInventoryItem(user_id,"maconha",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyHunger(user_id,25)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						--vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,"sucesso","Maconha utilizada com sucesso.",8000)
					end)
				end
				
			elseif itemName == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"cocaina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent('cancelando',source,true)
					TriggerClientEvent("progress",source,10000,"cheirando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent('cancelando',source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",120)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",120)
						TriggerClientEvent("Notify",source,"sucesso","Cocaína utilizada com sucesso.",8000)
					end)
				end
			elseif itemName == "metanfetamina" then
				if vRP.tryGetInventoryItem(user_id,"metanfetamina",1) then
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._playAnim(source,true,{{"mp_player_int_uppersmoke","mp_player_int_smoke"}},true)
					TriggerClientEvent("progress",source,10000,"fumando")
					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRPclient.playScreenEffect(source,"RaceTurbo",180)
						vRPclient.playScreenEffect(source,"DrugsTrevorClownsFight",180)
						TriggerClientEvent("Notify",source,"sucesso","Metanfetamina utilizada com sucesso.",8000)
					end)
				end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ ULTILITÁRIOS ILEGAIS ]------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------
			elseif itemName == "lockpick" then
				local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
				local policia = vRP.getUsersByPermission("lspd.permission")

				if #policia < 0 then
					TriggerClientEvent("Notify",source,"aviso","Policiais insuficientes em serviço.")
					return true
				end

				if vRP.hasPermission(user_id,"lspd.permission") then
					TriggerEvent("setPlateEveryone",placa)
					vGARAGE.vehicleClientLock(-1,vnetid,lock)
					TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
					return
				end

				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 and vRP.tryGetInventoryItem(user_id,"lockpick",1) and vehicle then
					actived[user_id] = true

					if vRP.hasPermission(user_id,"lspd.permission") then
						actived[user_id] = nil
						TriggerEvent("setPlateEveryone",placa)
						vGARAGE.vehicleClientLock(-1,vnetid,lock)
						return
					end

					TriggerClientEvent('cancelando',source,true)
					vCLIENT.closeInventory(source)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					TriggerClientEvent("progress",source,15000,"roubando")

					SetTimeout(15000,function()
						actived[user_id] = nil
						TriggerClientEvent('cancelando',source,false)
						vRPclient._stopAnim(source,false)

						if math.random(100) >= 50 then
							TriggerEvent("setPlateEveryone",placa)
							vGARAGE.vehicleClientLock(-1,vnetid,lock)
							TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
						else
							TriggerClientEvent("Notify",source,"negado","Roubo do veículo falhou e as autoridades foram acionadas.",8000)
							local policia = vRP.getUsersByPermission("lspd.permission")
							local x,y,z = vRPclient.getPosition(source)
							for k,v in pairs(policia) do
								local player = vRP.getUserSource(parseInt(v))
								if player then
									async(function()
										local id = idgens:gen()
										vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
										TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
										pick[id] = vRPclient.addBlip(player,x,y,z,10,5,"Ocorrência",0.5,false)
										SetTimeout(20000,function() vRPclient.removeBlip(player,pick[id]) idgens:free(id) end)
									end)
								end
							end
						end
					end)
				end
			elseif itemName == "capuz" then
				if vRP.getInventoryItemAmount(user_id,"capuz") >= 1 then
					local nplayer = vRPclient.getNearestPlayer(source,2)
					if nplayer then
						vRPclient.setCapuz(nplayer)
						vRP.closeMenu(nplayer)
						TriggerClientEvent("Notify",source,"sucesso","Capuz utilizado com sucesso.",8000)
					end
				end
			elseif itemName == "placa" then
                if vRPclient.GetVehicleSeat(source) then
                    if vRP.tryGetInventoryItem(user_id,"placa",1) then
                        local placa = vRP.generatePlate()
                        TriggerClientEvent('Creative:Update',source,'updateMochila')
                        TriggerClientEvent('cancelando',source,true)
						vCLIENT.closeInventory(source)
                        TriggerClientEvent("vehicleanchor",source)
                        TriggerClientEvent("progress",source,59500,"clonando")
                        SetTimeout(60000,function()
                            TriggerClientEvent('cancelando',source,false)
                            TriggerClientEvent("cloneplates",source,placa)
                            --TriggerEvent("setPlateEveryone",placa)
                            TriggerClientEvent("Notify",source,"sucesso","Placa clonada com sucesso.",8000)
                        end)
                    end
                end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ BEBIDAS ]-------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "agua" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"agua",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ba_prop_club_water_bottle",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou Água")
					end)

				end
			elseif itemName == "leite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"leite",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "cafe" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafe",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "cafecleite" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafecleite",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "cafeexpresso" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cafeexpresso",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-40)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Cafe Expresso</b>.")
					end)

				end
			elseif itemName == "capuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"capuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-55)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Capuccino</b>.")
					end)

				end
			elseif itemName == "frappuccino" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frappuccino",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_aa_coffee@idle_a","idle_a","prop_fib_coffee",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-65)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Frappuccino</b>.")
					end)

				end
			elseif itemName == "cha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Chá</b>.")
					end)

				end
			elseif itemName == "icecha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"icecha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-50)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Chá Gelado</b>.")
					end)

				end
			elseif itemName == "sprunk" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sprunk",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01b",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-65)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Sprunk</b>.")
					end)

				end
			elseif itemName == "cola" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"cola",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","ng_proc_sodacan_01a",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-70)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você tomou <b>Cola</b>.")
					end)

				end
			elseif itemName == "energetico" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"energetico",1) then
				
					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_energy_drink",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,15000,"tomando")

					SetTimeout(15000,function()
						actived[user_id] = nil
						TriggerClientEvent('energeticos',source,true)
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,-100)
						vRP.varyHunger(user_id,0)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você bebeu um energético.")
						
						SetTimeout(60000,function()
							TriggerClientEvent('energeticos',source,false)
							TriggerClientEvent("Notify",source,"aviso","O efeito do energético passou.")
						end)
					end)
				end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ COMIDAS ]-------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "sanduiche" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"sanduiche",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer")
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "rosquinha" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"rosquinha",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer3")
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "hotdog" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"hotdog",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer2")
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "xburguer" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"xburguer",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					TriggerClientEvent("emotes",source,"comer")
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "chips" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"chips",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","ng_proc_food_chips01b",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "batataf" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"batataf",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_bs_chips",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "pizza" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"pizza",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","v_res_tt_pizzaplate",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						
					end)

				end
			elseif itemName == "frango" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"frango",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_food_cb_nugets",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Frango Frito</b>.")
					end)

				end
			elseif itemName == "bcereal" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bcereal",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_pq",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Barra de Cereal</b>.")
					end)

				end
			elseif itemName == "bchocolate" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"bchocolate",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_choc_meto",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Barra de Chocolate</b>.")
					end)

				end
			elseif itemName == "taco" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"taco",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_taco_01",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Taco</b>.")
					end)

				end
			elseif itemName == "yakisoba" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"yakisoba",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@code_human_wander_eating_donut@male@idle_a","idle_c","prop_cs_plate_01",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"comendo")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						vRP.varyThirst(user_id,0)
						vRP.varyHunger(user_id,-40)
						vRPclient._DeletarObjeto(src)
						TriggerClientEvent("Notify",source,"sucesso","Você comeu um <b>Yakisoba</b>.")
					end)

				end
			--------------------------------------------------------------------------------------------------------------------------------------------------
			--[ REMÉDIOS ]------------------------------------------------------------------------------------------------------------------------------------
			--------------------------------------------------------------------------------------------------------------------------------------------------	
			elseif itemName == "paracetamil" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"paracetamil",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						
					end)
				end
			elseif itemName == "voltarom" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"voltarom",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						
					end)
				end
			elseif itemName == "trandrylux" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"trandrylux",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						
					end)
				end
			elseif itemName == "dorfrex" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"dorfrex",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						
					end)
				end
			elseif itemName == "buscopom" then
				local src = source
				if vRP.tryGetInventoryItem(user_id,"buscopom",1) then

					actived[user_id] = true
					TriggerClientEvent('Creative:Update',source,'updateMochila')
					vRPclient._CarregarObjeto(src,"amb@world_human_drinking@beer@male@idle_a","idle_a","prop_cs_pills",49,28422)
					vCLIENT.closeInventory(source)
					TriggerClientEvent("progress",source,10000,"tomando")

					SetTimeout(10000,function()
						actived[user_id] = nil
						vRPclient._stopAnim(source,false)
						TriggerClientEvent("remedios",source)
						vRPclient._DeletarObjeto(src)
						
					end)
				end
			end

		elseif type == "equipar" then
			if vRP.tryGetInventoryItem(user_id,itemName,1) then
				local weapons = {}
				local identity = vRP.getUserIdentity(user_id)
				weapons[string.gsub(itemName,"wbody|","")] = { ammo = 0 }
				vRPclient._giveWeapons(source,weapons)

				PerformHttpRequest(equipLog, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "EQUIPADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
									thumbnail = {
									url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
									}, 
									fields = {
										{ 
											name = "**Registro do usuário:**", 
											value = "` "..identity.name.." "..identity.firstname.." ` "
										},
										{ 
											name = "**Nº do ID:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**Nome do item equipado:**", 
											value = "` "..vRP.itemNameList(itemName).." ` "
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

				TriggerClientEvent('Creative:Update',source,'updateMochila')
			end
		elseif type == "recarregar" then
			local uweapons = vRPclient.getWeapons(source)
			local weaponuse = string.gsub(itemName,"wammo|","")
			local identity = vRP.getUserIdentity(user_id)
			if uweapons[weaponuse] then				
				if vRP.tryGetInventoryItem(user_id,"wammo|"..weaponuse,parseInt(ramount)) then
					local weapons = {}
					weapons[weaponuse] = { ammo = parseInt(ramount) }
					vRPclient._giveWeapons(source,weapons,false)
					PerformHttpRequest(ammoLog, function(err, text, headers) end, 'POST', json.encode({
							embeds = {
								{ 
									title = "RECARREGADO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
									thumbnail = {
									url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
									}, 
									fields = {
										{ 
											name = "**Registro do usuário:**", 
											value = "` "..identity.name.." "..identity.firstname.." ` "
										},
										{ 
											name = "**Nº do ID:**", 
											value = "` "..user_id.." ` "
										},
										{ 
											name = "**Nome da munição:**", 
											value = "` "..vRP.itemNameList(itemName).." ` "
										},
										{ 
											name = "**Quantidade de munição:**", 
											value = "` "..parseInt(ramount).." ` "
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
					TriggerClientEvent('Creative:Update',source,'updateMochila')
				end
			end
		end
	end
end
-- [ EVENTO DE CANCELAMENTO ] --
RegisterServerEvent("bdl_inventory:Cancel")
AddEventHandler("bdl_inventory:Cancel",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if active[parseInt(user_id)] == nil then
			active[parseInt(user_id)] = 0
		end

		if active[parseInt(user_id)] > 0 then
			active[parseInt(user_id)] = -1
			TriggerClientEvent("Progress",source,1500)

			SetTimeout(1000,function()
				vRPclient._removeObjects(source)
				vCLIENT.blockButtons(source,false)
				vGARAGE.updateHotwired(source,false)
			end)
		else
			vRPclient._removeObjects(source)
		end
	end
end)
-- [ CHECAR INVENTÁRIO (DESATIVADO) ] --
function vRPex.checkInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if active[parseInt(user_id)] == nil then
			active[parseInt(user_id)] = 0
		end

		if active[parseInt(user_id)] > 0 then
			return false
		end
		return true
	end
end
-- [ DESATIVADO ] --
function vRPex.verifySlots(user_id)
	for k,v in pairs(slots) do
		if vRP.hasPermission(user_id,k) then
			return v
		end
	end
end
-- [ DESATIVADO ] --
function vRPex.getRemaingSlots(user_id)
	local tSlot = vRPex.verifySlots(user_id)
	if tSlot ~= nil then
		tSlot = tSlot
	else
		tSlot = 11
	end
	for k,v in pairs(vRP.getInventory(user_id)) do
		tSlot = tSlot - 1
	end
	return tSlot
end
-- [ DESATIVADO ] --
function vRPex.haveMoreSlots(user_id)
	if vRPex.getRemaingSlots(user_id) > 0 then
		return true
	else
		return false
	end
end