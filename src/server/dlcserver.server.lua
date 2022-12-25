local MarketplaceService = game:GetService("MarketplaceService")
local purchaseDlc = game.ReplicatedStorage.PurchaseDLC
local Players = game:GetService("Players")
local healthGP = game.ReplicatedStorage.HealthGP
local speedGP = game.ReplicatedStorage.SpeedGP
local jumpGP = game.ReplicatedStorage.JumpGP
local gamePasses = require(game.ServerScriptService.Server.gamePasses)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.healthDLC) then
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.MaxHealth = 200
            humanoid.Health = humanoid.MaxHealth
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.WalkSpeed = 24
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.jumpDLC) then
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.JumpHeight = 12
            humanoid.JumpPower = 70
        end
    end)
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
    if gamePassId == gamePasses.healthDLC and wasPurchased then
        local character = player:WaitForChild("Character")
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.MaxHealth = 200
        humanoid.Health = humanoid.MaxHealth
    end
    if gamePassId == gamePasses.speedDLC and wasPurchased then
        local character = player:WaitForChild("Character")
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = 24
    end
    if gamePassId == gamePasses.jumpDLC and wasPurchased then
        local character = player:WaitForChild("Character")
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.JumpHeight = 12
        humanoid.JumpPower = 70
    end
end)

purchaseDlc.OnServerEvent:Connect(function(player, buttonType)
    if buttonType == "Health" then
        local success, error = pcall(function()
            MarketplaceService:PromptGamePassPurchase(player, gamePasses.healthDLC)
        end)
    end
    if buttonType == "Speed" then
        local success, error = pcall(function()
            MarketplaceService:PromptGamePassPurchase(player, gamePasses.speedDLC)
        end)
    end
    if buttonType == "Jump" then
        local success, error = pcall(function()
            MarketplaceService:PromptGamePassPurchase(player, gamePasses.jumpDLC)
        end)
    end
end)

healthGP.OnServerEvent:Connect(function(player, humanoid)
    if humanoid.Name == "Humanoid" then
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.healthDLC) then
            humanoid.MaxHealth = 200
            humanoid.Health = humanoid.MaxHealth
        end
    end
end)

speedGP.OnServerEvent:Connect(function(player, humanoid)
    if humanoid.Name == "Humanoid" then
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
            humanoid.WalkSpeed = 24
        end
    end
end)



jumpGP.OnServerEvent:Connect(function(player, humanoid)
    if humanoid.Name == "Humanoid" then
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
            humanoid.JumpHeight = 12
            humanoid.JumpPower = 70
        end
    end
end)