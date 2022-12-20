local changeText = game.ReplicatedStorage.ChangeText
local roundSystem = {}
local playersTeleportedToMap = false
local playersTeleportedToLobby = false
local mapSelect = game.ReplicatedStorage.MapSelect

function roundSystem.intermission(intermissionTime)

    intermissionTime.Value -= 1
    changeText:FireAllClients(intermissionTime.Value, "Intermission")
end

function roundSystem.spawnDodgeBalls(roundTime)
    local dodgeBall = Instance.new("Part")
    dodgeBall.Name = "dodgeball"
    dodgeBall.Parent = workspace
    dodgeBall.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    dodgeBall.Size = Vector3.new(4, 4, 4)
    dodgeBall.Material = Enum.Material.SmoothPlastic
    dodgeBall.Shape = Enum.PartType.Ball
    dodgeBall.Position = Vector3.new(dodgeBallSpawn.Position.x, dodgeBallSpawn.Position.y + 10, dodgeBallSpawn.Position.z)
    dodgeBall:Clone()

    dodgeBall.Touched:Connect(function(otherPart)
        dodgeBall:ApplyImpulse(Vector3.new(math.random(-3000, 3000), 1500, math.random(-3000, 3000)))
        if otherPart.Parent:FindFirstChild("Humanoid") then
            local humanoid = otherPart.Parent:FindFirstChild("Humanoid")
            humanoid:TakeDamage(2)
        end

    end)
    
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
    dodgeBallSpawn = selectedMap["Ball Spawn"]
    mapSelect:FireAllClients(selectedMapIndex)
end


function roundSystem.teleportAndGetPlayers()
    local playerList = game:GetService("Players"):GetPlayers()
    for i, player in pairs(playerList) do
        local playerModel = player.Character.Humanoid.RootPart
        playerModel.Position = Vector3.new(playerSpawn.Position.x, playerSpawn.Position.y, playerSpawn.Position.z)
    end
end

function roundSystem.teleportPlayersToLobby()
    local playerList = game:GetService("Players"):GetPlayers()
    for i, player in pairs(playerList) do
        local playerModel = player.Character.Humanoid.RootPart
        local player = player.Character.Humanoid
        local lobbySpawn = game.Workspace.SpawnLocation
        playerModel.Position = Vector3.new(lobbySpawn.Position.x, lobbySpawn.Position.y, lobbySpawn.Position.z)
        player.Health = 100
    end
end

return roundSystem