--[[
Game https://www.roblox.com/games/3165431732/Crystal-Gem-Simulator
contact https://github.com/dady172172/Roblox-Cheats
]]--

for _,i in pairs(game:GetService("Workspace").DropContainers.Gems:GetChildren()) do		
	for _,v in pairs(i:GetChildren()) do
		Wait()
		v.CanCollide = false
		v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	end
end
