--[[
Game : https://www.roblox.com/games/1953610113
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
]]--

getgenv().EatFood = true -- change to false to stop


local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
while getgenv().EatFood do
    task.wait()
    for i,v in pairs(game:GetService("Workspace").Food:GetChildren()) do
        if v:FindFirstChild("TouchInterest") and v.Name ~= "Tomato" then
            task.wait()
            firetouchinterest(hrp, v, 0)
            firetouchinterest(hrp, v, 1)
        end
    end
end