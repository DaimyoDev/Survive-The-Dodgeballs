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

    purchaseDlc:FireServer("Health")

end

function dlcClient.purchaseSpeed()

    purchaseDlc:FireServer("Speed")

end

function dlcClient.purchaseJump()

    purchaseDlc:FireServer("Jump")

end

return dlcClient

