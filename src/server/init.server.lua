local intermissionTimer = game.ServerStorage["Intermission Timer"]
local roundSystem = require(script.roundsystem)

while true do
    wait(1)
    roundSystem.intermission(intermissionTimer)

    -- call intermission timer function
    
end