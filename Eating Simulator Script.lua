--[[
Game : https://www.roblox.com/games/1953610113
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
]]--

getgenv().EatFood = true -- change to false to stop


local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
while getgenv().EatFood do
    wait()
    for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
        if v.name == "TouchInterest" then
            if v.Parent.name == "UpperTorso" then
                if game.Players[v.Parent.Parent.name].leaderstats.Mass.Value < game.Players.LocalPlayer.leaderstats.Mass.Value then
                    firetouchinterest(game.Players.LocalPlayer.Character.UpperTorso, v.Parent, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.UpperTorso, v.Parent, 1)
                end
            else
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
          
            end
        end  
    end
    
end