local selectedPlayer = -1

if(Config.dev) then
    RegisterCommand('TestUi', function() 
        local nearbyPeds = lib.getNearbyPlayers(GetEntityCoords(PlayerPedId()), 2, false)

        print(nearbyPeds)
        print(ESX.DumpTable(nearbyPeds))
       

        local pData = {1}
        local playres = {}

        for k, data in pairs(nearbyPeds) do
            local MugShot = exports["MugShotBase64"]:GetMugShotBase64(GetPlayerPed(GetPlayerFromServerId(data["id"])), true)
            table.insert(playres, {
                ["id"] = data["id"],
                ["name"] = GetPlayerName(data["id"]),
                ["avatarURL"] = MugShot,
            })
        end

        if(#nearbyPeds > 0) then
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'open',
                players = json.encode(playres)
            })
        end
    end)
end

RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'exit'
    })
end)

RegisterNUICallback("selectedPlayer", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'exit'
    })

    selectedPlayer = data["id"]
    print(selectedPlayer)
end)

RegisterNetEvent("vaggos_playerSelect:selectPlayers", function()
    local nearbyPeds = lib.getNearbyPlayers(GetEntityCoords(PlayerPedId()), 2, false)

    print(nearbyPeds)
    print(ESX.DumpTable(nearbyPeds))
   
    local playres = {}

    for k, data in pairs(nearbyPeds) do
        local MugShot = exports["MugShotBase64"]:GetMugShotBase64(GetPlayerPed(GetPlayerFromServerId(data["id"])), true)
        table.insert(playres, {
            ["id"] = data["id"],
            ["name"] = GetPlayerName(data["id"]),
            ["avatarURL"] = MugShot,
        })
    end

    if(#nearbyPeds > 0) then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'open',
            players = json.encode(playres)
        })
    end
end)

AddEventHandler("vaggos_playerSelect:selectedPlayers", function(cb)
    if(selectedPlayer ~= -1) then
        cb({
            ["id"] = selectedPlayer,
            ["wait"] = false
        })
    else
        cb({
            ["id"] = nil,
            ["wait"] = true
        })
    end
end)