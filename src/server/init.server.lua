local intermissiontimer = game.ServerStorage["Intermission Timer"]
local roundsystem = require(script.roundsystem)

while true do
    wait(1)
    roundsystem.intermission(intermissiontimer)

    -- call intermission timer function
    
end