local changeText = game.ReplicatedStorage.ChangeText
local mapSelect = game.ReplicatedStorage.MapSelect
local player = game:GetService("Players").LocalPlayer
local shopButton = player:WaitForChild("PlayerGui"):WaitForChild("PlayerUI").ShopButton
local closeShop = player:WaitForChild("PlayerGui"):WaitForChild("ShopUI").Close
local mapSelectFrame = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MapSelected").Frame
local roundSystemClient = require(script.roundsystemclient)
local dlcClient = require(script.dlcclient)

mapSelectFrame.BackgroundTransparency = 1

shopButton.Activated:Connect(dlcClient.openShopMenu)
closeShop.Activated:Connect(dlcClient.closeShopMenu)

changeText.OnClientEvent:Connect(roundSystemClient.timerChanged)
mapSelect.OnClientEvent:Connect(roundSystemClient.mapSelected)
