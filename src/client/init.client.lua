local changeText = game.ReplicatedStorage.ChangeText
local timerText = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PlayerUI").TimerText

local function timerChanged(time, type)

    timerText.Text = type .. ": " .. time .. " Seconds Left"

end


changeText.OnClientEvent:Connect(timerChanged)