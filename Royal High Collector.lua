--https://www.roblox.com/games/735030788/Royale-High
--https://github.com/dady172172/Roblox-Cheats
--just teleports you to the diamonds in the school area and will teleport you to the spiders you can collect in the main lobby. script can tell the difference between the two.
_G.Collector = true 
while _G.Collector == true do
	Wait(.01)
	local diamond = game:GetService("Workspace"):FindFirstChild("diamond")
	local specialdiamond = game:GetService("Workspace"):FindFirstChild("specialdiamond")
	if diamond ~= nil then
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = diamond.CFrame   
	end 
	if specialdiamond ~= nil then 
		for _,v in pairs(game:GetService("Workspace"):GetChildren()) do 
			if v.Name == "specialdiamond" then 
				if v.Transparency == 0 then
					wait()				
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame  
				end
			end
		end
	end
end