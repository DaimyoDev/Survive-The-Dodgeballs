local leaderBoard = {}

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

return leaderBoard