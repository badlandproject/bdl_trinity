RegisterNetEvent("progress")
AddEventHandler("progress",function(time)
	SendNUIMessage({ time = tonumber(time-500) })
end)