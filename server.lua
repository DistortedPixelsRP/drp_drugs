local amountToGet = DRPDrugs.AmountYouGet
local amountToProd = DRPDrugs.AmountToProduceOne
local timeToDoStuff = DRPDrugs.TimeToPickProduceSell

----------------------------------------------------------------------------------------------------------------------------------
----- Send Blips and locations to player.
----------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("DRP_Drugs:InitAll")
AddEventHandler("DRP_Drugs:InitAll", function()
    local src = source
    local blip = DRPDrugs.Blips
    local drug = DRPDrugs.Locations
    local prod = DRPDrugs.Productions
    local sell = DRPDrugs.SellLocations
    TriggerClientEvent("DRP_Drugs:Init", src, blip, drug, prod, sell)
end)

----------------------------------------------------------------------------------------------------------------------------------
----- Pick drug from location.
----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:PickDrug")
AddEventHandler("DRP_Drugs:PickDrug", function(type, pick, auto)
    local src = source
    local player = exports["drp_id"]:GetCharacterData(src)
    if pick then
        TriggerClientEvent("DRP_Drugs:DrugLocationPick", player.charid, true, false, amountToGet, type, timeToDoStuff)
    elseif auto then
        TriggerClientEvent("DRP_Drugs:DrugLocationPick", player.charid, false, true, amountToGet, type, timeToDoStuff)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------
----- Produce drug from location.
----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:ProdDrug")
AddEventHandler("DRP_Drugs:ProdDrug", function(type, use, prod, auto)
    local src = source
    local player = exports["drp_id"]:GetCharacterData(src)
    if prod then
        TriggerClientEvent("DRP_Drugs:DrugLocationProd", player.charid, true, false, amountToGet, amountToProd, type, use, timeToDoStuff)
    elseif auto then
        TriggerClientEvent("DRP_Drugs:DrugLocationProd", player.charid, false, true, amountToGet, amountToProd, type, use, timeToDoStuff)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------
----- Sell drugs to dealer.
----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:SellDrug")
AddEventHandler("DRP_Drugs:SellDrug", function(type, price, prod, auto)
    local src = source
    local player = exports["drp_id"]:GetCharacterData(src)
    if prod then
        TriggerClientEvent("DRP_Drugs:SellLocationDrug", player.charid, true, false, amountToGet, price, type, timeToDoStuff)
    elseif auto then
        TriggerClientEvent("DRP_Drugs:SellLocationDrug", player.charid, false, true, amountToGet, price, type, timeToDoStuff)
    end
end)

----------------------------------------------------------------------------------------------------------------------------------
----- Add dirty money after selling drugs.
----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("DRP_Drugs:AddDirtyMoney")
AddEventHandler("DRP_Drugs:AddDirtyMoney", function(price)
    local src = source
    local player = exports["drp_id"]:GetCharacterData(src)
    TriggerEvent("DRP_Bank:AddDirtyMoney", player, price)
end)