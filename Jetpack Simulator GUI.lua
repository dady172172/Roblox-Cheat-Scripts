--[[
Game : https://www.roblox.com/games/2662100821/Jetpack-Simulator
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Jetpack Simulator GUI") -- Creates the window

local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Teleport")
game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.FullFuelFrame.Visible = false
game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.NotEnoughMoneyFrame.Visible = false
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('NotificationService') then
	game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('NotificationService'):Destroy()
end
local plr = game:GetService("Players").LocalPlayer.Name

local jetpackBool = false
b:Toggle("Resource", function(bool)
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

local prestigeBool = false
b:Toggle("Prestige", function(bool)
	prestigeBool = bool
	if bool then
		game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.PrestigeFrame.Visible = false
	else
		game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.PrestigeFrame.Visible = true
	end
end)

b:Button("Enchantments", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(124, 5, -29)
end)
local walkSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
b:Slider("Walk Speed",{
    min = 10; -- min value of the slider
    max = 300; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    walkSpeed = value
end)

spawn(function()
	while wait() do
		game:GetService("ReplicatedStorage").DataFolder[plr].Enchantments.SpeedBoost.Value = walkSpeed
	end
end)

spawn(function()
	while wait() do
		if upgradeJetpackBool then
			game:GetService("ReplicatedStorage").ClientToServer.PurchaseJetpackUpgrade:FireServer()
		end
		if upgradeBackpackBool then
			game:GetService("ReplicatedStorage").ClientToServer.PurchaseFuelUpgrade:FireServer()
		end
		if prestigeBool then
			game:GetService("ReplicatedStorage").ServerToClient.RequestPrestige:FireServer()
		end
	end
end)

local saveLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
c:Button("Save Location", function()
	saveLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame 
end)

c:Button("TP Saved Location", function()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = saveLocation
end)

local locationsNames = {"Spawn","Floating Island","Moon","Mars","Neptune","Jupiter","Planet X","Diamond Planet","Magma Planet","Void Star"}
local locationsCFrames = {CFrame.new(116, 5, -2),CFrame.new(34, 598, -19),CFrame.new(35, 1159, -18),CFrame.new(34, 2118, -17),CFrame.new(34, 3212, -17),CFrame.new(33, 4609, -18),CFrame.new(33, 6767, -19),CFrame.new(32, 8739, -18),CFrame.new(32, 10748, -19),CFrame.new(32, 12631, -18),CFrame.new(32, 12631, -19)}
for i,v in pairs(locationsNames) do
	c:Button(v,function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = locationsCFrames[i]
	end)
end

spawn(function()
	while wait() do
		if sellBool and jetpackBool == false then
			repeat
				wait()
				local jetpackFuel = game:GetService("ReplicatedStorage").DataFolder[plr].JetpackData.FuelLevel.Value
				local jetpackMaxFuel = game:GetService("ReplicatedStorage").DataFolder[plr].JetpackData.MaxFuel.Value
				if sellBool and jetpackFuel >= jetpackMaxFuel then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(89, 12631, -13)
				end
			until not sellBool or jetpackFuel < jetpackMaxFuel
		end
	end
end)

spawn(function()
	while wait() do
		if jetpackBool then
			repeat
				Wait()
				local jetpackLevel = game:GetService("ReplicatedStorage").DataFolder[plr].JetpackData.EnergyLevel.Value
				if jetpackLevel == 1 and game.workspace.Areas.Area1.Coal:FindFirstChild("Coal") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area1.Coal:FindFirstChild("Coal").HitPart.CFrame
				elseif  jetpackLevel == 2 and game.workspace.Areas.Area2.Battery:FindFirstChild("Battery") then 
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area1.Battery:FindFirstChild("Battery").HitPart.CFrame
				elseif  jetpackLevel == 3 and game.workspace.Areas.Area2.Solar:FindFirstChild("Solar") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area2.Solar:FindFirstChild("Solar").HitPart.CFrame
				elseif jetpackLevel == 4 and game.workspace.Areas.Area4.Wind:FindFirstChild("Wind") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area3.Wind:FindFirstChild("Wind").HitPart.CFrame
				elseif jetpackLevel == 5 and game.workspace.Areas.Area7.Nuclear:FindFirstChild("Nuclear") then					
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area7.Nuclear:FindFirstChild("Nuclear").HitPart.CFrame
				elseif jetpackLevel == 6 and game.workspace.Areas.Area7.Plasma:FindFirstChild("Plasma") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area7.Plasma:FindFirstChild("Plasma").HitPart.CFrame
				elseif jetpackLevel == 7 and game.workspace.Areas.Area11.Aetherium:FindFirstChild("Aetherium") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area11.Aetherium:FindFirstChild("Aetherium").HitPart.CFrame
				elseif jetpackLevel == 8 and game.workspace.Areas.Area13.Corrodium:FindFirstChild("Corrodium") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area13.Corrodium:FindFirstChild("Corrodium").HitPart.CFrame
				elseif jetpackLevel == 9 and game.workspace.Areas.Area13["Element 99"]:FindFirstChild("Element 99") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area13["Element 99"]:FindFirstChild("Element 99").HitPart.CFrame
				elseif jetpackLevel == 10 and game.workspace.Areas.Area15.Galacticium:FindFirstChild("Galacticium") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area15.Galacticium:FindFirstChild("Galacticium").HitPart.CFrame
				elseif jetpackLevel == 11 and game.workspace.Areas.Area17.Magmatium:FindFirstChild("Magmatium") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area17.Magmatium:FindFirstChild("Magmatium").HitPart.CFrame
				elseif jetpackLevel == 12 and game.workspace.Areas.Area19["Lightning Orb"]:FindFirstChild("Lightning Orb") then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.workspace.Areas.Area19["Lightning Orb"]:FindFirstChild("Lightning Orb").HitPart.CFrame
				end
				if sellBool then
					repeat
						wait()
						local jetpackFuel = game:GetService("ReplicatedStorage").DataFolder[plr].JetpackData.FuelLevel.Value
						local jetpackMaxFuel = game:GetService("ReplicatedStorage").DataFolder[plr].JetpackData.MaxFuel.Value
						if sellBool and jetpackFuel >= jetpackMaxFuel then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(89, 12631, -13)
						end
					until not sellBool or jetpackFuel < jetpackMaxFuel
				end
				
			until not jetpackBool
		end
	end
end)
