local MarketplaceService = game:GetService("MarketplaceService")
local purchaseDlc = game.ReplicatedStorage.PurchaseDLC
local Players = game:GetService("Players")
local healthGP = game.ReplicatedStorage.HealthGP
local speedGP = game.ReplicatedStorage.SpeedGP
local jumpGP = game.ReplicatedStorage.JumpGP

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512622) then
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.MaxHealth = 200
            humanoid.Health = humanoid.MaxHealth
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.WalkSpeed = 24
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113506638) then
            local humanoid = character:WaitForChild("Humanoid")
            humanoid.JumpHeight = 12
            humanoid.JumpPower = 70
        end
    end)
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
    if gamePassId == 113512622 and wasPurchased then
        local character = player:WaitForChild("Character")
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.MaxHealth = 200
        humanoid.Health = humanoid.MaxHealth
    end
    if gamePassId == 113512366 and wasPurchased then
        local character = player:WaitForChild("Character")
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.WalkSpeed = 24
    end
    if gamePassId == 113506638 and wasPurchased then
        local character = player:WaitForChild("Character")
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.JumpHeight = 12
        humanoid.JumpPower = 70
    end
end)

purchaseDlc.OnServerEvent:Connect(function(player, buttonType)
    if buttonType == "Health" then
        local success, error = pcall(function()
            MarketplaceService:PromptGamePassPurchase(player, 113512622)
        end)
    end
    if buttonType == "Speed" then
        local success, error = pcall(function()
            MarketplaceService:PromptGamePassPurchase(player, 113512366)
        end)
    end
    if buttonType == "Jump" then
        local success, error = pcall(function()
            MarketplaceService:PromptGamePassPurchase(player, 113506638)
        end)
    end
end)

healthGP.OnServerEvent:Connect(function(player, humanoid)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512622) then
        humanoid.MaxHealth = 200
        humanoid.Health = humanoid.MaxHealth
    end
end)

speedGP.OnServerEvent:Connect(function(player, humanoid)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
        humanoid.WalkSpeed = 24
    end
end)

jumpGP.OnServerEvent:Connect(function(player, humanoid)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
        humanoid.JumpHeight = 12
        humanoid.JumpPower = 70
    end
end)