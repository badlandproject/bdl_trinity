-- [ TUNNELS, DATABASE, VARIÀVEIS ETC ] --
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

vRP._prepare("sRP/banco",[[
  CREATE TABLE IF NOT EXISTS vrp_bdl_banco(
    id INTEGER AUTO_INCREMENT,
    user_id INTEGER,
    extrato VARCHAR(255),
    data VARCHAR(255),
    CONSTRAINT pk_banco PRIMARY KEY(id)
  )
]])

vRP._prepare("sRP/inserir_table","INSERT INTO vrp_bdl_banco(user_id, extrato, data) VALUES(@user_id, @extrato, DATE_FORMAT(CURDATE(), '%d/%m/%Y') )")
vRP._prepare("sRP/get_banco_id","SELECT * FROM vrp_bdl_banco WHERE user_id = @user_id")
vRP._prepare("sRP/get_dinheiro","SELECT bank FROM vrp_user_moneys WHERE user_id = @user_id")
vRP._prepare("sRP/set_banco","UPDATE vrp_user_moneys SET bank = @bank WHERE user_id = @user_id")

async(function()
  vRP.execute("sRP/banco")
end)

vRPex = {}
Tunnel.bindInterface("bdl_banco",vRPex)

banK = {}
Tunnel.bindInterface("bdl_banco",banK)
Proxy.addInterface("bdl_banco",banK)

local timers = 0
local recompensa = 0
local andamento = false
local dinheirosujo = {}
-- [ TEMPO DO ROUBO ] --
local caixas = {
	[1] = { ['seconds'] = 25 },
	[2] = { ['seconds'] = 39 },
	[3] = { ['seconds'] = 39 },
	[4] = { ['seconds'] = 35 },
	[5] = { ['seconds'] = 33 },
	[6] = { ['seconds'] = 33 },
	[7] = { ['seconds'] = 55 },
	[8] = { ['seconds'] = 39 },
	[9] = { ['seconds'] = 35 },
	[10] = { ['seconds'] = 60 },
	[11] = { ['seconds'] = 43 },
	[12] = { ['seconds'] = 27 },
	[13] = { ['seconds'] = 45 },
	[14] = { ['seconds'] = 120 }
}
-- [ WEBHOOKS ] --
local depositLog = "SEULINK"
local withdrawLog = "SEULINK"
local citationLog = "SEULINK"
local transferLog = "SEULINK"
local caixinhaLog = "SEULINK"

-- [ GET BANCO EVENTO ] --
RegisterServerEvent('get:banco')
AddEventHandler('get:banco', function()
    local banco = {}
    local source = source
    local user_id = vRP.getUserId(source)
    local ban = vRP.query("sRP/get_banco_id", {user_id = user_id})
    for i=1, #ban, 1 do
      table.insert(banco, {
        extrato = ban[i].extrato,
        data = ban[i].data
	  })
    end
    TriggerClientEvent('send:banco', source, banco)
end)
-- [ EVENTO DE DEPOSITO ] --
RegisterServerEvent('banco:depositar')
AddEventHandler('banco:depositar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local getBank = vRP.getBankMoney(user_id)
	local updateValue = vRP.getBankMoney(user_id) + parseInt(amount)
	PerformHttpRequest(depositLog, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE DEPÓSITO:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
						}, 
						fields = {
							{ 
								name = "**Nº do ID:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**Depositou a quantia de:**", 
								value = "` $"..parseInt(amount).." `"
							},
							{ 
								name = "**O saldo no banco do usuário era de:**",
								value = "` $"..parseInt(getBank).." `"
							},
							{ 
								name = "**O saldo no banco do usuário agora é de:**",
								value = "` $"..parseInt(updateValue).." `"
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
						},
						color = 15914080
					}
				}
			}), { ['Content-Type'] = 'application/json' })

	if amount == nil or amount <= 0 or amount > vRP.getMoney(user_id) then
		TriggerClientEvent("Notify",_source,"negado","Valor inválido")
	else
		vRP.tryDeposit(user_id, tonumber(amount))
		TriggerClientEvent("Notify",_source,"sucesso","Você depositou $"..amount.." dólares.")
		vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você depositou $"..amount.." dólares"})
		
	end
end)
-- [ EVENTO DE SAQUE ] --
RegisterServerEvent('banco:sacar')
AddEventHandler('banco:sacar', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local getBank = vRP.getBankMoney(user_id)
	local updateValue = getBank - parseInt(amount)
	

	amount = tonumber(amount)
	local getbankmoney = vRP.getBankMoney(user_id)

	if amount == nil or amount <= 0 or amount > getbankmoney then
		TriggerClientEvent("Notify",_source,"negado","Valor inválido")
	else
		vRP.tryWithdraw(user_id,amount)
		TriggerClientEvent("Notify",_source,"sucesso","Você sacou $"..amount.." dólares.")
		vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você sacou $"..amount.." dólares"})
		PerformHttpRequest(withdrawLog, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE SAQUE:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
						}, 
						fields = {
							{ 
								name = "**Nº do ID:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**Sacou a quantia de:**", 
								value = "` $"..parseInt(amount).." `"
							},
							{ 
								name = "**O saldo no banco do usuário era de:**",
								value = "` $"..parseInt(getBank).." `"
							},
							{ 
								name = "**O saldo no banco do usuário agora é de:**",
								value = "` $"..parseInt(updateValue).." `"
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
						},
						color = 15914080
					}
				}
			}), { ['Content-Type'] = 'application/json' })
	end
end)
-- [ EVENTO DE MULTAS ] --
RegisterServerEvent('banco:multas')
AddEventHandler('banco:multas', function(amount)
	local _source = source
	local user_id = vRP.getUserId(_source)
	local banco = vRP.getBankMoney(user_id)

	local valor = parseInt(amount)

	if banco >= parseInt(amount) then
		local multas = vRP.getUData(user_id,"vRP:multas")
		local int = parseInt(multas)
		if int >= valor then
			
				local rounded = math.ceil(valor)
				local novamulta = int - rounded
				vRP.setUData(user_id,"vRP:multas",json.encode(novamulta))
				vRP.setBankMoney(user_id,banco-tonumber(valor))
				TriggerClientEvent("Notify",_source,"sucesso","Você pagou $"..valor.." em multas.")
				TriggerClientEvent("currentbalance2",_source)
				vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você pagou $"..parseInt(amount)..",00 dólares em multas. Valor pendente: $"..novamulta..',00.'})
		else
			TriggerClientEvent("Notify",_source,"negado","Você não pode pagar mais multas do que possuí.")
		end
	else
		TriggerClientEvent("Notify",_source,"negado","Saldo inválido.")
	end
end)
-- [ EVENTO DO SALDO ] --
RegisterServerEvent('banco:balance')
AddEventHandler('banco:balance', function()
	local _source = source
	local user_id = vRP.getUserId(_source)
	local getbankmoney = vRP.getBankMoney(user_id)
	local getwalletmoney = vRP.getMoney(user_id)
	local citation = parseInt(vRP.getUData(user_id,"vRP:multas"))
	TriggerClientEvent("currentbalance",_source,getbankmoney,getwalletmoney,citation)
end)
-- [ EVENTO DE TRANSFERÊNCIA ] --
RegisterServerEvent('banco:transferir')
AddEventHandler('banco:transferir', function(to,amountt)
	local _source = source
	local user_id = vRP.getUserId(_source)
	
	local getBankUser = vRP.getBankMoney(user_id)
	local updateValueUser = getBankUser - parseInt(amountt)

	local _nplayer = vRP.getUserSource(parseInt(to))
	local nuser_id = vRP.getUserId(_nplayer)
	
	local getBankNuser = vRP.getBankMoney(nuser_id)
	local updateValueNuser = getBankNuser + parseInt(amountt)
	local banco = 0

	if nuser_id == nil then
		TriggerClientEvent("Notify",_source,"negado","Passaporte inválido ou indisponível.")
	else
		if nuser_id == user_id then
			TriggerClientEvent("Notify",_source,"negado","Você não pode transferir a si mesmo.")
		else
			local banco = vRP.getBankMoney(user_id)
			local banconu = vRP.getBankMoney(nuser_id)
			
			if banco <= 0 or banco < tonumber(amountt) or tonumber(amountt) <= 0 then
				TriggerClientEvent("Notify",_source,"negado","Dinheiro Insuficiente")
			else
				vRP.setBankMoney(user_id,banco-tonumber(amountt))
				vRP.setBankMoney(nuser_id,banconu+tonumber(amountt))

				TriggerClientEvent("Notify",_nplayer,"sucesso","O passaporte nº"..user_id.." depositou $"..amountt.." dólares na sua conta.",10000)
				TriggerClientEvent("Notify",_source,"sucesso","Você transferiu $"..amountt.." dólares para o passaporte nº"..nuser_id,10000)
				vRP.execute("sRP/inserir_table", {user_id = user_id, extrato = "Você transferiu $"..amountt.." dólares para o ID Nº"..nuser_id})
				PerformHttpRequest(transferLog, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE TRANSFERÊNCIA:⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
						thumbnail = {
						url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
						}, 
						fields = {
							{ 
								name = "**Nº do ID:**", 
								value = "` "..user_id.." ` "
							},
							{ 
								name = "**Enviou para o Nº do ID:**", 
								value = "` "..nuser_id.." ` "
							},
							{ 
								name = "**A quantia de:**", 
								value = "` $"..parseInt(amountt).." `"
							},
							{ 
								name = "**O saldo no banco do usuário que enviou era de:**",
								value = "` $"..parseInt(getBankUser).." `"
							},
							{ 
								name = "**O saldo no banco do usuário que enviou é de:**",
								value = "` $"..parseInt(updateValueUser).." `"
							},
							{ 
								name = "**O saldo no banco do usuário que recebeu era de:**",
								value = "` $"..parseInt(getBankNuser).." `"
							},
							{ 
								name = "**O saldo no banco do usuário que recebeu é de:**",
								value = "` $"..parseInt(updateValueNuser).." `"
							},
						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"), 
							icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png" 
						},
						color = 15914080
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			end
		end
		
	end
end)
-- [ FUNÇÃO PRINCIPAL DO ROUBO ] --
function banK.checkRobbery(id,x,y,z,head)
	local source = source
	local user_id = vRP.getUserId(source)
	local policia = vRP.getUsersByPermission("lspd.permission")
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		if #policia < 0 then
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		elseif (os.time()-timers) <= 1800 then
			TriggerClientEvent("Notify",source,"aviso","Os caixas estão vazios, aguarde "..vRP.format(parseInt((1800-(os.time()-timers)))).." segundos.",8000)
		else
			local yes = vRP.request(user_id,"Você realmente deseja iniciar o roubo?",30)
			if yes then
				andamento = true
				timers = os.time()
				dinheirosujo = {}
				dinheirosujo[user_id] = caixas[id].seconds
				vRPclient.setStandBY(source,parseInt(800))
				recompensa = parseInt(math.random(8000,14000)/caixas[id].seconds)
				TriggerClientEvent('iniciandocaixaeletronico',source,x,y,z,caixas[id].seconds,head)
				vRPclient._playAnim(source,false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
				for l,w in pairs(policia) do
					local player = vRP.getUserSource(parseInt(w))
					if player then
						async(function()
							TriggerClientEvent('blip:criar:caixaeletronico',player,x,y,z)
							vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
							TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo começou no ^1Caixa Eletrônico^0, dirija-se até o local e intercepte os assaltantes.")
						end)
					end
				end
			end
			
			PerformHttpRequest(caixinhaLog, function(err, text, headers) end, 'POST', json.encode({
				embeds = {
					{ 
						title = "REGISTRO DE ASSALTO:",
						thumbnail = {
							url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
						}, 
						fields = {
							{ 
								name = "**IDENTIFICAÇÃO DO PLAYER:**",
								value = "**"..identity.name.." "..identity.firstname.."** [**"..user_id.."**] \n⠀"
							},
							{ 
								name = "**LUCRO DO ASSALTO:**",
								value = "**$"..parseInt(recompensa).." dólares**\n⠀"
							},

						}, 
						footer = { 
							text = os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S"),
							icon_url = "https://cdn.discordapp.com/attachments/740912067095035955/757142616054824970/badland2.png"
						},
						color = 15906321 
					}
				}
			}), { ['Content-Type'] = 'application/json' })
			
			SetTimeout(caixas[id].seconds*1000,function()
				if andamento then
					andamento = false
					for l,w in pairs(policia) do
						local player = vRP.getUserSource(parseInt(w))
						if player then
							async(function()
								TriggerClientEvent('blip:remover:caixaeletronico',player)
								TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
							end)
						end
					end
				end
			end)
		end
	end
end
-- [ FUNÇÃO DE CANCELAR O ROUBO ] --
function banK.cancelRobbery()
	if andamento then
		andamento = false
		local policia = vRP.getUsersByPermission("dpla.permissao")
		for l,w in pairs(policia) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					TriggerClientEvent('blip:remover:caixaeletronico',player)
					TriggerClientEvent('chatMessage',player,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
				end)
			end
		end
	end
end
-- [ PEGAR AS INFORMAÇÕES DO CLIENT ] --
function vRPex.Infos()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local id = user_id
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			return vRP.format(parseInt(carteira)),vRP.format(parseInt(banco)),identity.name,identity.firstname,identity.age,identity.user_id,identity.registration
		end
	end
end
-- [ RECOMPENSA DO ROUBO ] --
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			for k,v in pairs(dinheirosujo) do
				if v > 0 then
					dinheirosujo[k] = v - 1
					vRP._giveInventoryItem(k,"dinheiro-sujo",recompensa)
				end
			end
		end
	end
end)
-- [ PERMISSÕES ] --
function banK.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return not (vRP.hasPermission(user_id,"dpla.permissao") or vRP.hasPermission(user_id,"dmla.permissao") or vRP.hasPermission(user_id,"paisana-dpla.permissao") or vRP.hasPermission(user_id,"paisana-dmla.permissao"))
end





