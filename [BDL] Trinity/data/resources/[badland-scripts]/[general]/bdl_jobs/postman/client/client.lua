local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

post = Tunnel.getInterface("postman")

local process = false
local CoordenadaX = 78.93
local CoordenadaY = 112.45
local CoordenadaZ = 81.16

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local x,y,z = table.unpack(GetEntityCoords(ped))
			if Vdist(CoordenadaX,CoordenadaY,CoordenadaZ,x,y,z) < 5.1 then
				idle = 5
				DrawMarker(23, CoordenadaX, CoordenadaY, CoordenadaZ-0.98, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 50, 150, 50, 180, 0, 0, 0, 0)
				if Vdist(CoordenadaX,CoordenadaY,CoordenadaZ,x,y,z) <= 1.2 then
					if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), CoordenadaX,CoordenadaY,CoordenadaZ, true ) <= 1.1  then
						DrawText3Ds(CoordenadaX,CoordenadaY,CoordenadaZ, "Pressione [~g~E~w~] para ~g~EMPACOTAR~w~")
					end
					if IsControlJustPressed(1,38) then
						if not process then
							if post.checkWeight() then
								process = true
								TriggerEvent('cancelando',true)
								TriggerEvent("progress",8000,"Coletando")
								FreezeEntityPosition(ped,true)
								vRP._playAnim(false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)
								SetTimeout(8000,function()
									process = false
									TriggerEvent('cancelando',false)
									FreezeEntityPosition(ped,false)
									vRP._stopAnim(false)
								end)
							end
						end
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

-- [ FUNÇÃO DO TEXTO 3D ] --
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