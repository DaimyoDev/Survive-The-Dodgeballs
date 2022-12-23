local dataStoreService = game:GetService("DataStoreService")
local pointsData = dataStoreService:GetDataStore("PlayerPoints")
local gamesData = dataStoreService:GetDataStore("PlayerGames")
local leaderBoard = require(script.Parent.leaderboard)

local saveData = {}

function saveData.saveData(player)
    local playerPoints = player.leaderstats.Points.Value
    local playerGames = player.leaderstats.Games.Value
    local successPoints, errorPoints = pcall(function()
        pointsData:SetAsync(player.UserId, playerPoints)
    end)
    local successGames, errorGames = pcall(function()
        gamesData:SetAsync(player.UserId, playerGames)
    end)
end

function saveData.loadData(player)
    local successPoints, errorPoints = pcall(function()
        updatedPoints = pointsData:GetAsync(player.UserId)
    end)
    if not successPoints then
        print(errorPoints)
    end
    local successGames, errorGames = pcall(function()
        updatedGames = gamesData:GetAsync(player.UserId)
    end)
    if not successGames then
        print(errorGames)
    end
    if successGames and successPoints then
        leaderBoard.updateLeaderBoard(player, updatedPoints, updatedGames)
    end
end


return saveData