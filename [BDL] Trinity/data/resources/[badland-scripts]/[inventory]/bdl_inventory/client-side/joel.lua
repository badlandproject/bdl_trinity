------------------------------------------------------------------------------------------------------
-- [ PRODUTO ADQUIRIDO EM E&G VENDAS (discord.gg/bABGBEX) ]   										--
-- [ DESENVOLVIDO POR Edu#0069 // BACK-END POR ALLSTAR BASE ]   									--
-- [ SE VOCÊ ADQUIRIU ESSE PRODUTO, VOCÊ TEM DIREITO A SUPORTE GRATUITO ]   						--
-- [ OBRIGADO PELA CONFIANÇA // CONTATO: Edu#0069 // GITHUB: https://github.com/badlandproject  ]   --
------------------------------------------------------------------------------------------------------

-- [ TUNELAGEM / VARIÁVEIS PRINCIPAIS] --
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
local invOpen = false
RPex = {}
Tunnel.bindInterface("bdl_inventory",RPex)
vSERVER = Tunnel.getInterface("bdl_inventory")

-- [ CLOSE MENU CALLBACK ] --
RegisterNUICallback("invClose",function()
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
	StopScreenEffect("MenuMGSelectionIn")
	TriggerEvent("bdl:triggerhud")
	TransitionFromBlurred(1000)
	invOpen = false
end)
function RPex.closeInventory()
	StopScreenEffect("MenuMGSelectionIn")
	TransitionFromBlurred(1000)
	SetNuiFocus(false,false)
	SetCursorLocation(0.5,0.5)
	SendNUIMessage({ action = "hideMenu" })
	TriggerEvent("bdl:triggerhud")
	invOpen = false
end
-- [ THREAD PRINCIPAL ] --
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		if IsControlJustPressed(0,243) and not IsPlayerFreeAiming(PlayerId()) and GetEntityHealth(PlayerPedId()) >= 102 and not vRP.isHandcuff() then
			if not invOpen then
				StartScreenEffect("MenuMGSelectionIn", 0, true)
				TransitionToBlurred(1000)
				SetNuiFocus(true,true)
				SetCursorLocation(0.5,0.5)
				SendNUIMessage({ action = "showMenu" })
				invOpen = true

				
				local identity = false
				if identity then
					identity = false
					SendNUIMessage({ type = 'close' })
				else
					local  carteira,banco,coins,nome,sobrenome,idade,user_id,identidade,telefone,job,cargo,vip,faturas,multas,mypaypal,position = vSERVER.Identidade()
					TriggerEvent("bdl:triggerhud")
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
						mypaypal = mypaypal,
						position = position

					})
					identity = true
					if vSERVER.returnPermission("staff.permission") and vSERVER.returnPermission("pass.permission") then
						SendNUIMessage({tag = "staffDoador"})
						print("staff")
						print("donator")
					elseif vSERVER.returnPermission("pass.permission") and not vSERVER.returnPermission("staff.permission") then
						SendNUIMessage({tag = "userDoador"})
						print("user")
						print("donator")
					elseif not vSERVER.returnPermission("pass.permission") and not vSERVER.returnPermission("staff.permission") then
						print("user")
						SendNUIMessage({tag = "onlyUser"})
					elseif vSERVER.returnPermission("staff.permission") and not vSERVER.returnPermission("pass.permission") then
						print("staff")
						SendNUIMessage({tag = "onlyStaff"})
					end
				end
			end
		end
		Citizen.Wait(5)
	end
end)

-- [ DROP ITEM CALLBACK ] --
RegisterNUICallback("dropItem",function(data)
	vSERVER.dropItem(data.item,data.amount)
end)
-- [ SEND ITEM CALLBACK ] --
RegisterNUICallback("sendItem",function(data)
	vSERVER.sendItem(data.item,data.amount)
end)
-- [ USE ITEM CALLBACK ] --
RegisterNUICallback("useItem",function(data)
	vSERVER.useItem(data.item,data.type,data.amount)
end)
-- [ DESATIVADO ] --
RegisterNUICallback("DoSomething",function(data)
	if data.tDrop == "roubar" then
		vSERVER.roubItem(data.item,data.amount)
	elseif data.tDrop == "armamento" then
		vSERVER.getWeapon(data.item)
	end
end)
-- [ DESATIVADO ] --
RegisterNUICallback("requestMochila",function(data,cb)
	local inventario,peso,maxpeso,slots = vSERVER.Mochila()
	vSERVER.Armamento()
	if inventario then
		cb({ inventario = inventario, peso = peso, maxpeso = maxpeso, slots = slots })
	end
end)
-- [ DESATIVADO ] --
RegisterNUICallback("requestNearMochila",function(data,cb)
	local nearinventario = vSERVER.NearMochila()
	if nearinventario then
		cb({ nearinventario = nearinventario })
	end
end)
-- [ DESATIVADO ] --
RegisterNUICallback("requestArmamento",function(data,cb)
	local armamento = vSERVER.Armamento()
	if armamento then
		cb({ armamento = armamento })
	end
end)
-- [ UPDATE DO INVENTÁRIO ] --
RegisterNetEvent("Creative:Update")
AddEventHandler("Creative:Update",function(action)
	SendNUIMessage({ action = action })
end)
-- [ BLOQUEAR BOTÕES ] --
local blockButtons = false
function RPex.blockButtons(status)
	blockButtons = status
end
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		if blockButtons then
			timeDistance = 5
			BlockWeaponWheelThisFrame()
			DisableControlAction(0,56,true)
			DisableControlAction(0,57,true)
			DisableControlAction(0,73,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,47,true)
			DisableControlAction(0,38,true)
			DisableControlAction(0,20,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,105,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,327,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,243,true)
		end
		Citizen.Wait(timeDistance)
	end
end)
-- [ FUNCÃO DE CHECAGEM DE PROP (DESATIVADO) ] --
function RPex.checkObjects(prop)
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	if DoesObjectOfTypeExistAtCoords(x,y,z,0.7,GetHashKey(prop),true) then
		return true
	end

	return false
end