local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

milkman = Tunnel.getInterface("milkman")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local process = false
local seconds = 0
local hour = 0

local cows = {
	{ 425.55, 6463.64, 28.79 },
	{ 431.11, 6459.52, 28.76 },
	{ 436.25, 6454.87, 28.75 },
	{ 429.02, 6476.92, 28.79 },
	{ 434.12, 6472.93, 28.78 }
}

--[ THREAD ]--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for _,func in pairs(cows) do
				local x2,y2,z2 = table.unpack(func)
				local distancia = Vdist(x,y,z,x2,y2,z2)
				local lastVehicle = GetEntityModel(GetPlayersLastVehicle())
				if distancia < 1.3 then
					idle = 5
					if not process then
						DrawText3Ds(x2,y2,z2,"Pressione [~g~E~w~] para ~g~ORDENHAR~w~.")
					end
					if IsControlJustPressed(0,38) then
						if not process then
							if milkman.checkPayment() then
								secondsCount()
								TriggerEvent('cancelando',true)
								vRP._playAnim(false,{{"amb@medic@standing@tendtodead@base","base"}},true)	
								process = true
								seconds = 10
								SetTimeout(10000,function()
									vRP._stopAnim(false)
								end)
							end
						end
					end
				end
			end
		end
		if process then
			drawTxt("AGUARDE ~g~"..seconds.."~w~ SEGUNDOS ATÉ FINALIZAR A EXTRAÇÃO DO LEITE",4,0.5,0.94,0.35,255,255,255,180)
		end
		Citizen.Wait(idle)
	end
end)

function secondsCount()
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if seconds > 0 and process then
			seconds = seconds - 1
			if seconds == 0 then
				process = false
				TriggerEvent('cancelando',false)
			end
		else
			break
		end
	end
end)
end

--[ FUNCTION ]------------------------------------------------------------------------------------------------------------------

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

function DrawText3Ds(x,y,z,text)
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