--[[
Game : https://www.roblox.com/games/4260821538
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
local w = library:CreateWindow("Jetpack Universe GUI") -- Creates the window
local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Teleport")
local jetpackBool = false
b:Toggle("Farm Resource", function(bool)
	jetpackBool = bool
end)

local sellBool = false
b:Toggle("Sell", function(bool)
	sellBool = bool
end)

local upgradeJetpackBool = false
b:Toggle("Upgrade Jetpack", function(bool)
	upgradeJetpackBool = bool
end)

local upgradeBackpackBool = false
b:Toggle("Upgrade Backpack", function(bool)
	upgradeBackpackBool = bool
end)

b:Button("Chests", function()
	for i,v in pairs(game:GetService("Workspace").DailyTreasures:getChildren()) do
		if v.Model.Collision then
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Model.Collision, 0)
			wait(.2)
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Model.Collision, 1)
		end
	end
end)

local locations = {"Spawn", "Earth", "Floating Island", "Moon", "Mars", "Neptune", "Corroduis"}
local locationsTp = {game:GetService("Workspace").SpawnLocation.CFrame, game:GetService("Workspace").AreaResourseSpawns.Earth.CFrame, game:GetService("Workspace").AreaResourseSpawns["Floating Island"].CFrame, game:GetService("Workspace").AreaResourseSpawns.Moon.CFrame, game:GetService("Workspace").AreaResourseSpawns.Mars.CFrame, game:GetService("Workspace").AreaResourseSpawns.Neptune.CFrame, game:GetService("Workspace").AreaResourseSpawns.Corrodius.CFrame}
for i,v in pairs(locations) do
	local nx, ny, nz, r00, r01, r02, r10, r11, r12, r20, r21, r22 = locationsTp[i]:components()
	c:Button(v, function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(nx,ny+3,nz) end)
end

spawn(function()
	while wait() do
		if upgradeJetpackBool then
			game:GetService("ReplicatedStorage").CTS.UpgradeJetpack:FireServer()
		end
		if upgradeBackpackBool then
			game:GetService("ReplicatedStorage").CTS.UpgradeFuelTank:FireServer()
		end
	end
end)

local OrigSpotSellSpot = game:GetService("Workspace").SellingSpot.Collision.CFrame
local OrigTransSellSpot = game:GetService("Workspace").SellingSpot.Collision.Transparency
spawn(function()
		while wait() do
			if sellBool then
				game:GetService("Workspace").SellingSpot.Collision.Transparency = 1
				repeat
					game:GetService("Workspace").SellingSpot.Collision.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
					Wait()
					game:GetService("Workspace").SellingSpot.Collision.CFrame = OrigSpotSellSpot
				until sellBool == false
				game:GetService("Workspace").SellingSpot.Collision.Transparency = OrigTransSellSpot
			end
		end
end)

spawn(function()
	while wait() do
		if jetpackBool then
			repeat
				Wait()
				local jPL = game:GetService("Players").LocalPlayer.Stats.JetpackLevel.Value
				if jPL == 1 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AreaResourseSpawns.Earth.Coal:FindFirstChild('Coal').BOUNDS.CFrame + Vector3.new(0, 3, 0)
				elseif jPL == 2 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AreaResourseSpawns.Earth.Batteries:FindFirstChild('Batteries').BOUNDS.CFrame + Vector3.new(0, 3, 0)
				elseif jPL == 3 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AreaResourseSpawns.Moon['Wind Turbine']:FindFirstChild('Wind Turbine').BOUNDS.CFrame + Vector3.new(0, 3, 0)
				elseif jPL == 4 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AreaResourseSpawns.Moon['Solar Panel']:FindFirstChild('Solar Panel').BOUNDS.CFrame + Vector3.new(0, 3, 0)
				elseif jPL == 5 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AreaResourseSpawns.Mars["Oil Barrel"]:FindFirstChild('Oil Barrel').BOUNDS.CFrame + Vector3.new(0, 3, 0)
				elseif jPL == 6 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AreaResourseSpawns.Neptune["Nuclear Waste"]:FindFirstChild('Nuclear Waste').BOUNDS.CFrame + Vector3.new(0, 3, 0)
				elseif jPL >= 7 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").AreaResourseSpawns.Corrodius.Corrodium:FindFirstChild('Corrodium').BOUNDS.CFrame + Vector3.new(0, 3, 0)
				end
			until jetpackBool == false
		end
	end
end)