--[[
Game : https://www.roblox.com/games/5736409216
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
]]--

_G.Farm = true --true to auto collect. false to stop auto collecting
while _G.Farm and wait() do
    game.ReplicatedStorage.RemoteEvent:FireServer("RequestCollectCash")
end