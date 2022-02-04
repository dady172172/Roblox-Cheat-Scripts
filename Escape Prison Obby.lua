--[[
Game : https://www.roblox.com/games/3072832953
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
]]--
for i=2,13 do
    wait(.1)  
	local checkpoint = "Checkpoint " .. tostring(i)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")[checkpoint].CFrame
end