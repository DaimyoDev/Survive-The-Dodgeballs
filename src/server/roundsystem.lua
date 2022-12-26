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
local Lighting = game:GetService("Lighting")
local antiCheat = require(script.Parent.anticheat)
local gamePasses = require(script.Parent.gamePasses)
local badges = require(script.Parent.badges)

function roundSystem.roundType()
    local roundList = {"Slow", "Fast", "Small", "No Jump", "Super Fast", "Night", "Large", "Fire", "Super Large"}
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
    elseif selectedRound == "Small" then
        dodgeBall.Size = Vector3.new(2, 2, 2)
    elseif selectedRound == "Super Large" then
        dodgeBall.Size = Vector3.new(20, 20, 20)
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
        fire.Heat = 50
        fire.Size = 20
    end
    dodgeBall:Clone()


    dodgeBall.Touched:Connect(function(otherPart)
        if otherPart.Name == "Wall" then
            return
        end
        local directionX, directionZ = math.random(1, 2), math.random(1, 2)
        if selectedRound ~= "Small" and selectedRound ~= "Large" and selectedRound ~= "Super Large" then
            if directionX == 1 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(2000, 1000, 2000))
            end
            if directionX == 1 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(2000, 1000, -2000))
            end
            if directionX == 2 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(-2000, 1000, 2000))
            end
            if directionX == 2 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(-2000, 1000, -2000))
            end
        end
        if selectedRound == "Small" then
            if directionX == 1 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(250, 100, 250))
            end
            if directionX == 1 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(250, 100, -250))
            end
            if directionX == 2 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(-250, 100, 250))
            end
            if directionX == 2 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(-250, 100, -250))
            end
        end
        if selectedRound == "Large" then
            if directionX == 1 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(20000, 20000, 20000))
            end
            if directionX == 1 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(20000, 20000, -20000))
            end
            if directionX == 2 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(-20000, 20000, 20000))
            end
            if directionX == 2 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(-20000, 20000, -20000))
            end
        end
        if selectedRound == "Super Large" then
            if directionX == 1 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(100000, 130000, 100000))
            end
            if directionX == 1 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(100000, 130000, -100000))
            end
            if directionX == 2 and directionZ == 1 then
                dodgeBall:ApplyImpulse(Vector3.new(-100000, 130000, 100000))
            end
            if directionX == 2 and directionZ == 2 then
                dodgeBall:ApplyImpulse(Vector3.new(-100000, 130000, -100000))
            end
        end
        if otherPart.Parent:FindFirstChild("Humanoid") == nil then
            return
        end
        if otherPart.Parent:FindFirstChild("Humanoid") then
            local humanoid = otherPart.Parent:FindFirstChild("Humanoid")
            humanoid:TakeDamage(30)
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

    if selectedRound == "Night" then
        Lighting:SetMinutesAfterMidnight(0)

    end

    --Fetch players
    for i, player in pairs(playerList) do
        local playerModel = player.Character.Humanoid.RootPart
        playerModel.Position = Vector3.new(playerSpawn.Position.x, playerSpawn.Position.y, playerSpawn.Position.z)
        local playerHumanoid = player.Character.Humanoid
        
        antiCheat.runAntiCheat(player, selectedRound)
        
        if selectedRound == "Slow" then
            if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
                playerHumanoid.WalkSpeed = 14
            else
                playerHumanoid.WalkSpeed = playerHumanoid.WalkSpeed - 10
            end
        end
        if selectedRound == "Fast" then
            if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
                playerHumanoid.WalkSpeed = 34
            else
                playerHumanoid.WalkSpeed += 10
            end
        end
        if selectedRound == "Super Fast" then
            if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
                playerHumanoid.WalkSpeed = 44
            else
                playerHumanoid.WalkSpeed += 20
            end
        end
        if selectedRound == "No Jump" then
            if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.jumpDLC) then
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
                return BadgeService:GetBadgeInfoAsync(badges.TEN_GAMES_BADGE_ID)
            end)
            if success then
                if badgeInfo.IsEnabled then
                    local awardSuccess, result = pcall(function()
                        return BadgeService:AwardBadge(player.UserId, badges.TEN_GAMES_BADGE_ID)
                    end)
                end
            end
        end
        if player.leaderstats.Games.Value >= 100 then
            local success, badgeInfo = pcall(function()
                return BadgeService:GetBadgeInfoAsync(badges.ONE_HUNDRED_GAMES_BADGE_ID)
            end)
            if success then
                if badgeInfo.IsEnabled then
                    local awardSuccess, result = pcall(function()
                        return BadgeService:AwardBadge(player.UserId, badges.ONE_HUNDRED_GAMES_BADGE_ID)
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
        Lighting:SetMinutesAfterMidnight(720)

        if player.leaderstats.Points.Value >= 1000 then
            local success, badgeInfo = pcall(function()
                return BadgeService:GetBadgeInfoAsync(badges.ONE_THOUSAND_POINTS_BADGE_ID)
            end)
            if success then
                if badgeInfo.IsEnabled then
                    local awardSuccess, result = pcall(function()
                        return BadgeService:AwardBadge(player.UserId, badges.ONE_THOUSAND_POINTS_BADGE_ID)
                    end)
                end
            end
        end
        if player.leaderstats.Points.Value >= 5000 then
            local success, badgeInfo = pcall(function()
                return BadgeService:GetBadgeInfoAsync(badges.FIVE_THOUSAND_POINTS_BADGE_ID)
            end)
            if success then
                if badgeInfo.IsEnabled then
                    local awardSuccess, result = pcall(function()
                        return BadgeService:AwardBadge(player.UserId, badges.FIVE_THOUSAND_POINTS_BADGE_ID)
                    end)
                end
            end
        end

        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.healthDLC) then
            playerHumanoid.MaxHealth = 200
            playerHumanoid.Health = playerHumanoid.MaxHealth
        else
            playerHumanoid.Health = 100
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.speedDLC) then
            playerHumanoid.WalkSpeed = 24
        else
            playerHumanoid.WalkSpeed = 16
        end
        if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamePasses.jumpDLC) then
            playerHumanoid.JumpHeight = 12
            playerHumanoid.JumpPower = 70
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