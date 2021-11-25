local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("bdl_moneywash")

washX = 16.96
washY = -1400.66
washZ = 28.76

local processo = 0
local isProcessando = false
local isReady = false
local inWashProcess = false

CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local distance = Vdist(washX,washY,washZ,x,y,z)
		if distance <= 4 then
			DrawMarker(23,washX,washY,washZ-1,0,0,0,0,180.0,130.0,1.2,1.2,1.2,255,25,25,50,0,0,0,1)
			if distance <= 1.5 then
				if parseInt(processo) >= 100 then
					DrawText3D(washX,washY,washZ,"[~r~E~w~] Para ~r~DECLARAR~w~ o dinheiro.")
				elseif parseInt(processo) > 0 and parseInt(processo) < 100 then
					DrawText3D(washX,washY,washZ,"LAVANDO: ~r~"..parseInt(processo).."~w~%")
				else
					DrawText3D(washX,washY,washZ,"[~r~E~w~] Para ~r~LAVAR~w~ dinheiro.")
				end
				if IsControlJustPressed(0,38) and not isReady and not isProcessando then
					if vSERVER.tryWashMoney() then
						inWashProcess = true
						isProcessando = true
					end
				end
				if IsControlJustPressed(0,38) and isReady then
					if vSERVER.tryDeclareMoney() then
						vRP._playAnim(true,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
						TriggerEvent('progress',5000)
						TriggerEvent('F6Cancel',true)
						Wait(5000)
						vRP.stopAnim(ped)
						TriggerEvent('F6Cancel',false)
						isReady = false
						inWashProcess = false
						processo = 0
					end
				end
			end
		end
		Wait(1)
	end
end)

CreateThread(function()
	while true do
		if inWashProcess then
			if processo ~= nil and processo < 100 then
				processo = processo + 1
				Wait(10)
			end
			if processo >= 100 then
				isProcessando = false
				isReady = true
				
			end
		end
		Wait(200)
	end
end)


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.40, 0.40)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end
