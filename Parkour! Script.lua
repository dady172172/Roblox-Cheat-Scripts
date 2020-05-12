--[[
Game https://www.roblox.com/games/2329123383/Parkour
Contact/More https://github.com/dady172172/Roblox-Cheats
]]--

--2 parts you have to run b/c you die on 132 for some reason
--run this first
for i=1,132 do
    wait()
	game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")[i].CFrame
    i = i + 1
end
-- then run this 
for i=133,250 do
    wait()
    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")[i].CFrame
    i = i + 1
end

