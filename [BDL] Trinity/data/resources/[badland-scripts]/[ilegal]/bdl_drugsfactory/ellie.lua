local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

src = {}
Tunnel.bindInterface("bdl_drugsfactory",src)
vCLIENT = Tunnel.getInterface("bdl_drugsfactory")
-- TABLE DO PROGRESSO DAS PLANTAS
local reactProgress = {}
-- FUNÇÃO DE COMEÇAR A PLANTAR
function src.startPlanting(id,receive)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not reactProgress[id] then
			-- MACONHA | PEGAR ITEM NECESSARIO
			if receive == "maconha" then
				if vRP.tryGetInventoryItem(user_id,"adubo",1) then
					reactProgress[id] = 0
					TriggerClientEvent("cancelando",source,true)
					TriggerClientEvent("progress",source,8000,"plantando")
					vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
					Citizen.Wait(8000)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent("cancelando",source,false)
				else
					TriggerClientEvent("Notify",source,"negado","Você precisa de: <b>Adubo</b>.")
				end
			-- COCAINA | PEGAR ITEM NECESSARIO
			elseif receive == "cocaina" then
				if vRP.tryGetInventoryItem(user_id,"adubo",1) then
					reactProgress[id] = 0
					TriggerClientEvent("cancelando",source,true)
					TriggerClientEvent("progress",source,8000,"plantando")
					vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
					Citizen.Wait(8000)
					vRPclient._stopAnim(source,false)
					TriggerClientEvent("cancelando",source,false)
				else
					TriggerClientEvent("Notify",source,"negado","Você precisa de: <b>Adubo</b>.")
				end
			end
		else
			-- MACONHA | DAR ITEM APOS FIM DO PROGRESSO
			if reactProgress[id] >= 100 then
				if receive == "maconha" then
					local amount = math.random(1,3)
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("maconha")*amount <= vRP.getInventoryMaxWeight(user_id) then
						reactProgress[id] = nil
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent("progress",source,9000,"colhendo")
						vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
						Citizen.Wait(9000)
						vRPclient._stopAnim(source,false)
						vCLIENT.returnPlanting(-1,reactProgress)
						TriggerClientEvent("cancelando",source,false)
						vRP.giveInventoryItem(user_id,"maconha",amount)
					end
				-- COCAINA | DAR ITEM APOS FIM DO PROGRESSO
				elseif receive == "cocaina" then
					local amount = math.random(1,3)
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("folha-coca")*amount <= vRP.getInventoryMaxWeight(user_id) then
						reactProgress[id] = nil
						TriggerClientEvent("cancelando",source,true)
						TriggerClientEvent("progress",source,9000,"colhendo")
						vRPclient._playAnim(source,true,{{"amb@world_human_gardener_plant@female@idle_a","idle_a_female"}},false)
						Citizen.Wait(9000)
						vRPclient._stopAnim(source,false)
						vCLIENT.returnPlanting(-1,reactProgress)
						TriggerClientEvent("cancelando",source,false)
						vRP.giveInventoryItem(user_id,"folha-coca",amount)
					end
				end
			end
		end
	end
end
-- FUNÇÃO QUE PEGA O ITEM PASTA-COCA E RETORNA VALOR VERDADEIRO
function src.takeCocaItem(amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"pasta-coca",amount) then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Valor inválido.")
		end
	end
end
-- FUNÇÃO QUE PEGA QUALQUER ITEM VIA CLIENT-SIDE E RETORNA VALOR VERDADEIRO
function src.tryGetDrugsFromInv(item)
	local source = source
	local user_id = vRP.getUserId(source)
	getPastaAmount = vRP.prompt(source,"Coloque a quantidade:","")
	return vRP.tryGetInventoryItem(user_id,item,getPastaAmount)
end
-- FUNÇÃO QUE GIVA O ITEM COCAINA PRO SOURCE SETADO SE O VALOR DE ITEM-WEIGHT FOR VERDADEIRO
function src.tryGiveDrugsToInv()
	local source = source
	local user_id = vRP.getUserId(source)
	local getCocainaAmount = math.random(1,3)
	if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cocaina")*getPastaAmount <= vRP.getInventoryMaxWeight(user_id) then
		vRPclient._playAnim(source,true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		TriggerClientEvent("cancelando",source,true)
		TriggerClientEvent("progress",source,9000,"colhendo")
		Citizen.Wait(9000)
		vRPclient._stopAnim(source,false)
		TriggerClientEvent("cancelando",source,false)
		vRP.giveInventoryItem(user_id,"cocaina",getPastaAmount*getCocainaAmount)
		return true
	else
		TriggerClientEvent("Espaço insuficiente.")
	end
end
-- FUNÇÃO DE EMBALAR A MACONHA
function src.tryPackProduct()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"ballas.permission") then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("maconha-embalada")*1 <= vRP.getInventoryMaxWeight(user_id) then
				local currentWeedAmount = vRP.getInventoryItemAmount(user_id,"maconha")
				local missingWeedAmount = 5 - parseInt(currentWeedAmount)
				if vRP.tryGetInventoryItem(user_id,"maconha",5) then
					TriggerClientEvent('sentarnacadeira',source,head,x,y,z)
					TriggerClientEvent("cancelando",source,true)
					vRPclient._playAnim(source,true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					SetTimeout(10000,function()
						TriggerClientEvent("cancelando",source,false)
						vRPclient._stopAnim(source,false)
						vRP.giveInventoryItem(user_id,"maconha-embalada",1)
					end)
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Você precisa de: <b>"..missingWeedAmount.."x Maconha(s)</b>")
				end
			end
		end
	end
end
-- FUNÇÃO DE EMBALAR A COCAINA
function src.tryPackCoca()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.hasPermission(user_id,"grove.permission") then
			local tempo = 0
			local getAmount = vRP.prompt(source,"Coloque a quantidade a ser embalada:","")
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("coca-embalada")*parseInt(getAmount)/5 <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,"cocaina",getAmount) then
					if tonumber(getAmount) >= 1 and tonumber(getAmount) < 20 then
						tempo = 10000
					elseif tonumber(getAmount) >= 20 and tonumber(getAmount) < 50 then
						tempo = 25000
					elseif tonumber(getAmount) >= 50 and tonumber(getAmount) < 80 then
						tempo = 50000
					elseif tonumber(getAmount) >= 80 and tonumber(getAmount) < 120 then
						tempo = 80000
					elseif tonumber(getAmount) >= 120 then
						tempo = 100000
					end
					print(tempo)
					TriggerClientEvent("progress",source,tempo)
					TriggerClientEvent("cancelando",source,true)
					vRPclient._playAnim(source,true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
					SetTimeout(tempo,function()
						TriggerClientEvent("cancelando",source,false)
						vRPclient._stopAnim(source,false)
						vRP.giveInventoryItem(user_id,"coca-embalada",tonumber(getAmount)/5)
					end)
					
					vRP.giveInventoryItem(user_id,"cocaina",parseInt(getAmount%5))
					
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Valor inválido.")
				end
			end
		end
	end
end
-- FUNÇÃO QUE PEGA A FOLHA DE COCA E RETORNA VALOR VERDADEIRO
function src.takeCokeFlower()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if vRP.tryGetInventoryItem(user_id,"folha-coca",5) then
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Você precisa de: <b>5x Folhas</b>")
	end
end
-- FUNÇÃO QUE GIVA PASTA DE COCA
function src.getCokePasta()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local amount = math.random(2,6)
	if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pasta-coca")*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
		TriggerClientEvent("cancelando",source,true)
		vRPclient._playAnim(source,true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		SetTimeout(15000,function()
			TriggerClientEvent("cancelando",source,false)
			vRPclient._stopAnim(source,false)
			vRP.giveInventoryItem(user_id,"pasta-coca",parseInt(amount))
		end)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Peso insuficiente.</b>")
	end
end
-- FUNÇÃO QUE PEGA COMPRIMIDOS E ACIDO
function src.takeIngredients()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"comprimidos") >= 1 then
			if vRP.getInventoryItemAmount(user_id,"acido") >= 1 then
				vRP.tryGetInventoryItem(user_id,"comprimidos",1)
				vRP.tryGetInventoryItem(user_id,"acido",1)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Ácido</b>")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>Comprimidos</b>")
		end
	end
end
-- FUNÇÃO QUE GIVA COMPOSITO
function src.getComposit()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local amount = 5
	if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("composito")*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
		TriggerClientEvent("cancelando",source,true)
		vRPclient._playAnim(source,true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		TriggerClientEvent("progress",source,2000)
		SetTimeout(2000,function()
			TriggerClientEvent("cancelando",source,false)
			vRPclient._stopAnim(source,false)
			vRP.giveInventoryItem(user_id,"composito",amount)
		end)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Peso insuficiente.</b>")
	end
end
-- FUNÇÃO QUE PEGA Querosene E COMPOSITO
function src.mixComposit()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,"composito") >= 5 then
			if vRP.getInventoryItemAmount(user_id,"querosene") >= 1 then
				vRP.tryGetInventoryItem(user_id,"composito",5)
				vRP.tryGetInventoryItem(user_id,"querosene",1)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você precisa de <b>1x Querosene</b>")
			end
		else
			TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x Compósito</b>")
		end
	end
end
-- FUNÇÃO QUE GIVA METANFETAMINA
function src.getMethFromFactory()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local amount = math.random(2,5)
	if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("metanfetamina")*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
		TriggerClientEvent("cancelando",source,true)
		vRPclient._playAnim(source,true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
		TriggerClientEvent("progress",source,2000)
		SetTimeout(2000,function()
			TriggerClientEvent("cancelando",source,false)
			vRPclient._stopAnim(source,false)
			vRP.giveInventoryItem(user_id,"metanfetamina",parseInt(amount))
		end)
		return true
	else
		TriggerClientEvent("Notify",source,"negado","Peso insuficiente.</b>")
	end
end
-- FUNÇÃO DE LAVAR A META
function src.tryWashItem()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	wash_amount = vRP.prompt(source,"Coloque a quantidade a ser lavada:","")
	if vRP.hasPermission(user_id,"vagos.permission") then
		if parseInt(wash_amount) >= 5 then
			if vRP.tryGetInventoryItem(user_id,"metanfetamina",parseInt(wash_amount)) then
				vRP.giveInventoryItem(user_id,"metanfetamina",wash_amount%5)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Valor inválido.")
			end
		else
			TriggerClientEvent("Notify",source,"negado","A quantidade mínima é de <b>5x Metanfetamina</b>")
		end
	end
end
-- FUNÇÃO DE EMBALAR A META
function src.tryPackMeth()
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local methpack_amount = parseInt(wash_amount)
		local timer = 0
		if methpack_amount > 1 and methpack_amount <= 20 then
			timer = 30
		elseif methpack_amount > 20 and methpack_amount <= 40 then
			timer = 45
		elseif methpack_amount > 40 and methpack_amount <= 60 then
			timer = 60
		elseif methpack_amount > 60 and methpack_amount <= 80 then
			timer = 75
		elseif methpack_amount > 80 and methpack_amount <= 100 then
			timer = 90
		elseif methpack_amount > 100 then
			timer = 120
		end
		
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("meta-embalada")*parseInt(amount) <= vRP.getInventoryMaxWeight(user_id) then
			TriggerClientEvent("progress",source,timer*1000)
			TriggerClientEvent("cancelando",source,true)
			vRPclient._playAnim(source,true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
			SetTimeout(timer*1000,function()
				TriggerClientEvent("cancelando",source,false)
				vRP.giveInventoryItem(user_id,"meta-embalada",methpack_amount/5)
				vRPclient._stopAnim(source,false)
			end)
			return true
		end
	end
end

-- [ COMPRAR ING. DE META ] --
local forSale = {
    { item = "querosene", name = "Querosene", price = 500, amount = 1 },
    { item = "acido", name = "Ácido", price = 100, amount = 1 },
    { item = "comprimidos", name = "Comprimidos", price = 100, amount = 1 }
}
-- [ EVENTO COMPRAR META ] --
RegisterServerEvent("meth-comprar")
AddEventHandler("meth-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(forSale) do
			if item == v.item then
				if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.amount <= vRP.getInventoryMaxWeight(user_id) then
					if vRP.tryPayment(user_id,parseInt(v.price)) then
						vRP.giveInventoryItem(user_id,v.item,parseInt(v.amount))
						TriggerClientEvent("Notify",source,"sucesso","Comprou <b>"..parseInt(v.amount).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.price)).." dólares</b>.")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
					end
				else
					TriggerClientEvent("Notify",source,"negado","Espaço insuficiente.")
				end
			end
		end
	end
end)

function src.getUserPermission(permission)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,permission)
end


-- THREAD DO PROGRESSO DAS PLANTAS NO SERVER SIDE
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(reactProgress) do
			if v ~= nil and v < 100 then
				reactProgress[k] = v + 1
				vCLIENT.returnPlanting(-1,reactProgress)
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(200)
	end
end)