local antiCheat = {}
local MarketplaceService = game:GetService("MarketplaceService")
local healthGP = game.ReplicatedStorage.HealthGP
local speedGP = game.ReplicatedStorage.SpeedGP
local jumpGP = game.ReplicatedStorage.JumpGP
local gamePasses = require(script.Parent.gamePasses)

function antiCheat.runAntiCheat(player, selectedRound)
    local playerHumanoid = player.Character.Humanoid
    if playerHumanoid.MaxHealth > 100 and not MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.healthDLC) then
        player:Kick("You have been kicked for exploiting")
    end
    if playerHumanoid.Health > 100 and not MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.healthDLC) then
        player:Kick("You have been kicked for exploiting")
    end

    if playerHumanoid.WalkSpeed > 16 and not MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
        if selectedRound == "Fast" then
            if playerHumanoid.WalkSpeed > 26 and not MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
                player:Kick("You have been kicked for exploiting")
            end
        end
        if SelectedRound == "Super Fast" then
            if playerHumanoid.WalkSpeed > 36 and not MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
                player:Kick("You have been kicked for exploiting")
            end
        end
        if not SelectedRound == "Fast" and not SelectedRound == "Super Fast" then
            player:Kick("You have been kicked for exploiting")
        end
    end
    if playerHumanoid.WalkSpeed > 24 then
        if selectedRound == "Fast" then
            if playerHumanoid.WalkSpeed > 34 then
                player:Kick("You have been kicked for exploiting")
            end
        end
        if SelectedRound == "Super Fast" then
            if playerHumanoid.WalkSpeed > 44 then
                player:Kick("You have been kicked for exploiting")
            end
        end
        if not SelectedRound == "Fast" and not SelectedRound == "Super Fast" then
            player:Kick("You have been kicked for exploiting")
        end
    end
    if playerHumanoid.JumpHeight > 7.3 and not MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.healthDLC) then
        player:Kick("You have been kicked for exploiting")
    end
    if playerHumanoid.JumpPower > 51 and not MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.healthDLC) then
        player:Kick("You have been kicked for exploiting")
    end

    if playerHumanoid.JumpPower > 70 then
        player:Kick("You have been kicked for exploiting")
    end
    if playerHumanoid.JumpHeight > 12 then
        player:Kick("You have been kicked for exploiting")
    end
    if playerHumanoid.MaxHealth > 200 then
        player:Kick("You have been kicked for exploiting")
    end
    if playerHumanoid.Health > 200 then
        player:Kick("You have been kicked for exploiting")
    end
end

healthGP.OnServerEvent:Connect(antiCheat.runAntiCheat)

return antiCheat