local player = game:GetService("Players").LocalPlayer
local character = player.Character
local playerDied = game.ReplicatedStorage.PlayerDied
if character then
    local humanoid = character:WaitForChild("Humanoid")
    local function onPlayerDeath()
        playerDied:FireServer()
    end
    
    humanoid.Died:Connect(onPlayerDeath)
end
local function onPlayerDeath()
    playerDied:FireServer()
end
