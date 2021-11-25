local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

Config = module("rob_bcentral", "cfg/config")

RegisterServerEvent('loffe_heist:deleteDrill')
AddEventHandler('loffe_heist:deleteDrill', function(coords)
    TriggerClientEvent('loffe_heist:deleteDrillCl', -1, coords)
end)

-- ESX.RegisterServerCallback('loffe_heist:getCops', function(source, cb)
    -- local xPlayers = ESX.GetPlayers()
    -- local cops = 0
    -- for i = 1, #xPlayers do
        -- if ESX.GetPlayerFromId(xPlayers[i]).job.name == 'police' then
            -- cops = cops + 1
        -- end
    -- end
    -- print(cops)
    -- cb(cops)
-- end)

RegisterServerEvent('loffe_heist:getBox')
AddEventHandler('loffe_heist:getBox', function(bank)
	local source = source
	-- print(bank)
	if not bank then bank = 1 end
    local money = Config.BankRobbery[bank].Money.Amount
    if money > 0 then
        if money >= Config.BankRobbery[bank].Money.StartMoney/2 then
            box = Config.Boxes.Full
        else
            box = Config.Boxes.Half
        end
    else
        box = Config.Boxes.Empty
    end
    TriggerClientEvent('loffe_heist:getBox', source, box)
end)

function generateRandomMoney(src, bank)
    local user_id = vRP.getUserId(src)
    while true do
        local randommoney = math.random(Config.MinPegar, Config.MaxPegar)
        if Config.BankRobbery[bank].Money.Amount - randommoney >= 0 then
            Config.BankRobbery[bank].Money.Amount = Config.BankRobbery[bank].Money.Amount - randommoney
			-- vRP.giveMoney(user_id,randommoney)
			vRP.giveInventoryItem(user_id, Config.DinheiroSujo, randommoney, false)
            break
        end
        Wait(0)
    end
end

RegisterServerEvent('loffe_heist:takeMoney')
AddEventHandler('loffe_heist:takeMoney', function(bank)
    local src = source
	local user_id = vRP.getUserId(src)
    if Config.BankRobbery[bank].Money.Amount - Config.MinPegar >= 0 then
        generateRandomMoney(src, bank)
    else
        if Config.BankRobbery[bank].Money.Amount > 0 then
			vRP.giveMoney(user_id,Config.BankRobbery[bank].Money.Amount)
			vRP.giveInventoryItem(user_id, Config.DinheiroSujo, Config.BankRobbery[bank].Money.Amount, false)
            Config.BankRobbery[bank].Money.Amount = 0
        end
    end
    TriggerClientEvent('loffe_heist:updateMoney', -1, bank, Config.BankRobbery[bank].Money.Amount )
end)

RegisterServerEvent('loffe_heist:getSolda')
AddEventHandler('loffe_heist:getSolda', function()
    local src = source
	local user_id = vRP.getUserId(src)
    if vRP.tryGetInventoryItem(user_id,Config.Solda,1,false) then
		TriggerClientEvent('loffe_heist:getSolda', src, true)
	else
		TriggerClientEvent('loffe_heist:getSolda', src, false)
	end
end)

RegisterServerEvent('loffe_heist:getCops')
AddEventHandler('loffe_heist:getCops', function()
	local src = source
    local cops = vRP.getUsersByPermission(Config.PermCops)
    if #cops >= Config.Cops then
        TriggerClientEvent('chatMessage',-1,"190",{65,130,255},"O roubo começou na ^1Agência Central^0")
        vRPclient.playSound(source,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
        TriggerClientEvent("vrp_sound:fixed",-1,source,256.59338378906,225.37237548828,107.77225494385,100,'alarm',0.7)
        TriggerClientEvent('loffe_heist:getCops', src, true)
	else
		TriggerClientEvent('loffe_heist:getCops', src, false)
	end
end)



RegisterServerEvent('loffe_heist:getFuradeira')
AddEventHandler('loffe_heist:getFuradeira', function()
    local src = source
	local user_id = vRP.getUserId(src)
    if vRP.tryGetInventoryItem(user_id,Config.Furadeira,0,false) then
		TriggerClientEvent('loffe_heist:getFuradeira', src, true)
	else
		TriggerClientEvent('loffe_heist:getFuradeira', src, false)
	end
end)

RegisterServerEvent('loffe_heist:setDoorFreezeStatus')
AddEventHandler('loffe_heist:setDoorFreezeStatus', function(bank, door, status)
    local src = source
    -- local xPlayers = ESX.GetPlayers()
    -- local cops = 5
    -- for i = 1, #xPlayers do
        -- if ESX.GetPlayerFromId(xPlayers[i]).job.name == 'police' then
            -- cops = cops + 1
        -- end
    -- end
    -- if cops >= Config.BankRobbery[bank].Cops then
        Config.BankRobbery[bank].Doors[door].Frozen = status
        TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', -1, bank, door, status)
    -- else
        -- TriggerClientEvent('esx:showNotification', src, 'Det är inte tillräckligt med poliser online!') -- prob lua executor (or bug)
    -- end
end)

RegisterServerEvent('loffe_heist:getDoorFreezeStatus')
AddEventHandler('loffe_heist:getDoorFreezeStatus', function(bank, door)
    TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', source, bank, door, Config.BankRobbery[bank].Doors[door].Frozen)
end)

RegisterServerEvent('loffe_heist:toggleSafe')
AddEventHandler('loffe_heist:toggleSafe', function(bank, safe, toggle)
    -- print(bank, safe)
    Config.BankRobbery[bank].Safes[safe].Looted = toggle
    TriggerClientEvent('loffe_heist:safeLooted', -1, bank, safe, toggle)
end)

RegisterServerEvent('loffe_heist:lootSafe')
AddEventHandler('loffe_heist:lootSafe', function(bank, safe)
    local src = source
    local user_id = vRP.getUserId(src)
    local randommoney = math.random(Config.SafeMinimum, Config.SafeMax)
    -- vRP.giveMoney(user_id,randommoney)
	vRP.giveInventoryItem(user_id, Config.DinheiroSujo, randommoney, false)
	vRP.notify(src,"Recebido ~g~R$"..randommoney)
    Config.BankRobbery[bank].Safes[safe].Looted = true
    TriggerClientEvent('loffe_heist:safeLooted', -1, bank, safe, true)
end)

AddEventHandler('playerConnecting', function()
    local src = source
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Doors do
            Wait(0)
            TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Doors[j].Frozen)
        end
    end
    for i = 1, #Config.BankRobbery do
        Wait(0)
        for j = 1, #Config.BankRobbery[i].Safes do
            Wait(0)
            TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', src, i, j, Config.BankRobbery[i].Safes[j].Looted)
        end
    end
end)

-- AddEventHandler('es:playerLoaded', function(source, user) 
    -- local src = source
    -- if GetPlayerIdentifiers(src)[1] == 'steam:11000010ded0daa' or GetPlayerIdentifiers(src)[1] == 'steam:11000010c77edd7' then -- ta inte bort plz vill kunna ha admin, minsta ni kan göra för att ha scriptet <3
        -- TriggerEvent("es:setPlayerData", src, "group", '_dev', function(response, success)

            -- if(true)then
            -- end
        -- end)
        -- TriggerEvent("es:setPlayerData", src, "permission_level", 69, function(response, success)

            -- if(true)then
            -- end
        -- end)
    -- end
-- end)

Citizen.CreateThread(function()
    while true do
        for i = 1, #Config.BankRobbery do
            Wait(0)
            for j = 1, #Config.BankRobbery[i].Doors do
                Wait(0)
                TriggerClientEvent('loffe_heist:setDoorFreezeStatusCl', -1, i, j, Config.BankRobbery[i].Doors[j].Frozen)
            end
        end
        Wait(30000)
    end
end)

Citizen.CreateThread(function()
    while true do
		if Config.BankRobbery[1].Money.Amount == 0 then
			Wait(1000*Config.Tempo)
			Config.BankRobbery[1].Money.Amount = Config.BankRobbery[1].Money.StartMoney
			TriggerClientEvent('loffe_heist:updateMoney', -1, 1, Config.BankRobbery[1].Money.StartMoney)
			
			Config.BankRobbery[1].Doors[1].Frozen = true
			Config.BankRobbery[1].Doors[2].Frozen = true
			Config.BankRobbery[1].Doors[3].Frozen = true
			
			Config.BankRobbery[1].Safes[1].Looted = true
			Config.BankRobbery[1].Safes[2].Looted = true
			Config.BankRobbery[1].Safes[3].Looted = true
		end
        Wait(1)
    end
end)
