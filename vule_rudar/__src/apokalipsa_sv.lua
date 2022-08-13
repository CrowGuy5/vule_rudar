ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj 
end)




Items = {
    "bakar",
    "copper",
    "iron",
    'steel'
}
  
function RandomItem()
return Items[math.random(#Items)]
end

function RandomNumber()
    return math.random(2,3)
end

RegisterServerEvent('apokalipsa:dajeitem')
AddEventHandler('apokalipsa:dajeitem', function()
local xPlayer = ESX.GetPlayerFromId(source)
math.randomseed(GetGameTimer())
xPlayer.addInventoryItem(RandomItem(), RandomNumber())
end)