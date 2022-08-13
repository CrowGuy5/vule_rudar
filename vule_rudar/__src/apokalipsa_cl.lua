lib.locale()
ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
        
    end
     while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()


end)
Objects = {}
AddEventHandler("onResourceStop", function(res)
  if GetCurrentResourceName() == res then


    for i = 1, #Objects do
      DeleteObject(Objects[i])
    end


  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)



Citizen.CreateThread(function()
	
	for k, v in pairs(Config.Propovi) do  
	  RequestModel(GetHashKey(v.prop))	
    PostaviSefss = CreateObject(v.prop, v.coords, false, true)
    SetEntityHeading(PostaviSefss, v.headings)
    FreezeEntityPosition(PostaviSefss, true) 
    SetEntityInvincible(PostaviSefss, true)

    PlaceObjectOnGroundProperly(PostaviSefss)
    table.insert(Objects, PostaviSefss)
    SetModelAsNoLongerNeeded(v.prop)

  end 
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Propovi) do
      exports.qtarget:RemoveZone(v.name.. 'rudarenje')
      exports.qtarget:AddBoxZone(v.name.. 'rudarenje', v.coords, v.width, v.length, {
        name= v.name,
        heading= v.heading,
        debugPoly= v.debug,
        minZ= v.coords.z -1,
        maxZ= v.coords.z +2,
        }, {
          options = {
            {
              event = 'apokalipsa:startujrudu',
              icon = "fas fa-sign-in-alt",
              label = "Razbijte blok peska",
             -- job = v.job,
            },
          },
          distance = 6.5
      })
    end
  end)




Citizen.CreateThread(function()

    for k, v in pairs(Config.Propovi) do
      v.blip = AddBlipForCoord(v.coords)
      SetBlipSprite(v.blip, v.id)
      SetBlipDisplay(v.blip, 4)
      SetBlipScale(v.blip, 1.2)
      SetBlipColour(v.blip, v.colour)
      SetBlipAsShortRange(v.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(v.title)
      EndTextCommandSetBlipName(v.blip)
    end
end)




RegisterNetEvent("apokalipsa:startujrudu", function()
local ped = PlayerPedId()
local pozicija = GetEntityCoords(ped)
pickaxe = CreateObject(GetHashKey("prop_tool_pickaxe"), 0, 0, 0, true, true, true) 
AttachEntityToEntity(pickaxe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.18, -0.02, -0.02, 350.0, 100.00, 140.0, true, true, false, true, 1, true)
lib.progressCircle({
	duration = 30000,
	useWhileDead = false,
	canCancel = false,
	disable = {
		move = true,
		car = true,
		combat = true,
	},
	anim = {
		dict =  'melee@hatchet@streamed_core',
		clip = 'plyr_rear_takedown_b' ,
	},
})
ClearPedTasks(ped)
DetachEntity(pickaxe, 1, true)
DeleteEntity(pickaxe)
DeleteObject(pickaxe)
TriggerServerEvent("apokalipsa:dajeitem")
end)	








