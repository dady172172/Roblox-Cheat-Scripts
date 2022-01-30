--[[
Game : https://www.roblox.com/games/4934958405/SALE-Fruit-Collecting-Simulator
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Images : https://prnt.sc/15pgduu , https://prnt.sc/15pggwv

Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
]]--
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
local kVars = {}
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Fruit Collecting Simulator") -- Creates the window

local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local eh = w:CreateFolder("Eggs/Hats")
local misc = w:CreateFolder("Misc")

---- vars ----
local localPlayer = game:GetService("Players").LocalPlayer
local rsEvents = game:GetService("ReplicatedStorage").Events
local origGravity = game.workspace.Gravity
local foodToCollect = "Apple"
local backpackTable = {"Starter Backpack","Shoulder Backpack","Drawstring Backpack","Balloon Backpack","Phoenix Backpack","Unicorn Backpack","Dragon Hatchling Backpack","Playful Puppy Backpack","Robot Backpack","Red 8-Bit Backpack","Green 8-Bit Backpack","Black 8-Bit Backpack","Glowing Neon Backpack","Cookie Jar Backpack","Milk Carton Backpack","Upcycled Backpack","Beach Bucket Backpack","Lifeguard Backpack","Chocolate Backpack","Lollipop Backpack","Lava Drawstring Backpack","Lava 8-Bit Backpack","UFO Backpack","Spaceship Backpack","Red Sailor Duffel Bag","Medic Bag","Ninja Backpack","Ninja Shuriken","Apple Juice Box","XXL Fries To-Go","Jar O' Stars","Boombox"}
local unlockNextArea = {"Dojo", "Camping", "Toy Paradise", "Food Heaven", "Moon", "Volcano", "Candyland", "Beach", "Desert", "Winter"}
local trailTable = {"Default","Red","Blue","Pink","Green","Roblox Logo","Rainbow","Sand","Toy Brick","Water","Lava","Paint","Galaxy"}
local toolTable = {"Trowel","Small Shovel","Shovel","Leaf Rake","Soade","Scissors","Pickaxe","Flat Shovel","Mallet","Crowbar","Pitchfork","Battle Axe","Saw","Small Sickle","Sickle","Reaper Scythe","Rake","Hammer","Bucket","Magnet","Chainsaw","CandyCane","Lava Shovel","Lava Crowbar","Lava Saw","Lava Pickaxe","Lava Chainsaw","Axe","Machete","Bamboo Katana","Katana"}

---- AFK Spot ----
kVars.afkSpotBool = false
b:Toggle("AFK Spot", function(bool)
	kVars.afkSpotBool = bool
	if bool then
		game.workspace.Gravity = 0
	else
		game.workspace.Gravity = origGravity
	end
end)
function afkSpotFunc()
	spawn(function()
		while kVars.afkSpotBool do
			wait()
			if localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-124, -58, -26)
			end
		end
	end)
end
---- farm food ----
kVars.farmFoodBool = false
b:Toggle("Fruit", function(bool)
	kVars.farmFoodBool = bool
	if bool then farmFoodFunc() end
end)
function farmFoodFunc()
	spawn(function()
		while kVars.farmFoodBool do
			wait()
			local curTool = localPlayer.CurrentToolEquipped.Value
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				if localPlayer.Areas:FindFirstChild("Dojo") then
					foodToCollect = "Coconut"
				elseif localPlayer.Areas:FindFirstChild("Camping") then
					foodToCollect = "Grape"
				elseif localPlayer.Areas:FindFirstChild("Toy Paradise") then
					foodToCollect = "Cherry"
				elseif localPlayer.Areas:FindFirstChild("Food Heaven") then
					foodToCollect = "Lime"
				elseif localPlayer.Areas:FindFirstChild("Moon") then
					foodToCollect = "Orange"
				elseif localPlayer.Areas:FindFirstChild("Volcano") then
					foodToCollect = "Pineapple"
				elseif localPlayer.Areas:FindFirstChild("Candyland") then
					foodToCollect = "Pear"
				elseif localPlayer.Areas:FindFirstChild("Beach") then
					foodToCollect = "Watermelon"
				elseif localPlayer.Areas:FindFirstChild("Desert") then
					foodToCollect = "Banana"
				elseif localPlayer.Areas:FindFirstChild("Winter") then
					foodToCollect = "StrawBerry"
				else
					foodToCollect = "Apple"
				end
				if game:GetService("Players").LocalPlayer:WaitForChild("Tools") and curTool ~= nil then
					rsEvents.Collect:FireServer(foodToCollect, localPlayer.Character[curTool])
				end
			end
		end
	end)
end
---- sell ----
local sellBackpackBool = false
b:Toggle("Sell", function(bool)
	sellBackpackBool = bool
	if bool then
		localPlayer.PlayerGui.MainGui.ScreenFrame.BackpackFullFrame.Position = UDim2.new(2, 0, 2, 0)
		sellBackpackFunc()
	else
		localPlayer.PlayerGui.MainGui.ScreenFrame.BackpackFullFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	end
end)
function sellBackpackFunc()
	spawn(function()
		while sellBackpackBool do
			wait()
			if localPlayer.Character:WaitForChild("RightFoot") then
				firetouchinterest(localPlayer.Character.RightFoot, game:GetService("Workspace").MapFolder.TouchParts.SellPart, 0)
				wait(.1)
				firetouchinterest(localPlayer.Character.RightFoot, game:GetService("Workspace").MapFolder.TouchParts.SellPart, 1)
			end
		end
	end)
end
---- buy next backpack ----
local buyNextBackpackBool = false
b:Toggle("Backpack", function(bool)
	buyNextBackpackBool = bool
	if bool then buyNextBackpackFunc() end
end)
function buyNextBackpackFunc()
	spawn(function()
		while buyNextBackpackBool do
			wait()
			local curentBackpack = localPlayer.CurrentBackpackEquipped.Value
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				if curentBackpack ~= backpackTable[#backpackTable] and table.find(backpackTable, curentBackpack) then
					rsEvents.Server:InvokeServer("PurchaseBackpack", backpackTable[table.find(backpackTable, curentBackpack)+1])
				end
			end
		end
	end)
end
---- buy next tool ----
local buyToolBool = false
b:Toggle("Tool", function(bool)
	buyToolBool = bool
	if bool then buyToolFunc() end
end)
function buyToolFunc()
	spawn(function()
		while buyToolBool do
			wait()
			local curTool = localPlayer.CurrentToolEquipped.Value
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				if curTool ~= toolTable[#toolTable] and table.find(toolTable, curTool) then
					rsEvents.Server:InvokeServer("PurchaseTool", toolTable[table.find(toolTable, curTool)+1])
				end
			end
		end
	end)
end
---- buy next trail ----
local buyTrailBool = false
b:Toggle("Trail", function(bool)
	buyTrailBool = bool
	if bool then buyTrailFunc() end
end)
function buyToolFunc()
	spawn(function()
		while buyToolBool do
			wait()
			local curTrail = localPlayer.TrailEquipped.Value
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				local tI = table.find(trailTable, curTrail)
				if trailTable[tI] ~= trailTable[#trailTable] then
					rsEvents.TrailPurchase:FireServer(trailTable[tI+1], localPlayer)
					rsEvents.TrailEquip:FireServer(trailTable[tI+1], localPlayer)
				end
			end
		end
	end)
end
---- unlock next area ----
local unlockNextAreaBool = false
b:Toggle("Next Area", function(bool)
	unlockNextAreaBool = bool
	if bool then unlockNextAreaFunc() end
end)
function unlockNextAreaFunc()
	spawn(function()
		while unlockNextAreaBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				if localPlayer.Areas:FindFirstChild("Dojo") then
				elseif localPlayer.Areas:FindFirstChild("Camping") then
					rsEvents.Server:InvokeServer("UnlockArea", "Dojo")
				elseif localPlayer.Areas:FindFirstChild("Toy Paradise") then
					rsEvents.Server:InvokeServer("UnlockArea", "Camping")
				elseif localPlayer.Areas:FindFirstChild("Food Heaven") then
					rsEvents.Server:InvokeServer("UnlockArea", "Toy Paradise")
				elseif localPlayer.Areas:FindFirstChild("Moon") then
					rsEvents.Server:InvokeServer("UnlockArea", "Food Heaven")
				elseif localPlayer.Areas:FindFirstChild("Volcano") then
					rsEvents.Server:InvokeServer("UnlockArea", "Moon")
				elseif localPlayer.Areas:FindFirstChild("Candyland") then
					rsEvents.Server:InvokeServer("UnlockArea", "Volcano")
				elseif localPlayer.Areas:FindFirstChild("Beach") then
					rsEvents.Server:InvokeServer("UnlockArea", "Candyland")
				elseif localPlayer.Areas:FindFirstChild("Desert") then
					rsEvents.Server:InvokeServer("UnlockArea", "Beach")
				elseif localPlayer.Areas:FindFirstChild("Winter") then
					rsEvents.Server:InvokeServer("UnlockArea", "Desert")
				elseif not localPlayer.Areas:FindFirstChild("Winter") then
					rsEvents.Server:InvokeServer("UnlockArea", "Winter")
				end
			end
		end
	end)
end
---- upgrade gem multiplier ----
local upgradeGemBool = false
b:Toggle("Upgrade Gem", function(bool)
	upgradeGemBool = bool
	if Bool then upgradeGemFunc() end
end)
function upgradeGemFunc()
	spawn(function()
		while upgradeGemBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				rsEvents.Upgrade:FireServer("GemUpgrade", "Coins", localPlayer)
			end
		end
	end)
end
---- upgrade xp multiplier ----
local upgradeXPBool = false
b:Toggle("Upgrade XP", function(bool)
	upgradeXPBool = bool
	if bool then upgradeXPFunc() end
end)
function upgradeXPFunc()
	spawn(function()
		while upgradeXPBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				rsEvents.Upgrade:FireServer("ExpUpgrade", "Gems", localPlayer)
			end
		end
	end)
end
---- upgrade food multiplier ----
local upgradeFoodBool = false
b:Toggle("Upgrade Fruit", function(bool)
	upgradeFoodBool = bool
	if bool then upgradeFoodFunc() end
end)
function upgradeFoodFunc()
	spawn(function()
		while upgradeFoodBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				rsEvents.Upgrade:FireServer("FruitUpgrade", "Gems", localPlayer)
			end	
		end
	end)
end
---- rebirth ----
local rebirthBool = false
b:Toggle("Rebirth", function(bool)
	rebirthBool = bool
	if bool then rebirthFunc() end
end)
function rebirthFunc()
	spawn(function()
		while rebirthBool do
			wait()
			localPlayer:WaitForChild("Tools")
			if localPlayer:WaitForChild("Tools") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				rsEvents.Rebirth:FireServer("Rebirth", localPlayer)
			end	
		end
	end)
end
---- button for game passes ----
b:Button("Game Passes", function()
	localPlayer['4PetsGamepass'].Value = true
	localPlayer.SprintGamepass.Value = true
	localPlayer.MultiEggGamepass.Value  = true
	localPlayer["Faster Respawn"].Value  = true
	localPlayer['2PetsGamepass'].Value  = true
	localPlayer['2xGemsGamepass'].Value  = true
	localPlayer['2xFruitGamepass'].Value  = true
	localPlayer['2xPetExp'].Value  = true
	localPlayer['100SlotsGamepass'].Value = true
	localPlayer['2xDistanceGamepass'].Value = true
	localPlayer['300SlotsGamepass'].Value = true
	localPlayer.StormBreakerGamepass.Value = true
	localPlayer['2xCoinsGamepass'].Value = true
	localPlayer.InfiniteBackpackGamepass.Value = true
	localPlayer.VIPGamepass.Value = true
	localPlayer['2xHatExp'].Value = true
end)

---------------------------------------- Eggs/Hats Section ----------------------------------------
---- Eggs ----
local eggsTable = {"CommonEgg", "UncommonEgg", "RareEgg", "IceEgg", "IdolEgg", "BallEgg", "IceCream", "FlameEgg", "RocketEgg", "GourmetEgg", "ZombieEgg", "ScoutEgg", "FabergeEgg"}
local eggToOpen = "CommonEgg"
eh:Label("Eggs",{
    TextSize = 20; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining 
}) 

eh:Dropdown("CommonEgg", eggsTable, true, function(value)
	eggToOpen = value
end)

local eggOpenBool = false
eh:Toggle("Open Egg", function(bool)
	eggOpenBool = bool
	if bool then openEggFunc() end
end)
function openEggFunc()
	spawn(function()
		while eggOpenBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				rsEvents.Egg:FireServer("OpenEgg",{eggToOpen})
			end
		end
	end)
end
---- Crates ----
local crateTable = {"CommonCrate", "uncommonCrate", "RareCrate", "IceCrate", "IdolCrate", "BeachCrate", "IceCreamCrate", "FlameCrate", "RocketCrate", "GourmetCrate", "ToyCrate", "ScoutCrate", "FabergeCrate"}
local crateToOpen = "CommonCrate"
eh:Label("Crates",{
    TextSize = 20; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining 
}) 

eh:Dropdown("CommonCrate", crateTable, true, function(value)
	crateToOpen = value
end)
local crateOpenBool = false
eh:Toggle("Open Crate", function(bool)
	crateOpenBool = bool
	if bool then openCrateFunc() end
end)
function openCrateFunc()
	spawn(function()
		while crateOpenBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				rsEvents.Crate:FireServer("OpenCrate",{crateToOpen})
			end
		end
	end)
end
-------- Pet Delete --------
local petTable = {}
table.insert(petTable, "1none1")
for i,v in pairs(game:GetService("ReplicatedStorage").Pets:getChildren()) do
	table.insert(petTable, v.Name)
end
table.sort(petTable)
eh:Label("Delete Pet *Carefull*",{
    TextSize = 20; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining 
})
local petDelSelection1 = "1none1"
eh:Dropdown("1none1", petTable, true, function(value)
	petDelSelection1 = value
end)
local petDelSelection2 = "1none1"
eh:Dropdown("1none1", petTable, true, function(value)
	petDelSelection2 = value
end)
local petDelSelection3 = "1none1"
eh:Dropdown("1none1", petTable, true, function(value)
	petDelSelection3 = value
end)
local petDelSelection4 = "1none1"
eh:Dropdown("1none1", petTable, true, function(value)
	petDelSelection4 = value
end)
local petDelBool = false
eh:Toggle("Delete", function(bool)
	petDelBool = bool
	if bool then delPetFunc() end
end)
function delPetFunc()
	spawn(function()
		while petDelBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				if petDelSelection1 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection1 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {game:GetService("Players").LocalPlayer.Pets:FindFirstChild(del)})
						end
					end				
				end
				if petDelSelection2 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection2 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {game:GetService("Players").LocalPlayer.Pets:FindFirstChild(del)})
						end
					end	
				end
				if petDelSelection3 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection3 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {game:GetService("Players").LocalPlayer.Pets:FindFirstChild(del)})
						end
					end	
				end
				if petDelSelection4 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection4 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {game:GetService("Players").LocalPlayer.Pets:FindFirstChild(del)})
						end
					end	
				end
			end
		end
	end)
end
-------- Hat Delete --------
local hatTable = {}
table.insert(hatTable, "1none1")
for i,v in pairs(game:GetService("ReplicatedStorage").Hats:getChildren()) do
	table.insert(hatTable, v.Name)
end
table.sort(hatTable)
eh:Label("Delete hat *Carefull*",{
    TextSize = 20; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining 
})
local hatDelSelection1 = "1none1"
eh:Dropdown("1none1", hatTable, true, function(value)
	hatDelSelection1 = value
end)
local hatDelSelection2 = "1none1"
eh:Dropdown("1none1", hatTable, true, function(value)
	hatDelSelection2 = value
end)
local hatDelSelection3 = "1none1"
eh:Dropdown("1none1", hatTable, true, function(value)
	hatDelSelection3 = value
end)
local hatDelSelection4 = "1none1"
eh:Dropdown("1none1", hatTable, true, function(value)
	hatDelSelection4 = value
end)
local hatDelBool = false
eh:Toggle("Delete", function(bool)
	hatDelBool = bool
	if bool then delHatFunc() end
end)
function delHatFunc()
	spawn(function()
		while hatDelBool do
			wait()
			if localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
				if hatDelSelection1 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Hats:getChildren()) do
						if v.HatName.Value == hatDelSelection1 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.HatInventory:FireServer("DeleteHat", {game:GetService("Players").LocalPlayer.Hats:FindFirstChild(del)})
						end
					end
				end
				if hatDelSelection2 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Hats:getChildren()) do
						if v.HatName.Value == hatDelSelection2 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.HatInventory:FireServer("DeleteHat", {game:GetService("Players").LocalPlayer.Hats:FindFirstChild(del)})
						end
					end
				end
				if hatDelSelection3 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Hats:getChildren()) do
						if v.HatName.Value == hatDelSelection3 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.HatInventory:FireServer("DeleteHat", {game:GetService("Players").LocalPlayer.Hats:FindFirstChild(del)})
						end
					end
				end
				if hatDelSelection4 ~= "1none1" then
					local del = nil
					for i,v in pairs(game:GetService('Players').LocalPlayer.Hats:getChildren()) do
						if v.HatName.Value == hatDelSelection4 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.HatInventory:FireServer("DeleteHat", {game:GetService("Players").LocalPlayer.Hats:FindFirstChild(del)})
						end
					end
				end
			end
		end
	end)
end

---------------------------------------- Misc Section ----------------------------------------
---- PopUpFrame ----
local WalkSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
misc:Slider("Speed",{
    min = 20; -- min value of the slider
    max = 200; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    WalkSpeed = value
end)
spawn(function()
	while wait() do		
		if WalkSpeed and localPlayer.Tools:FindFirstChild("Trowel") and localPlayer.Character:FindFirstChild('HumanoidRootPart') then
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = WalkSpeed
		end
	end
end)
misc:Toggle("Pop Up Frames", function(bool)
	if bool then
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.PopUpFrame.Visible = false
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.LevelUp.Visible = false
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.LeftButtonFrame.CoinsFrame.Visible = false
	else
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.PopUpFrame.Visible = true
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.LevelUp.Visible = true
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.LeftButtonFrame.CoinsFrame.Visible = true
	end
end)