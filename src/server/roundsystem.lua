local changeText = game.ReplicatedStorage.ChangeText
local roundSystem = {}
local playersTeleportedToMap = false
local playersTeleportedToLobby = false
local mapSelect = game.ReplicatedStorage.MapSelect
local CollectionService = game:GetService("CollectionService")
local roundSelected = game.ReplicatedStorage.RoundSelected
local BadgeService = game:GetService("BadgeService")
local healthGP = game.ReplicatedStorage.HealthGP
local speedGP = game.ReplicatedStorage.SpeedGP
local jumpGP = game.ReplicatedStorage.JumpGP
local MarketplaceService = game:GetService("MarketplaceService")

local TEN_GAMES_BADGE_ID = 2130048300
local ONE_HUNDRED_GAMES_BADGE_ID = 2130048302
local ONE_THOUSAND_POINTS_BADGE_ID = 2130048323
local FIVE_THOUSAND_POINTS_BADGE_ID = 2130048325


function roundSystem.roundType()

    local roundList = {"Slow", "Fast", "No Jump"}
    local selectedRoundIndex = math.random(1, #roundList)
    selectedRound = roundList[selectedRoundIndex]
    roundSelected:FireAllClients(selectedRound)
    
end

function roundSystem.intermission(intermissionTime)

    intermissionTime.Value -= 1
    changeText:FireAllClients(intermissionTime.Value, "Intermission")
end

function roundSystem.spawnDodgeBalls(roundTime)
    local dodgeBall = Instance.new("Part")
    dodgeBall.Name = "dodgeball"
    dodgeBall.Parent = workspace
    dodgeBall.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    if selectedRound == "Large" then
        dodgeBall.Size = Vector3.new(10, 10, 10)
    else
        dodgeBall.Size = Vector3.new(4, 4, 4)
    end
    dodgeBall.Material = Enum.Material.SmoothPlastic
    dodgeBall.Shape = Enum.PartType.Ball
    dodgeBall.Position = Vector3.new(dodgeBallSpawn.Position.x, dodgeBallSpawn.Position.y + 10, dodgeBallSpawn.Position.z)

    if selectedRound == "Fire" then
        local fire = Instance.new("Fire")
        fire.Name = "fire"
        fire.Parent = dodgeBall
        fire.Heat = 10
    end
    dodgeBall:Clone()

    dodgeBall.Touched:Connect(function(otherPart)
        if selectedRound == "Large" then
            dodgeBall:ApplyImpulse(Vector3.new(math.random(-20000, 20000), 20000, math.random(-20000, 20000)))
        else
            dodgeBall:ApplyImpulse(Vector3.new(math.random(-3000, 3000), 1500, math.random(-3000, 3000)))
        end
        if otherPart.Parent:FindFirstChild("Humanoid") then
            local humanoid = otherPart.Parent:FindFirstChild("Humanoid")
            humanoid:TakeDamage(5)
        end

    end)
    
end

function roundSystem.round(roundTime)

    roundTime.Value -= 1
    changeText:FireAllClients(roundTime.Value, "Time Left")
    local playerList = game:GetService("Players"):GetPlayers()
    for i, player in pairs(playerList) do
        if CollectionService:HasTag(player, "Alive") then
            player.leaderstats.Points.Value += 5
            if player.leaderstats.Points.Value >= 1000 then
                local success, badgeInfo = pcall(function()
                    return BadgeService:GetBadgeInfoAsync(ONE_THOUSAND_POINTS_BADGE_ID)
                end)
                if success then
                    if badgeInfo.IsEnabled then
                        local awardSuccess, result = pcall(function()
                            return BadgeService:AwardBadge(player.UserId, ONE_THOUSAND_POINTS_BADGE_ID)
                        end)
                    end
                end
            end
            if player.leaderstats.Points.Value >= 5000 then
                local success, badgeInfo = pcall(function()
                    return BadgeService:GetBadgeInfoAsync(FIVE_THOUSAND_POINTS_BADGE_ID)
                end)
                if success then
                    if badgeInfo.IsEnabled then
                        local awardSuccess, result = pcall(function()
                            return BadgeService:AwardBadge(player.UserId, FIVE_THOUSAND_POINTS_BADGE_ID)
                        end)
                    end
                end
            end
        end
    end
end

function roundSystem.selectRandomMap()
    local map1, map2, map3 = game.ServerStorage["Map 1"], game.ServerStorage["Map 2"], game.ServerStorage["Map 3"]
    local mapList = {map1, map2, map3}
    local selectedMapIndex = math.random(1, 3)

    local selectedMap = mapList[selectedMapIndex]:Clone()
    selectedMap.Parent = game.Workspace
    playerSpawn = selectedMap["Player Spawn"]
    dodgeBallSpawn = selectedMap["Ball Spawn"]
    mapSelect:FireAllClients(selectedMapIndex)
end


function roundSystem.teleportAndGetPlayers()
    local playerList = game:GetService("Players"):GetPlayers()
    for i, player in pairs(playerList) do
        local playerModel = player.Character.Humanoid.RootPart
        playerModel.Position = Vector3.new(playerSpawn.Position.x, playerSpawn.Position.y, playerSpawn.Position.z)
        local playerHumanoid = player.Character.Humanoid
        if selectedRound == "Slow" then
            if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
                playerHumanoid.WalkSpeed = 14
            else
                playerHumanoid.WalkSpeed = playerHumanoid.WalkSpeed - 10
            end
        end
        if selectedRound == "Fast" then
            if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
                playerHumanoid.WalkSpeed = 34
            else
                playerHumanoid.WalkSpeed += 10
            end
        end
        if selectedRound == "No Jump" then
            if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113506638) then
                playerHumanoid.JumpHeight = 5.8
                playerHumanoid.JumpPower = 20
            else
                playerHumanoid.JumpHeight -= 7.2
                playerHumanoid.JumpPower -= 50
            end
        end
        CollectionService:AddTag(player, "Alive")
        player.leaderstats.Games.Value += 1
        if player.leaderstats.Games.Value >= 10 then
            local success, badgeInfo = pcall(function()
                return BadgeService:GetBadgeInfoAsync(TEN_GAMES_BADGE_ID)
            end)
            if success then
                if badgeInfo.IsEnabled then
                    local awardSuccess, result = pcall(function()
                        return BadgeService:AwardBadge(player.UserId, TEN_GAMES_BADGE_ID)
                    end)
                end
            end
        end
        if player.leaderstats.Games.Value >= 100 then
            local success, badgeInfo = pcall(function()
                return BadgeService:GetBadgeInfoAsync(ONE_HUNDRED_GAMES_BADGE_ID)
            end)
            if success then
                if badgeInfo.IsEnabled then
                    local awardSuccess, result = pcall(function()
                        return BadgeService:AwardBadge(player.UserId, ONE_HUNDRED_GAMES_BADGE_ID)
                    end)
                end
            end
        end
    end
end

function roundSystem.teleportPlayersToLobby()
    local playerList = game:GetService("Players"):GetPlayers()
    for i, player in pairs(playerList) do
        local playerModel = player.Character.Humanoid.RootPart
        local playerHumanoid = player.Character.Humanoid
        local lobbySpawn = game.Workspace.SpawnLocation

        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512622) then
            healthGP:FireClient(player)
        else
            playerHumanoid.Health = 100
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113512366) then
            speedGP:FireClient(player)
        else
            playerHumanoid.WalkSpeed = 16
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, 113506638) then
            jumpGP:FireClient(player)
        else
            playerHumanoid.JumpHeight = 7.2
            playerHumanoid.JumpPower = 50
        end

        if CollectionService:HasTag(player, "Alive") then
            playerModel.Position = Vector3.new(lobbySpawn.Position.x, lobbySpawn.Position.y, lobbySpawn.Position.z)
            CollectionService:RemoveTag(player, "Alive")
        end
        roundSelected:FireAllClients("None")
    end
end

return roundSystem