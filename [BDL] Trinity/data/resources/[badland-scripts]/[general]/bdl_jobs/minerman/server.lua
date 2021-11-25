local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

miner = {}
Tunnel.bindInterface("minerman",miner)

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local ammount = {}
local percentage = 0
local breakChance = 0
local itemName = ""

--[ RANDOM AMMOUNT | FUNCTION ]-------------------------------------------------------------------------------------------------

function miner.ammount()
	local source = source
	if ammount[source] == nil then
		ammount[source] = math.random(1,4)
	end
end

--[ CHECK WEIGHT | FUNCTION ]---------------------------------------------------------------------------------------------------

function miner.checkWeight()
	miner.ammount()

	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		percentage = math.random(100)
		if percentage <= 58 then
			itemName = "ferro"
		elseif percentage >= 59 and percentage <= 79 then
			itemName = "bronze"
		elseif percentage >= 80 and percentage <= 90 then
			itemName = "ouro"
		elseif percentage >= 91 then
			itemName = "diamante"
		end
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(itemName)*ammount[source] <= vRP.getInventoryMaxWeight(user_id) then
			if vRP.getInventoryItemAmount(user_id,"britadeira") > 0 then
				breakChance = math.random(100)
				if breakChance > 75 then
					vRP.tryGetInventoryItem(user_id,"britadeira",1)
				end
				vRP.giveInventoryItem(user_id,itemName,ammount[source])
				ammount[source] = nil
				return true
			end
		end
	end
end