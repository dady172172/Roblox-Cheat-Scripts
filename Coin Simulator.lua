--[[
Game https://www.roblox.com/games/4767544262
contact https://github.com/dady172172/Roblox-Cheats
]]--
--collects coins and can ruin the game for other people
_G.shit = true
while _G.shit == true do
	for _,v in pairs(game:GetService("Workspace"):GetChildren()) do
		if string.match(v.Name, "Coin") then
			if v:FindFirstChild("TouchInterest") then
				wait()
				firetouchinterest(game.Players.LocalPlayer.Character.LeftFoot, v, 0)
			end
		end
	end
end