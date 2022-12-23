local dataStoreService = game:GetService("DataStoreService")
local pointsData = dataStoreService:GetDataStore("PlayerPoints")
local gamesData = dataStoreService:GetDataStore("PlayerGames")

local saveData = {}

function saveData.saveData(player)

    local playerPoints = player.leaderstats.Points.Value
    local playerGames = player.leaderstats.Games.Value

    local successPoints, errorPoints = pcall(function()
        pointsData:SetAsync(player, playerPoints)
    end)
    if not successPoints then
    print(errorPoints)
    end

    local successGames, errorGames = pcall(function()
        gamesData:SetAsync(player, playerGames)
    end)
    if not successGames then
    print(errorGames)
    end

end

function saveData.loadData(player)

    local successPoints, errorPoints = pcall(function()
        return pointsData:GetAsync(player)
    end)
    if not successPoints then
        print(errorPoints)
    else
        return successPoints
    end

    local successGames, errorGames = pcall(function()
        return gamesData:GetAsync(player)
    end)
    if not successGames then
        print(errorGames)
    else
        return successGames
    end

end


return saveData