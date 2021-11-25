local items = {}

local nomes = {
	-- [ Utilitários ] --
	Gadget_parachute = "Paraquedas",
	Petrolcan = "Galão de Gasolina",
	Flare = "Sinalizador",
	Fireextinguisher = "Extintor",
	-- [ Brancas ] --
	Knife = "Faca",
	Dagger = "Adaga",
	Knuckle = "Soco-Inglês",
	Machete = "Machete",
	Switchblade = "Canivete",
	Wrench = "Chave de Grifo",
	Hammer = "Martelo",
	Golfclub = "Taco de Golf",
	Crowbar = "Pé de Cabra",
	Hatchet = "Machado",
	Flashlight = "Lanterna",
	Bat = "Taco de Beisebol",
	Bottle = "Garrafa",
	Battleaxe = "Machado de Batalha",
	Poolcue = "Taco de Sinuca",
	Stone_hatchet = "Machado de Pedra",
	Nightstick = "Cacetete",
	-- [ Pistolas ] --
	Pistol_mk2 = "FN Five-Seven",
	Combatpistol = "Glock-19",
	Pistol = "M1911",
	Vintagepistol = "FN-M22",
	Snspistol = "HK-110",
	Stungun = "Taser",
	-- [ Rifles de assalto ] --
	Assaultrifle = "AK-47",
	Assaultrifle_mk2 = "AK-103",
	Carbinerifle = "M4-A4",
	Carbinerifle_mk2 = "M4-A1",
	Advancedrifle = "AUG-A3",
	-- [ SMGs ] --
	Smg = "MP5",
	Combatpdw = "MPX",
	Machinepistol = "Tec-9",
	Compactrifle = "AK-74u",
	-- [ Shotguns ] --
	Pumpshotgun = "Secutor.12",
	Pumpshotgun_mk2 = "Executor.45",
	-- [ Rifles de caça ] --
	Musket = "Winchester 22"
}

local get_wname = function(weapon_id)
	local name = string.gsub(weapon_id,"WEAPON_","")
	name = string.upper(string.sub(name,1,1))..string.lower(string.sub(name,2))
	return nomes[name]
end

local wammo_name = function(args)
	if args[2] == "WEAPON_PETROLCAN" then
		return "Combustível"
	else
		return "Munição de "..get_wname(args[2])
	end
end

local wbody_name = function(args)
	return get_wname(args[2])
end

items["wbody"] = { wbody_name,5 }
items["wammo"] = { wammo_name,0.03 }

return items