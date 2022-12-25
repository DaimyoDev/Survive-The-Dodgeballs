local MarketplaceService = game:GetService("MarketplaceService")
local purchaseDlc = game.ReplicatedStorage.PurchaseDLC
local healthGP = game.ReplicatedStorage.HealthGP
local speedGP = game.ReplicatedStorage.SpeedGP
local jumpGP = game.ReplicatedStorage.JumpGP
local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512622) then
        healthGP:FireClient(player)
    end
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
        speedGP:FireClient(player)
    end
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113506638) then
        jumpGP:FireClient(player)
    end
end)

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(player, gamePassId, wasPurchased)
    if gamePassId == 113512622 and wasPurchased then
        healthGP:FireClient(player)
    end
    if gamePassId == 113512366 and wasPurchased then
        speedGP:FireClient(player)
    end
    if gamePassId == 113506638 and wasPurchased then
        jumpGP:FireClient(player)
    end
end)

healthGP.OnServerEvent:Connect(function(player)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512622) then
        healthGP:FireClient(player)
    end
end)

speedGP.OnServerEvent:Connect(function(player)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
        speedGP:FireClient(player)
    end
end)

jumpGP.OnServerEvent:Connect(function(player)
    if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113506638) then
        jumpGP:FireClient(player)
    end
end)

purchaseDlc.OnServerEvent:Connect(function(player, gamepassId)

    local success, error = pcall(function()
        MarketplaceService:PromptGamePassPurchase(player, gamepassId)
    end)
end)
