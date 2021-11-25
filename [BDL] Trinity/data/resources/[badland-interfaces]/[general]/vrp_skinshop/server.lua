local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_skinshop")
vRPloja = Tunnel.getInterface("vrp_skinshop")

RegisterServerEvent("LojaDeRoupas:Comprar")
AddEventHandler("LojaDeRoupas:Comprar", function(preco)
    local user_id = vRP.getUserId(source)
    if preco then
        if vRP.tryPayment(user_id, preco) then
            TriggerClientEvent("Notify",source,"importante","Você fez um pagamento de: R$"..preco.." ",10000)
            TriggerClientEvent('LojaDeRoupas:ReceberCompra', source, true)
        else
            TriggerClientEvent("Notify",source,"importante","Você não tem dinheiro suficiente",10000)
            TriggerClientEvent('LojaDeRoupas:ReceberCompra', source, false)
        end
    end
end)

