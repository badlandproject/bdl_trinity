local cfg = {}

cfg.items = {
	["mochila"] = { "Mochila",0 },
	["celular"] = { "Celular",0.3 },
	["radio"] = { "WalkTalk",0.3 },
	["militec"] = { "Militec",1.0 },
	["repairkit"] = { "Kit de Reparos",1.0 },
	["pneus"] = { "Pneus",2.0 },
	["melhoria"] = { "Melhoria Nvl.1",3.0 },
	["identidade"] = { "Identidade",0.1 },
	["roupas"] = { "Roupas",5.0 },
	["algema"] = { "Algema",0.4 },

	-- [ Empregos ] --
	["garrafavazia"] = { "Garrafa Vazia",0.2 }, --
	["garrafaleite"] = { "Garrafa de Leite",0.8 },
	["encomenda"] = { "Encomenda",1.4 },
	["britadeira"] = { "Britadeira",8.0 }, --
	["ferro"] = { "M. de Ferro",2.0 },
	["bronze"] = { "M. de Bronze",1.6 },
	["ouro"] = { "M. de Ouro",1.2 },
	["diamante"] = { "M. de Diamante",0.8 },
	["blueberry"] = { "Blueberry",0.2 },
	["s-blueberry"] = { "Sementes",0.1 }, --
	
	-- [ Ilegais ] --
	["blankcard"] = { "Cartão",0.2 },
	["dinamite"] = { "Dinamite",1.2 },
	["furadeira"] = { "Furadeira",1.8 },
	["lockpick"] = { "Lockpick",0.2 },
	["capuz"] = { "Capuz",0.1 },
	["colete"] = { "Colete",2.0 },
	["dinheiro-sujo"] = { "Dinheiro Sujo", 0.0 },
	--#Ballas
	["adubo"] = { "Adubo", 0.3 },
	["maconha"] = { "Maconha", 0.5 },
	["maconha-embalada"] = { "Maconha Emb.", 1.0 },
	--#Grove
	["folha-coca"] = { "Folha de Coca", 0.1 },
	["pasta-coca"] = { "Pasta de Coca", 0.5 },
	["cocaína"] = { "Cocaína", 0.3 },
	["coca-embalada"] = { "Cocaína Emb.", 1.0 },
	--#Vagos
	["comprimidos"] = { "Comprimidos", 0.1 },
	["acido"] = { "Ácido", 0.2 },
	["composito"] = { "Compósito", 0.2 },
	["querosene"] = { "Querosene", 0.4 },
	["metanfetamina"] = { "Metanfetamina", 0.4 },
	["meta-embalada"] = { "Metanf. Emb.", 1.0 },
	--#Bratva
	["polvora"] = { "Pólvora", 0.1 },
	["capsulas"] = { "Capsulas", 0.4 },
	["molas"] = { "Molas", 0.1 },
	["gatilho"] = { "Gatilho", 0.2 },
	["placa-metal"] = { "Placa de Metal", 0.2 },
	["corpo-ak47"] = { "Corpo de AK-47", 0.4 },
	["corpo-ak103"] = { "Corpo de AK-103", 0.4 },
	["corpo-ak74"] = { "Corpo de AK-74", 0.4 },
	["corpo-mp5"] = { "Corpo de MP-5", 0.4 },
	["corpo-tec9"] = { "Corpo de TEC-9", 0.4 },
	["corpo-m1911"] = { "Corpo de M1911", 0.4 },
	["corpo-hk110"] = { "Corpo de HK-110", 0.4 },

	-- [ Remédios ] --
	["paracetamol"] = { "Paracetamol",0.2 },
	["voltaren"] = { "Voltaren",0.2 },
	["tandrilax"] = { "Tandrilax",0.2 },
	["dorflex"] = { "Dorflex",0.2 },
	["buscopan"] = { "buscopan",0.2 },
	["r-paracetamol"] = { "R. Paracetamol",0.2 },
	["r-voltaren"] = { "R. Voltaren",0.2 },
	["r-tandrilax"] = { "R. Tandrilax",0.2 },
	["r-dorflex"] = { "R. Dorflex",0.2 },
	["r-buscopan"] = { "R. Buscopan",0.2 },

	-- [ Bebidas ] --
	["agua"] = { "G. d'Água",0.1 },
	["energetico"] = { "Energético",0.4 },
	["sprunk"] = { "Sprunk",0.2 },
	["cola"] = { "Cola",0.2 },
	["leite"] = { "Leite",0.1 },
	["barracho"] = { "Barracho",0.4 },
	["patriot"] = { "Patriot",0.2 },
	["pibwassen"] = { "PibWassen",0.2 },

	-- [ Comida ] --
	["xburguer"] = { "X Burguer",0.2 },
	["sanduiche"] = { "Sanduiche",0.2 },
	["pizza"] = { "Pizza",0.2 },
	["batataf"] = { "Batata Frita",0.1 },
	["chips"] = { "Chips",0.1 },
	["rosquinha"] = { "Rosquinha",0.1 },
	["hotdog"] = { "HotDog",0.2 },
	["taco"] = { "Taco",0.3 },

}

local function load_item_pack(name)
	local items = module("cfg/item/"..name)
	if items then
		for k,v in pairs(items) do
			cfg.items[k] = v
		end
	end
end

load_item_pack("armamentos")

return cfg