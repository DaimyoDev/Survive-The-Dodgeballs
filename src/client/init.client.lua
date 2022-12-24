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

local function setNewHumanoid(newHumanoid)
    humanoid = newHumanoid
    print("New humanoid")
end

player.CharacterAdded:Connect(function()
    print("Character added")
    local newHumanoid = player.Character:WaitForChild("Humanoid")
    setNewHumanoid(newHumanoid)
end)


mapSelectFrame.BackgroundTransparency = 1

shopButton.Activated:Connect(dlcClient.openShopMenu)
closeShop.Activated:Connect(dlcClient.closeShopMenu)

changeText.OnClientEvent:Connect(roundSystemClient.timerChanged)
mapSelect.OnClientEvent:Connect(roundSystemClient.mapSelected)
roundSelected.OnClientEvent:Connect(roundSystemClient.roundSelected)

local function onPlayerDeath()
    playerDied:FireServer()
end

while true do
    task.wait(1)
    if humanoid ~= nil then
        humanoid.Died:Connect(onPlayerDeath)
    end
end
