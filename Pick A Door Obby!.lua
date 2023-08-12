
--[[
Game : https://www.roblox.com/games/4930223686
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
]]--

local last = "CheckPoint"
for i,v in pairs(game.Workspace:GetChildren()) do
    if string.find(v.Name, "Checkpoint") and v.ClassName == "MeshPart" then
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
        wait()
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
        last = v       
    end
end
wait()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = last.CFrame