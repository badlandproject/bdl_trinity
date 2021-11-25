local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
		TriggerEvent("bdl:triggerhud")
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
		TriggerEvent("bdl:triggerhud")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "hospital" then
		vRP.teleport(279.81,-585.9,43.31)
	elseif data == "beach" then
		vRP.teleport(-2028.32,-460.09,11.51)
	elseif data == "paleto" then
		vRP.teleport(-99.63,6342.48,31.5)
	elseif data == "sandys" then
		vRP.teleport(1969.83,3732.64,32.36)
	elseif data == "airport" then
		vRP.teleport(-1037.69,-2737.12,20.17)
	elseif data == "lsgarage" then
		vRP.teleport(52.93,-881.96,30.32)
	end
	ToggleActionMenu()
	TriggerEvent("ToogleBackCharacter")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE LOGIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('vrp:ToogleLoginMenu')
AddEventHandler('vrp:ToogleLoginMenu',function()
	ToggleActionMenu()
end)