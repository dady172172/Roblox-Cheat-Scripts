--[[
Games : https://www.roblox.com/games/3191992205/Speed-World-BETA
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
]]--
while wait() do    
	for _,g in pairs(game:GetService("Workspace").Bolts:GetChildren()) do 
		for _,v in pairs(g:GetChildren()) do 
			if (v.Name == "Radius") then
				wait(.01)
				v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			end
		end
	end	
	for _,g in pairs(game:GetService("Workspace")["B_Spawner"]:GetChildren()) do 
		for _,v in pairs(g:GetChildren()) do 
			if (v.Name == "Radius") then
				wait(.01)
				v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			end
		end
	end
end