local dataStoreService = game:GetService("DataStoreService")
local pointsData = dataStoreService:GetDataStore("PlayerPoints")
local gamesData = dataStoreService:GetDataStore("PlayerGames")

local saveData = {}

function saveData.savePoints(player, playerPoints)

pointsData:SetAsync(player, playerPoints)

end

function saveData.saveGames(player, playerGames)

    gamesData:SetAsync(player, playerGames)

end

function saveData.saveData(player, playerPoints, playerGames)

    local successPoints, errorPoints = pcall(saveData.savePoints(player, playerPoints))
    if not successPoints then
    print(errorPoints)
    end

    local successGames, errorGames = pcall(saveData.savePoints(player, playerGames))
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