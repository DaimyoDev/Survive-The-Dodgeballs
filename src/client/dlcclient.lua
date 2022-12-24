local dlcClient = {}
local purchaseDlc = game.ReplicatedStorage.PurchaseDLC
local player = game:GetService("Players").LocalPlayer
local shopUI = player:WaitForChild("PlayerGui"):WaitForChild("ShopUI")

function dlcClient.openShopMenu()

    shopUI.Enabled = true

end

function dlcClient.closeShopMenu()

    shopUI.Enabled = false

end

function dlcClient.purchaseHealth()

    purchaseDlc:FireServer(113512622)

end

function dlcClient.purchaseSpeed()

    purchaseDlc:FireServer(113512366)

end

function dlcClient.purchaseJump()

    purchaseDlc:FireServer(113506638)

end

return dlcClient

