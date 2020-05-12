--[[
Game https://www.roblox.com/games/4926631744/Gem-Simulator
contact https://github.com/dady172172/Roblox-Cheats
]]--

_G.collect = true
local orgCFrame = game:GetService("Workspace").CashIn.CFrame
while _G.collect == true do
   
    for _,v in pairs(game:GetService("Workspace").Gems:GetChildren()) do
        v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Wait()
        game:GetService("Workspace").CashIn.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Wait()
        game:GetService("Workspace").CashIn.CFrame = orgCFrame
    end
end