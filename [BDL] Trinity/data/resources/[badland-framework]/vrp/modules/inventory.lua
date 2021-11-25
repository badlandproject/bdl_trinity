local cfg = module("cfg/inventory")

local itemlist = {
	["mochila"] = { index = "mochila", nome = "Mochila", type = "usar" },
	["celular"] = { index = "celular", nome = "Celular", type = "usar" },
	["radio"] = { index = "radio", nome = "WalkTalk", type = "usar" },
	["militec"] = { index = "militec", nome = "Militec", type = "usar" },
	["repairkit"] = { index = "repairkit", nome = "Kit de Reparos", type = "usar" },
	["pneus"] = { index = "pneus", nome = "Pneus", type = "usar" },
	["melhoria"] = { index = "melhoria", nome = "Melhoria Nvl.1", type = "usar" },
	["identidade"] = { index = "identidade", nome = "Identidade", type = "usar" },
	["colete"] = { index = "colete", nome = "Colete Balístico", type = "usar" },
	["roupas"] = { index = "roupas", nome = "Roupas", type = "usar" },
	["algema"] = { index = "algema", nome = "Algema", type = "usar" },

	-- [ Empregos ] --
	["garrafavazia"] = { index = "garrafavazia", nome = "Garrafa Vazia", type = "usar" },
	["garrafaleite"] = { index = "garrafaleite", nome = "Garrafa de Leite", type = "usar" },
	["encomenda"] = { index = "encomenda", nome = "Encomenda", type = "usar" },
	["britadeira"] = { index = "britadeira", nome = "Britadeira", type = "usar" },
	["ferro"] = { index = "ferro", nome = "Ferro", type = "usar" },
	["bronze"] = { index = "bronze", nome = "Bronze", type = "usar" },
	["ouro"] = { index = "ouro", nome = "Ouro", type = "usar" },
	["diamante"] = { index = "diamante", nome = "Diamante", type = "usar" },
	["blueberry"] = { index = "blueberry", nome = "Blueberry", type = "usar" },
	["s-blueberry"] = { index = "s-blueberry", nome = "Sementes", type = "usar" },
	
	-- [ Ilegais ] --
	["blankcard"] = { index = "blankcard", nome = "Cartão", type = "usar" },
	["dinamite"] = { index = "dinamite", nome = "Dinamite", type = "usar" },
	["furadeira"] = { index = "furadeira", nome = "Furadeira", type = "usar" },
	["dinheiro-sujo"] = { index = "dinheiro-sujo", nome = "Dinheiro Sujo", type = "usar" },
	["lockpick"] = { index = "lockpick", nome = "Lockpick", type = "usar" },
	["capuz"] = { index = "capuz", nome = "Capuz", type = "usar" },
	--#Ballas
	["pe-maconha"] = { index = "pe-maconha", nome = "Pé de Maconha", type = "usar" },
	["adubo"] = { index = "adubo", nome = "Adubo", type = "usar" },
	["maconha"] = { index = "maconha", nome = "Maconha", type = "usar" },
	["maconha-embalada"] = { index = "maconha-embalada", nome = "Maconha Emb.", type = "usar" },
	--#Grove
	["folha-coca"] = { index = "folha-coca", nome = "Folha de Coca", type = "usar" },
	["pasta-coca"] = { index = "pasta-coca", nome = "Pasta de Coca", type = "usar" },
	["cocaina"] = { index = "cocaina", nome = "Cocaína", type = "usar" },
	["coca-embalada"] = { index = "coca-embalada", nome = "Cocaína Emb.", type = "usar" },
	--#Vagos
	["comprimidos"] = { index = "comprimidos", nome = "Comprimidos", type = "usar" },
	["acido"] = { index = "acido", nome = "Ácido", type = "usar" },
	["composito"] = { index = "composito", nome = "Compósito", type = "usar" },
	["querosene"] = { index = "querosene", nome = "Querosene", type = "usar" },
	["metanfetamina"] = { index = "metanfetamina", nome = "Metanfetamina", type = "usar" },
	["meta-embalada"] = { index = "meta-embalada", nome = "Metanf. Emb.", type = "usar" },
	--#Bratva
	["polvora"] = { index = "polvora", nome = "Pólvora", type = "usar" },
	["capsulas"] = { index = "capsulas", nome = "Capsulas", type = "usar" },
	["molas"] = { index = "molas", nome = "Molas", type = "usar" },
	["gatilho"] = { index = "gatilho", nome = "Gatilho", type = "usar" },
	["placa-metal"] = { index = "placa-metal", nome = "Placa de Metal", type = "usar" },
	["corpo-ak103"] = { index = "corpo-ak103", nome = "Corpo de AK-103", type = "usar" },
	["corpo-ak47"] = { index = "corpo-ak47", nome = "Corpo de AK-47", type = "usar" },
	["corpo-ak74"] = { index = "corpo-ak74", nome = "Corpo de AK-74", type = "usar" },
	["corpo-mp5"] = { index = "corpo-mp5", nome = "Corpo de MP-5", type = "usar" },
	["corpo-tec9"] = { index = "corpo-tec9", nome = "Corpo de Tec-9", type = "usar" },
	["corpo-m1911"] = { index = "corpo-m1911", nome = "Corpo de M1911", type = "usar" },
	["corpo-hk110"] = { index = "corpo-hk110", nome = "Corpo de HK110", type = "usar" },
	-- [ Remédios ] --
	["paracetamol"] = { index = "paracetamol", nome = "Paracetamol", type = "usar" },
	["voltaren"] = { index = "voltaren", nome = "Voltaren", type = "usar" },
	["tandrilax"] = { index = "tandrilax", nome = "Tandrilax", type = "usar" },
	["dorflex"] = { index = "dorflex", nome = "Dorflex", type = "usar" },
	["buscopan"] = { index = "buscopan", nome = "Buscopan", type = "usar" },
	["r-paracetamol"] = { index = "r-paracetamol", nome = "R. Paracetamol", type = "usar" },
	["r-voltaren"] = { index = "r-voltaren", nome = "R. Voltaren", type = "usar" },
	["r-tandrilax"] = { index = "r-tandrilax", nome = "R. Tandrilax", type = "usar" },
	["r-dorflex"] = { index = "r-dorflex", nome = "R. Dorflex", type = "usar" },
	["r-buscopan"] = { index = "r-buscopan", nome = "R. Buscopan", type = "usar" },

	-- [ Bebidas ] --
	["agua"] = { index = "agua", nome = "G. d'Água", type = "usar"},
	["energetico"] = { index = "energetico", nome = "Energético", type = "usar"},
	["sprunk"] = { index = "sprunk", nome = "Sprunk", type = "usar"},
	["cola"] = { index = "cola", nome = "Cola", type = "usar"},
	["leite"] = { index = "leite", nome = "Leite", type = "usar"},
	["barracho"] = { index = "barracho", nome = "Barracho", type = "usar"},
	["patriot"] = { index = "patriot", nome = "Patriot", type = "usar"},
	["pibwassen"] = { index = "pibwassen", nome = "Pibwassen", type = "usar"},

	-- [ Comidas ] --
	["xburguer"] = { index = "xburguer", nome = "X Burguer", type = "usar"},
	["sanduiche"] = { index = "sanduiche", nome = "Sanduiche", type = "usar"},
	["pizza"] = { index = "pizza", nome = "Pizza", type = "usar"},
	["batataf"] = { index = "batataf", nome = "Batata Frita", type = "usar"},
	["chips"] = { index = "chips", nome = "Chips", type = "usar"},
	["rosquinha"] = { index = "rosquinha", nome = "Rosquinha", type = "usar"},
	["hotdog"] = { index = "hotdog", nome = "HotDog", type = "usar"},
	["taco"] = { index = "taco", nome = "Taco", type = "usar"},

	-- [ Armas ] --
	-- UTILITÁRIOS
	["wbody|GADGET_PARACHUTE"] = { index = "paraquedas", nome = "Paraquedas", type = "equipar" },
	["wbody|WEAPON_PETROLCAN"] = { index = "gasolina", nome = "Galão de Gasolina", type = "equipar" },
	["wbody|WEAPON_FLARE"] = { index = "sinalizador", nome = "Sinalizador", type = "equipar" },
	["wbody|WEAPON_FIREEXTINGUISHER"] = { index = "extintor", nome = "Extintor", type = "equipar" },
	-- BRANCAS
	["wbody|WEAPON_KNIFE"] = { index = "faca", nome = "Faca", type = "equipar" },
	["wbody|WEAPON_DAGGER"] = { index = "adaga", nome = "Adaga", type = "equipar" },
	["wbody|WEAPON_KNUCKLE"] = { index = "ingles", nome = "Soco-Inglês", type = "equipar" },
	["wbody|WEAPON_MACHETE"] = { index = "machete", nome = "Machete", type = "equipar" },
	["wbody|WEAPON_SWITCHBLADE"] = { index = "canivete", nome = "Canivete", type = "equipar" },
	["wbody|WEAPON_WRENCH"] = { index = "grifo", nome = "Chave de Grifo", type = "equipar" },
	["wbody|WEAPON_HAMMER"] = { index = "martelo", nome = "Martelo", type = "equipar" },
	["wbody|WEAPON_GOLFCLUB"] = { index = "golf", nome = "Taco de Golf", type = "equipar" },
	["wbody|WEAPON_CROWBAR"] = { index = "cabra", nome = "Pé de Cabra", type = "equipar" },
	["wbody|WEAPON_HATCHET"] = { index = "machado", nome = "Machado", type = "equipar" },
	["wbody|WEAPON_FLASHLIGHT"] = { index = "lanterna", nome = "Lanterna", type = "equipar" },
	["wbody|WEAPON_BAT"] = { index = "beisebol", nome = "Taco de Beisebol", type = "equipar" },
	["wbody|WEAPON_BOTTLE"] = { index = "garrafa", nome = "Garrafa", type = "equipar" },
	["wbody|WEAPON_BATTLEAXE"] = { index = "batalha", nome = "Machado de Batalha", type = "equipar" },
	["wbody|WEAPON_POOLCUE"] = { index = "sinuca", nome = "Taco de Sinuca", type = "equipar" },
	["wbody|WEAPON_STONE_HATCHET"] = { index = "pedra", nome = "Machado de Pedra", type = "equipar" },
	["wbody|WEAPON_NIGHTSTICK"] = { index = "cassetete", nome = "Cassetete", type = "equipar" },
	-- PISTOLAS
	["wbody|WEAPON_PISTOL_MK2"] = { index = "fiveseven", nome = "FN Five-Seven", type = "equipar" },
	["wbody|WEAPON_COMBATPISTOL"] = { index = "glock", nome = "Glock-19", type = "equipar" },
	["wbody|WEAPON_PISTOL"] = { index = "m1911", nome = "M1911", type = "equipar" },
	["wbody|WEAPON_VINTAGEPISTOL"] = { index = "m22", nome = "FN-M22", type = "equipar" },
	["wbody|WEAPON_SNSPISTOL"] = { index = "hk110", nome = "HK 110", type = "equipar" },
	["wbody|WEAPON_STUNGUN"] = { index = "taser", nome = "Taser", type = "equipar" },
	-- RIFLES DE ASSALTO
	["wbody|WEAPON_ASSAULTRIFLE"] = { index = "ak47", nome = "AK-47", type = "equipar" },
	["wbody|WEAPON_ASSAULTRIFLE_MK2"] = { index = "ak103", nome = "AK-103", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE"] = { index = "m4a4", nome = "M4-A4", type = "equipar" },
	["wbody|WEAPON_CARBINERIFLE_MK2"] = { index = "m4a1", nome = "M4-A1", type = "equipar" },
	["wbody|WEAPON_ADVANCEDRIFLE"] = { index = "aug", nome = "AUG-A3", type = "equipar" },
	-- SMGs
	["wbody|WEAPON_SMG"] = { index = "mp5", nome = "MP5", type = "equipar" },
	["wbody|WEAPON_COMBATPDW"] = { index = "mpx", nome = "MPX", type = "equipar" },
	["wbody|WEAPON_MACHINEPISTOL"] = { index = "tec9", nome = "Tec-9", type = "equipar" },
	["wbody|WEAPON_COMPACTRIFLE"] = { index = "ak74u", nome = "AK-74u", type = "equipar" },
	-- SHOTGUNS
	["wbody|WEAPON_PUMPSHOTGUN"] = { index = "remington12", nome = "Secutor.12", type = "equipar" },
	["wbody|WEAPON_PUMPSHOTGUN_MK2"] = { index = "remington45", nome = "Executor.45", type = "equipar" },
	-- RIFLES DE CAÇA
	["wbody|WEAPON_MUSKET"] = { index = "winchester22", nome = "Winchester 22", type = "equipar" },
	
	-- [ Munições ] --
	-- UTILITÁRIOS
	["wammo|GADGET_PARACHUTE"] = { index = "m-paraquedas", nome = "M.Paraquedas", type = "recarregar" },
	["wammo|WEAPON_PETROLCAN"] = { index = "combustivel", nome = "Combustível", type = "recarregar" },
	["wammo|WEAPON_FLARE"] = { index = "m-sinalizador", nome = "M.Sinalizador", type = "recarregar" },
	["wammo|WEAPON_FIREEXTINGUISHER"] = { index = "m-extintor", nome = "M.Extintor", type = "recarregar" },
	-- PISTOLAS
	["wammo|WEAPON_PISTOL_MK2"] = { index = "m-fiveseven", nome = "FN Five-Seven", type = "recarregar" },
	["wammo|WEAPON_COMBATPISTOL"] = { index = "m-glock", nome = "Glock-19", type = "recarregar" },
	["wammo|WEAPON_PISTOL"] = { index = "m-m1911", nome = "M1911", type = "recarregar" },
	["wammo|WEAPON_VINTAGEPISTOL"] = { index = "m-m22", nome = "FN-M22", type = "recarregar" },
	["wammo|WEAPON_SNSPISTOL"] = { index = "m-hk110", nome = "HK-110", type = "recarregar" },
	["wammo|WEAPON_STUNGUN"] = { index = "m-taser", nome = "Taser", type = "recarregar" },
	-- RIFLES DE ASSALTO
	["wammo|WEAPON_ASSAULTRIFLE"] = { index = "m-ak47", nome = "AK-47", type = "recarregar" },
	["wammo|WEAPON_ASSAULTRIFLE_MK2"] = { index = "m-ak103", nome = "AK-103", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE"] = { index = "m-m4a4", nome = "M4-A4", type = "recarregar" },
	["wammo|WEAPON_CARBINERIFLE_MK2"] = { index = "m-m4a1", nome = "M4-A1", type = "recarregar" },
	["wammo|WEAPON_ADVANCEDRIFLE"] = { index = "m-aug", nome = "AUG-A3", type = "recarregar" },
	-- SMGs
	["wammo|WEAPON_SMG"] = { index = "m-mp5", nome = "MP5", type = "recarregar" },
	["wammo|WEAPON_COMBATPDW"] = { index = "m-mpx", nome = "MPX", type = "recarregar" },
	["wammo|WEAPON_MACHINEPISTOL"] = { index = "m-tec9", nome = "Tec-9", type = "recarregar" },
	["wammo|WEAPON_COMPACTRIFLE"] = { index = "m-ak74u", nome = "AK-74u", type = "recarregar" },
	-- SHOTGUNS
	["wammo|WEAPON_PUMPSHOTGUN"] = { index = "m-remington12", nome = "Secutor.12", type = "recarregar" },
	["wammo|WEAPON_PUMPSHOTGUN_MK2"] = { index = "m-remington45", nome = "Executor.45", type = "recarregar" },
	-- RIFLES DE CAÇA
	["wammo|WEAPON_MUSKET"] = { index = "m-winchester22", nome = "M.Winchester 22", type = "recarregar" }
}

function vRP.itemNameList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].nome
	end
end

function vRP.itemIndexList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].index
	end
end

function vRP.itemTypeList(item)
	if itemlist[item] ~= nil then
		return itemlist[item].type
	end
end

function vRP.itemBodyList(item)
	if itemlist[item] ~= nil then
		return itemlist[item]
	end
end

vRP.items = {}
function vRP.defInventoryItem(idname,name,weight)
	if weight == nil then
		weight = 0
	end
	local item = { name = name, weight = weight }
	vRP.items[idname] = item
end

function vRP.computeItemName(item,args)
	if type(item.name) == "string" then
		return item.name
	else
		return item.name(args)
	end
end

function vRP.computeItemWeight(item,args)
	if type(item.weight) == "number" then
		return item.weight
	else
		return item.weight(args)
	end
end

function vRP.parseItem(idname)
	return splitString(idname,"|")
end

function vRP.getItemDefinition(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemName(item,args),vRP.computeItemWeight(item,args)
	end
	return nil,nil
end

function vRP.getItemWeight(idname)
	local args = vRP.parseItem(idname)
	local item = vRP.items[args[1]]
	if item then
		return vRP.computeItemWeight(item,args)
	end
	return 0
end

function vRP.computeItemsWeight(items)
	local weight = 0
	for k,v in pairs(items) do
		local iweight = vRP.getItemWeight(k)
		weight = weight+iweight*v.amount
	end
	return weight
end

function vRP.giveInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		local entry = data.inventory[idname]
		if entry then
			entry.amount = entry.amount + amount
		else
			data.inventory[idname] = { amount = amount }
		end
	end
end

--local creative_itens = "https://discordapp.com/api/webhooks/604945979023687691/8XKL0ByvuyQxjnW5JtWVb8FdtDyPYa0mKcP2wcifM2LGzMGSHpFchQhD8-PAdYG-QfQq"

function vRP.tryGetInventoryItem(user_id,idname,amount)
	local amount = parseInt(amount)
	local data = vRP.getUserDataTable(user_id)
	if data and amount > 0 then
		--if idname == "tora" or idname == "carnedepuma" or idname == "etiqueta" then
			--creativeLogs(creative_itens,"**USER_ID:** "..user_id.." **ITEM:** "..idname.." - **QUANTIDADE:** "..parseInt(amount).." - "..os.date("%H:%M:%S"))
		--end
		local entry = data.inventory[idname]
		if entry and entry.amount >= amount then
			entry.amount = entry.amount - amount

			if entry.amount <= 0 then
				data.inventory[idname] = nil
			end
			return true
		end
	end
	return false
end

function vRP.getInventoryItemAmount(user_id,idname)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		local entry = data.inventory[idname]
		if entry then
			return entry.amount
		end
	end
	return 0
end

function vRP.getInventory(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data then
		return data.inventory
	end
end

function vRP.getInventoryWeight(user_id)
	local data = vRP.getUserDataTable(user_id)
	if data and data.inventory then
		return vRP.computeItemsWeight(data.inventory)
	end
	return 0
end

function vRP.getInventoryMaxWeight(user_id)
	return math.floor(vRP.expToLevel(vRP.getExp(user_id,"physical","strength")))*3
end

RegisterServerEvent("clearInventory")
AddEventHandler("clearInventory",function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local data = vRP.getUserDataTable(user_id)
        if data then
            data.inventory = {}
        end

        vRP.setMoney(user_id,0)
        vRPclient._clearWeapons(source)
        vRPclient._setHandcuffed(source,false)

        if not vRP.hasPermission(user_id,"mochila.permissao") then
            vRP.setExp(user_id,"physical","strength",20)
        end
    end
end)

AddEventHandler("vRP:playerJoin", function(user_id,source,name)
	local data = vRP.getUserDataTable(user_id)
	if not data.inventory then
		data.inventory = {}
	end
end)

local chests = {}
local function build_itemlist_menu(name,items,cb)
	local menu = { name = name }
	local kitems = {}

	local choose = function(player,choice)
		local idname = kitems[choice]
		if idname then
			cb(idname)
		end
	end

	for k,v in pairs(items) do 
		local name,weight = vRP.getItemDefinition(k)
		if name then
			kitems[name] = k
			menu[name] = { choose,"<text01>Quantidade:</text01> <text02>"..v.amount.."</text02><text01>Peso:</text01> <text02>"..string.format("%.2f",weight).."kg</text02>" }
		end
	end

	return menu
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local vehglobal = {
	-----------------------
	-- [ CARROS ] ---------
	-----------------------
	["blista"] = { ['name'] = "Blista", ['price'] = 22000, ['tipo'] = "carros", ['mala'] = 50 },
	["brioso"] = { ['name'] = "Brioso", ['price'] = 35000, ['tipo'] = "carros", ['mala'] = 50 },
	["emperor"] = { ['name'] = "Emperor", ['price'] = 7000, ['tipo'] = "carros", ["mala"] = 50 },
	["emperor2"] = { ['name'] = "Emperor 2", ['price'] = 50000, ['tipo'] = "carros", ["mala"] = 50 },
	["dilettante"] = { ['name'] = "Dilettante", ['price'] = 17000, ['tipo'] = "carros", ["mala"] = 50 },
	["issi2"] = { ['name'] = "Issi2", ['price'] = 90000, ['tipo'] = "carros", ["mala"] = 50 },
	["panto"] = { ['name'] = "Panto", ['price'] = 12000, ['tipo'] = "carros", ["mala"] = 50 },
	["prairie"] = { ['name'] = "Prairie", ['price'] = 27000, ['tipo'] = "carros", ["mala"] = 50 },
	["rhapsody"] = { ['name'] = "Rhapsody", ['price'] = 10000, ['tipo'] = "carros", ["mala"] = 50 },
	["cogcabrio"] = { ['name'] = "Cogcabrio", ['price'] = 130000, ['tipo'] = "carros", ["mala"] = 50 },
	["exemplar"] = { ['name'] = "Exemplar", ['price'] = 80000, ['tipo'] = "carros", ["mala"] = 50 },
	["f620"] = { ['name'] = "F620", ['price'] = 55000, ['tipo'] = "carros", ["mala"] = 50 },
	["felon"] = { ['name'] = "Felon", ['price'] = 70000, ['tipo'] = "carros", ["mala"] = 50 },
	["ingot"] = { ['name'] = "Ingot", ['price'] = 160000, ['tipo'] = "carros", ["mala"] = 50 },
	["jackal"] = { ['name'] = "Jackal", ['price'] = 60000, ['tipo'] = "carros", ["mala"] = 50 },
	["oracle"] = { ['name'] = "Oracle", ['price'] = 28000, ['tipo'] = "carros", ["mala"] = 50 },
	["oracle2"] = { ['name'] = "Oracle2", ['price'] = 80000, ['tipo'] = "carros", ["mala"] = 50 },
	["sentinel"] = { ['name'] = "Sentinel", ['price'] = 50000, ['tipo'] = "carros", ["mala"] = 50 },
	["sentinel2"] = { ['name'] = "Sentinel2", ['price'] = 60000, ['tipo'] = "carros", ["mala"] = 50 },
	["windsor"] = { ['name'] = "Windsor", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["windsor2"] = { ['name'] = "Windsor2", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["zion"] = { ['name'] = "Zion", ['price'] = 50000, ['tipo'] = "carros", ["mala"] = 50 },
	["zion2"] = { ['name'] = "Zion2", ['price'] = 60000, ['tipo'] = "carros", ["mala"] = 50 },
	["blade"] = { ['name'] = "Blade", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["buccaneer"] = { ['name'] = "Buccaneer", ['price'] = 130000, ['tipo'] = "carros", ["mala"] = 50 },
	["buccaneer2"] = { ['name'] = "Buccaneer2", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["primo"] = { ['name'] = "Primo", ['price'] = 9500, ['tipo'] = "carros", ["mala"] = 50 },
	["chino"] = { ['name'] = "Chino", ['price'] = 130000, ['tipo'] = "carros", ["mala"] = 50 },
	["coquette3"] = { ['name'] = "Coquette3", ['price'] = 195000, ['tipo'] = "carros", ["mala"] = 50 },
	["dukes"] = { ['name'] = "Dukes", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["faction"] = { ['name'] = "Faction", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["faction3"] = { ['name'] = "Faction3", ['price'] = 350000, ['tipo'] = "carros", ["mala"] = 50 },
	["gauntlet"] = { ['name'] = "Gauntlet", ['price'] = 165000, ['tipo'] = "carros", ["mala"] = 50 },
	["gauntlet2"] = { ['name'] = "Gauntlet2", ['price'] = 165000, ['tipo'] = "carros", ["mala"] = 50 },
	["hermes"] = { ['name'] = "Hermes", ['price'] = 280000, ['tipo'] = "carros", ["mala"] = 50 },
	["hotknife"] = { ['name'] = "Hotknife", ['price'] = 180000, ['tipo'] = "carros", ["mala"] = 50 },
	["moonbeam"] = { ['name'] = "Moonbeam", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["moonbeam2"] = { ['name'] = "Moonbeam2", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["nightshade"] = { ['name'] = "Nightshade", ['price'] = 270000, ['tipo'] = "carros", ["mala"] = 50 },
	["picador"] = { ['name'] = "Picador", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["ruiner"] = { ['name'] = "Ruiner", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["sabregt"] = { ['name'] = "Sabregt", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["sabregt2"] = { ['name'] = "Sabregt2", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["slamvan"] = { ['name'] = "Slamvan", ['price'] = 180000, ['tipo'] = "carros", ["mala"] = 50 },
	["slamvan3"] = { ['name'] = "Slamvan3", ['price'] = 230000, ['tipo'] = "carros", ["mala"] = 50 },
	["stalion"] = { ['name'] = "Stalion", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["stalion2"] = { ['name'] = "Stalion2", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["tampa"] = { ['name'] = "Tampa", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["vigero"] = { ['name'] = "Vigero", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["virgo"] = { ['name'] = "Virgo", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["virgo2"] = { ['name'] = "Virgo2", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["virgo3"] = { ['name'] = "Virgo3", ['price'] = 180000, ['tipo'] = "carros", ["mala"] = 50 },
	["voodoo"] = { ['name'] = "Voodoo", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["voodoo2"] = { ['name'] = "Voodoo2", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["yosemite"] = { ['name'] = "Yosemite", ['price'] = 350000, ['tipo'] = "carros", ["mala"] = 50 },
	["bfinjection"] = { ['name'] = "Bfinjection", ['price'] = 80000, ['tipo'] = "carros", ["mala"] = 50 },
	["bifta"] = { ['name'] = "Bifta", ['price'] = 190000, ['tipo'] = "carros", ["mala"] = 50 },
	["bodhi2"] = { ['name'] = "Bodhi2", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["brawler"] = { ['name'] = "Brawler", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["trophytruck"] = { ['name'] = "Trophytruck", ['price'] = 400000, ['tipo'] = "carros", ["mala"] = 50 },
	["trophytruck2"] = { ['name'] = "Trophytruck2", ['price'] = 400000, ['tipo'] = "carros", ["mala"] = 50 },
	["dubsta3"] = { ['name'] = "Dubsta3", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["mesa3"] = { ['name'] = "Mesa3", ['price'] = 200000, ['tipo'] = "carros", ["mala"] = 50 },
	["rancherxl"] = { ['name'] = "Rancherxl", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["rebel2"] = { ['name'] = "Rebel2", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["riata"] = { ['name'] = "Riata", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["dloader"] = { ['name'] = "Dloader", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["sandking"] = { ['name'] = "Sandking", ['price'] = 400000, ['tipo'] = "carros", ["mala"] = 50 },
	["sandking2"] = { ['name'] = "Sandking2", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["baller"] = { ['name'] = "Baller", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["baller2"] = { ['name'] = "Baller2", ['price'] = 160000, ['tipo'] = "carros", ["mala"] = 50 },
	["baller3"] = { ['name'] = "Baller3", ['price'] = 175000, ['tipo'] = "carros", ["mala"] = 50 },
	["baller4"] = { ['name'] = "Baller4", ['price'] = 185000, ['tipo'] = "carros", ["mala"] = 50 },
	["baller5"] = { ['name'] = "Baller5", ['price'] = 270000, ['tipo'] = "carros", ["mala"] = 50 },
	["baller6"] = { ['name'] = "Baller6", ['price'] = 280000, ['tipo'] = "carros", ["mala"] = 50 },
	["bjxl"] = { ['name'] = "Bjxl", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["cavalcade"] = { ['name'] = "Cavalcade", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["cavalcade2"] = { ['name'] = "Cavalcade2", ['price'] = 130000, ['tipo'] = "carros", ["mala"] = 50 },
	["contender"] = { ['name'] = "Contender", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["dubsta"] = { ['name'] = "Dubsta", ['price'] = 210000, ['tipo'] = "carros", ["mala"] = 50 },
	["dubsta2"] = { ['name'] = "Dubsta2", ['price'] = 240000, ['tipo'] = "carros", ["mala"] = 50 },
	["fq2"] = { ['name'] = "Fq2", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["granger"] = { ['name'] = "Granger", ['price'] = 345000, ['tipo'] = "carros", ["mala"] = 50 },
	["gresley"] = { ['name'] = "Gresley", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["habanero"] = { ['name'] = "Habanero", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["seminole"] = { ['name'] = "Seminole", ['price'] = 49000, ['tipo'] = "carros", ["mala"] = 50 },
	["serrano"] = { ['name'] = "Serrano", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["xls"] = { ['name'] = "Xls", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["xls2"] = { ['name'] = "Xls2", ['price'] = 350000, ['tipo'] = "carros", ["mala"] = 50 },
	["asea"] = { ['name'] = "Asea", ['price'] = 32000, ['tipo'] = "carros", ["mala"] = 50 },
	["asterope"] = { ['name'] = "Asterope", ['price'] = 49000, ['tipo'] = "carros", ["mala"] = 50 },
	["cog552"] = { ['name'] = "Cog552", ['price'] = 400000, ['tipo'] = "carros", ["mala"] = 50 },
	["cognoscenti"] = { ['name'] = "Cognoscenti", ['price'] = 280000, ['tipo'] = "carros", ["mala"] = 50 },
	["cognoscenti2"] = { ['name'] = "Cognoscenti2", ['price'] = 400000, ['tipo'] = "carros", ["mala"] = 50 },
	["stanier"] = { ['name'] = "Stanier", ['price'] = 18000, ['tipo'] = "carros", ["mala"] = 50 },
	["stratum"] = { ['name'] = "Stratum", ['price'] = 90000, ['tipo'] = "carros", ["mala"] = 50 },
	["surge"] = { ['name'] = "Surge", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["tailgater"] = { ['name'] = "Tailgater", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["warrener"] = { ['name'] = "Warrener", ['price'] = 90000, ['tipo'] = "carros", ["mala"] = 50 },
	["washington"] = { ['name'] = "Washington", ['price'] = 130000, ['tipo'] = "carros", ["mala"] = 50 },
	["alpha"] = { ['name'] = "Alpha", ['price'] = 230000, ['tipo'] = "carros", ["mala"] = 50 },
	["banshee"] = { ['name'] = "Banshee", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["bestiagts"] = { ['name'] = "Bestiagts", ['price'] = 290000, ['tipo'] = "carros", ["mala"] = 50 },
	["blista2"] = { ['name'] = "Blista2", ['price'] = 55000, ['tipo'] = "carros", ["mala"] = 50 },
	["blista3"] = { ['name'] = "Blista3", ['price'] = 80000, ['tipo'] = "carros", ["mala"] = 50 },
	["buffalo"] = { ['name'] = "Buffalo", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["buffalo2"] = { ['name'] = "Buffalo2", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["buffalo3"] = { ['name'] = "Buffalo3", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["carbonizzare"] = { ['name'] = "Carbonizzare", ['price'] = 290000, ['tipo'] = "carros", ["mala"] = 50 },
	["comet2"] = { ['name'] = "Comet2", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["comet3"] = { ['name'] = "Comet3", ['price'] = 290000, ['tipo'] = "carros", ["mala"] = 50 },
	["comet5"] = { ['name'] = "Comet5", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["coquette"] = { ['name'] = "Coquette", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["elegy"] = { ['name'] = "Elegy", ['price'] = 350000, ['tipo'] = "carros", ["mala"] = 50 },
	["elegy2"] = { ['name'] = "Elegy2", ['price'] = 355000, ['tipo'] = "carros", ["mala"] = 50 },
	["feltzer2"] = { ['name'] = "Feltzer2", ['price'] = 255000, ['tipo'] = "carros", ["mala"] = 50 },
	["furoregt"] = { ['name'] = "Furoregt", ['price'] = 290000, ['tipo'] = "carros", ["mala"] = 50 },
	["fusilade"] = { ['name'] = "Fusilade", ['price'] = 210000, ['tipo'] = "carros", ["mala"] = 50 },
	["futo"] = { ['name'] = "Futo", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["jester"] = { ['name'] = "Jester", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["khamelion"] = { ['name'] = "Khamelion", ['price'] = 210000, ['tipo'] = "carros", ["mala"] = 50 },
	["kuruma"] = { ['name'] = "Kuruma", ['price'] = 330000, ['tipo'] = "carros", ["mala"] = 50 },
	["massacro"] = { ['name'] = "Massacro", ['price'] = 330000, ['tipo'] = "carros", ["mala"] = 50 },
	["massacro2"] = { ['name'] = "Massacro2", ['price'] = 330000, ['tipo'] = "carros", ["mala"] = 50 },
	["ninef"] = { ['name'] = "Ninef", ['price'] = 290000, ['tipo'] = "carros", ["mala"] = 50 },
	["ninef2"] = { ['name'] = "Ninef2", ['price'] = 290000, ['tipo'] = "carros", ["mala"] = 50 },
	["omnis"] = { ['name'] = "Omnis", ['price'] = 240000, ['tipo'] = "carros", ["mala"] = 50 },
	["pariah"] = { ['name'] = "Pariah", ['price'] = 500000, ['tipo'] = "carros", ["mala"] = 50 },
	["penumbra"] = { ['name'] = "Penumbra", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["raiden"] = { ['name'] = "Raiden", ['price'] = 240000, ['tipo'] = "carros", ["mala"] = 50 },
	["rapidgt"] = { ['name'] = "Rapidgt", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["rapidgt2"] = { ['name'] = "Rapidgt2", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["ruston"] = { ['name'] = "Ruston", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["schafter3"] = { ['name'] = "Schafter3", ['price'] = 275000, ['tipo'] = "carros", ["mala"] = 50 },
	["schafter4"] = { ['name'] = "Schafter4", ['price'] = 275000, ['tipo'] = "carros", ["mala"] = 50 },
	["schafter5"] = { ['name'] = "Schafter5", ['price'] = 275000, ['tipo'] = "carros", ["mala"] = 50 },
	["schwarzer"] = { ['name'] = "Schwarzer", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["sentinel3"] = { ['name'] = "Sentinel3", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["seven70"] = { ['name'] = "Seven70", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["specter"] = { ['name'] = "Specter", ['price'] = 320000, ['tipo'] = "carros", ["mala"] = 50 },
	["specter2"] = { ['name'] = "Specter2", ['price'] = 355000, ['tipo'] = "carros", ["mala"] = 50 },
	["streiter"] = { ['name'] = "Streiter", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["sultan"] = { ['name'] = "Sultan", ['price'] = 210000, ['tipo'] = "carros", ["mala"] = 50 },
	["surano"] = { ['name'] = "Surano", ['price'] = 310000, ['tipo'] = "carros", ["mala"] = 50 },
	["tampa2"] = { ['name'] = "Tampa2", ['price'] = 200000, ['tipo'] = "carros", ["mala"] = 50 },
	["tropos"] = { ['name'] = "Tropos", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["verlierer2"] = { ['name'] = "Verlierer2", ['price'] = 380000, ['tipo'] = "carros", ["mala"] = 50 },
	["btype2"] = { ['name'] = "Btype2", ['price'] = 460000, ['tipo'] = "carros", ["mala"] = 50 },
	["btype3"] = { ['name'] = "Btype3", ['price'] = 390000, ['tipo'] = "carros", ["mala"] = 50 },
	["casco"] = { ['name'] = "Casco", ['price'] = 355000, ['tipo'] = "carros", ["mala"] = 50 },
	["cheetah"] = { ['name'] = "Cheetah", ['price'] = 425000, ['tipo'] = "carros", ["mala"] = 50 },
	["coquette2"] = { ['name'] = "Coquette2", ['price'] = 285000, ['tipo'] = "carros", ["mala"] = 50 },
	["feltzer3"] = { ['name'] = "Feltzer3", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["gt500"] = { ['name'] = "Gt500", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["infernus2"] = { ['name'] = "Infernus2", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["jb700"] = { ['name'] = "Jb700", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["mamba"] = { ['name'] = "Mamba", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["manana"] = { ['name'] = "Manana", ['price'] = 130000, ['tipo'] = "carros", ["mala"] = 50 },
	["monroe"] = { ['name'] = "Monroe", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["peyote"] = { ['name'] = "Peyote", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["pigalle"] = { ['name'] = "Pigalle", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["rapidgt3"] = { ['name'] = "Rapidgt3", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["retinue"] = { ['name'] = "Retinue", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["stinger"] = { ['name'] = "Stinger", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["stingergt"] = { ['name'] = "Stingergt", ['price'] = 230000, ['tipo'] = "carros", ["mala"] = 50 },
	["torero"] = { ['name'] = "Torero", ['price'] = 160000, ['tipo'] = "carros", ["mala"] = 50 },
	["tornado"] = { ['name'] = "Tornado", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["tornado2"] = { ['name'] = "Tornado2", ['price'] = 160000, ['tipo'] = "carros", ["mala"] = 50 },
	["tornado6"] = { ['name'] = "Tornado6", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["turismo2"] = { ['name'] = "Turismo2", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["ztype"] = { ['name'] = "Ztype", ['price'] = 400000, ['tipo'] = "carros", ["mala"] = 50 },
	["adder"] = { ['name'] = "Adder", ['price'] = 620000, ['tipo'] = "carros", ["mala"] = 50 },
	["autarch"] = { ['name'] = "Autarch", ['price'] = 760000, ['tipo'] = "carros", ["mala"] = 50 },
	["banshee2"] = { ['name'] = "Banshee2", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["bullet"] = { ['name'] = "Bullet", ['price'] = 400000, ['tipo'] = "carros", ["mala"] = 50 },
	["cheetah2"] = { ['name'] = "Cheetah2", ['price'] = 240000, ['tipo'] = "carros", ["mala"] = 50 },
	["entityxf"] = { ['name'] = "Entityxf", ['price'] = 460000, ['tipo'] = "carros", ["mala"] = 50 },
	["fmj"] = { ['name'] = "Fmj", ['price'] = 520000, ['tipo'] = "carros", ["mala"] = 50 },
	["gp1"] = { ['name'] = "Gp1", ['price'] = 495000, ['tipo'] = "carros", ["mala"] = 50 },
	["infernus"] = { ['name'] = "Infernus", ['price'] = 470000, ['tipo'] = "carros", ["mala"] = 50 },
	["nero"] = { ['name'] = "Nero", ['price'] = 450000, ['tipo'] = "carros", ["mala"] = 50 },
	["nero2"] = { ['name'] = "Nero2", ['price'] = 480000, ['tipo'] = "carros", ["mala"] = 50 },
	["osiris"] = { ['name'] = "Osiris", ['price'] = 460000, ['tipo'] = "carros", ["mala"] = 50 },
	["penetrator"] = { ['name'] = "Penetrator", ['price'] = 480000, ['tipo'] = "carros", ["mala"] = 50 },
	["pfister811"] = { ['name'] = "Pfister811", ['price'] = 530000, ['tipo'] = "carros", ["mala"] = 50 },
	["reaper"] = { ['name'] = "Reaper", ['price'] = 620000, ['tipo'] = "carros", ["mala"] = 50 },
	["sc1"] = { ['name'] = "Sc1", ['price'] = 495000, ['tipo'] = "carros", ["mala"] = 50 },
	["sultanrs"] = { ['name'] = "Sultan RS", ['price'] = 450000, ['tipo'] = "carros", ["mala"] = 50 },
	["t20"] = { ['name'] = "T20", ['price'] = 670000, ['tipo'] = "carros", ["mala"] = 50 },
	["tempesta"] = { ['name'] = "Tempesta", ['price'] = 600000, ['tipo'] = "carros", ["mala"] = 50 },
	["turismor"] = { ['name'] = "Turismor", ['price'] = 620000, ['tipo'] = "carros", ["mala"] = 50 },
	["tyrus"] = { ['name'] = "Tyrus", ['price'] = 620000, ['tipo'] = "carros", ["mala"] = 50 },
	["vacca"] = { ['name'] = "Vacca", ['price'] = 620000, ['tipo'] = "carros", ["mala"] = 50 },
	["visione"] = { ['name'] = "Visione", ['price'] = 690000, ['tipo'] = "carros", ["mala"] = 50 },
	["voltic"] = { ['name'] = "Voltic", ['price'] = 440000, ['tipo'] = "carros", ["mala"] = 50 },
	["zentorno"] = { ['name'] = "Zentorno", ['price'] = 920000, ['tipo'] = "carros", ["mala"] = 50 },
	["sadler"] = { ['name'] = "Sadler", ['price'] = 180000, ['tipo'] = "carros", ["mala"] = 50 },
	["bison"] = { ['name'] = "Bison", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["bison2"] = { ['name'] = "Bison2", ['price'] = 180000, ['tipo'] = "carros", ["mala"] = 50 },
	["bobcatxl"] = { ['name'] = "Bobcatxl", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["burrito"] = { ['name'] = "Burrito", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["burrito2"] = { ['name'] = "Burrito2", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["burrito3"] = { ['name'] = "Burrito3", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["burrito4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["mule4"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["rallytruck"] = { ['name'] = "Burrito4", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["minivan"] = { ['name'] = "Minivan", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["minivan2"] = { ['name'] = "Minivan2", ['price'] = 220000, ['tipo'] = "carros", ["mala"] = 50 },
	["paradise"] = { ['name'] = "Paradise", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["pony"] = { ['name'] = "Pony", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["pony2"] = { ['name'] = "Pony2", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["rumpo"] = { ['name'] = "Rumpo", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["rumpo2"] = { ['name'] = "Rumpo2", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["rumpo3"] = { ['name'] = "Rumpo3", ['price'] = 350000, ['tipo'] = "carros", ["mala"] = 50 },
	["surfer"] = { ['name'] = "Surfer", ['price'] = 55000, ['tipo'] = "carros", ["mala"] = 50 },
	["youga"] = { ['name'] = "Youga", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 50 },
	["huntley"] = { ['name'] = "Huntley", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["landstalker"] = { ['name'] = "Landstalker", ['price'] = 130000, ['tipo'] = "carros", ["mala"] = 50 },
	["mesa"] = { ['name'] = "Mesa", ['price'] = 90000, ['tipo'] = "carros", ["mala"] = 50 },
	["patriot"] = { ['name'] = "Patriot", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["radi"] = { ['name'] = "Radi", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["rocoto"] = { ['name'] = "Rocoto", ['price'] = 110000, ['tipo'] = "carros", ["mala"] = 50 },
	["tyrant"] = { ['name'] = "Tyrant", ['price'] = 690000, ['tipo'] = "carros", ["mala"] = 50 },
	["entity2"] = { ['name'] = "Entity2", ['price'] = 550000, ['tipo'] = "carros", ["mala"] = 50 },
	["cheburek"] = { ['name'] = "Cheburek", ['price'] = 170000, ['tipo'] = "carros", ["mala"] = 50 },
	["hotring"] = { ['name'] = "Hotring", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["jester3"] = { ['name'] = "Jester3", ['price'] = 345000, ['tipo'] = "carros", ["mala"] = 50 },
	["flashgt"] = { ['name'] = "Flashgt", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["ellie"] = { ['name'] = "Ellie", ['price'] = 320000, ['tipo'] = "carros", ["mala"] = 50 },
	["michelli"] = { ['name'] = "Michelli", ['price'] = 160000, ['tipo'] = "carros", ["mala"] = 50 },
	["fagaloa"] = { ['name'] = "Fagaloa", ['price'] = 320000, ['tipo'] = "carros", ["mala"] = 50 },
	["dominator"] = { ['name'] = "Dominator", ['price'] = 230000, ['tipo'] = "carros", ["mala"] = 50 },
	["dominator2"] = { ['name'] = "Dominator2", ['price'] = 230000, ['tipo'] = "carros", ["mala"] = 50 },
	["dominator3"] = { ['name'] = "Dominator3", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["issi3"] = { ['name'] = "Issi3", ['price'] = 190000, ['tipo'] = "carros", ["mala"] = 50 },
	["taipan"] = { ['name'] = "Taipan", ['price'] = 620000, ['tipo'] = "carros", ["mala"] = 50 },
	["gb200"] = { ['name'] = "Gb200", ['price'] = 195000, ['tipo'] = "carros", ["mala"] = 50 },
	["stretch"] = { ['name'] = "Stretch", ['price'] = 520000, ['tipo'] = "carros", ["mala"] = 50 },
	["guardian"] = { ['name'] = "Guardian", ['price'] = 540000, ['tipo'] = "carros", ["mala"] = 50 },
	["kamacho"] = { ['name'] = "Kamacho", ['price'] = 460000, ['tipo'] = "carros", ["mala"] = 50 },
	["neon"] = { ['name'] = "Neon", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["cyclone"] = { ['name'] = "Cyclone", ['price'] = 920000, ['tipo'] = "carros", ["mala"] = 50 },
	["italigtb"] = { ['name'] = "Italigtb", ['price'] = 600000, ['tipo'] = "carros", ["mala"] = 50 },
	["italigtb2"] = { ['name'] = "Italigtb2", ['price'] = 610000, ['tipo'] = "carros", ["mala"] = 50 },
	["vagner"] = { ['name'] = "Vagner", ['price'] = 680000, ['tipo'] = "carros", ["mala"] = 50 },
	["xa21"] = { ['name'] = "Xa21", ['price'] = 630000, ['tipo'] = "carros", ['mala'] = 50 },
	["tezeract"] = { ['name'] = "Tezeract", ['price'] = 920000, ['tipo'] = "carros", ["mala"] = 50 },
	["prototipo"] = { ['name'] = "Prototipo", ['price'] = 1030000, ['tipo'] = "carros", ["mala"] = 50 },
	["patriot2"] = { ['name'] = "Patriot2", ['price'] = 550000, ['tipo'] = "carros", ["mala"] = 50 },
	["swinger"] = { ['name'] = "Swinger", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["clique"] = { ['name'] = "Clique", ['price'] = 360000, ['tipo'] = "carros", ["mala"] = 50 },
	["deveste"] = { ['name'] = "Deveste", ['price'] = 920000, ['tipo'] = "carros", ["mala"] = 50 },
	["deviant"] = { ['name'] = "Deviant", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["impaler"] = { ['name'] = "Impaler", ['price'] = 320000, ['tipo'] = "carros", ["mala"] = 50 },
	["italigto"] = { ['name'] = "Italigto", ['price'] = 800000, ['tipo'] = "carros", ["mala"] = 50 },
	["schlagen"] = { ['name'] = "Schlagen", ['price'] = 690000, ['tipo'] = "carros", ["mala"] = 50 },
	["toros"] = { ['name'] = "Toros", ['price'] = 520000, ['tipo'] = "carros", ["mala"] = 50 },
	["tulip"] = { ['name'] = "Tulip", ['price'] = 320000, ['tipo'] = "carros", ["mala"] = 50 },
	["vamos"] = { ['name'] = "Vamos", ['price'] = 320000, ['tipo'] = "carros", ["mala"] = 50 },
	["freecrawler"] = { ['name'] = "Freecrawler", ['price'] = 350000, ['tipo'] = "carros", ["mala"] = 50 },
	["fugitive"] = { ['name'] = "Fugitive", ['price'] = 50000, ['tipo'] = "carros", ["mala"] = 50 },
	["glendale"] = { ['name'] = "Glendale", ['price'] = 70000, ['tipo'] = "carros", ["mala"] = 50 },
	["intruder"] = { ['name'] = "Intruder", ['price'] = 11000, ['tipo'] = "carros", ["mala"] = 50 },
	["le7b"] = { ['name'] = "Le7b", ['price'] = 700000, ['tipo'] = "carros", ["mala"] = 50 },
	["lurcher"] = { ['name'] = "Lurcher", ['price'] = 150000, ['tipo'] = "carros", ["mala"] = 50 },
	["lynx"] = { ['name'] = "Lynx", ['price'] = 370000, ['tipo'] = "carros", ["mala"] = 50 },
	["phoenix"] = { ['name'] = "Phoenix", ['price'] = 250000, ['tipo'] = "carros", ["mala"] = 50 },
	["premier"] = { ['name'] = "Premier", ['price'] = 37000, ['tipo'] = "carros", ["mala"] = 50 },
	["raptor"] = { ['name'] = "Raptor", ['price'] = 300000, ['tipo'] = "carros", ["mala"] = 50 },
	["sheava"] = { ['name'] = "Sheava", ['price'] = 700000, ['tipo'] = "carros", ["mala"] = 50 },
	["z190"] = { ['name'] = "Z190", ['price'] = 350000, ['tipo'] = "carros", ["mala"] = 50 },

	-----------------------
	-- [ BIKES ] ----------
	-----------------------
	
	["akuma"] = { ['name'] = "Akuma", ['price'] = 500000, ['tipo'] = "motos", ["mala"] = 10 },
	["avarus"] = { ['name'] = "Avarus", ['price'] = 440000, ['tipo'] = "motos", ["mala"] = 10 },
	["bagger"] = { ['name'] = "Bagger", ['price'] = 300000, ['tipo'] = "motos", ["mala"] = 10 },
	["bati"] = { ['name'] = "Bati", ['price'] = 370000, ['tipo'] = "motos", ["mala"] = 10 },
	["bati2"] = { ['name'] = "Bati2", ['price'] = 300000, ['tipo'] = "motos", ["mala"] = 10 },
	["bf400"] = { ['name'] = "Bf400", ['price'] = 320000, ['tipo'] = "motos", ["mala"] = 10 },
	["carbonrs"] = { ['name'] = "Carbonrs", ['price'] = 370000, ['tipo'] = "motos", ["mala"] = 10 },
	["chimera"] = { ['name'] = "Chimera", ['price'] = 345000, ['tipo'] = "motos", ["mala"] = 10 },
	["cliffhanger"] = { ['name'] = "Cliffhanger", ['price'] = 310000, ['tipo'] = "motos", ["mala"] = 10 },
	["daemon2"]  = { ['name'] = "Daemon2", ['price'] = 240000, ['tipo'] = "motos", ["mala"] = 10 },
	["defiler"] = { ['name'] = "Defiler", ['price'] = 460000, ['tipo'] = "motos", ["mala"] = 10 },
	["diablous"] = { ['name'] = "Diablous", ['price'] = 430000, ['tipo'] = "motos", ["mala"] = 10 },
	["diablous2"] = { ['name'] = "Diablous2", ['price'] = 460000, ['tipo'] = "motos", ["mala"] = 10 },
	["double"] = { ['name'] = "Double", ['price'] = 370000, ['tipo'] = "motos", ["mala"] = 10 },
	["enduro"] = { ['name'] = "Enduro", ['price'] = 28000, ['tipo'] = "motos", ["mala"] = 10 },
	["esskey"] = { ['name'] = "Esskey", ['price'] = 320000, ['tipo'] = "motos", ["mala"] = 10 },
	["faggio"] = { ['name'] = "Faggio", ['price'] = 5000, ['tipo'] = "motos", ["mala"] = 10 },
	["faggio2"] = { ['name'] = "Faggio2", ['price'] = 5000, ['tipo'] = "motos", ["mala"] = 10 },
	["faggio3"] = { ['name'] = "Faggio3", ['price'] = 5000, ['tipo'] = "motos", ["mala"] = 10 },
	["fcr"] = { ['name'] = "Fcr", ['price'] = 390000, ['tipo'] = "motos", ["mala"] = 10 },
	["fcr2"] = { ['name'] = "Fcr2", ['price'] = 390000, ['tipo'] = "motos", ["mala"] = 10 },
	["gargoyle"] = { ['name'] = "Gargoyle", ['price'] = 345000, ['tipo'] = "motos", ["mala"] = 10 },
	["hakuchou"] = { ['name'] = "Hakuchou", ['price'] = 380000, ['tipo'] = "motos", ["mala"] = 10 },
	["hakuchou2"] = { ['name'] = "Hakuchou2", ['price'] = 550000, ['tipo'] = "motos", ["mala"] = 10 },
	["hexer"] = { ['name'] = "Hexer", ['price'] = 250000, ['tipo'] = "motos", ["mala"] = 10 },
	["innovation"] = { ['name'] = "Innovation", ['price'] = 250000, ['tipo'] = "motos", ["mala"] = 10 },
	["lectro"] = { ['name'] = "Lectro", ['price'] = 380000, ['tipo'] = "motos", ["mala"] = 10 },
	["manchez"] = { ['name'] = "Manchez", ['price'] = 355000, ['tipo'] = "motos", ["mala"] = 10 },
	["nemesis"] = { ['name'] = "Nemesis", ['price'] = 345000, ['tipo'] = "motos", ["mala"] = 10 },
	["nightblade"] = { ['name'] = "Nightblade", ['price'] = 415000, ['tipo'] = "motos", ["mala"] = 10 },
	["pcj"] = { ['name'] = "Pcj", ['price'] = 32000, ['tipo'] = "motos", ["mala"] = 10 },
	["ruffian"] = { ['name'] = "Ruffian", ['price'] = 345000, ['tipo'] = "motos", ["mala"] = 10 },
	["sanchez"] = { ['name'] = "Sanchez", ['price'] = 185000, ['tipo'] = "motos", ["mala"] = 10 },
	["sanchez2"] = { ['name'] = "Sanchez2", ['price'] = 185000, ['tipo'] = "motos", ["mala"] = 10 },
	["sovereign"] = { ['name'] = "Sovereign", ['price'] = 285000, ['tipo'] = "motos", ["mala"] = 10 },
	["thrust"] = { ['name'] = "Thrust", ['price'] = 375000, ['tipo'] = "motos", ["mala"] = 10 },
	["vader"] = { ['name'] = "Vader", ['price'] = 345000, ['tipo'] = "motos", ["mala"] = 10 },
	["vindicator"] = { ['name'] = "Vindicator", ['price'] = 340000, ['tipo'] = "motos", ["mala"] = 10 },
	["vortex"] = { ['name'] = "Vortex", ['price'] = 375000, ['tipo'] = "motos", ["mala"] = 10 },
	["wolfsbane"] = { ['name'] = "Wolfsbane", ['price'] = 290000, ['tipo'] = "motos", ["mala"] = 10 },
	["zombiea"] = { ['name'] = "Zombiea", ['price'] = 290000, ['tipo'] = "motos", ["mala"] = 10 },
	["zombieb"] = { ['name'] = "Zombieb", ['price'] = 300000, ['tipo'] = "motos", ["mala"] = 10 },
	["shotaro"] = { ['name'] = "Shotaro", ['price'] = 1000000, ['tipo'] = "motos", ["mala"] = 10 },
	["ratbike"] = { ['name'] = "Ratbike", ['price'] = 230000, ['tipo'] = "motos", ["mala"] = 10 },
	["blazer"] = { ['name'] = "Blazer", ['price'] = 230000, ['tipo'] = "motos", ["mala"] = 10 },
	["blazer4"] = { ['name'] = "Blazer4", ['price'] = 370000, ['tipo'] = "motos", ["mala"] = 10 },

	-----------------------
	-- [ WORK VEHICLES ] --
	-----------------------
	
	-- [ LSPD ] --
	["pbus"] = { ['name'] = "Echo", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 80 },
	["policiaheli"] = { ['name'] = "Delta", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 40 },
	["policiabmwr1200"] = { ['name'] = "BMW R1200", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 10 },
	["14charger"] = { ['name'] = "D. Charger 2014", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 30 },
	["14explorer"] = { ['name'] = "F. Explorer 2014", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 60 },
	["18charger"] = { ['name'] = "D. Charger 2018", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 30 },
	["20explorer"] = { ['name'] = "F. Explorer 2020", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 60 },
	["2019tahoe"] = { ['name'] = "C. Tahoe 2019", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 80 },
	["vic"] = { ['name'] = "C. Victoria 2006", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 35 },
	["taurus"] = { ['name'] = "F. Taurus 2016", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 40 },
	["mustang19"] = { ['name'] = "F. Mustang 2019", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 15 },
	["camaro19"] = { ['name'] = "C. Camaro 2020", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 15 },

	-- [ EMS ] --
	["paramedicoambu"] = { ['name'] = "EMS Ambulância", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 80 },
	["paramedicoheli"] = { ['name'] = "EMS Helicoptero", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 40 },
	["amr_explorer"] = { ['name'] = "F. Explorer 2016", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 60 },
	["amr_tahoe"] = { ['name'] = "C. Tahoe 2020", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 80 },
	-- [ RANDOM WORKS ] --
	["coach"] = { ['name'] = "Coach", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["bus"] = { ['name'] = "Ônibus", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["flatbed"] = { ['name'] = "Reboque", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["towtruck"] = { ['name'] = "Towtruck", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["towtruck2"] = { ['name'] = "Towtruck2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["ratloader"] = { ['name'] = "RatLoader", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["ratloader2"] = { ['name'] = "Ratloader2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["rubble"] = { ['name'] = "Rubble", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["taxi"] = { ['name'] = "Taxi", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["boxville2"] = { ['name'] = "Boxville2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["boxville4"] = { ['name'] = "Boxville4", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["youga2"] = { ['name'] = "Youga2", ['price'] = 260000, ['tipo'] = "carros", ["mala"] = 0 },
	["trash2"] = { ['name'] = "Trash", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tiptruck"] = { ['name'] = "Tiptruck", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 60 },
	["scorcher"] = { ['name'] = "Scorcher", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tribike"] = { ['name'] = "Tribike", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tribike2"] = { ['name'] = "Tribike2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tribike3"] = { ['name'] = "Tribike3", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["fixter"] = { ['name'] = "Fixter", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["cruiser"] = { ['name'] = "Cruiser", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["bmx"] = { ['name'] = "Bmx", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["dinghy"] = { ['name'] = "Dinghy", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["jetmax"] = { ['name'] = "Jetmax", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["marquis"] = { ['name'] = "Marquis", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["seashark3"] = { ['name'] = "Seashark3", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["speeder"] = { ['name'] = "Speeder", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["speeder2"] = { ['name'] = "Speeder2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["squalo"] = { ['name'] = "Squalo", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["suntrap"] = { ['name'] = "Suntrap", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["toro"] = { ['name'] = "Toro", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["toro2"] = { ['name'] = "Toro2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tropic"] = { ['name'] = "Tropic", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tropic2"] = { ['name'] = "Tropic2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["phantom"] = { ['name'] = "Phantom", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["packer"] = { ['name'] = "Packer", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["supervolito"] = { ['name'] = "Supervolito", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["supervolito2"] = { ['name'] = "Supervolito2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["cuban800"] = { ['name'] = "Cuban800", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["mammatus"] = { ['name'] = "Mammatus", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["vestra"] = { ['name'] = "Vestra", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["velum2"] = { ['name'] = "Velum2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["buzzard2"] = { ['name'] = "Buzzard2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["frogger"] = { ['name'] = "Frogger", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["maverick"] = { ['name'] = "Maverick", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tanker2"] = { ['name'] = "Gas", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["armytanker"] = { ['name'] = "Diesel", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tvtrailer"] = { ['name'] = "Show", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["trailerlogs"] = { ['name'] = "Woods", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["tr4"] = { ['name'] = "Cars", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["speedo"] = { ['name'] = "Speedo", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["primo2"] = { ['name'] = "Primo2", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["faction2"] = { ['name'] = "Faction2", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["chino2"] = { ['name'] = "Chino2", ['price'] = 200000, ['tipo'] = "work", ["mala"] =10 },
	["tornado5"] = { ['name'] = "Tornado5", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["daemon"] = { ['name'] = "Daemon", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["sanctus"] = { ['name'] = "Sanctus", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["gburrito"] = { ['name'] = "GBurrito", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["slamvan2"] = { ['name'] = "Slamvan2", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["stafford"] = { ['name'] = "Stafford", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["cog55"] = { ['name'] = "Cog55", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["superd"] = { ['name'] = "Superd", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["btype"] = { ['name'] = "Btype", ['price'] = 200000, ['tipo'] = "work", ["mala"] = 0 },
	["tractor2"] = { ['name'] = "Tractor2", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["rebel"] = { ['name'] = "Rebel", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["flatbed3"] = { ['name'] = "flatbed3", ['price'] = 1000, ['tipo'] = "work", ["mala"] = 0 },
	["volatus"] = { ['name'] = "Volatus", ['price'] = 1000000, ['tipo'] = "work", ["mala"] = 0 },
	["cargobob2"] = { ['name'] = "Cargo Bob", ['price'] = 1000000, ['tipo'] = "work", ["mala"] = 0 },	
	
	----------------
	-- [ IMPORT ] --
	----------------

	["bmwm3f80"] = { ['name'] = "BMW M3 F80", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["bmwm4gts"] = { ['name'] = "BMW M4 GTS", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["ferrariitalia"] = { ['name'] = "Ferrari Italia", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["hondafk8"] = { ['name'] = "Honda Civic FK8", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["lamborghinihuracan"] = { ['name'] = "Lamborghini Huracan", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["lancerevolution9"] = { ['name'] = "Lancer Evolution 9", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["lancerevolutionx"] = { ['name'] = "Lancer Evolution X", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["mazdarx7"] = { ['name'] = "Mazda RX7", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["nissan370z"] = { ['name'] = "Nissan 370z", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["nissangtr"] = { ['name'] = "Nissan GTR R35", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["nissanskyliner34"] = { ['name'] = "Nissan GTR R34", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
	["teslaprior"] = { ['name'] = "Tesla Prior", ['price'] = 750000, ['tipo'] = "import", ["mala"] = 20 },
}

local actived = {}
local activedAmount = {}
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(actived) do
			if actived[k] > 0 then
				actived[k] = v - 1
				if actived[k] <= 0 then
					actived[k] = nil
					activedAmount[k] = nil
				end
			end
		end
		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleGlobal()
	return vehglobal
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLENAME
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleName(vname)
	return vehglobal[vname].name
end

function vRP.vehicleChest(vname)
	return vehglobal[vname].mala
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLEPRICE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehiclePrice(vname)
	return vehglobal[vname].price
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLETYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleType(vname)
	return vehglobal[vname].tipo
end

function vRP.storeChestItem(user_id,chestData,itemName,amount,chestWeight)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then

			if parseInt(amount) > 0 then
				activedAmount[user_id] = parseInt(amount)
			else
				return false
			end

			local new_weight = vRP.computeItemsWeight(items) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])
			if new_weight <= parseInt(chestWeight) then
				if vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(activedAmount[user_id])) then
					if items[itemName] ~= nil then
						items[itemName].amount = parseInt(items[itemName].amount) + parseInt(activedAmount[user_id])
					else
						items[itemName] = { amount = parseInt(activedAmount[user_id]) }
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end

function vRP.tryChestItem(user_id,chestData,itemName,amount)
	if actived[user_id] == nil then
		actived[user_id] = 1
		local data = vRP.getSData(chestData)
		local items = json.decode(data) or {}
		if data and items ~= nil then
			if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then

				if parseInt(amount) > 0 then
					activedAmount[user_id] = parseInt(amount)
				else
					return false
				end

				local new_weight = vRP.getInventoryWeight(parseInt(user_id)) + vRP.getItemWeight(itemName) * parseInt(activedAmount[user_id])
				if new_weight <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
					vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(activedAmount[user_id]))

					items[itemName].amount = parseInt(items[itemName].amount) - parseInt(activedAmount[user_id])

					if parseInt(items[itemName].amount) <= 0 then
						items[itemName] = nil
					end

					vRP.setSData(chestData,json.encode(items))
					return true
				end
			end
		end
	end
	return false
end

function vRP.openChest2(source,name,max_weight,cb_close,cb_in,cb_out)
	local user_id = vRP.getUserId(source)
	if user_id then
		local data = vRP.getUserDataTable(user_id)
		local identity = vRP.getUserIdentity(user_id)
		if data.inventory then
			if not chests[name] then
				local close_count = 0
				local chest = { max_weight = max_weight }
				chests[name] = chest 
				local cdata = vRP.getSData("chest:"..name)
				chest.items = json.decode(cdata) or {}

				local menu = { name = "Baú" }
				local cb_take = function(idname)
					local citem = chest.items[idname]
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					if amount > 0 and amount <= citem.amount then
						local new_weight = vRP.getInventoryWeight(user_id)+vRP.getItemWeight(idname)*amount
						if new_weight <= vRP.getInventoryMaxWeight(user_id) then
							vRP.giveInventoryItem(user_id,idname,amount)
							SendWebhookMessage(webhookbaucasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: "..name.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							citem.amount = citem.amount - amount

							if citem.amount <= 0 then
								chest.items[idname] = nil
							end

							if cb_out then
								cb_out(idname,amount)
							end
							vRP.closeMenu(source)
						else
							TriggerClientEvent("Notify",source,"negado","<b>Mochila</b> cheia.")
						end
					else
						TriggerClientEvent("Notify",source,"negado","Valor inválido.")
					end
				end

				local ch_take = function(player,choice)
					local weight = vRP.computeItemsWeight(chest.items)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",chest.items,cb_take)

					submenu.onclose = function()
						close_count = close_count - 1
						vRP.openMenu(player,menu)
					end
					close_count = close_count + 1
					vRP.openMenu(player,submenu)
				end

				local cb_put = function(idname)
					local amount = vRP.prompt(source,"Quantidade:","")
					amount = parseInt(amount)
					local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*amount
					if new_weight <= max_weight then
						if amount > 0 and vRP.tryGetInventoryItem(user_id,idname,amount) then
							SendWebhookMessage(webhookbaucasa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.itemNameList(idname).." \n[QUANTIDADE]: "..vRP.format(parseInt(amount)).." \n[BAU]: "..name.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
							local citem = chest.items[idname]

							if citem ~= nil then
								citem.amount = citem.amount + amount
							else
								chest.items[idname] = { amount = amount }
							end

							if cb_in then
								cb_in(idname,amount)
							end
							vRP.closeMenu(source)
						end
					else
						TriggerClientEvent("Notify",source,"negado","Baú cheio.")
					end
				end

				local ch_put = function(player,choice)
					local weight = vRP.computeItemsWeight(data.inventory)
					local submenu = build_itemlist_menu(string.format("%.2f",weight).." / "..max_weight.."kg",data.inventory,cb_put)

					submenu.onclose = function()
						close_count = close_count-1
						vRP.openMenu(player,menu)
					end

					close_count = close_count+1
					vRP.openMenu(player,submenu)
				end

				menu["Retirar"] = { ch_take }
				menu["Colocar"] = { ch_put }

				menu.onclose = function()
					if close_count == 0 then
						vRP.setSData("chest:"..name,json.encode(chest.items))
						chests[name] = nil
						if cb_close then
							cb_close()
						end
					end
				end
				vRP.openMenu(source,menu)
			else
				TriggerClientEvent("Notify",source,"importante","O baú está sendo utilizado no momento.")
			end
		end
	end
end