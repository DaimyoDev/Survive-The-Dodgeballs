local MarketplaceService = game:GetService("MarketplaceService")
local purchaseDlc = game.ReplicatedStorage.PurchaseDLC

purchaseDlc.OnServerEvent:Connect(function(player, gamepassId)

    MarketplaceService:PromptGamePassPurchase(player, gamepassId)

end)
