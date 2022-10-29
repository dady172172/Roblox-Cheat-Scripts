--[[
Game : https://www.roblox.com/games/7091685325
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
]]--


getgenv().InfCash = true --Change this to false to disable


while getgenv().InfCash do
    task.wait(.5)
    game:GetService("ReplicatedStorage").Coinclicked:FireServer(math.huge)
    
    for i = 1,4 do
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").SPad,0)
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").SPad,1)
    end
end