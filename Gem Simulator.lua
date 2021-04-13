--[[
Game https://www.roblox.com/games/4926631744/Gem-Simulator
contact https://github.com/dady172172/Roblox-Cheats
]]--

_G.collecter = true  -- true to auto collect gems. false to stop
local orgCFrame = game:GetService("Workspace").CashIn.CFrame
while _G.collecter and wait() do
for _,v in pairs(game:GetService("Workspace").Gems:GetChildren()) do
	firetouchinterest(game:GetService("Workspace").keathunsar.RightFoot, v, 0)
end
    game:GetService("Workspace").CashIn.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    wait()
    game:GetService("Workspace").CashIn.CFrame = orgCFrame
end