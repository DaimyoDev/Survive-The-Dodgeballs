local changeText = game.ReplicatedStorage.ChangeText
local roundSystem = {}
local playersTeleportedToMap = false
local playersTeleportedToLobby = false

function roundSystem.intermission(intermissionTime)

    intermissionTime.Value -= 1
    changeText:FireAllClients(intermissionTime.Value, "Intermission")
end

function roundSystem.round(roundTime)

    roundTime.Value -= 1
    changeText:FireAllClients(roundTime.Value, "Time Left")

end

function roundSystem.selectRandomMap()
    local map1, map2, map3 = game.ServerStorage["Map 1"], game.ServerStorage["Map 2"], game.ServerStorage["Map 3"]
    local mapList = {map1, map2, map3}
    local selectedMapIndex = math.random(1, 3)

    local selectedMap = mapList[selectedMapIndex]:Clone()
    selectedMap.Parent = game.Workspace
    playerSpawn = selectedMap["Player Spawn"]
end


function roundSystem.teleportAndGetPlayers()
    local playerList = game:GetService("Players"):GetPlayers()
    for i, player in pairs(playerList) do
        local playerModel = player.Character.Humanoid.RootPart
        print(playerModel.Position)
        playerModel.Position = Vector3.new(playerSpawn.Position.x, playerSpawn.Position.y, playerSpawn.Position.z)
    end
end


return roundSystem