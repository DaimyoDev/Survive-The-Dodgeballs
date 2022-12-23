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

return dlcClient

