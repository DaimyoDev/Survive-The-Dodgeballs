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

    healthGP:FireServer()
    speedGP:FireServer()
    jumpGP:FireServer()

    humanoid.Died:Connect(onPlayerDeath)

    healthGP.OnClientEvent:Connect(function()
        humanoid.MaxHealth = 150
        humanoid.Health = 150
    end)

    jumpGP.OnClientEvent:Connect(function()
        humanoid.JumpHeight = 12
        humanoid.JumpPower = 70
    end)

    speedGP.OnClientEvent:Connect(function()
        humanoid.WalkSpeed = 24
    end)

end
