local player = game:GetService("Players").LocalPlayer
local character = player.Character
local playerDied = game.ReplicatedStorage.PlayerDied
local healthGP = game.ReplicatedStorage.HealthGP
local speedGP = game.ReplicatedStorage.SpeedGP
local jumpGP = game.ReplicatedStorage.JumpGP


if character then
    local humanoid = character:WaitForChild("Humanoid")
    local function onPlayerDeath()
        playerDied:FireServer()
    end

    healthGP:FireServer(humanoid)
    speedGP:FireServer(humanoid)
    jumpGP:FireServer(humanoid)

    humanoid.Died:Connect(onPlayerDeath)

end
