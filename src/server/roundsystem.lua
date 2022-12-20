local changeText = game.ReplicatedStorage.ChangeText 

local roundSystem = {}

function roundSystem.intermission(intermissionTime)

    intermissionTime.Value -= 1
    changeText:FireAllClients(intermissionTime.Value, "Intermission")
end

return roundSystem