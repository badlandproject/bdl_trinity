local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

farms = Tunnel.getInterface("farmer-sell")

local farmsell = {
    { 2030.35,4980.1,42.1 }
}

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        for k,v in pairs(farmsell) do
            local ped = PlayerPedId()
            local x,y,z = table.unpack(GetEntityCoords(ped))
            local distance = Vdist(x,y,z, v[1], v[2], v[3])
            if distance < 3 then
                sleep = 5
                DrawText3Ds(v[1], v[2], v[3],"Pressione [~g~E~w~] para ~g~VENDER~w~ as frutas.")
            end
            if distance < 10 then
                sleep = 5
                DrawMarker(23,v[1], v[2], v[3]-0.97,0,0,0,0,0,0,1.0,1.0,0.5,50, 150, 50, 180,0,0,0,0)
                if distance < 1.2 then
                    if IsControlJustPressed(0,38) then
                        farms.sellFruits()
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

-- [ Função do texto 3D ] --
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