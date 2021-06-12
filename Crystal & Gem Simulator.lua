--[[
Game https://www.roblox.com/games/3165431732/Crystal-Gem-Simulator
contact https://github.com/dady172172/Roblox-Cheats
GUI made by : https://v3rmillion.net/member.php?action=profile&uid=507120
]]--

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:CreateWindow("Crystal & Gem Simulator") -- Creates the window
local b = w:CreateFolder("") -- Creates the folder(U will put here your buttons,etc)
local autoCollect = false
b:Toggle("Auto Collect",function(bool)
    shared.toggle = bool
    autoCollect = bool
end)
b:Slider("Speed",{
    min = 10; -- min value of the slider
    max = 200; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)
b:DestroyGui()
while wait() do
	if autoCollect == true then
		for _,t in pairs(game:GetService("Workspace").DropContainers.EnchantedGems:GetChildren()) do
		   for _,u in pairs(t:GetChildren()) do
			   wait()
				u.CanCollide = false
				u.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			end
		end
		for _,i in pairs(game:GetService("Workspace").DropContainers.Gems:GetChildren()) do		
			for _,v in pairs(i:GetChildren()) do
				wait()
				v.CanCollide = false
				v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			end
		end
	end
end