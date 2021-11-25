local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
inProgress = {}

src = {}
Tunnel.bindInterface("bdl_ammofactory", src)

local itemName = {
	{ item = "ak103" },
	{ item = "ak47" },
	{ item = "ak74" },
	{ item = "mp5" },
	{ item = "tec9" },
	{ item = "m1911" },
	{ item = "hk110" }
}

RegisterServerEvent("bdl_ammofactory:ammofactory")
AddEventHandler("bdl_ammofactory:ammofactory",function(item)
	local src = source
	local user_id = vRP.getUserId(src)
	if user_id then
		for e,g in pairs(itemName) do
			if item == g.item then
				if not inProgress[src] then
					if item == "ak103" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE_MK2") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
								if vRP.getInventoryItemAmount(user_id,"polvora") >= 80 then
									if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",80) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE_MK2",30)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou munição de <b>AK-103</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Pólvora</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Capsulas</b> o suficiente.")
							end
							
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "ak47" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_ASSAULTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
								if vRP.getInventoryItemAmount(user_id,"polvora") >= 80 then
									if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",80) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"wammo|WEAPON_ASSAULTRIFLE",30)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou munição de <b>AK-47</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Pólvora</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Capsulas</b> o suficiente.")
							end
							
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "ak74" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_COMPACTRIFLE") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
								if vRP.getInventoryItemAmount(user_id,"polvora") >= 80 then
									if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",80) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"wammo|WEAPON_COMPACTRIFLE",30)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou munição de <b>AK-74u</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Pólvora</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Capsulas</b> o suficiente.")
							end
							
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "mp5" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SMG") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"capsulas") >= 30 then
								if vRP.getInventoryItemAmount(user_id,"polvora") >= 60 then
									if vRP.tryGetInventoryItem(user_id,"capsulas",30) and vRP.tryGetInventoryItem(user_id,"polvora",60) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"wammo|WEAPON_SMG",30)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou munição de <b>MP-5</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Pólvora</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Capsulas</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "tec9" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_MACHINEPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"capsulas") >= 20 then
								if vRP.getInventoryItemAmount(user_id,"polvora") >= 50 then
									if vRP.tryGetInventoryItem(user_id,"capsulas",20) and vRP.tryGetInventoryItem(user_id,"polvora",50) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"wammo|WEAPON_MACHINEPISTOL",20)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou munição de <b>TEC-9</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Pólvora</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Capsulas</b> o suficiente.")
							end
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "m1911" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PISTOL") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"capsulas") >= 12 then
								if vRP.getInventoryItemAmount(user_id,"polvora") >= 40 then
									if vRP.tryGetInventoryItem(user_id,"capsulas",12) and vRP.tryGetInventoryItem(user_id,"polvora",40) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL",12)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou munição de <b>M1911</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Pólvora</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Capsulas</b> o suficiente.")
							end
							
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
						
					elseif item == "hk110" then
						if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SNSPISTOL") <= vRP.getInventoryMaxWeight(user_id) then
							if vRP.getInventoryItemAmount(user_id,"capsulas") >= 12 then
								if vRP.getInventoryItemAmount(user_id,"polvora") >= 40 then
									if vRP.tryGetInventoryItem(user_id,"capsulas",12) and vRP.tryGetInventoryItem(user_id,"polvora",40) then
										TriggerClientEvent("progress",src,25000,"fazendo")
										vRPclient._playAnim(src,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
										inProgress[src] = true
										TriggerClientEvent("F6Cancel",src,true)
										SetTimeout(25000,function()
											vRPclient._stopAnim(src,false)
											vRP.giveInventoryItem(user_id,"wammo|WEAPON_SNSPISTOL",12)
											TriggerClientEvent("Notify",src,"sucesso","Você fabricou munição de <b>HK-110</b>.")
											inProgress[src] = false
											TriggerClientEvent("F6Cancel",src,false)
										end)
									end
									
								else
									TriggerClientEvent("Notify",src,"negado","Você não tem <b>Pólvora</b> o suficiente.")
								end
							else
								TriggerClientEvent("Notify",src,"negado","Você não tem <b>Capsulas</b> o suficiente.")
							end
							
						else
							TriggerClientEvent("Notify",src,"negado","Você não tem espaço o suficiente.")
						end
					end
				else
					TriggerClientEvent("Notify",src,"negado","Termine a produção em progresso para iniciar outra.")
				end
			end
		end
	end
end)

function src.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"bratva.permission") or vRP.hasPermission(user_id,"lost.permission") then
		return true
	end
end