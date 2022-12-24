local leaderBoard = {}
local Players = game:GetService("Players")

function leaderBoard.leaderBoardSetup(player)

    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local points = Instance.new("IntValue")
    points.Name = "Points"
    points.Parent = leaderstats
    points.Value = 0

    local games = Instance.new("IntValue")
    games.Name = "Games"
    games.Parent = leaderstats
    games.Value = 0

end

function leaderBoard.updateLeaderBoard(currentPlayer, newPoints, newGames)

    for i, player in pairs(Players:GetPlayers()) do
        if player.UserId == currentPlayer.UserId then
            player.leaderstats.Points.Value = newPoints
            player.leaderstats.Games.Value = newGames
        end
    end
end
return leaderBoard