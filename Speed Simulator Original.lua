--[[
Game : https://www.roblox.com/games/1131164713
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
--make sure to select Original
]]--

_G.cheat1 = true
while _G.cheat1 == true do
	for _,v in pairs(game.workspace:GetChildren()) do 
		if string.match(v.Name, "Orb") then 
			wait()
			if _G.cheat1 == false then return end
			v.orb2.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			v.orb.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		end
	end
end