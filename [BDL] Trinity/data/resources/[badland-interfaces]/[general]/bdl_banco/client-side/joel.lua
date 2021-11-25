-- [ TUNNELS, DATABASE, VARIÀVEIS ETC ] --
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("bdl_inventory")
vRPex = Tunnel.getInterface("bdl_banco")
banK = Tunnel.getInterface("bdl_banco")

inMenu = false
local andamento = false
local segundos = 0
local showblips	= true
local atBanco = false
local BancoMenu	= true
local blip = nil
local hora = 0
-- [ ARRAY DOS ROUBOS ] --
local locais = {
	{ ['id'] = 1, ['x'] = 119.10, ['y'] = -883.70, ['z'] = 31.12, ['h'] = 71.0 },
	{ ['id'] = 2, ['x'] = -1315.80, ['y'] = -834.76, ['z'] = 16.96, ['h'] = 305.0 },
	{ ['id'] = 3, ['x'] = 285.45, ['y'] = 143.39, ['z'] = 104.18, ['h'] = 159.0 },
	{ ['id'] = 4, ['x'] = 1138.23, ['y'] = -468.89, ['z'] = 66.73, ['h'] = 74.0 },
	{ ['id'] = 5, ['x'] = 1077.76, ['y'] = -776.54, ['z'] = 58.25, ['h'] = 182.0 },
	{ ['id'] = 6, ['x'] = -712.89, ['y'] = -818.9, ['z'] = 23.73, ['h'] = 0.0 },
	{ ['id'] = 7, ['x'] = -821.7, ['y'] = -1081.93, ['z'] = 11.14, ['h'] = 31.0 },
	{ ['id'] = 8,['x'] = -1409.79, ['y'] = -100.47, ['z'] = 52.39, ['h'] = 107.0 },
	{ ['id'] = 9, ['x'] = -846.27, ['y'] = -341.33, ['z'] = 38.69, ['h'] = 116.0 },
	{ ['id'] = 10, ['x'] = -2072.44, ['y'] = -317.22, ['z'] = 13.32, ['h'] = 260.0 },
	{ ['id'] = 11, ['x'] = -526.61, ['y'] = -1222.98, ['z'] = 18.46, ['h'] = 153.0 },
	{ ['id'] = 12, ['x'] = -254.39, ['y'] = -692.46, ['z'] = 33.61, ['h'] = 159.0 },
	{ ['id'] = 13, ['x'] = -283.0, ['y'] = 6226.13, ['z'] = 31.5, ['h'] = 313.90 },
	{ ['id'] = 14, ['x'] = 155.91, ['y'] = 6642.9, ['z'] = 31.61, ['h'] = 313.90 },
}
-- [ ARRAY DOS BANCOS ] --
local Bancos = {
	{name='Banco', id=108, x=148.55, y=-1040.32, z=29.38},
	{name='Banco', id=108, x=149.87, y=-1040.82, z=29.38},
	{name='Banco', id=108, x=-1212.980, y=-330.841, z=37.787},
	{name='Banco', id=108, x=-2962.582, y=482.627, z=15.703},
	{name='Banco', id=108, x=-112.202, y=6469.295, z=31.626},
	{name='Banco', id=108, x=314.187, y=-278.621, z=54.170},
	{name='Banco', id=108, x=-351.534, y=-49.529, z=49.042},
	{name='Banco', id=106, x=241.54, y=225.37, z=106.29, principal = true},
	{name='Banco', id=108, x=1175.064, y=2706.643, z=38.094}
}	
-- [ ARRAY DOS ATMS ] --
local atms = {
	{name='ATM', id=277, x=145.97, y=-1035.17, z=29.35},
	{name='ATM', id=277, x=147.63, y=-1035.69, z=29.35},
	{name='ATM', id=277, x=298.81, y=-588.77, z=43.3},
	{name='ATM', id=277, x=-586.48, y=-143.28, z=47.21},
	{name='ATM', id=277, x=-588.52, y=-141.19, z=47.21},
	{name='ATM', id=277, x=-587.47, y=-142.29, z=47.21},
	{name='ATM', id=277, x=-577.08, y=-194.81, z=38.22},
	{name='ATM', id=277, x=-527.75, y=-166.08, z=38.24},
	{name='ATM', id=277, x=-537.25, y=-171.61, z=38.22},
	{name='ATM', id=277, x=-386.733, y=6045.953, z=31.501},
	{name='ATM', id=277, x=-283.03, y=6226.09, z=31.5, assaltavel=true},
	{name='ATM', id=277, x=-132.99, y=6366.5, z=31.48},
	{name='ATM', id=277, x=-97.3, y=6455.44, z=31.47},
	{name='ATM', id=277, x=-95.53, y=6457.11, z=31.47}, 
	{name='ATM', id=277, x=155.91, y=6642.9, z=31.61, assaltavel=true},
	{name='ATM', id=277, x=174.14, y=6637.92, z=31.58},
	{name='ATM', id=277, x=1701.21, y=6426.56, z=32.77},
	{name='ATM', id=277, x=1735.27, y=6410.52, z=35.04},
	{name='ATM', id=277, x=1703.03, y=4933.59, z=42.07},
	{name='ATM', id=277, x=1968.09, y=3743.54, z=32.35},
	{name='ATM', id=277, x=1822.67, y=3683.1, z=34.28},
	{name='ATM', id=277, x=540.29, y=2671.14, z=42.16},
	{name='ATM', id=277, x=2564.5, y=2584.79, z=38.09},
	{name='ATM', id=277, x=2558.76, y=351.01, z=108.63},
	{name='ATM', id=277, x=2558.5, y=389.49, z=108.63},
	{name='ATM', id=277, x=1077.76, y=-776.54, z=58.25, assaltavel=true},
	{name='ATM', id=277, x=1166.96, y=-456.13, z=66.81},
	{name='ATM', id=277, x=1153.73, y=-326.8, z=69.21},
	{name='ATM', id=277, x=380.77, y=323.39, z=103.57},
	{name='ATM', id=277, x=285.51, y=143.42, z=104.18, assaltavel=true},
	{name='ATM', id=277, x=158.65, y=234.22, z=106.63},
	{name='ATM', id=277, x=-165.1, y=232.72, z=94.93},
	{name='ATM', id=277, x=-165.16, y=234.77, z=94.93},
	{name='ATM', id=277, x=-1827.26, y=784.89, z=138.31},
	{name='ATM', id=277, x=-1409.74, y=-100.47, z=52.39, assaltavel=true},
	{name='ATM', id=277, x=-1410.35, y=-98.75, z=52.43},
	{name='ATM', id=277, x=-1204.97, y=-326.33, z=37.84},
	{name='ATM', id=277, x=-1205.75, y=-324.82, z=37.86},
	{name='ATM', id=277, x=-1215.64, y=-332.231, z=37.881},
	{name='ATM', id=277, x=-2072.35, y=-317.24, z=13.32, assaltavel=true},
	{name='ATM', id=277, x=-2975.07, y=380.14, z=15.0},
	{name='ATM', id=277, x=-2956.82, y=487.68, z=15.47},
	{name='ATM', id=277, x=-2958.98, y=487.74, z=15.47},
	{name='ATM', id=277, x=-3043.98, y=594.57, z=7.74},
	{name='ATM', id=277, x=-3144.39, y=1127.58, z=20.86},
	{name='ATM', id=277, x=-3241.17, y=997.59, z=12.56},
	{name='ATM', id=277, x=-3240.57, y=1008.61, z=12.84},
	{name='ATM', id=277, x=-1305.36, y=-706.43, z=25.33},
	{name='ATM', id=277, x=-537.81, y=-854.51, z=29.3},
	{name='ATM', id=277, x=-712.95, y=-818.91, z=23.73, assaltavel=true},
	{name='ATM', id=277, x=-710.09, y=-818.91, z=23.73},
	{name='ATM', id=277, x=-717.71, y=-915.73, z=19.22},
	{name='ATM', id=277, x=-526.61, y=-1222.98, z=18.46, assaltavel=true},
	{name='ATM', id=277, x=-256.24, y=-716.02, z=33.53},
	{name='ATM', id=277, x=-203.8, y=-861.4, z=30.27},
	{name='ATM', id=277, x=111.22, y=-775.22, z=31.44},
	{name='ATM', id=277, x=114.39, y=-776.35, z=31.42},
	{name='ATM', id=277, x=112.62, y=-819.41, z=31.34},
	{name='ATM', id=277, x=119.05, y=-883.69, z=31.13, assaltavel=true},
	{name='ATM', id=277, x=-846.25, y=-341.33, z=38.69, assaltavel=true},
	{name='ATM', id=277, x=-846.84, y=-340.21, z=38.69},
	{name='ATM', id=277, x=-1204.98, y=-326.33, z=37.84},
	{name='ATM', id=277, x=-56.96, y=-1752.07, z=29.43},
	{name='ATM', id=277, x=-262.03, y=-2012.33, z=30.15},
	{name='ATM', id=277, x=-273.11, y=-2024.54, z=30.15},
	{name='ATM', id=277, x=24.44, y=-945.97, z=29.36},
	{name='ATM', id=277, x=-254.39, y=-692.46, z=33.61, assaltavel=true},
	{name='ATM', id=277, x=-1570.197, y=-546.651, z=34.955},
	{name='ATM', id=277, x=-1571.03, y=-547.37, z=34.96},
	{name='ATM', id=277, x=-1415.94, y=-212.02, z=46.51},
	{name='ATM', id=277, x=-1430.112, y=-211.014, z=46.500},
	{name='ATM', id=277, x=33.17, y=-1348.23, z=29.5},
	{name='ATM', id=277, x=129.216, y=-1292.347, z=29.269},
	{name='ATM', id=277, x=288.76, y=-1282.29, z=29.65},
	{name='ATM', id=277, x=289.11, y=-1256.81, z=29.45},
	{name='ATM', id=277, x=296.48, y=-894.14, z=29.24},
	{name='ATM', id=277, x=295.74, y=-896.08, z=29.22},
	{name='ATM', id=277, x=1686.753, y=4815.809, z=42.008},
	{name='ATM', id=277, x=-303.28, y=-829.72, z=32.42},
	{name='ATM', id=277, x=5.27, y=-919.85, z=29.56},
	{name='ATM', id=277, x=-1074.01, y=-827.69, z=19.04},
	{name='ATM', id=277, x=-1110.92, y=-836.26, z=19.01},
	{name='ATM', id=277, x=-1074.39, y=-827.47, z=27.04},
	{name='ATM', id=277, x=-660.68, y=-854.05, z=24.49},
	{name='ATM', id=277, x=-1315.75, y=-834.68, z=16.97, assaltavel=true},
	{name='ATM', id=277, x=-1314.78, y=-835.99, z=16.97},
	{name='ATM', id=277, x=1138.23, y=-468.94, z=66.74, assaltavel=true},
	{name='ATM', id=277, x=-821.7, y=-1081.93, z=11.14, assaltavel=true},
	{name='ATM', id=277, x=236.6, y=219.66, z=106.29},
	{name='ATM', id=277, x=237.02, y=218.76, z=106.29},
	{name='ATM', id=277, x=237.48, y=217.83, z=106.29},
	{name='ATM', id=277, x=237.89, y=216.93, z=106.29},
	{name='ATM', id=277, x=238.32, y=215.98, z=106.29},
	{name='ATM', id=277, x=265.82, y=213.89, z=106.29},
	{name='ATM', id=277, x=265.51, y=212.96, z=106.29},
	{name='ATM', id=277, x=265.17, y=212.0, z=106.29},
	{name='ATM', id=277, x=264.81, y=211.06, z=106.29},
	{name='ATM', id=277, x=264.46, y=210.08, z=106.29},
	{name='ATM', id=277, x=24.45, y=-946.01, z=29.36},
	{name='ATM', id=277, x=-258.77, y=-723.38, z=33.47},
	{name='ATM', id=277, x=-611.87, y=-704.81, z=31.24},
	{name='ATM', id=277, x=-614.58, y=-704.84, z=31.24},
	{name='ATM', id=277, x=-866.65, y=-187.74, z=37.85},
	{name='ATM', id=277, x=-867.61, y=-186.1, z=37.85},
	{name='ATM', id=277, x=-567.89, y=-234.35, z=34.25},
	{name='ATM', id=277, x=-301.68, y=-830.05, z=32.42},
	{name='ATM', id=277, x=-37.81, y=-1115.22, z=26.44},
	{name='ATM', id=277, x=-200.63, y=-1309.54, z=31.3},
	{name='ATM', id=277, x=903.81, y=-164.08, z=74.17}
}
-- [ CALCULO DO TEMPO ] --
function CalculateTimeToDisplay()
	hora = GetClockHours()
	if hora <= 9 then
		hora = "0" .. hora
	end
end
-- [ THREAD DO ACESSO AO BANCO ] --
if BancoMenu then
	Citizen.CreateThread(function()
		while true do
			local idle = 1000
			if nearBanco() then
				idle = 5
				if IsControlJustPressed(1, 38) then
					CalculateTimeToDisplay()
					if parseInt(hora) >= 07 and parseInt(hora) <= 17 then
						local  carteira,banco,coins,nome,sobrenome,idade,user_id,identidade,telefone,job,cargo,vip,faturas,multas,mypaypal = vSERVER.Identidade()
						SendNUIMessage({
							type = 'open',
							nome = nome,
							sobrenome = sobrenome,
							carteira = carteira,
							banco = banco,
							vip = vip,
							emprego = job,
							cargo = cargo,
							id = user_id,
							documento = identidade,
							idade = idade,
							telefone = telefone,
							multas = multas,
							mypaypal = mypaypal
						})
						inMenu = true
						SetNuiFocus(true, true)
						SendNUIMessage({type = 'openGeneral'})
						TriggerServerEvent('banco:balance')
						TriggerServerEvent("get:banco")
						TriggerEvent('bdl:triggerhud')
						print('BDL Bank v0.1.3 - E&G Vendas')
						local ped = GetPlayerPed(-1)
					else
						TriggerEvent("Notify","importante","Funcionamento dos bancos é das <b>07:00</b> as <b>18:00</b>.") 
					end
				end
			end

			if nearATM() then
				idle = 5
				if IsControlJustPressed(1, 38) then
				local  carteira,banco,coins,nome,sobrenome,idade,user_id,identidade,telefone,job,cargo,vip,faturas,multas,mypaypal = vSERVER.Identidade()
						SendNUIMessage({
							type = 'open',
							nome = nome,
							sobrenome = sobrenome,
							carteira = carteira,
							banco = banco,
							vip = vip,
							emprego = job,
							cargo = cargo,
							id = user_id,
							documento = identidade,
							idade = idade,
							telefone = telefone,
							multas = multas,
							mypaypal = mypaypal
						})
					inMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openGeneral', isATM = true})
					TriggerServerEvent('banco:balance')
					TriggerEvent('bdl:triggerhud')
					TriggerServerEvent("get:banco")
					local ped = GetPlayerPed(-1)
				end
			end
					
			if IsControlJustPressed(1, 322) then
				inMenu = false
				SetNuiFocus(false, false)
				SendNUIMessage({type = 'close'})
			end
			Wait(idle)
		end
	end)
end
-- [ EVENTOS & CALLBACKS ] --
RegisterNetEvent('currentbalance')
AddEventHandler('currentbalance', function(balance,wallet,citation)
	local id = PlayerId()
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		wallet = wallet,
		citation = citation
	})
end)
RegisterNetEvent('currentbalance2')
AddEventHandler('currentbalance2', function()
	TriggerServerEvent('banco:balance')
end)
RegisterNUICallback('multasbalance', function(data, cb)
	SendNUIMessage({openSection = "multasbalance"})
	cb('ok')
end)
RegisterNetEvent('banking:updateBalance')
AddEventHandler('banking:updateBalance', function(balance,wallet,citation)
	SendNUIMessage({
	updateBalance = true,
	balance = balance,
	wallet = wallet,
    citation = citation
	})
end)
RegisterNetEvent('send:banco')
AddEventHandler('send:banco', function(banco)
  SendNUIMessage({
	  openBank = true,
	  banco = banco
	})
end)
-- [ CALLBACK DO DEPOSITO ] --
RegisterNUICallback('depositar', function(data)
	TriggerServerEvent('banco:depositar', tonumber(data.amount))
	TriggerServerEvent('banco:balance')
end)
-- [ CALLBACK DO SAQUE ] --
RegisterNUICallback('sacar', function(data)
	TriggerServerEvent('banco:sacar', tonumber(data.amounts))
	TriggerServerEvent('banco:balance')
	TriggerEvent('balance')
end)
-- [ CALLBACK DA MULTA PT 3 ] --
RegisterNUICallback('multa', function(data)
	TriggerServerEvent('banco:multas', tonumber(data.amountm))
	TriggerServerEvent('banco:balance')
end)
-- [ CALLBACK DA MULTA PT 2 ] --
RegisterNUICallback('pagar', function(data)
	TriggerServerEvent('banco:pagar', tonumber(data.amountp))
	TriggerServerEvent('banco:balance')
end)
-- [ CALLBACK DO SALDO ] --
RegisterNUICallback('balance', function()
	TriggerServerEvent('banco:balance')
end)
-- [ CALLBACK DA MULTA ] --
RegisterNUICallback('citation', function()
	TriggerServerEvent('banco:citation')
end)
-- [ EVENTO DE ATUALIZAÇÃO DA MULTA NA NUI ] --
RegisterNetEvent('citation:back')
AddEventHandler('citation:back', function(citation)
	SendNUIMessage({type = 'citationReturn', cit = citation})
end)
-- [ EVENTO DE ATUALIZAÇÃO DO SALDO NA NUI ] --
RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)
-- [ CALLBACK DA TRANSFERÊNCIA ] --
RegisterNUICallback('transferir', function(data)
	TriggerServerEvent('banco:transferir', data.to, data.amountt)
	TriggerServerEvent('banco:balance')
end)
-- [ EVENTO DO RESULTADO ] --
RegisterNetEvent('banco:result')
AddEventHandler('banco:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)
-- [ TIRAR O FOCO DA NUI ] --
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
	TriggerEvent('bdl:triggerhud')
end)
-- [ VERIFICAR DISTÂNCIA DO CLIENT A AGÊNCIA ] --
function nearBanco()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	for _, search in pairs(Bancos) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 1 then
			if not inMenu then
				DrawText3D(search.x, search.y, search.z, "[~g~E~w~] Para acessar o ~g~BANCO")
				return true
			end
		end
	end
end
-- [ VERIFICAR DISTÂNCIA DO CLIENT AO ATM ] --
function nearATM()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(atms) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 1 and not andamento then
			if search.assaltavel == true then 
				if not inMenu then
					DrawText3D(search.x, search.y, search.z, "[~g~E~w~] Para acessar o ~g~CAIXA ELETRÔNICO    ~w~[~r~G~w~] Para iniciar o ~r~ROUBO~w~.")
					return true
				end
			else
				if not inMenu then
					DrawText3D(search.x, search.y, search.z, "[~g~E~w~] Para acessar o ~g~CAIXA ELETRÔNICO~w~.")
					return true
				end
			end
		end
	end
end
-- [ THREAD DO ROUBO ] --
Citizen.CreateThread(function()
	while true do
		local sleep = 1000
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
					sleep = 5
					if IsControlJustPressed(0,47) then
						banK.checkRobbery(v.id,v.x,v.y,v.z,v.h)
					end
				end
			end
			if andamento then
				sleep = 5
				drawTxt("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",4,0.5,0.90,0.35,255,255,255,150)
				drawTxt("RESTAM ~r~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",4,0.5,0.92,0.35,255,255,255,200)
				if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 100 or IsPedBeingStunned(ped) then
					andamento = false
					ClearPedTasks(ped)
					banK.cancelRobbery()
					TriggerEvent('cancelando',false)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-- [ NATIVES DO ROUBO ] --
RegisterNetEvent("iniciandocaixaeletronico")
AddEventHandler("iniciandocaixaeletronico",function(x,y,z,secs,head)
	segundos = secs
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	TriggerEvent('cancelando',true)
end)
-- [ THREAD DA CONTAGEM ] --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)
-- [ DRAW TXT ] --
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-- [ ADICIONAR BLIP DO ROUBO ] --
RegisterNetEvent('blip:criar:caixaeletronico')
AddEventHandler('blip:criar:caixaeletronico',function(x,y,z)
	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(x,y,z)
		SetBlipScale(blip,0.5)
		SetBlipSprite(blip,1)
		SetBlipColour(blip,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo: Caixa Eletrônico")
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
	end
end)
-- [ REMOVER BLIP DO ROUBO ] --
RegisterNetEvent('blip:remover:caixaeletronico')
AddEventHandler('blip:remover:caixaeletronico',function()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end
end)
-- [ TEXTO 3D ] --
function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end