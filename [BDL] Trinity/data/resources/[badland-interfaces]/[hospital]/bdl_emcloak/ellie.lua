-- [ ESSE SISTEMA FOI DESENVOLVIDO POR Edu#0069 ou rossiniJS ] --
-- [ ESSE SISTEMA É 100% GRATUITO E OPEN SOURCE, SUA VENDA É PROIBIDA ] --
-- [ VISITE NOSSA LOJA E SAIBA MAIS SOBRE NOSSO TRABALHO - discord.gg/bABGBEX ] --
-- [ VISITE NOSSO GITHUB PARA TER ACESSO A MAIS SCRIPTS GRATUITOS COMO ESSE AQUI ] --
-- [ PARA CONSEGUIR AJUDA COM ESSE OU OUTRO DE NOSSOS SISTEMAS GRATUITOS, ACESSE NOSSO DISCORD ] --

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vCLIENT = Tunnel.getInterface("bdl_emcloak")

vRPex = {}
Tunnel.bindInterface("bdl_emcloak",vRPex)

local enfermeiro = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 74,0 },
        [4] = { 7,13 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 30,0 },			
        [8] = { 15,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 146,6 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 96,0 },
        [4] = { 23,0 },
        [5] = { -1,0 },
        [6] = { 10,1 },
        [7] = { 14,0 },			
        [8] = { 78,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 141,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local paramedico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 74,0 },
        [4] = { 96,0 },
        [5] = { -1,0 },
        [6] = { 42,0 },
        [7] = { 126,0 },			
        [8] = { 129,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 250,0 },
        ["p0"] = { 122,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 96,0 },
        [4] = { 99,0 },
        [5] = { -1,0 },
        [6] = { 27,0 },
        [7] = { 96,0 },			
        [8] = { 159,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 258,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local medico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 77,0 },
        [4] = { 20,0 },
        [5] = { -1,0 },
        [6] = { 21,9 },
        [7] = { 126,0 },			
        [8] = { 32,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 29,7 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 92,0 },
        [4] = { 23,0 },
        [5] = { -1,0 },
        [6] = { 7,1 },
        [7] = { 96,0 },			
        [8] = { 64,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 57,7 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local clinico = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 75,0 },
        [4] = { 10,0 },
        [5] = { -1,0 },
        [6] = { 21,0 },
        [7] = { 30,0 },			
        [8] = { 31,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 29,0 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 7,0 },
        [4] = { 52,2 },
        [5] = { -1,0 },
        [6] = { 42,2 },
        [7] = { 14,0 },			
        [8] = { 39,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 139,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local diretor = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 4,0 },
        [4] = { 20,0 },
        [5] = { -1,0 },
        [6] = { 21,9 },
        [7] = { 30,0 },			
        [8] = { 31,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 29,5 },
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 5,0 },
        [4] = { 47,0 },
        [5] = { -1,0 },
        [6] = { 42,2 },
        [7] = { 14,0 },			
        [8] = { 183,0 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 24,0 },			
        ["p0"] = { -1,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

local resgate = {
    [1885233650] = {
        [1] = { -1,0 },
        [3] = { 31,0 },
        [4] = { 98,0 },
        [5] = { -1,0 },
        [6] = { 51,0 },
        [7] = { 126,0 },			
        [8] = { 125,2 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 251,0 },
        ["p0"] = { 85,0 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { 1,0 },
        ["p7"] = { -1,0 }
    },
    [-1667301416] = {
        [1] = { -1,0 },
        [3] = { 39,0 },
        [4] = { 101,0 },
        [5] = { -1,0 },
        [6] = { 27,0 },
        [7] = { 96,0 },			
        [8] = { 157,2 },
        [9] = { -1,0 },
        [10] = { -1,0 },
        [11] = { 259,0 },			
        ["p0"] = { 59,9 },
        ["p1"] = { -1,0 },
        ["p2"] = { -1,0 },
        ["p6"] = { -1,0 },
        ["p7"] = { -1,0 }
    }
}

RegisterServerEvent("enfermeiro")
AddEventHandler("enfermeiro",function()
	local source = source
    local user_id = vRP.getUserId(source)
    local custom = enfermeiro
    if custom then
		TriggerClientEvent("progress",source,15000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(15000,function()
			
			vRPclient._stopAnim(source,false)
			TriggerClientEvent('cancelando',source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("paramedico")
AddEventHandler("paramedico",function()
	local source = source
    local user_id = vRP.getUserId(source)
    local custom = paramedico
    if custom then
		TriggerClientEvent("progress",source,25000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(25000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("medico")
AddEventHandler("medico",function()
	local source = source
    local user_id = vRP.getUserId(source)
    local custom = medico
    if custom then
		TriggerClientEvent("progress",source,20000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(20000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("clinico")
AddEventHandler("clinico",function()
	local source = source
    local user_id = vRP.getUserId(source)
    local custom = clinico
    if custom then
		TriggerClientEvent("progress",source,20000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(20000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("diretor")
AddEventHandler("diretor",function()
	local source = source
    local user_id = vRP.getUserId(source)
    local custom = diretor
    if custom then
		TriggerClientEvent("progress",source,25000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(25000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("resgate")
AddEventHandler("resgate",function()
	local source = source
    local user_id = vRP.getUserId(source)
    local custom = resgate
    if custom then
		TriggerClientEvent("progress",source,35000,"vestindo")
		vCLIENT.closeMenu(source)
		TriggerClientEvent('cancelando',source,true)
		vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
		SetTimeout(35000,function()
			TriggerClientEvent('cancelando',source,false)
			vRPclient._stopAnim(source,false)
			local old_custom = vRPclient.getCustomization(source)
			local idle_copy = {}

			idle_copy = vRP.save_idle_custom(source,old_custom)
			idle_copy.modelhash = nil

			for k,v in pairs(custom[old_custom.modelhash]) do
				idle_copy[k] = v
			end
			vRPclient._setCustomization(source,idle_copy)
		end)
    end
end)

RegisterServerEvent("off-uniform-ems")
AddEventHandler("off-uniform-ems",function()
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerClientEvent("progress",source,2000,"vestindo")
	vCLIENT.closeMenu(source)
	TriggerClientEvent('cancelando',source,true)
	vRPclient._playAnim(source,false,{{"clothingshirt","try_shirt_positive_d"}},true)
	SetTimeout(2000,function()
		TriggerClientEvent('cancelando',source,false)
		vRPclient._stopAnim(source,false)
		vRP.removeCloak(source)
	end)
end)

function vRPex.checkOfficer()
	local source = source
	local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"ems.permission") or vRP.hasPermission(user_id,"off-ems.permission") then
        return true
	end
end

-- [ ESSE SISTEMA FOI DESENVOLVIDO POR Edu#0069 ou rossiniJS ] --
-- [ ESSE SISTEMA FOI DESENVOLVIDO POR Edu#0069 ou rossiniJS ] --
-- [ ESSE SISTEMA FOI DESENVOLVIDO POR Edu#0069 ou rossiniJS ] --
-- [ ESSE SISTEMA FOI DESENVOLVIDO POR Edu#0069 ou rossiniJS ] --
-- [ ESSE SISTEMA FOI DESENVOLVIDO POR Edu#0069 ou rossiniJS ] --