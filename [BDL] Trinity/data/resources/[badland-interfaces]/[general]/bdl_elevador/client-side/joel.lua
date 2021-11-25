------------------------------------------------------------------------------------------------------
-- [ PRODUTO ADQUIRIDO EM E&G VENDAS (discord.gg/bABGBEX) ]   										--
-- [ DESENVOLVIDO POR Edu#0069 // BACK-END Edu#0069 ]   											--
-- [ SE VOCÊ ADQUIRIU ESSE PRODUTO, VOCÊ TEM DIREITO A SUPORTE GRATUITO ]   						--
-- [ OBRIGADO PELA CONFIANÇA // CONTATO: Edu#0069 // GITHUB: https://github.com/badlandproject  ]   --
------------------------------------------------------------------------------------------------------

onMenu = false
local menuactive = false
function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		onMenu = true
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
	else
		onMenu = false
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("bdl:triggerhud")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	local ped = PlayerPedId()
	if data == "-1andar" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,4.89,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)

	elseif data == "-2andar" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,10.28,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)

	elseif data == "-3andar" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,13.69,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)

	elseif data == "terreo" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,19.01,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)

	elseif data == "3andar" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,26.83,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)

	elseif data == "4andar" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,30.76,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)

	elseif data == "5andar" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,34.37,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)

	elseif data == "heli" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,-1096.06,-850.59,38.25,0,0,0,0)
			SetEntityHeading(ped,32.76)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)
		
	elseif data == "1andarEMS" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,344.65,-586.23,28.8,0,0,0,0)
			SetEntityHeading(ped,250.0)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)
	elseif data == "heliEMS" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,338.75,-583.97,74.17,0,0,0,0)
			SetEntityHeading(ped,255.0)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)
	elseif data == "terreoEMS" then
		DoScreenFadeOut(1000)
		ToggleActionMenu()
		SetTimeout(1400,function()
			SetEntityCoords(ped,332.41,-595.67,43.29,0,0,0,0)
			SetEntityHeading(ped,75.0)
			TriggerEvent("vrp_sound:source",'elevator-bell',0.5)
			DoScreenFadeIn(1000)
		end)
		
	elseif data == "nothing" then
		TriggerEvent("Notify","negado","Botão quebrado.")
	
	elseif data == "fechar" then
		ToggleActionMenu()
	
	end
end)

local elevador = {
	{"lspd", -1096.06, -850.59, 4.89, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255 },
	{"lspd", -1096.06, -850.59, 10.28, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255},
	{"lspd", -1096.06, -850.59, 13.69, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255},
	{"lspd", -1096.06, -850.59, 19.01, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255},
	{"lspd", -1096.06, -850.59, 26.83, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255},
	{"lspd", -1096.06, -850.59, 30.76, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255},
	{"lspd", -1096.06, -850.59, 34.37, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255},
	{"lspd", -1096.06, -850.59, 38.25, "[~b~E~w~] Para ~b~USAR~w~ o elevador.", 0,140,255},
	{"ems", 344.45,-586.21,28.8, "[~r~E~w~] Para ~r~USAR~w~ o elevador.", 255,25,25},
	{"ems", 332.31,-595.72,43.29, "[~r~E~w~] Para ~r~USAR~w~ o elevador.", 255,25,25},
	{"ems", 338.54,-583.79,74.17, "[~r~E~w~] Para ~r~USAR~w~ o elevador.", 255,25,25},
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ MENU ]-------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local sleep = 1000

		for k,v in pairs(elevador) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(v[2],v[3],v[4],x,y,z)
			if not onMenu then
				if distance <= 2 then
					sleep = 5
					DrawText3D(v[2],v[3],v[4], v[5])
				end
				
				if distance <= 15 then
					sleep = 5
					
					DrawMarker(30, v[2],v[3],v[4]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,v[6],v[7],v[8],90,0,0,0,1)
					if distance <= 2.3 then
						if IsControlJustPressed(0,38) then
							ToggleActionMenu()
							if v[1] == "ems" then
								SendNUIMessage({ elevEMS = true })
							else
								SendNUIMessage({ elevLSPD = true })
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
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