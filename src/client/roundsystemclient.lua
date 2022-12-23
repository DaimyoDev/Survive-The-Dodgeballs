local mapSelectUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MapSelected")
local mapText = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MapSelected").Frame.MapText
local timerText = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PlayerUI").TimerText
local mapSelectFrame = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MapSelected").Frame

local roundSystemClient = {}

function roundSystemClient.timerChanged(time, type)

    timerText.Text = type .. ": " .. time .. " Seconds Left"

    if type == "Intermission" and time <= 5 then
        mapSelectUI.Enabled = true
        
        while mapSelectFrame.BackgroundTransparency >= 0 do
            task.wait(0.1)
            mapSelectFrame.BackgroundTransparency -= 0.1

        end
        

    else
        mapSelectUI.Enabled = false
    end

end

function roundSystemClient.mapSelected(map)

    if map == 1 then

        mapText.Text = "Map 1 has been selected!"

    end
    if map == 2 then

        mapText.Text = "Map 2 has been selected!"

    end
    if map == 3 then

        mapText.Text = "Map 3 has been selected!"

    end

end

return roundSystemClient