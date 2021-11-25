local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
src = {}
Tunnel.bindInterface("bdl_garages",src)
vCLIENT = Tunnel.getInterface("bdl_garages")
local inventory = module("vrp","cfg/inventory")
local idgens = Tools.newIDGenerator()
-- [ DATABASE ] --
vRP._prepare("creative/get_vehicle","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_vehicle","DELETE FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/get_vehicles","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_update_vehicles","UPDATE vrp_user_vehicles SET engine = @engine, body = @body, fuel = @fuel WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_detido","UPDATE vrp_user_vehicles SET detido = @detido, time = @time WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_ipva","UPDATE vrp_user_vehicles SET ipva = @ipva WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/move_vehicle","UPDATE vrp_user_vehicles SET user_id = @nuser_id WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/add_vehicle","INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,ipva) VALUES(@user_id,@vehicle,@ipva)")
vRP._prepare("creative/con_maxvehs","SELECT COUNT(vehicle) as qtd FROM vrp_user_vehicles WHERE user_id = @user_id")
vRP._prepare("creative/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
vRP._prepare("creative/get_estoque","SELECT * FROM vrp_estoque WHERE vehicle = @vehicle")
vRP._prepare("creative/set_estoque","UPDATE vrp_estoque SET quantidade = @quantidade WHERE vehicle = @vehicle")
vRP._prepare("creative/get_users","SELECT * FROM vrp_users WHERE id = @user_id")
vRP._prepare("creative/get_vehicle_state","SELECT * FROM vrp_user_vehicles WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_vehicle_state","UPDATE vrp_user_vehicles SET state = @state WHERE user_id = @user_id AND vehicle = @vehicle")
vRP._prepare("creative/set_vehicle_state_to_zero","UPDATE vrp_user_vehicles SET state = 0 WHERE user_id = @user_id AND vehicle = vehicle")
-- [ WEBHOOKS ] --
local webhookadmin = ""
local webhookvehs = ""
local webhookdesmanche = ""

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-- [ VARIABLES ] --
local police = {}
local vehlist = {}
local trydoors = {}
trydoors["CLONADOS"] = true
trydoors["CREATIVE"] = true
-- [ RETURN VEHICLES ] --
function src.returnVehicleEveryone(placa)
	return trydoors[placa]
end
-- [ SET PLATE ] --
RegisterServerEvent("setPlateEveryone")
AddEventHandler("setPlateEveryone",function(placa)
	trydoors[placa] = true
end)
-- [ MAIN ARRAY (PERMISSIONS, NAMES) ] --
local garages = {
	[1] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[2] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[3] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[4] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[5] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[6] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[7] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[8] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[9] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[10] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[11] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[12] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[13] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[14] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[15] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	-- [ LSPD ] --
	[16] = { ['name'] = "LSPD", ['payment'] = false, ['perm'] = "lspd.permission" },
	[17] = { ['name'] = "LSPD", ['payment'] = false, ['perm'] = "lspd.permission" },
	[18] = { ['name'] = "LSPDH", ['payment'] = false, ['perm'] = "lspd.permission" },
	-- [ EMS ] --
	[19] = { ['name'] = "EMS", ['payment'] = false, ['perm'] = "ems.permission" },
	[20] = { ['name'] = "EMSH", ['payment'] = false, ['perm'] = "ems.permission" },
	
	[21] = { ['name'] = "Bennys", ['payment'] = false, ['perm'] = "bennys.permission" },
	
	[22] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[23] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[24] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	[25] = { ['name'] = "Garagem", ['payment'] = false, ['public'] = true },
	-- [ HOMES ] --
	[145] = { ['name'] = "FH01", ['payment'] = false, ['public'] = false },
	[148] = { ['name'] = "FH04", ['payment'] = false, ['public'] = false },
	[155] = { ['name'] = "FH11", ['payment'] = false, ['public'] = false },
	[159] = { ['name'] = "FH15", ['payment'] = false, ['public'] = false },
	[163] = { ['name'] = "FH19", ['payment'] = false, ['public'] = false },
	[167] = { ['name'] = "FH23", ['payment'] = false, ['public'] = false },
	[168] = { ['name'] = "FH24", ['payment'] = false, ['public'] = false },
	[170] = { ['name'] = "FH26", ['payment'] = false, ['public'] = false },
	[173] = { ['name'] = "FH29", ['payment'] = false, ['public'] = false },
	[175] = { ['name'] = "FH31", ['payment'] = false, ['public'] = false },
	[176] = { ['name'] = "FH32", ['payment'] = false, ['public'] = false },
	[189] = { ['name'] = "FH45", ['payment'] = false, ['public'] = false },
	[192] = { ['name'] = "FH48", ['payment'] = false, ['public'] = false },
	[193] = { ['name'] = "FH49", ['payment'] = false, ['public'] = false },
	[196] = { ['name'] = "FH52", ['payment'] = false, ['public'] = false },
	[198] = { ['name'] = "FH54", ['payment'] = false, ['public'] = false },
	[199] = { ['name'] = "FH55", ['payment'] = false, ['public'] = false },
	[202] = { ['name'] = "FH58", ['payment'] = false, ['public'] = false },
	[203] = { ['name'] = "FH59", ['payment'] = false, ['public'] = false },
	[212] = { ['name'] = "FH68", ['payment'] = false, ['public'] = false },
	[225] = { ['name'] = "FH81", ['payment'] = false, ['public'] = false },
	[235] = { ['name'] = "FH91", ['payment'] = false, ['public'] = false },
	[236] = { ['name'] = "FH92", ['payment'] = false, ['public'] = false },
	[237] = { ['name'] = "FH93", ['payment'] = false, ['public'] = false },
	[238] = { ['name'] = "FH94", ['payment'] = false, ['public'] = false },

	[245] = { ['name'] = "LX01", ['payment'] = false, ['public'] = false },
	[246] = { ['name'] = "LX02", ['payment'] = false, ['public'] = false },
	[247] = { ['name'] = "LX03", ['payment'] = false, ['public'] = false },
	[248] = { ['name'] = "LX04", ['payment'] = false, ['public'] = false },
	[249] = { ['name'] = "LX05", ['payment'] = false, ['public'] = false },
	[250] = { ['name'] = "LX06", ['payment'] = false, ['public'] = false },
	[251] = { ['name'] = "LX07", ['payment'] = false, ['public'] = false },
	[252] = { ['name'] = "LX08", ['payment'] = false, ['public'] = false },
	[253] = { ['name'] = "LX09", ['payment'] = false, ['public'] = false },
	[254] = { ['name'] = "LX10", ['payment'] = false, ['public'] = false },
	[255] = { ['name'] = "LX11", ['payment'] = false, ['public'] = false },
	[256] = { ['name'] = "LX12", ['payment'] = false, ['public'] = false },
	[257] = { ['name'] = "LX13", ['payment'] = false, ['public'] = false },
	[258] = { ['name'] = "LX14", ['payment'] = false, ['public'] = false },
	[259] = { ['name'] = "LX15", ['payment'] = false, ['public'] = false },
	[260] = { ['name'] = "LX16", ['payment'] = false, ['public'] = false },
	[261] = { ['name'] = "LX17", ['payment'] = false, ['public'] = false },
	[262] = { ['name'] = "LX18", ['payment'] = false, ['public'] = false },
	[263] = { ['name'] = "LX19", ['payment'] = false, ['public'] = false },
	[264] = { ['name'] = "LX20", ['payment'] = false, ['public'] = false },
	[265] = { ['name'] = "LX21", ['payment'] = false, ['public'] = false },
	[266] = { ['name'] = "LX22", ['payment'] = false, ['public'] = false },
	[267] = { ['name'] = "LX23", ['payment'] = false, ['public'] = false },
	[268] = { ['name'] = "LX24", ['payment'] = false, ['public'] = false },
	[269] = { ['name'] = "LX25", ['payment'] = false, ['public'] = false },
	[270] = { ['name'] = "LX26", ['payment'] = false, ['public'] = false },
	[271] = { ['name'] = "LX27", ['payment'] = false, ['public'] = false },
	[272] = { ['name'] = "LX28", ['payment'] = false, ['public'] = false },
	[273] = { ['name'] = "LX29", ['payment'] = false, ['public'] = false },
	[276] = { ['name'] = "LX32", ['payment'] = false, ['public'] = false },
	[278] = { ['name'] = "LX34", ['payment'] = false, ['public'] = false },
	[279] = { ['name'] = "LX35", ['payment'] = false, ['public'] = false },
	[280] = { ['name'] = "LX36", ['payment'] = false, ['public'] = false },
	[281] = { ['name'] = "LX37", ['payment'] = false, ['public'] = false },
	[282] = { ['name'] = "LX38", ['payment'] = false, ['public'] = false },
	[283] = { ['name'] = "LX39", ['payment'] = false, ['public'] = false },
	[284] = { ['name'] = "LX40", ['payment'] = false, ['public'] = false },
	[285] = { ['name'] = "LX41", ['payment'] = false, ['public'] = false },
	[286] = { ['name'] = "LX42", ['payment'] = false, ['public'] = false },
	[287] = { ['name'] = "LX43", ['payment'] = false, ['public'] = false },
	[288] = { ['name'] = "LX44", ['payment'] = false, ['public'] = false },
	[289] = { ['name'] = "LX45", ['payment'] = false, ['public'] = false },
	[290] = { ['name'] = "LX46", ['payment'] = false, ['public'] = false },
	[291] = { ['name'] = "LX47", ['payment'] = false, ['public'] = false },
	[292] = { ['name'] = "LX48", ['payment'] = false, ['public'] = false },
	[294] = { ['name'] = "LX50", ['payment'] = false, ['public'] = false },
	[295] = { ['name'] = "LX51", ['payment'] = false, ['public'] = false },
	[296] = { ['name'] = "LX52", ['payment'] = false, ['public'] = false },
	[297] = { ['name'] = "LX53", ['payment'] = false, ['public'] = false },
	[298] = { ['name'] = "LX54", ['payment'] = false, ['public'] = false },
	[299] = { ['name'] = "LX55", ['payment'] = false, ['public'] = false },
	[302] = { ['name'] = "LX58", ['payment'] = false, ['public'] = false },
	[303] = { ['name'] = "LX59", ['payment'] = false, ['public'] = false },
	[304] = { ['name'] = "LX60", ['payment'] = false, ['public'] = false },
	[305] = { ['name'] = "LX61", ['payment'] = false, ['public'] = false },
	[306] = { ['name'] = "LX62", ['payment'] = false, ['public'] = false },
	[307] = { ['name'] = "LX63", ['payment'] = false, ['public'] = false },
	[308] = { ['name'] = "LX64", ['payment'] = false, ['public'] = false },
	[309] = { ['name'] = "LX65", ['payment'] = false, ['public'] = false },
	[310] = { ['name'] = "LX66", ['payment'] = false, ['public'] = false },
	[311] = { ['name'] = "LX67", ['payment'] = false, ['public'] = false },
	[312] = { ['name'] = "LX68", ['payment'] = false, ['public'] = false },
	[313] = { ['name'] = "LX69", ['payment'] = false, ['public'] = false },
	[314] = { ['name'] = "LX70", ['payment'] = false, ['public'] = false },

	[315] = { ['name'] = "LS01", ['payment'] = false, ['public'] = false },
	[316] = { ['name'] = "LS02", ['payment'] = false, ['public'] = false },
	[317] = { ['name'] = "LS03", ['payment'] = false, ['public'] = false },
	[318] = { ['name'] = "LS04", ['payment'] = false, ['public'] = false },
	[319] = { ['name'] = "LS05", ['payment'] = false, ['public'] = false },
	[320] = { ['name'] = "LS06", ['payment'] = false, ['public'] = false },
	[321] = { ['name'] = "LS07", ['payment'] = false, ['public'] = false },
	[322] = { ['name'] = "LS08", ['payment'] = false, ['public'] = false },
	[323] = { ['name'] = "LS09", ['payment'] = false, ['public'] = false },
	[324] = { ['name'] = "LS10", ['payment'] = false, ['public'] = false },
	[325] = { ['name'] = "LS11", ['payment'] = false, ['public'] = false },
	[326] = { ['name'] = "LS12", ['payment'] = false, ['public'] = false },
	[327] = { ['name'] = "LS13", ['payment'] = false, ['public'] = false },
	[328] = { ['name'] = "LS14", ['payment'] = false, ['public'] = false },
	[329] = { ['name'] = "LS15", ['payment'] = false, ['public'] = false },
	[330] = { ['name'] = "LS16", ['payment'] = false, ['public'] = false },
	[331] = { ['name'] = "LS17", ['payment'] = false, ['public'] = false },
	[332] = { ['name'] = "LS18", ['payment'] = false, ['public'] = false },
	[333] = { ['name'] = "LS19", ['payment'] = false, ['public'] = false },
	[334] = { ['name'] = "LS20", ['payment'] = false, ['public'] = false },
	[335] = { ['name'] = "LS21", ['payment'] = false, ['public'] = false },
	[336] = { ['name'] = "LS22", ['payment'] = false, ['public'] = false },
	[337] = { ['name'] = "LS23", ['payment'] = false, ['public'] = false },
	[338] = { ['name'] = "LS24", ['payment'] = false, ['public'] = false },
	[339] = { ['name'] = "LS25", ['payment'] = false, ['public'] = false },
	[340] = { ['name'] = "LS26", ['payment'] = false, ['public'] = false },
	[341] = { ['name'] = "LS27", ['payment'] = false, ['public'] = false },
	[342] = { ['name'] = "LS28", ['payment'] = false, ['public'] = false },
	[343] = { ['name'] = "LS29", ['payment'] = false, ['public'] = false },
	[344] = { ['name'] = "LS30", ['payment'] = false, ['public'] = false },
	[345] = { ['name'] = "LS31", ['payment'] = false, ['public'] = false },
	[346] = { ['name'] = "LS32", ['payment'] = false, ['public'] = false },
	[347] = { ['name'] = "LS33", ['payment'] = false, ['public'] = false },
	[348] = { ['name'] = "LS34", ['payment'] = false, ['public'] = false },
	[349] = { ['name'] = "LS35", ['payment'] = false, ['public'] = false },
	[350] = { ['name'] = "LS36", ['payment'] = false, ['public'] = false },
	[351] = { ['name'] = "LS37", ['payment'] = false, ['public'] = false },
	[352] = { ['name'] = "LS38", ['payment'] = false, ['public'] = false },
	[353] = { ['name'] = "LS39", ['payment'] = false, ['public'] = false },
	[354] = { ['name'] = "LS40", ['payment'] = false, ['public'] = false },
	[355] = { ['name'] = "LS41", ['payment'] = false, ['public'] = false },
	[356] = { ['name'] = "LS42", ['payment'] = false, ['public'] = false },
	[357] = { ['name'] = "LS43", ['payment'] = false, ['public'] = false },
	[358] = { ['name'] = "LS44", ['payment'] = false, ['public'] = false },
	[359] = { ['name'] = "LS45", ['payment'] = false, ['public'] = false },
	[360] = { ['name'] = "LS46", ['payment'] = false, ['public'] = false },
	[361] = { ['name'] = "LS47", ['payment'] = false, ['public'] = false },
	[362] = { ['name'] = "LS48", ['payment'] = false, ['public'] = false },
	[363] = { ['name'] = "LS49", ['payment'] = false, ['public'] = false },
	[364] = { ['name'] = "LS50", ['payment'] = false, ['public'] = false },
	[365] = { ['name'] = "LS51", ['payment'] = false, ['public'] = false },
	[366] = { ['name'] = "LS52", ['payment'] = false, ['public'] = false },
	[367] = { ['name'] = "LS53", ['payment'] = false, ['public'] = false },
	[368] = { ['name'] = "LS54", ['payment'] = false, ['public'] = false },
	[369] = { ['name'] = "LS55", ['payment'] = false, ['public'] = false },
	[370] = { ['name'] = "LS56", ['payment'] = false, ['public'] = false },
	[371] = { ['name'] = "LS57", ['payment'] = false, ['public'] = false },
	[372] = { ['name'] = "LS58", ['payment'] = false, ['public'] = false },
	[373] = { ['name'] = "LS59", ['payment'] = false, ['public'] = false },
	[374] = { ['name'] = "LS60", ['payment'] = false, ['public'] = false },
	[375] = { ['name'] = "LS61", ['payment'] = false, ['public'] = false },
	[376] = { ['name'] = "LS62", ['payment'] = false, ['public'] = false },
	[377] = { ['name'] = "LS63", ['payment'] = false, ['public'] = false },
	[378] = { ['name'] = "LS64", ['payment'] = false, ['public'] = false },
	[379] = { ['name'] = "LS65", ['payment'] = false, ['public'] = false },
	[380] = { ['name'] = "LS66", ['payment'] = false, ['public'] = false },
	[381] = { ['name'] = "LS67", ['payment'] = false, ['public'] = false },
	[382] = { ['name'] = "LS68", ['payment'] = false, ['public'] = false },
	[383] = { ['name'] = "LS69", ['payment'] = false, ['public'] = false },
	[384] = { ['name'] = "LS70", ['payment'] = false, ['public'] = false },
	[385] = { ['name'] = "LS71", ['payment'] = false, ['public'] = false },
	[386] = { ['name'] = "LS72", ['payment'] = false, ['public'] = false },

	--[387] = { ['name'] = "KR01", ['payment'] = false, ['public'] = false },
	[388] = { ['name'] = "KR02", ['payment'] = false, ['public'] = false },
	[389] = { ['name'] = "KR03", ['payment'] = false, ['public'] = false },
	[390] = { ['name'] = "KR04", ['payment'] = false, ['public'] = false },
	[391] = { ['name'] = "KR05", ['payment'] = false, ['public'] = false },
	[392] = { ['name'] = "KR06", ['payment'] = false, ['public'] = false },
	[393] = { ['name'] = "KR07", ['payment'] = false, ['public'] = false },
	[394] = { ['name'] = "KR08", ['payment'] = false, ['public'] = false },
	[395] = { ['name'] = "KR09", ['payment'] = false, ['public'] = false },
	[396] = { ['name'] = "KR10", ['payment'] = false, ['public'] = false },
	[397] = { ['name'] = "KR11", ['payment'] = false, ['public'] = false },
	[398] = { ['name'] = "KR12", ['payment'] = false, ['public'] = false },
	[399] = { ['name'] = "KR13", ['payment'] = false, ['public'] = false },
	[400] = { ['name'] = "KR14", ['payment'] = false, ['public'] = false },
	[401] = { ['name'] = "KR15", ['payment'] = false, ['public'] = false },
	[402] = { ['name'] = "KR16", ['payment'] = false, ['public'] = false },
	[403] = { ['name'] = "KR17", ['payment'] = false, ['public'] = false },
	[404] = { ['name'] = "KR18", ['payment'] = false, ['public'] = false },
	[405] = { ['name'] = "KR19", ['payment'] = false, ['public'] = false },
	[406] = { ['name'] = "KR20", ['payment'] = false, ['public'] = false },
	[407] = { ['name'] = "KR21", ['payment'] = false, ['public'] = false },
	[408] = { ['name'] = "KR22", ['payment'] = false, ['public'] = false },
	[409] = { ['name'] = "KR23", ['payment'] = false, ['public'] = false },
	[410] = { ['name'] = "KR24", ['payment'] = false, ['public'] = false },
	[411] = { ['name'] = "KR25", ['payment'] = false, ['public'] = false },
	[412] = { ['name'] = "KR26", ['payment'] = false, ['public'] = false },
	[413] = { ['name'] = "KR27", ['payment'] = false, ['public'] = false },
	[414] = { ['name'] = "KR28", ['payment'] = false, ['public'] = false },
	[415] = { ['name'] = "KR29", ['payment'] = false, ['public'] = false },
	[416] = { ['name'] = "KR30", ['payment'] = false, ['public'] = false },
	[417] = { ['name'] = "KR31", ['payment'] = false, ['public'] = false },
	[418] = { ['name'] = "KR32", ['payment'] = false, ['public'] = false },
	[419] = { ['name'] = "KR33", ['payment'] = false, ['public'] = false },
	[420] = { ['name'] = "KR34", ['payment'] = false, ['public'] = false },
	[421] = { ['name'] = "KR35", ['payment'] = false, ['public'] = false },
	[422] = { ['name'] = "KR36", ['payment'] = false, ['public'] = false },
	[423] = { ['name'] = "KR37", ['payment'] = false, ['public'] = false },
	[424] = { ['name'] = "KR38", ['payment'] = false, ['public'] = false },
	[425] = { ['name'] = "KR39", ['payment'] = false, ['public'] = false },
	[426] = { ['name'] = "KR40", ['payment'] = false, ['public'] = false },
	[427] = { ['name'] = "KR41", ['payment'] = false, ['public'] = false },

	[428] = { ['name'] = "LV01", ['payment'] = false, ['public'] = false },
	[429] = { ['name'] = "LV02", ['payment'] = false, ['public'] = false },
	[430] = { ['name'] = "LV03", ['payment'] = false, ['public'] = false },
	[431] = { ['name'] = "LV04", ['payment'] = false, ['public'] = false },
	[432] = { ['name'] = "LV05", ['payment'] = false, ['public'] = false },
	[433] = { ['name'] = "LV06", ['payment'] = false, ['public'] = false },
	[434] = { ['name'] = "LV07", ['payment'] = false, ['public'] = false },
	[435] = { ['name'] = "LV08", ['payment'] = false, ['public'] = false },
	[436] = { ['name'] = "LV09", ['payment'] = false, ['public'] = false },
	[437] = { ['name'] = "LV10", ['payment'] = false, ['public'] = false },
	[438] = { ['name'] = "LV11", ['payment'] = false, ['public'] = false },
	[439] = { ['name'] = "LV12", ['payment'] = false, ['public'] = false },
	[440] = { ['name'] = "LV13", ['payment'] = false, ['public'] = false },
	[441] = { ['name'] = "LV14", ['payment'] = false, ['public'] = false },
	[442] = { ['name'] = "LV15", ['payment'] = false, ['public'] = false },
	[443] = { ['name'] = "LV16", ['payment'] = false, ['public'] = false },
	[444] = { ['name'] = "LV17", ['payment'] = false, ['public'] = false },
	[445] = { ['name'] = "LV18", ['payment'] = false, ['public'] = false },
	[446] = { ['name'] = "LV19", ['payment'] = false, ['public'] = false },
	[447] = { ['name'] = "LV20", ['payment'] = false, ['public'] = false },
	[448] = { ['name'] = "LV21", ['payment'] = false, ['public'] = false },
	[449] = { ['name'] = "LV22", ['payment'] = false, ['public'] = false },
	[450] = { ['name'] = "LV23", ['payment'] = false, ['public'] = false },
	[451] = { ['name'] = "LV24", ['payment'] = false, ['public'] = false },
	[452] = { ['name'] = "LV25", ['payment'] = false, ['public'] = false },
	[453] = { ['name'] = "LV26", ['payment'] = false, ['public'] = false },
	[454] = { ['name'] = "LV27", ['payment'] = false, ['public'] = false },
	[455] = { ['name'] = "LV28", ['payment'] = false, ['public'] = false },
	[456] = { ['name'] = "LV29", ['payment'] = false, ['public'] = false },
	[457] = { ['name'] = "LV30", ['payment'] = false, ['public'] = false },
	[458] = { ['name'] = "LV31", ['payment'] = false, ['public'] = false },
	[459] = { ['name'] = "LV32", ['payment'] = false, ['public'] = false },
	[460] = { ['name'] = "LV33", ['payment'] = false, ['public'] = false },
	[461] = { ['name'] = "LV34", ['payment'] = false, ['public'] = false },
	[462] = { ['name'] = "LV35", ['payment'] = false, ['public'] = false },

	[463] = { ['name'] = "PB01", ['payment'] = false, ['public'] = false },
	[464] = { ['name'] = "PB02", ['payment'] = false, ['public'] = false },
	[465] = { ['name'] = "PB03", ['payment'] = false, ['public'] = false },
	[466] = { ['name'] = "PB04", ['payment'] = false, ['public'] = false },
	[467] = { ['name'] = "PB05", ['payment'] = false, ['public'] = false },
	[468] = { ['name'] = "PB06", ['payment'] = false, ['public'] = false },
	[469] = { ['name'] = "PB07", ['payment'] = false, ['public'] = false },
	[470] = { ['name'] = "PB08", ['payment'] = false, ['public'] = false },
	[471] = { ['name'] = "PB09", ['payment'] = false, ['public'] = false },
	[472] = { ['name'] = "PB10", ['payment'] = false, ['public'] = false },
	[473] = { ['name'] = "PB11", ['payment'] = false, ['public'] = false },
	[474] = { ['name'] = "PB12", ['payment'] = false, ['public'] = false },
	[475] = { ['name'] = "PB13", ['payment'] = false, ['public'] = false },
	[476] = { ['name'] = "PB14", ['payment'] = false, ['public'] = false },
	[477] = { ['name'] = "PB15", ['payment'] = false, ['public'] = false },
	[478] = { ['name'] = "PB16", ['payment'] = false, ['public'] = false },
	[479] = { ['name'] = "PB17", ['payment'] = false, ['public'] = false },
	[480] = { ['name'] = "PB18", ['payment'] = false, ['public'] = false },
	[481] = { ['name'] = "PB19", ['payment'] = false, ['public'] = false },
	[482] = { ['name'] = "PB20", ['payment'] = false, ['public'] = false },
	[483] = { ['name'] = "PB21", ['payment'] = false, ['public'] = false },
	[484] = { ['name'] = "PB22", ['payment'] = false, ['public'] = false },
	[485] = { ['name'] = "PB23", ['payment'] = false, ['public'] = false },
	[486] = { ['name'] = "PB24", ['payment'] = false, ['public'] = false },
	[487] = { ['name'] = "PB25", ['payment'] = false, ['public'] = false },
	[488] = { ['name'] = "PB26", ['payment'] = false, ['public'] = false },
	[489] = { ['name'] = "PB27", ['payment'] = false, ['public'] = false },
	[490] = { ['name'] = "PB28", ['payment'] = false, ['public'] = false },
	[491] = { ['name'] = "PB29", ['payment'] = false, ['public'] = false },
	[492] = { ['name'] = "PB30", ['payment'] = false, ['public'] = false },
	[493] = { ['name'] = "PB31", ['payment'] = false, ['public'] = false },

	[600] = { ['name'] = "MS01", ['payment'] = false, ['public'] = false },
	[601] = { ['name'] = "MS02", ['payment'] = false, ['public'] = false },
	[602] = { ['name'] = "MS03", ['payment'] = false, ['public'] = false },
	[603] = { ['name'] = "MS04", ['payment'] = false, ['public'] = false },
	[604] = { ['name'] = "MS05", ['payment'] = false, ['public'] = false },
	[605] = { ['name'] = "MS09", ['payment'] = false, ['public'] = false },
	[606] = { ['name'] = "SS01", ['payment'] = false, ['public'] = false },
	[607] = { ['name'] = "MS08", ['payment'] = false, ['public'] = false },
	[608] = { ['name'] = "FZ01", ['payment'] = false, ['public'] = false },
	[609] = { ['name'] = "Frutas", ['payment'] = false, ['public'] = true },
	[610] = { ['name'] = "Fazendeiro", ['payment'] = false, ['public'] = true },
	[611] = { ['name'] = "Lixeiro", ['payment'] = false, ['public'] = true },
	[612] = { ['name'] = "Taco", ['payment'] = false, ['public'] = true },
	[613] = { ['name'] = "Mecanico", ['payment'] = false, ['perm'] = "bennys.permission" },
	[615] = { ['name'] = "News", ['payment'] = false, ['perm'] = "none.permission" },
	[616] = { ['name'] = "NewsH", ['payment'] = false, ['perm'] = "none.permission" },
	[617] = { ['name'] = "Carteiro", ['payment'] = false, ['public'] = true },
	[618] = { ['name'] = "Leiteiro", ['payment'] = false, ['public'] = true },
	[619] = { ['name'] = "Minerador", ['payment'] = false, ['public'] = true },
}
-- [ WORK VEHICLES ARRAY ] --
local workgarage = {
	["LSPD"] = {
		"14charger",
		"14explorer",
		"18charger",
		"20explorer",
		"2019tahoe",
		"vic",
		"taurus",
		"mustang19",
		"camaro19",
		"policiabmwr1200"
	},
	["LSPDH"] = {
		"policiaheli"
	},
	["EMS"] = {
		"amr_explorer",
		"amr_tahoe",
		"paramedicoambu"
	},
	["EMSH"] = {
		"paramedicoheli"
	},
	["Bennys"] = {
		"flatbed"
	},
	["Frutas"] = {
		"rebel"
	},
	["Mecanico"] = {
		"flatbed",
		"towtruck",
		"towtruck2"
	},
	["Carteiro"] = {
		"boxville2",
	},
	["Leiteiro"] = {
		"youga2",
	},
	["Minerador"] = {
		"tiptruck"
	},
	["Fazendeiro"] = {
		"tractor2",
		"rebel"
	},
	["Lixeiro"] = {
		"trash2"
	},
	["News"] = {
		"rumpo"
	},
	["NewsH"] = {
		"maverick"
	},
	["Taco"] = {
		"pcj"
	},
	["DMLA"] = {
		"paramedicoambu"
	},
	["DMLAH"] = {
		"paramedicoheli"
	}
}
-- [ MY VEHICLES FUNCTION ] --
function src.myVehicles(work)
	local source = source
	local user_id = vRP.getUserId(source)
	local myvehicles = {}
	local ipva = ""
	local vehstate = ""
	local status = ""
	local carDamage = ""
	if user_id then
		if workgarage[work] then
			for k,v in pairs(workgarage) do
				if k == work then
					for k2,v2 in pairs(v) do
						status = "<span class=\"green\">"..k.."</span>"
						ipva = "<span class=\"green\">Pago</span>"
						vehstate = "<i class=\"fas fa-car\"></i>"
						table.insert(myvehicles,{ name = v2, name2 = vRP.vehicleName(v2), engine = 100, body = 100, fuel = 100, status = status, ipva = ipva, vehstate = vehstate })
					end
				end
			end
			return myvehicles
		else
			local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
			local address = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })

			if #address > 0 then
				for k,v in pairs(address) do
					if v.home == work then
						for k2,v2 in pairs(vehicle) do
							if parseInt(os.time()) <= parseInt(vehicle[k2].time+24*60*60) then
								status = "<span class=\"red\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.2)).."</span>"
							elseif vehicle[k2].detido == 1 then
								status = "<span class=\"orange\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.1)).."</span>"
							else
								status = "<span class=\"green\">Gratuita</span>"
							end

							if vehicle[k2].state == 1 then
								vehstate = "<span class=\"vehOut\"><i class=\"fas fa-car\"></i></span>"
							else
								vehstate = "<span class=\"green\"><i class=\"fas fa-car\"></i></span>"
							end

							if vehicle[k2].detido == 1 then
								vehstate = "<span class=\"red\"><i class=\"fas fa-car\"></i></span>"
							end

							if parseInt(os.time()) >= parseInt(vehicle[k2].ipva+24*15*60*60) then
								ipva = "<span class=\"red\">Atrasado</span>"
							else
								ipva = "<span class=\"green\">Pago</span>"
							end
							table.insert(myvehicles,{ name = vehicle[k2].vehicle, name2 = vRP.vehicleName(vehicle[k2].vehicle), engine = parseInt(vehicle[k2].engine*0.1), body = parseInt(vehicle[k2].body*0.1), fuel = parseInt(vehicle[k2].fuel), status = status, ipva = ipva, vehstate = vehstate })
						end
						return myvehicles
					else
						for k2,v2 in pairs(vehicle) do
							if parseInt(os.time()) <= parseInt(vehicle[k2].time+24*60*60) then
								status = "<span class=\"red\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.2)).."</span>"
							elseif vehicle[k2].detido == 1 then
								status = "<span class=\"orange\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.1)).."</span>"
							else
								status = "<span class=\"green\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k2].vehicle)*0.005)).."</span>"
							end

							if vehicle[k2].state == 1 then
								vehstate = "<span class=\"vehOut\"><i class=\"fas fa-car\"></i></span>"
							else
								vehstate = "<span class=\"green\"><i class=\"fas fa-car\"></i></span>"
							end

							if vehicle[k2].detido == 1 then
								vehstate = "<span class=\"red\"><i class=\"fas fa-car\"></i></span>"
							end

							if parseInt(os.time()) >= parseInt(vehicle[k2].ipva+24*15*60*60) then
								ipva = "<span class=\"red\">Atrasado</span>"
							else
								ipva = "<span class=\"green\">Pago</span>"
							end
							table.insert(myvehicles,{ name = vehicle[k2].vehicle, name2 = vRP.vehicleName(vehicle[k2].vehicle), engine = parseInt(vehicle[k2].engine*0.1), body = parseInt(vehicle[k2].body*0.1), fuel = parseInt(vehicle[k2].fuel), status = status, ipva = ipva, vehstate = vehstate })
						end
						return myvehicles
					end
				end
			else
				for k,v in pairs(vehicle) do
					if parseInt(os.time()) <= parseInt(vehicle[k].time+24*60*60) then
						status = "<span class=\"red\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k].vehicle)*0.2)).."</span>"
					elseif vehicle[k].detido == 1 then
						status = "<span class=\"orange\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k].vehicle)*0.1)).."</span>"
					else
						status = "<span class=\"green\">$"..vRP.format(parseInt(vRP.vehiclePrice(vehicle[k].vehicle)*0.005)).."</span>"
					end

					if vehicle[k].state == 1 then
						vehstate = "<span class=\"vehOut\"><i class=\"fas fa-car\"></i></span>"
					else
						vehstate = "<span class=\"green\"><i class=\"fas fa-car\"></i></span>"
					end

					if vehicle[k].detido == 1 then
						vehstate = "<span class=\"red\"><i class=\"fas fa-car\"></i></span>"
					end


					if parseInt(os.time()) >= parseInt(vehicle[k].ipva+24*15*60*60) then
						ipva = "<span class=\"red\">Atrasado</span>"
					else
						ipva = "<span class=\"green\">Pago</span>"
					end
					table.insert(myvehicles,{ name = vehicle[k].vehicle, name2 = vRP.vehicleName(vehicle[k].vehicle), engine = parseInt(vehicle[k].engine*0.1), body = parseInt(vehicle[k].body*0.1), fuel = parseInt(vehicle[k].fuel), status = status, ipva = ipva, vehstate = vehstate })
				end
				return myvehicles
			end
		end
	end
end
-- [ SPAWN VEHICLES FUNCION ] --
function src.spawnVehicles(name,use)
	if name then
		local source = source
		local user_id = vRP.getUserId(source)
		if user_id then
			local identity = vRP.getUserIdentity(user_id)
			local value = vRP.getUData(parseInt(user_id),"vRP:multas")
			local multas = json.decode(value) or 0
			if multas >= 10000 then
				TriggerClientEvent("Notify",source,"negado","Você tem multas pendentes.",10000)
				return true
			end
			if not vCLIENT.returnVehicle(source,name) then
				local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = name })
				local tuning = vRP.getSData("custom:u"..user_id.."veh_"..name) or {}
				local custom = json.decode(tuning) or {}
				if vehicle[1] ~= nil then
					if parseInt(os.time()) <= parseInt(vehicle[1].time+24*60*60) then
						local ok = vRP.request(source,"Veículo na retenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b> dólares ?",60)
						if ok then
							if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then
								vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })
								TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.",10000)
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
							end
						end
					elseif parseInt(vehicle[1].detido) >= 1 then
						local ok = vRP.request(source,"Veículo na detenção, deseja acionar o seguro pagando <b>$"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.1)).."</b> dólares ?",60)
						if ok then
							if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.1)) then
								vRP.execute("creative/set_detido",{ user_id = parseInt(user_id), vehicle = name, detido = 0, time = 0 })
								TriggerClientEvent("Notify",source,"sucesso","Veículo liberado.",10000)
							else
								TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
							end
						end
					else
						if parseInt(os.time()) <= parseInt(vehicle[1].ipva+24*15*60*60) then
							if garages[use].payment then
								if vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental" then
									local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom)
									vehlist[vehid] = { parseInt(user_id),name }
									TriggerEvent("setPlateEveryone",identity.registration)
									TriggerClientEvent("Notify",source,"sucesso","Veículo Exclusivo ou Alugado, não será cobrado a taxa de liberação.",10000)


								end
								if (vRP.getBankMoney(user_id)+vRP.getMoney(user_id)) >= parseInt(vRP.vehiclePrice(name)*0.005 and not vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental") then
									local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom)
									if spawnveh and vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.005)) then
										vehlist[vehid] = { parseInt(user_id),name }
										TriggerEvent("setPlateEveryone",identity.registration)

									end
								else
									TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
								end
							else
								local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,vehicle[1].engine,vehicle[1].body,vehicle[1].fuel,custom,parseInt(vehicle[1].colorR),parseInt(vehicle[1].colorG),parseInt(vehicle[1].colorB),parseInt(vehicle[1].color2R),parseInt(vehicle[1].color2G),parseInt(vehicle[1].color2B),false)
								if spawnveh then
									vehlist[vehid] = { user_id,name }
									TriggerEvent("setPlateEveryone",identity.registration)
									vRP.execute("creative/set_vehicle_state",{ user_id = parseInt(user_id), vehicle = name, state = 1})
								end
							end
						else
							if vRP.vehicleType(tostring(name)) == "exclusive" or vRP.vehicleType(tostring(name)) == "rental" then
								local ok = vRP.request(source,"Deseja pagar a taxa do veículo "..vRP.vehicleName(name).." por $"..vRP.format(parseInt(vRP.vehiclePrice(name)*0.00)).." dólares?",60)
								if ok then
									if vRP.tryFullPayment(user_id,parseInt(vRP.vehiclePrice(name)*0.00)) then
										vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = name, ipva = parseInt(os.time()) })
										TriggerClientEvent("Notify",source,"sucesso","Pagamento do Vehicle Tax conclúido com sucesso.",10000)
									else
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
									end
								end
							else
								local price_tax = parseInt(vRP.vehiclePrice(name)*0.10)
								if price_tax > 100000 then
									price_tax = 100000
								end
								local ok = vRP.request(source,"Deseja pagar o Vehicle Tax do veículo <b>"..vRP.vehicleName(name).." por <b>$"..vRP.format(price_tax).." dólares?",60)
								if ok then
									if vRP.tryFullPayment(user_id,price_tax) then
										vRP.execute("creative/set_ipva",{ user_id = parseInt(user_id), vehicle = name, ipva = parseInt(os.time()) })
										TriggerClientEvent("Notify",source,"sucesso","Pagamento do Vehicle Tax conclúido com sucesso.",10000)
									else
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",10000)
									end
								end
							end
						end
					end
				else
					local spawnveh,vehid = vCLIENT.spawnVehicle(source,name,1000,1000,100,custom,0,0,0,0,0,0,true)
					if spawnveh then
						vehlist[vehid] = { user_id,name }
						TriggerEvent("setPlateEveryone",identity.registration)
					end
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Já possui um veículo deste modelo fora da garagem.",10000)
			end
		end
	end
end
-- [ SET STATE TO 0 ] --
AddEventHandler("playerDropped",function()
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.execute("creative/set_vehicle_state_to_zero",{ user_id = parseInt(user_id) })
end)

-- [ DELETE VEHICLES FUNCTION ] --
function src.deleteVehicles()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle = vRPclient.getNearestVehicle(source,30)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
		end
	end
end
-- [ VEHICLE DISSASEMBLE ] --
RegisterServerEvent("desmancheVehicles")
AddEventHandler("desmancheVehicles",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })
				vRP.giveInventoryItem(user_id,"dinheiro-sujo",parseInt(vRP.vehiclePrice(vname)*0.1))
				vCLIENT.deleteVehicle(source,vehicle)
				local identity = vRP.getUserIdentity(user_id)
			end
		end
	end
end)
-- [ DV ] --
RegisterCommand('dv',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		local vehicle = vRPclient.getNearestVehicle(source,7)
		if vehicle then
			vCLIENT.deleteVehicle(source,vehicle)
		end
	end
end)
-- [ LOCK VEHICLE ] --
function src.vehicleLock()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle and placa then
			local placa_user_id = vRP.getUserByRegistration(placa)
			if user_id == placa_user_id then
				vCLIENT.vehicleClientLock(-1,vnetid,lock)
				TriggerClientEvent("vrp_sound:source",source,'lock',0.5)
				vRPclient.playAnim(source,true,{{"anim@mp_player_intmenu@key_fob@","fob_click"}},false)
				if lock == 1 then
					TriggerClientEvent("Notify",source,"importante","Veículo trancado com sucesso.",8000)
				else
					TriggerClientEvent("Notify",source,"importante","Veículo destrancado com sucesso.",8000)
				end
			end
		end
	end
end
-- [ TRY DELETE ] --
function src.tryDelete(vehid,vehengine,vehbody,vehfuel)
	if vehlist[vehid] and vehid ~= 0 then
		local user_id = vehlist[vehid][1]
		local vehname = vehlist[vehid][2]
		local player = vRP.getUserSource(user_id)
		if player then
			vCLIENT.syncNameDelete(player,vehname)
		end

		if vehengine <= 100 then
			vehengine = 100
		end

		if vehbody <= 100 then
			vehbody = 100
		end

		if vehfuel >= 100 then
			vehfuel = 100
		end

		local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = vehname })
		if vehicle[1] ~= nil then
			vRP.execute("creative/set_update_vehicles",{ user_id = parseInt(user_id), vehicle = vehname, engine = parseInt(vehengine), body = parseInt(vehbody), fuel = parseInt(vehfuel) })
			vRP.execute("creative/set_vehicle_state",{ user_id = parseInt(user_id), vehicle = vehname, state = 0})
		end
	end
	vCLIENT.syncVehicle(-1,vehid)
end
-- [ TRY DELETE EVENT ] --
RegisterServerEvent("trydeleteveh")
AddEventHandler("trydeleteveh",function(vehid)
	vCLIENT.syncVehicle(-1,vehid)
end)
-- [ RETURN HOMES PERMISSION ] --
function src.returnHouses(nome,garage)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			local address = vRP.query("homes/get_homeuserid",{ user_id = parseInt(user_id) })
			if #address > 0 then
				for k,v in pairs(address) do
					if v.home == garages[garage].name then
						if parseInt(v.garage) == 1 then
							local resultOwner = vRP.query("homes/get_homeuseridowner",{ home = tostring(nome) })
							if resultOwner[1] then
								if parseInt(os.time()) >= parseInt(resultOwner[1].tax+24*15*60*60) then
									TriggerClientEvent("Notify",source,"aviso","A Property Tax da residência está atrasada.",10000)
									return false
								else
									vCLIENT.openGarage(source,nome,garage)
								end
							end
						end
					end
				end
			end
			if garages[garage].perm == "livre" then
				return vCLIENT.openGarage(source,nome,garage)
			elseif garages[garage].perm then
				if vRP.hasPermission(user_id,garages[garage].perm) then
					return vCLIENT.openGarage(source,nome,garage)
				end
			elseif garages[garage].public then
				return vCLIENT.openGarage(source,nome,garage)
			end
		end
		return false
	end
end
-- [ FREEZE VEHICLE ] --
RegisterCommand('travar',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"lspd.permission") then
			if vRPclient.isInVehicle(source) then
				local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
				if vehicle then
					TriggerClientEvent("progress",source,5000,"travar/destravar")
					SetTimeout(5000,function()
						vCLIENT.vehicleAnchor(source,vehicle)
					end)
				end
			end
		end
	end
end)
-- [ FREEZE BOAT ] --
RegisterCommand('ancorar',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.isInVehicle(source) then
			local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
			if vehicle then
				vCLIENT.boatAnchor(source,vehicle)
			end
		end
	end
end)
-- [ POLICE ALERT ] --
function src.policeAlert()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned,trunk,model,street = vRPclient.vehList(source,7)
		if vehicle then
			if math.random(100) >= 50 then
				local policia = vRP.getUsersByPermission("lspd.permission")
				local x,y,z = vRPclient.getPosition(source)
				for k,v in pairs(policia) do
					local player = vRP.getUserSource(parseInt(v))
					if player then
						async(function()
							local id = idgens:gen()
							TriggerClientEvent('chatMessage',player,"911",{64,64,255},"Roubo na ^1"..street.."^0 do veículo ^1"..model.."^0 de placa ^1"..placa.."^0 verifique o ocorrido.")
							police[id] = vRPclient.addBlip(player,x,y,z,304,3,"Ocorrência",0.6,false)
							SetTimeout(60000,function() vRPclient.removeBlip(player,police[id]) idgens:free(id) end)
						end)
					end
				end
			end
		end
	end
end

-- [ MY VEHICLES COMMAND ] --
RegisterCommand('myvehs',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if args[1] and parseInt(args[2]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[2]))
			local myvehicles = vRP.query("creative/get_vehicles",{ user_id = parseInt(user_id), vehicle = tostring(args[1]) })
			if myvehicles[1] then
				if vRP.vehicleType(tostring(args[1])) == "exclusive" or vRP.vehicleType(tostring(args[1])) == "rental" and not vRP.hasPermission(user_id,"staff.permission") then
					TriggerClientEvent("Notify",source,"negado",""..vRP.vehicleName(tostring(args[1])).." não pode ser transferido por ser um veículo Exclusivo",10000)
				else
					local identity = vRP.getUserIdentity(parseInt(args[2]))
					local identity2 = vRP.getUserIdentity(user_id)
					local price = tonumber(sanitizeString(vRP.prompt(source,"Valor:",""),"\"[]{}+=?!_()#@%/\\|,.",false))
					if vRP.request(source,"Deseja vender um <b>"..vRP.vehicleName(tostring(args[1])).."</b> para <b>"..identity.name.." "..identity.firstname.."</b> por <b>$"..vRP.format(parseInt(price)).."</b> dólares ?",30) then
						if vRP.request(nplayer,"Aceita comprar um <b>"..vRP.vehicleName(tostring(args[1])).."</b> de <b>"..identity2.name.." "..identity2.firstname.."</b> por <b>$"..vRP.format(parseInt(price)).."</b> dólares ?",30) then
							local vehicle = vRP.query("creative/get_vehicles",{ user_id = parseInt(args[2]), vehicle = tostring(args[1]) })
							if parseInt(price) > 0 then
								if vRP.tryFullPayment(parseInt(args[2]),parseInt(price)) then
									if vehicle[1] then
										TriggerClientEvent("Notify",source,"negado",""..identity.name.." "..identity.firstname.." já possui este modelo de veículo.",10000)
									else
										vRP.execute("creative/move_vehicle",{ user_id = parseInt(user_id), nuser_id = parseInt(args[2]), vehicle = tostring(args[1]) })

										local custom = vRP.getSData("custom:u"..parseInt(user_id).."veh_"..tostring(args[1]))
										local custom2 = json.decode(custom)
										if custom2 then
											vRP.setSData("custom:u"..parseInt(args[2]).."veh_"..tostring(args[1]),json.encode(custom2))
											vRP.execute("creative/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..tostring(args[1]) })
										end

										local chest = vRP.getSData("chest:u"..parseInt(user_id).."veh_"..tostring(args[1]))
										local chest2 = json.decode(chest)
										if chest2 then
											vRP.setSData("chest:u"..parseInt(args[2]).."veh_"..tostring(args[1]),json.encode(chest2))
											vRP.execute("creative/rem_srv_data",{ dkey = "chest:u"..parseInt(user_id).."veh_"..tostring(args[1]) })
										end

										TriggerClientEvent("Notify",source,"sucesso","Você vendeu "..vRP.vehicleName(tostring(args[1])).." e recebeu $"..vRP.format(parseInt(price)).." dólares.",20000)
										TriggerClientEvent("Notify",nplayer,"importante","Você recebeu as chaves do veículo "..vRP.vehicleName(tostring(args[1])).." por <b>$"..vRP.format(parseInt(price)).."</b> dólares.",40000)
											vRPclient.playSound(source,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
											vRPclient.playSound(nplayer,"Hack_Success","DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS")
											local consulta = vRP.getUData(user_id,"vRP:paypal")
											local resultado = json.decode(consulta) or 0
											vRP.setUData(user_id,"vRP:paypal",json.encode(parseInt(resultado + price)))
											SendWebhookMessage(webhookvehs,"```prolog\n[ID]: "..user_id.." "..identity2.name.." "..identity2.firstname.." \n[VENDEU]: "..vRP.vehicleName(tostring(args[1])).." \n[PARA]: "..(args[2]).." "..identity.name.." "..identity.firstname.." \n[VALOR]: $"..vRP.format(parseInt(price)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
										end
									else
										TriggerClientEvent("Notify",nplayer,"negado","Dinheiro insuficiente.",8000)
										TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",8000)
									end
								end
							end
						end
					end
				end
			else
				local vehicle = vRP.query("creative/get_vehicle",{ user_id = parseInt(user_id) })
				if #vehicle > 0 then
	                local car_names = {}
	                for k,v in pairs(vehicle) do
	                	table.insert(car_names, "<b>" .. vRP.vehicleName(v.vehicle) .. "</b> ("..v.vehicle..")")
	                    --TriggerClientEvent("Notify",source,"importante","<b>Modelo:</b> "..v.vehicle,10000)
	                end
	                car_names = table.concat(car_names, ", ")
	                TriggerClientEvent("Notify",source,"importante","Seus veículos: " .. car_names, 20000)
				else
					TriggerClientEvent("Notify",source,"importante","Você não possui nenhum veículo.",20000)
				end
			end
		end
	end)
-- [ SAVE LIVERY COMMAND ] --
RegisterCommand('savelivery',function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permission") then
		local vehicle,vnetid,placa,vname = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				local custom = json.decode(vRP.getSData("custom:u"..parseInt(puser_id).."veh_"..vname))
				local livery = vCLIENT.returnlivery(source,livery)
				custom.liveries = livery
				print(json.encode(custom))
				vRP.setSData("custom:u"..parseInt(puser_id).."veh_"..vname,json.encode(custom))
			end
		end
	end
end)
-- [ CHECK LIVERY PERM ] --
function src.CheckLiveryPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,"staff.permission")
end
-- [ RETURN VEHICLE HASH ] --
RegisterCommand('hash',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"staff.permission") then
        local vehassh = vCLIENT.getHash(source,vehiclehash)
        vRP.prompt(source,"Hash:",""..vehassh)
    end
end)

RegisterServerEvent("Vehiclesdesmanche")
AddEventHandler("Vehiclesdesmanche",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vnetid,placa,vname,lock,banned = vRPclient.vehList(source,7)
		if vehicle and placa then
			local puser_id = vRP.getUserByRegistration(placa)
			if puser_id then
				vRP.execute("creative/set_detido",{ user_id = parseInt(puser_id), vehicle = vname, detido = 1, time = parseInt(os.time()) })
				vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(vRP.vehiclePrice(vname)*0.1))
				vCLIENT.deleteVehicle(source,vehicle)
				local identity = vRP.getUserIdentity(user_id)
				SendWebhookMessage(webhookdesmanche,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[DESMANCHOU]: "..vname.." [ID]: "..puser_id.." \n[VALOR]: $"..vRP.format(parseInt(vRP.vehiclePrice(vname)*0.1)).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
