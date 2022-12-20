local intermissionTimer = game.ServerStorage["Intermission Timer"]
local roundTimer = game.ServerStorage["Round Timer"]
local roundSystem = require(script.roundsystem)
local mapSelected = false
local teleportPlayers = false

while true do
    wait(1)
    if intermissionTimer.Value >= 0 then
        roundSystem.intermission(intermissionTimer)
    end

    if intermissionTimer.Value <= 5 and intermissionTimer.Value >= 0 and not mapSelected then
        roundSystem.selectRandomMap()
        mapSelected = true
    end

    if intermissionTimer.Value <= 0 and not teleportPlayers then
        roundSystem.teleportAndGetPlayers()
        teleportPlayers = true
    end
    
    if intermissionTimer.Value <= 0 and roundTimer.Value >= 0 then
        roundSystem.round(roundTimer)
    end
    


    --call function when round starts. Teleports players to randomly chosen map and starts the round timer plus the dodgeball spawner.
    
end