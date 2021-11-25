Config = {}

Config.SafeMinimum = 0				-- Minimo que dá ao furar um caixa
Config.SafeMax = 0				-- Maximo que dá ao furar um caixa

Config.Solda = "dinamite" 					-- Item solda
Config.Furadeira = "furadeira" 			-- Item furadeira
Config.DinheiroSujo = "dinheiro-sujo" 	-- Item de dinheiro sujo
Config.Cops = 0					-- Quantidade minima de PMS
Config.PermCops = "lspd.permission" 	-- Permissao para os policiais
Config.MinPegar = 2500 					-- Valor minimo que o personagem pega do dinheiro
Config.MaxPegar = 5000 					-- Valor maximo que o personagem pega do dinheiro
Config.Tempo = 1600						-- Tempo (em segundos) pro roubo resetar

Config.AllowedBags = {40, 41, 44, 45}

Config.DrillSpawns = {
    vector3(-568.79, -1695.2, 19.11),
    vector3(-569.32, -1712.5, 22.36),
    vector3(-541.16, -1690.6, 18.96),
    vector3(-521.73, -1680.65, 18.36),
    vector3(-480.52, -1744.46, 17.65)
}

Config.Boxes = {Full = 'prop_cash_crate_01', Half = 'hei_prop_cash_crate_half_full', Empty = 'hei_prop_cash_crate_empty'}

Config.BankRobbery = {
    [1] = {
        Doors = { -- lägg ALLTID bankvalvs dörren sist (annars funkar inte hackningen)
            {Coords = vector3(257.22, 220.72, 106.28), Object = "hei_v_ilev_bk_gate_pris", Heading = -20.0, WeldPosition = {C = vector3(257.0, 219.76, 105.41), H = 338.38}, Time = 2, Frozen = true}, 
            {Coords = vector3(261.58, 222.05, 106.28), Object = "hei_v_ilev_bk_gate2_pris", Heading = -110.0, WeldPosition = {C = vector3(261.34, 221.91, 105.4), H = 254.73}, Time = 2, Frozen = true},  
            {Coords = vector3(253.90, 225.23, 101.87), Object = "v_ilev_bk_vaultdoor", Heading = 160.0, OpenHeading = -20.0, Hacking = true, Time = 5, Frozen = true},
        },
        Safes = {
            {Looted = false, Coords = vector3(259.61, 214.12, 100.8), Heading = 137.47, Cam = {From = {x = 258.16, y = 215.5, z = 102.5, rx = -25.0, ry = 0.0, rz = 200.0, r = 0}, To = {x = 260.92, y = 214.7, z = 102.5, rx = -25.0, ry = 0.0, rz = 123.0, r = 0}}},
            {Looted = false, Coords = vector3(258.3, 214.54, 100.8), Heading = 137.47, Cam = {From = {x = 257.73, y = 215.5, z = 102.5, rx = -25.0, ry = 0.0, rz = 200.0, r = 0}, To = {x = 260.92, y = 214.7, z = 102.5, rx = -25.0, ry = 0.0, rz = 123.0, r = 0}}},
            {Looted = false, Coords = vector3(256.83, 215.12, 100.8), Heading = 137.47, Cam = {From = {x = 256.3, y = 216.4, z = 102.5, rx = -25.0, ry = 0.0, rz = 200.0, r = 0}, To = {x = 260.92, y = 214.7, z = 102.5, rx = -25.0, ry = 0.0, rz = 123.0, r = 0}}},
        },
        Money = {
            StartMoney = 690000,
            Amount = 720000,
            BoxPosition = vector3(264.31, 213.77, 101.54),
            --Coords = vector3(263.4, 214.08, 100.8),
            --Heading = 253.62,
            Box = 'prop_cash_crate_01',
            Cam = {Coords = {x = 265.85, y = 213.51, z = 103.0}, Rotation = {rx = -35.0, ry = 0.0, rz = 70.0, r = 0}},
        },
        Hacking = {
            Coords = vector3(264.74, 219.83, 100.8),
            Heading = 286.41,
        },
        BankName = 'Swedbank'
    }
}

return Config