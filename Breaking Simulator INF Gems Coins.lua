--[[
Game : https://www.roblox.com/games/3289941263
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
]]--

-- inf coins
game.ReplicatedStorage.Events.GivePlayerItem:FireServer("Coins", math.huge)

-- inf gems
game:GetService("Players").LocalPlayer.stats.Gems.Value = math.huge

-- remove all gates
game:GetService("Workspace").Gates:Remove()
