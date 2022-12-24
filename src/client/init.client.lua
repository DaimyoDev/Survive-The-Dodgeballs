local changeText = game.ReplicatedStorage.ChangeText
local mapSelect = game.ReplicatedStorage.MapSelect
local player = game:GetService("Players").LocalPlayer
local shopButton = player:WaitForChild("PlayerGui"):WaitForChild("PlayerUI").ShopButton
local closeShop = player:WaitForChild("PlayerGui"):WaitForChild("ShopUI").Frame.Close
local mapSelectFrame = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MapSelected").Frame
local roundSystemClient = require(script.roundsystemclient)
local dlcClient = require(script.dlcclient)
local playerDied = game.ReplicatedStorage.PlayerDied
local roundSelected = game.ReplicatedStorage.RoundSelected
local humanoid = player.Character:WaitForChild("Humanoid")
local shopUI = player:WaitForChild("PlayerGui"):WaitForChild("ShopUI")
local extraHealthButton = shopUI.Shop.ExtraHealth.TextButton
local speedBoostButton = shopUI.Shop.SpeedBoost.TextButton
local jumpBoostButton = shopUI.Shop.JumpBoost.TextButton

mapSelectFrame.BackgroundTransparency = 1

shopButton.Activated:Connect(dlcClient.openShopMenu)
closeShop.Activated:Connect(dlcClient.closeShopMenu)

changeText.OnClientEvent:Connect(roundSystemClient.timerChanged)
mapSelect.OnClientEvent:Connect(roundSystemClient.mapSelected)
roundSelected.OnClientEvent:Connect(roundSystemClient.roundSelected)

extraHealthButton.Activated:Connect(dlcClient.purchaseHealth)
speedBoostButton.Activated:Connect(dlcClient.purchaseSpeed)
jumpBoostButton.Activated:Connect(dlcClient.purchaseJump)