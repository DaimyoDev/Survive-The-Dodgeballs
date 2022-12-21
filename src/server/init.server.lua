local intermissionTimer = game.ServerStorage["Intermission Timer"]
local roundTimer = game.ServerStorage["Round Timer"]
local roundSystem = require(script.roundsystem)
local mapSelected = false
local teleportPlayers = false
local roundType = false

while true do
    task.wait(1)
    if intermissionTimer.Value >= 0 then
        
        roundSystem.intermission(intermissionTimer)
    end

    if intermissionTimer.Value <= 5 and intermissionTimer.Value >= 0 and not mapSelected then
        roundSystem.selectRandomMap()
        roundSystem.roundType()
        roundType = true
        mapSelected = true
    end

    if intermissionTimer.Value <= 0 and not teleportPlayers then
        roundSystem.teleportAndGetPlayers()
        teleportPlayers = true
    end
    
    if intermissionTimer.Value <= 0 and roundTimer.Value >= 0 then
        roundSystem.spawnDodgeBalls(roundTimer)
        roundSystem.round(roundTimer)
    end

    if intermissionTimer.Value <= 0 and roundTimer.Value <= 0 then
        roundSystem.teleportPlayersToLobby()
        if game.Workspace:FindFirstChild("Map 1") then
            local map1 = game.Workspace:FindFirstChild("Map 1")
            map1:Destroy()
        end
        if game.Workspace:FindFirstChild("Map 2") then
            local map2 = game.Workspace:FindFirstChild("Map 2")
            map2:Destroy()
        end
        if game.Workspace:FindFirstChild("Map 3") then
            local map3 = game.Workspace:FindFirstChild("Map 3")
            map3:Destroy()
        end
        intermissionTimer.Value = 15
        roundTimer.Value = 120
        mapSelected = false
        teleportPlayers = false
        roundType = false
    end
    
end