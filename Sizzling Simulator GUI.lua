--[[
Game : https://www.roblox.com/games/4572547530
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--
--local Try = loadstring(game:HttpGet('https://raw.githubusercontent.com/F3XTeam/RBX-Try-Library/master/TryLibrary.lua'))()
if game:GetService("CoreGui"):FindFirstChild("Sizzling Simulator GUI By Keathunsar") then
    wait(1)
end
local success, response
local saveTable = {}
---- save file stuff ----
success, response = pcall(function()

if not isfolder("Sizzling Simulator GUI") then
	makefolder("Sizzling Simulator GUI")
end
if isfile("Sizzling Simulator GUI/settings.lua") then
	funcLoad = loadfile("Sizzling Simulator GUI/settings.lua")
	saveTable = funcLoad()
else
	local saveString = 'local save = {\n  theme = {Background = Color3.fromRGB(20, 20, 20), Glow = Color3.fromRGB(141, 60, 255), Accent = Color3.fromRGB(100, 100, 100), LightContrast = Color3.fromRGB(30, 30, 30), DarkContrast = Color3.fromRGB(40, 40, 40), TextColor = Color3.fromRGB(150, 150, 150)},\nrebirth = "x1"\n}\ndo\n  return save\nend\n'
	writefile("Sizzling Simulator GUI/settings.lua",saveString)
end
end)
if success == false then
	local string1 = 'save file stuff:\n'.. 'success:' .. tostring(success) .. ' response:' .. tostring(response)
	print(string1)
end
---------------------------------------- Vars ---------------------------------------------------
local kVars = {}
success, response = pcall(function()

kVars.lplr = game:GetService('Players').LocalPlayer
kVars.plrName = game:GetService('Players').LocalPlayer.Name
kVars.humanoid = game:GetService('Players').LocalPlayer.Character.Humanoid
kVars.autoAttackBool = false
kVars.walkToTarget = false
kVars.magnetMeatItemsBool = false
kVars.dropOffMeatBool = false
kVars.collectCoinsBool = false
kVars.collectGrillCoinsBool = false
kVars.unlockNextAreaBool = false
kVars.upgradeGrillsBool = false
kVars.buyBestWeaponBool = false
kVars.buyBestForkBool = false
kVars.chestBool = false
kVars.rebirthBool = false
kVars.openEggBool = false
kVars.openHatBool = false
kVars.removeSizzling = false
kVars.fogBool = true
kVars.origFog = game.Lighting.FogStart
kVars.sunRaysBool = true
kVars.blurBool = true
kVars.bloomBool = true
kVars.purchasePromptBool = true
kVars.reloadBarBool = true
kVars.nameplatsBool = false
kVars.ECOGUIBool = true
kVars.walkSpeed = game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed
local origWalkSpeed = game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed
kVars.jumpPower = game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower
local origJumpPower = game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower
kVars.origWalkSpeed = 65
kVars.rebirthMulti = "x1"
kVars.themes = {Background = Color3.fromRGB(20, 20, 20), Glow = Color3.fromRGB(141, 60, 255), Accent = Color3.fromRGB(100, 100, 100), LightContrast = Color3.fromRGB(30, 30, 30), DarkContrast = Color3.fromRGB(40, 40, 40), TextColor = Color3.fromRGB(150, 150, 150)}
kVars.autoAttackAnimalName = "Closest"
kVars.closing = false
end)
if success == false then
	local string1 = '---vars:\n'.. 'success:' .. tostring(success) .. ' response:' .. tostring(response)
	print(string1)
end

if saveTable ~= nil and next(saveTable) ~= nil then
	for i,v in pairs(saveTable) do
		if i == "theme" then
			kVars.themes = v
		end
		if i == "rebirth" then
			kVars.rebirthMulti = v
		end
	end
end
_G.themes = kVars.themes


local Locations = {
	[1] = {name = "Area1 - Spawn", cf = CFrame.new(-60, 5, 35)},
	[2] = {name = "Area2 - Duck", cf = CFrame.new(248, 5, 35)},
	[3] = {name = "Area3 - Cow", cf = CFrame.new(516, 5, 35)},
	[4] = {name = "Area4 - Turkey", cf = CFrame.new(794, 5, 35)},
	[5] = {name = "Area5 - Pig", cf = CFrame.new(1069, 5, 35)},
	[6] = {name = "Area6 - WildWest", cf = CFrame.new(1339, 5, 35)},
	[7] = {name = "Area7 - GrassLand", cf = CFrame.new(1620, 5, 35)},
	[8] = {name = "Area8 - DarkForest", cf = CFrame.new(1898, 5, 35)},
	[9] = {name = "Area9 - Moose", cf = CFrame.new(2177, 5, 35)},
	[10] = {name = "Area10 - Prehistoric", cf = CFrame.new(2460, 5, 35)},
	[11] = {name = "Area11 - BlackForest", cf = CFrame.new(-1389, 5, -19)},
	[12] = {name = "Area12 - WinterForest", cf = CFrame.new(-422, 5, 676)},
	[13] = {name = "BossBattle", cf = CFrame.new(366, 5, 882)},
	[14] = {name = "VIP", cf = CFrame.new(-151, 5, -180)}
} 
---- weaponData ----
local weaponData = {}
weaponData[1] = {name = "$50 - Big Stick", id = 2, price = 50} 
weaponData[2] = {name = "$100 - Boulder Club", id = 3, price = 100} 
weaponData[3] = {name = "$300 - Wooden Sword", id = 4, price = 300} 
weaponData[4] = {name = "$700 - Axe", id = 6, price = 700} 
weaponData[5] = {name = "$1000 - Khopesh", id = 7, price = 1000} 
weaponData[6] = {name = "$2000 - Machete", id = 8, price = 2000} 
weaponData[7] = {name = "$5000 - Pirate Cutlass", id = 9, price = 5000} 
weaponData[8] = {name = "$10000 - Lumber Axe", id = 10, price = 10000} 
weaponData[9] = {name = "$13000 - Ice Axe", id = 11, price = 13000} 
weaponData[10] = {name = "$25000 - Stop Sign Axe", id = 12, price = 25000} 
weaponData[11] = {name = "$40000 - Saw Sword", id = 13, price = 40000} 
weaponData[12] = {name = "$55000 - Swordbreaker", id = 14, price = 55000} 
weaponData[13] = {name = "$75000 - Redcliff Axe", id = 15, price = 75000} 
weaponData[14] = {name = "$100000 - Judge Hammer", id = 16, price = 100000} 
weaponData[15] = {name = "$250000 - Inflatable Sword", id = 17, price = 250000} 
weaponData[16] = {name = "$375000 - Skull Basher", id = 18, price = 375000} 
weaponData[17] = {name = "$500000 - Skeleton Axe", id = 19, price = 500000} 
weaponData[18] = {name = "$1000000 - Grim Axe", id = 20, price = 1000000} 
weaponData[19] = {name = "$1500000 - Overseer Axe", id = 21, price = 1500000} 
weaponData[20] = {name = "$4000000 - Overseer Sword", id = 22, price = 4000000} 
weaponData[21] = {name = "$7500000 - Overseer Mace", id = 23, price = 7500000} 
weaponData[22] = {name = "$10000000 - Ice Spiky Club", id = 24, price = 10000000} 
weaponData[23] = {name = "$15000000 - Murder Knife", id = 25, price = 15000000} 
weaponData[24] = {name = "$20000000 - Earth Sword", id = 26, price = 20000000} 
weaponData[25] = {name = "$25000000 - Tides Sword", id = 27, price = 25000000} 
weaponData[26] = {name = "$35000000 - Flames Sword", id = 28, price = 35000000} 
weaponData[27] = {name = "$50000000 - Mega Mallet", id = 29, price = 50000000} 
weaponData[28] = {name = "$80000000 - Glorious Sword", id = 30, price = 80000000} 
weaponData[29] = {name = "$120000000 - Fang Dagger", id = 31, price = 120000000} 
weaponData[30] = {name = "$150000000 - Luck Sword", id = 32, price = 150000000} 
weaponData[31] = {name = "$200000000 - Pot O' Gold Sword", id = 33, price = 200000000} 
weaponData[32] = {name = "$400000000 - Bombastic Sword", id = 34, price = 400000000} 
weaponData[33] = {name = "$750000000 - 8-Bit Sword", id = 35, price = 750000000} 
weaponData[34] = {name = "$1500000000 - Chartreuse Periastron", id = 36, price = 1500000000} 
weaponData[35] = {name = "$5000000000 - Rainbow Periastron", id = 37, price = 5000000000} 
weaponData[36] = {name = "$7500000000 - Ghostfire Dagger", id = 38, price = 7500000000} 
weaponData[37] = {name = "$10000000000 - Golem's Hammer", id = 39, price = 10000000000} 
weaponData[38] = {name = "$1e+14 - Dark Sword", id = 41, price = 1e+14} 
weaponData[39] = {name = "$1e+17 - Ice Breaker", id = 42, price = 1e+17} 
---- weaponDropDown ----
local weaponDropDown = {}
for i,v in pairs(weaponData) do
	table.insert(weaponDropDown, v.name)
end
---- forkData ----
local forkData = {}
forkData[1] = {name = "$50 - Green Fork", id = 2, price = 50} 
forkData[2] = {name = "$150 - Blue Fork", id = 3, price = 150} 
forkData[3] = {name = "$250 - White Fork", id = 4, price = 250} 
forkData[4] = {name = "$500 - Yellow Fork", id = 5, price = 500} 
forkData[5] = {name = "$800 - Orange Fork", id = 6, price = 800} 
forkData[6] = {name = "$2000 - Red Fork", id = 7, price = 2000} 
forkData[7] = {name = "$5000 - Purple Fork", id = 8, price = 5000} 
forkData[8] = {name = "$10000 - Pink Fork", id = 9, price = 10000} 
forkData[9] = {name = "$20000 - Neon Blue Fork", id = 10, price = 20000} 
forkData[10] = {name = "$35000 - Neon Green Fork", id = 11, price = 35000} 
forkData[11] = {name = "$75000 - Neon Yellow Fork", id = 12, price = 75000} 
forkData[12] = {name = "$150000 - Neon Orange Fork", id = 13, price = 150000} 
forkData[13] = {name = "$250000 - Neon Red Fork", id = 14, price = 250000} 
forkData[14] = {name = "$400000 - Really Blue Fork", id = 15, price = 400000} 
forkData[15] = {name = "$750000 - Dark Fork", id = 16, price = 750000} 
forkData[16] = {name = "$1000000 - Forcefield Fork", id = 17, price = 1000000} 
forkData[17] = {name = "$1200000 - Love Fork", id = 18, price = 1200000} 
forkData[18] = {name = "$3000000 - Lucky Fork", id = 19, price = 3000000} 
forkData[19] = {name = "$6000000 - Bubbling Fork", id = 20, price = 6000000} 
forkData[20] = {name = "$12000000 - Forest Fork", id = 21, price = 12000000} 
forkData[21] = {name = "$18000000 - Ghost Fork", id = 22, price = 18000000} 
forkData[22] = {name = "$30000000 - Toxic Fork", id = 23, price = 30000000} 
forkData[23] = {name = "$45000000 - Flaming Fork", id = 24, price = 45000000} 
forkData[24] = {name = "$80000000 - Galaxy Fork", id = 25, price = 80000000} 
forkData[25] = {name = "$120000000 - Plasma Fork", id = 26, price = 120000000} 
forkData[26] = {name = "$200000000 - Electric Fork", id = 27, price = 200000000} 
forkData[27] = {name = "$300000000 - Shiny Fork", id = 28, price = 300000000} 
forkData[28] = {name = "$500000000 - Hot Fork", id = 29, price = 500000000} 
----ForkDropDown
local forkDropDown = {}
for i,v in pairs(forkData) do
	table.insert(forkDropDown, v.name)
end
---- egg data ----
eggData = {}
eggData[1] = {name = "$100 - Basic Egg", id = 1 } 
eggData[2] = {name = "$1500 - Snack Egg", id = 2 } 
eggData[3] = {name = "$10000 - Toy Egg", id = 3 } 
eggData[4] = {name = "$50000 - Jungle Egg", id = 4 } 
eggData[5] = {name = "$150000 - Rare Egg", id = 5 } 
eggData[6] = {name = "$750000 - Cactus Egg", id = 6 } 
eggData[7] = {name = "$2000000 - Watermelon Egg", id = 7 } 
eggData[8] = {name = "$5000000 - Vampire Egg", id = 8 } 
eggData[9] = {name = "$20000000 - Shark Egg", id = 9 } 
eggData[10] = {name = "$75000000 - Magma Egg", id = 10 } 
eggData[11] = {name = "$1e+14 - Black Forest Egg", id = 19 } 
eggData[12] = {name = "$1e+16 - Snowman Egg", id = 21 } 
---- egg names list ----
eggNames = {}
eggNames[1] = "$100 - Basic Egg" 
eggNames[2] = "$1500 - Snack Egg" 
eggNames[3] = "$10000 - Toy Egg" 
eggNames[4] = "$50000 - Jungle Egg" 
eggNames[5] = "$150000 - Rare Egg" 
eggNames[6] = "$750000 - Cactus Egg" 
eggNames[7] = "$2000000 - Watermelon Egg" 
eggNames[8] = "$5000000 - Vampire Egg" 
eggNames[9] = "$20000000 - Shark Egg" 
eggNames[10] = "$75000000 - Magma Egg" 
eggNames[11] = "$1e+14 - Black Forest Egg" 
eggNames[12] = "$1e+16 - Snowman Egg" 
---- crate data ----
crateData = {}
crateData[1] = {name = "$250 - Basic Crate", id = 11 } 
crateData[2] = {name = "$2000 - Snack Crate", id = 12 } 
crateData[3] = {name = "$15000 - Toy Crate", id = 13 } 
crateData[4] = {name = "$200000 - Rare Crate", id = 14 } 
crateData[5] = {name = "$1000000 - Desert Crate", id = 15 } 
crateData[6] = {name = "$5000000 - Graveyard Crate", id = 16 } 
crateData[7] = {name = "$15000000 - Beach Crate", id = 17 } 
crateData[8] = {name = "$50000000 - Magma Crate", id = 18 } 
crateData[9] = {name = "$1.5e+14 - Black Forest Crate", id = 20 } 
crateData[10] = {name = "Gem750 - Winter Crate", id = 22 } 
---- crate names list ----
crateNames = {}
crateNames[1] = "$250 - Basic Crate" 
crateNames[2] = "$2000 - Snack Crate" 
crateNames[3] = "$15000 - Toy Crate" 
crateNames[4] = "$200000 - Rare Crate" 
crateNames[5] = "$1000000 - Desert Crate" 
crateNames[6] = "$5000000 - Graveyard Crate" 
crateNames[7] = "$15000000 - Beach Crate" 
crateNames[8] = "$50000000 - Magma Crate" 
crateNames[9] = "$1.5e+14 - Black Forest Crate" 
crateNames[10] = "Gem750 - Winter Crate" 
---- animal data ----
animalData = {}
animalData[1] = {dropName = "Area1 - Chicken", name = "Chicken"} 
animalData[2] = {dropName = "Area1 - Cornish Chicken", name = "Cornish Chicken"} 
animalData[3] = {dropName = "Area2 - Duck", name = "Duck"} 
animalData[4] = {dropName = "Area2 - Blue Duck", name = "Blue Duck"} 
animalData[5] = {dropName = "Area3 - Cow", name = "Cow"} 
animalData[6] = {dropName = "Area3 - Brown Cow", name = "Brown Cow"} 
animalData[7] = {dropName = "Area4 - Turkey", name = "Turkey"} 
animalData[8] = {dropName = "Area4 - Red Turkey", name = "Red Turkey"} 
animalData[9] = {dropName = "Area5 - Pig", name = "Pig"} 
animalData[10] = {dropName = "Area5 - Fat Pig", name = "Fat Pig"} 
animalData[11] = {dropName = "Area6 - Bison", name = "Bison"} 
animalData[12] = {dropName = "Area6 - Dark Bison", name = "Dark Bison"} 
animalData[13] = {dropName = "Area7 - Doe", name = "Doe"} 
animalData[14] = {dropName = "Area7 - Buck", name = "Buck"} 
animalData[15] = {dropName = "Area8 - Black Bear", name = "Black Bear"} 
animalData[16] = {dropName = "Area8 - Grizzly Bear", name = "Grizzly Bear"} 
animalData[17] = {dropName = "Area9 - Moose", name = "Moose"} 
animalData[18] = {dropName = "Area9 - Angry Moose", name = "Angry Moose"} 
animalData[19] = {dropName = "Area10 - Dinosaur", name = "Dinosaur"} 
animalData[20] = {dropName = "Area10 - Angry Dinosaur", name = "Angry Dinosaur"} 
animalData[21] = {dropName = "Area10 - Fiery Dinosaur", name = "Fiery Dinosaur"} 
animalData[22] = {dropName = "Area11 - Wolf", name = "Wolf"} 
animalData[23] = {dropName = "Area11 - Brown Wolf", name = "Brown Wolf"} 
animalData[24] = {dropName = "Area11 - Big Bad Wolf", name = "Big Bad Wolf"} 
animalData[25] = {dropName = "Area12 - Arctic Fox", name = "Arctic Fox"} 
animalData[26] = {dropName = "Area12 - Yeti", name = "Yeti"} 
animalData[27] = {dropName = "Area13 - Lion", name = "Lion"} 
animalData[28] = {dropName = "Area13 - Rhino", name = "Rhino"} 
animalData[29] = {dropName = "Area13 - Dragon", name = "Dragon"}
---- animal dropdown names ----
animalDropNames = {}
for i,v in pairs(animalData) do
	table.insert(animalDropNames,v.dropName)
end
table.insert(animalDropNames,1,"Closest")


local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent
local RemoteFunc = game:GetService("ReplicatedStorage").RemoteFunction
local RunService = game:GetService("RunService")
if game:GetService("CoreGui"):FindFirstChild("Sizzling Simulator GUI By Keathunsar") then
	game:GetService("CoreGui")["Sizzling Simulator GUI By Keathunsar"]:Remove()
end

---- anti AFK ----
game:GetService('Players').LocalPlayer.Idled:connect(function()
    game:GetService('VirtualUser'):CaptureController()
    game:GetService('VirtualUser'):ClickButton2(Vector2.new())
end)
---- librarys for GUI ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dady172172/Roblox-Cheats/master/UILibs/Venyx%20UILIB.lua"))() --someone reuploaded it so I put it in place of the original back up so guy can get free credit.
local venyx = library.new("Sizzling Simulator GUI By Keathunsar", 5013109572)
local pages = {}
-- pages
pages.page = venyx:addPage("Farm", 5012544693)
pages.ab = pages.page:addSection("Auto Attack")
pages.a = pages.page:addSection("Collect")

pages.pageRebirth = venyx:addPage("Rebirth", 5012544693)
pages.aRebirth = pages.pageRebirth:addSection("Rebirth")
pages.cRebirth = pages.pageRebirth:addSection("Rebirth Shop")
pages.bRebirth = pages.pageRebirth:addSection("Menu")
pages.page2 = venyx:addPage("Menus", 5012544693)
pages.b = pages.page2:addSection("Menus")
pages.ba = pages.page2:addSection("Crafting")
pages.page3 = venyx:addPage("Buy", 5012544693)
pages.c = pages.page3:addSection("Weapon")
pages.ca = pages.page3:addSection("Fork")
pages.cb = pages.page3:addSection("Egg")
pages.cc = pages.page3:addSection("Crate")
pages.cd = pages.page3:addSection("Delete Pet")
pages.page4 = venyx:addPage("Teleport", 5012544693)
pages.d = pages.page4:addSection("Teleport")
pages.pageKeyBinds = venyx:addPage("Keybinds", 5012544693)
pages.aKeyBinds = pages.pageKeyBinds:addSection("Keybinds")
pages.page5 = venyx:addPage("Misc", 5012544693)
pages.e = pages.page5:addSection("Misc")
---------------------------------------- Main ---------------------------------------------------
local meat = false
local coin = false
local last = math.huge
local nearest = nil
local id = nil
local currentTarget = 8
---- Auto Attack ----
pages.ab:addDropdown(animalDropNames[1],animalDropNames,function(value)
	for i,v in pairs(animalData) do
		if value == "Closest" then
			kVars.autoAttackAnimalName = "Closest"
		end
		if v.dropName == value then
			kVars.autoAttackAnimalName = v.name
			break
		end
	end	
end)
pages.ab:addToggle("Walk To Target", kVars.walkToTarget, function(bool)
	kVars.walkToTarget = bool
end)
pages.ab:addToggle("Attack", kVars.autoAttackBool, function(bool)
	kVars.autoAttackBool = bool
	if bool then 
		autoAttackFunc()
	else
		RemoteEvent:FireServer("Animal Deselected", currentTarget)
	end
end)

---- Magnet meat/items ----
pages.a:addToggle("Magnet Meat/Items", kVars.magnetMeatItemsBool, function(bool)
	kVars.magnetMeatItemsBool = bool 
	if bool then magnetMeatItemsFunc() end
end)

---- Drop Off Meat ----
pages.a:addToggle("Drop Off Meat", kVars.dropOffMeatBool, function(bool)
	kVars.dropOffMeatBool  = bool
	if bool then dropOffMeatFunc() end
end)

---- Collect Grill Coins ----
pages.a:addToggle("Collect Grill Coins", kVars.collectGrillCoinsBool, function(bool)
	kVars.collectGrillCoinsBool  = bool
	if bool then collectGrillCoinsFunc() end
end)

---- Collect Coins ----
pages.a:addToggle("Collect Coins", kVars.collectCoinsBool, function(bool)
	kVars.collectCoinsBool = bool
	if bool then collectCoinsFunc() end
end)

---- Unlock Next Area ----
local areaList = {}
local areaListNames = {}
for i,v in pairs(game:GetService("Workspace").AreaEntries:getChildren()) do
	local isUnlocked = false
	if v:FindFirstChild('MainWindow') then
		if v.MainWindow.Transparency == 1 then
			isUnlocked = true
		end
	end
	table.insert(areaList, {name = string.match(tostring(v),"%d+"), unlocked = isUnlocked})
	table.insert(areaListNames, tostring(v))
end
pages.a:addToggle("Unlock Areas", kVars.unlockNextAreaBool, function(bool)
	kVars.unlockNextAreaBool = bool
	if bool then unlockAreaFunc() end
end)

---- upgrade grills ----
pages.a:addToggle("Upgrade Grills", kVars.upgradeGrillsBool, function(bool)
	kVars.upgradeGrillsBool = bool
	if bool then upgradeGrillsFunc() end
end)

---- buy best weapon auto ----
pages.a:addToggle("Buy Best Weapon", kVars.buyBestWeaponBool, function(bool)
	kVars.buyBestWeaponBool = bool
	if bool then buyBestWeaponFunc() end
end)

---- buy best fork auto ----

pages.a:addToggle("Buy Best Fork", kVars.buyBestForkBool, function(bool)
	kVars.buyBestForkBool = bool
	if bool then buyBestForkFunc() end
end)

---- auto chests ----

pages.a:addToggle("Chests", kVars.chestBool, function(bool)
	kVars.chestBool = bool
	if bool then openChestsFunc() end
end)
----------------------------------------------------------- Rebirth Section -----------------------------------------------------------
---- Rebirth Dropdown ----	
pages.aRebirth:addDropdown(kVars.rebirthMulti,{"x1","x3","x5"},function(num)
	kVars.rebirthMulti = num
end)

---- Rebirth Button ----
pages.aRebirth:addButton("Rebirth",function()
	local num = string.match(kVars.rebirthMulti, "%d")
	RemoteEvent:FireServer('Rebirth',tonumber(num))
end)

---- Rebirth Toggle ----
pages.aRebirth:addToggle("Rebirth",kVars.rebirthBool, function(bool)
	kVars.rebirthBool = bool
	if bool then
		rebirthFunc()
	end
end)

pages.aRebirth:addToggle("Teleport to area",kVars.rebirthBool, function(bool)
	kVars.boolMyTeleportRebirth = bool
	if bool then
		fMyTeleportRebirth()
	end
end)

function fMyTeleportRebirth()
	spawn(function()
		while kVars.boolMyTeleportRebirth do
			wait()
			local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			local WeaponInv, curWeaponId = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Get Weapon Data")
			local a = (hrp.Position - Vector3.new(40, 6, 37)).magnitude
			local b = (hrp.Position - Vector3.new(2598, 6, 39)).magnitude
			local c = (hrp.Position - Vector3.new(2728, 6, -93)).magnitude
			if curWeaponId == 39 and b > 5 then
				wait()
				if hrp then
					hrp.CFrame = CFrame.new(2598, 6, 39)
				end
			elseif curWeaponId >= 41 and c > 5 then
				wait()
				if hrp then
					hrp.CFrame = CFrame.new(2728, 6, -93)
				end
			elseif curWeaponId <= 38 and a > 5 then
				wait()
				if hrp then
					hrp.CFrame = CFrame.new(40, 6, 37)
				end
			end
		end
	end)
 end

-------- Rebirth Shop --------
pages.cRebirth:addToggle("Buy Coin Multiplier",kVars.rebirthBool, function(bool)
	kVars.buyCoinMultiplierBool = bool
end)

pages.cRebirth:addToggle("Buy XP Multiplier",kVars.rebirthBool, function(bool)
	kVars.buyXpMultiplierBool = bool
end)

pages.cRebirth:addToggle("Buy Pet Start Level",kVars.rebirthBool, function(bool)
	kVars.buyPetStartLevelBool = bool
end)

-------- Respawn Menus --------
---- x1 ----
pages.bRebirth:addButton("x1", function()
	if game:GetService("Workspace"):FindFirstChild('RebirthButton') then
		fireTouch(game:GetService("Workspace").RebirthButton.TouchPart)
	end
end)
---- x3 ----
pages.bRebirth:addButton("x3", function()
	if game:GetService("Workspace"):FindFirstChild('Rebirth3Button') then
		fireTouch(game:GetService("Workspace").Rebirth3Button.TouchPart)
	end
end)
---- x5 ----
pages.bRebirth:addButton("x5", function()
	if game:GetService("Workspace"):FindFirstChild('Rebirth5Button') then
		fireTouch(game:GetService("Workspace").Rebirth5Button.TouchPart)
	end
end)
----------------------------------------------------------- Menus -----------------------------------------------------------
---- Grills Upgrade Menu ----
pages.b:addButton("Grills Upgrade",function()
	kVars.lplr.PlayerGui.MainGui.GrillMenuFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)

---- Rebirth Shop ----
pages.b:addButton("Rebirth Shop",function()
	game:GetService("Players").LocalPlayer.PlayerGui.MainGui.RebirthShopFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)
---- Hats Upgrade ----
pages.b:addButton("Hats Upgrade",function()
	game:GetService("Players").LocalPlayer.PlayerGui.MainGui.UpgradeFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
	--[[if game:GetService("Workspace"):FindFirstChild("Caleb Touch") then
		fireTouch(game:GetService("Workspace")["Caleb Touch"].TouchPart)
	end]]--
end)
---- Potions Shop ----
pages.b:addButton("Potions Shop",function()
	if game:GetService("Workspace"):FindFirstChild("Pet Scientist Touch") then
		fireTouch(game:GetService("Workspace")["Pet Scientist Touch"].TouchPart)
	end
	
end)

-------- Crafting Menus --------
---- Julia [Zone 6 ----
pages.ba:addButton("Julia [Zone 6]", function()
	if game:GetService("Workspace"):FindFirstChild("Julia Touch") then
		fireTouch(game:GetService("Workspace")["Julia Touch"].TouchPart)
	end
end)
---- Ancient Dragon [Zone 10] ----
pages.ba:addButton("Ancient Dragon [Zone 10]", function()
	if game:GetService("Workspace"):FindFirstChild("Ancient Dragon Touch") then
		fireTouch(game:GetService("Workspace")["Ancient Dragon Touch"].TouchPart)
	end
end)
---- Henry [Black Forest] ----
pages.ba:addButton("Henry [Black Forest]", function()
	if game:GetService("Workspace"):FindFirstChild("Henry Touch") then
		fireTouch(game:GetService("Workspace")["Henry Touch"].TouchPart)
	end
end)
---- Trevor [Winter Forest] ----
pages.ba:addButton("Trevor [Winter Forest]", function()
	if game:GetService("Workspace"):FindFirstChild("Trevor Touch") then
		fireTouch(game:GetService("Workspace")["Trevor Touch"].TouchPart)
	end
end)
---- Steven [VIP] ----
pages.ba:addButton("Steven [VIP]", function()
	if game:GetService("Workspace"):FindFirstChild("Steven Touch") then
		fireTouch(game:GetService("Workspace")["Steven Touch"].TouchPart)
	end
end)

function fireTouch(part)
	if kVars.lplr.Character:FindFirstChild('RightFoot') then
		firetouchinterest(kVars.lplr.Character.RightFoot, part, 0)
		wait(.5)
		firetouchinterest(kVars.lplr.Character.RightFoot, part, 1)
	end
end
----------------------------------------------------------- BUY -----------------------------------------------------------
---- Weapon DropDown ----
pages.c:addDropdown(weaponDropDown[1],weaponDropDown,function(num)
	kVars.weaponNum = num
end)

---- Weapon Button ----
pages.c:addButton("Buy",function()
	for i,v in pairs(weaponData) do
		if kVars.weaponNum ~= nil then
			if v.name == kVars.weaponNum then
				RemoteEvent:FireServer("Buy Weapon", v.id)
				break
			end
		end
	end	
end)

---- Weapon Buy Best ----
pages.c:addButton("Buy Best",function()
	funcBuyBestWeapon()
end)

function funcBuyBestWeapon()
	local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency");
	local WeaponInv, curWeaponId = RemoteFunc:InvokeServer("Get Weapon Data")
	local wantToBuy = nil
	---- stops if you have the best weapon in game equiped
	if curWeaponId ~= 42 then
		---- set robux weapons ID equal to equivlent 
		if curWeaponId == 40 then curWeaponId = 3 end
		if curWeaponId == 5 then curWeaponId = 22 end
		---- get want to buyitems
		for i,v in pairs(weaponData) do
			if v.price then
				if v.price > pCoins and v.id > curWeaponId then
					wantToBuy = weaponData[i-1].id
					if wantToBuy == 40 then wantToBuy = 39 end
					if wantToBuy == 5 then wantToBuy = 4 end
					break
				elseif i == #weaponData then
					wantToBuy = 42
				end
			end
		end
		if wantToBuy ~= nil and wantToBuy ~= curWeaponId then
			RemoteEvent:FireServer("Buy Weapon", wantToBuy)
		end
	end
end

---- fork dropdown ----
pages.ca:addDropdown(forkDropDown[1], forkDropDown,function(num)
	kVars.forkNum = num
end)

---- Fork Button ----
pages.ca:addButton("Buy",function()
	for i,v in pairs(forkData) do
		if kVars.forknum ~= nil then
			if v.name == kVars.forkNum then
				RemoteEvent:FireServer("Buy Fork", v.id)
				break
			end
		end
	end
end)
	

---- Fork Buy Best ----e
pages.ca:addButton("Buy Best",function()
	funcBuyBestFork()
end)
function funcBuyBestFork()
	local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency")
	local forkInv, curForkId = RemoteFunc:InvokeServer("Get Fork Data")
	local forkWantToBuy = nil
	if curForkId ~= 29 then
		for i,v in pairs(forkData) do
			if v.price then
				if v.price > pCoins and v.id > curForkId and v.id ~= 30  then
					forkWantToBuy = i-1
					break
				elseif i == #forkData or i == 29 then
					forkWantToBuy = 29
				end
			end
		end
		if forkWantToBuy ~= nil and forkWantToBuy ~= curForkId then
			RemoteEvent:FireServer("Buy Fork", forkWantToBuy)
		end
	end
end

---- Eggs ----
pages.cb:addDropdown(eggNames[1],eggNames,function(value)
	for i,v in pairs(eggData) do
		if v.name == value then
			kVars.eggSelection = v.id
			break
		end
	end
end)

pages.cb:addToggle("Open Egg", kVars.openEggBool, function(bool)
	kVars.openEggBool = bool
	if bool then openEggFunc() end
end)

pages.cb:addToggle("Open 3 *Must Buy* ", kVars.openThreeEggsBool, function(bool)
	kVars.openThreeEggsBool = bool
end)

---- Hats ----
pages.cc:addDropdown(crateNames[1],crateNames,function(value)
	for i,v in pairs(crateData) do
		if v.name == value then
			kVars.crateSelection = v.id
		end
	end
end)

pages.cc:addToggle("Open Crate", kVars.openHatBool, function(bool)
	kVars.openHatBool = bool
	if bool then openCrateFunc() end
end)

pages.cc:addToggle("Open 3 *Must Buy*", kVars.openThreeCrateBool, function(bool)
	kVars.openThreeCrateBool = bool
	
end)

---- delete pets ----
local petList = {}
for i,v in pairs(game:GetService("ReplicatedStorage").InstanceData.Pets:getChildren()) do
	table.insert(petList,v.Name)
end
table.sort(petList)
table.insert(petList,1,"None")
pages.cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel1 = value
end)
pages.cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel2 = value
end)
pages.cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel3 = value
end)
pages.cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel4 = value
end)
pages.cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel5 = value
end)
pages.cd:addToggle("Delete *Rename Any Pets you don't want delete*", kVars.petDelBool, function(bool)
	kVars.petDelBool = bool
	if bool then petDelFunc() end
end)
function petDelFunc()
	spawn(function()
		while kVars.petDelBool do
			wait()
			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.MainGui.InventoryFrame.Contents.ScrollingFrame:GetChildren()) do
				if v:FindFirstChild('Title') then
					local name = v.Title.Text
					if name == kVars.petDel1 or name == kVars.petDel2 or name == kVars.petDel3 or name == kVars.petDel4 or name == kVars.petDel5 then
						RemoteEvent:FireServer("Delete Pet", v.Name:sub(4))
					end
				end
			end
		end
	end)
end
----------------------------------------------------------- Teleports -----------------------------------------------------------
for k,v in ipairs(Locations) do
	pages.d:addButton(tostring(v.name),function()
		kVars.lplr.Character.HumanoidRootPart.CFrame = Locations[k].cf		
	end)
end 
----------------------------------------------------------- KeyBinds -----------------------------------------------------------
---- open close menu ----
pages.aKeyBinds:addKeybind("Open/Close Menu", Enum.KeyCode.Backquote, function()
venyx:toggle()
end, function()
end)

---- Auto Attack ----
pages.aKeyBinds:addKeybind("Auto Attack", nil, function()
	if kVars.autoAttackBool == false then
		kVars.autoAttackBool = true
	else
		kVars.autoAttackBool = false
		RemoteEvent:FireServer("Animal Deselected", currentTarget)
	end
end, function()
end)

---- magnet meat items ----
pages.aKeyBinds:addKeybind("Magnet Meat/Items", nil, function()
	if kVars.magnetMeatItemsBool == false then
		kVars.magnetMeatItemsBool = true
	else
		kVars.magnetMeatItemsBool = false
	end
end, function()
end)

---- Drop Off Meat ----
pages.aKeyBinds:addKeybind("Drop Off Meat", nil, function()
	if kVars.dropOffMeatBool == false then
		kVars.dropOffMeatBool  = true
	else
		kVars.dropOffMeatBool  = false
	end
end, function()
end)

---- Collect Grill Coins ----
pages.aKeyBinds:addKeybind("Collect Grill Coins", nil, function()
	if collectGrillCoinsBool == false then
		collectGrillCoinsBool  = true
	else
		collectGrillCoinsBool  = false
	end
end, function()
end)

---- collectCoinsBool ----
pages.aKeyBinds:addKeybind("Collect Coins", nil, function()

	if collectCoinsBool == false then
		collectCoinsBool = true
	else
		collectCoinsBool = false
	end
end, function()
end)
pages.aKeyBinds:addKeybind("Open Inventory", nil, function()
	game:GetService("Players").LocalPlayer.PlayerGui.mainGui.ViewInventoryFrame:TweenPosition(UDim2.new(0.5, 0, .5, 0), nil, nil, 0.3, true)
end)

---- Buy Best Weapon ----
pages.aKeyBinds:addKeybind("Buy Best Weapon", Enum.KeyCode.Minus, function()
	funcBuyBestWeapon()
end, function()
end)

---- Buy Best Fork ----
pages.aKeyBinds:addKeybind("Buy Best Fork", Enum.KeyCode.Equals, function()
	funcBuyBestFork()
end, function()
end)
----------------------------------------------------------- Misc -----------------------------------------------------------
---- walk speed -----
pages.e:addSlider("Speed",kVars.walkSpeed,30,300,function(value)
    kVars.walkSpeed = value
end)
---- jump power -----
pages.e:addSlider("Jump Power",kVars.jumpPower,50,300,function(value)
    kVars.jumpPower = value
end)
---- inf jump ---
pages.e:addToggle("Inf Jump", kVars.infJump, function(bool)
	kVars.varInfJump = bool
end)
---- time day ----
pages.e:addButton("Always Day *Restart to undo",function(bool)
		game:GetService("Lighting").Name = "Lighting1"
		game.Lighting1.TimeOfDay = "12:00:00"
end)

pages.e:addToggle("Fog", kVars.fogBool, function(bool)
	kVars.fogBool = bool
	if bool then
		game.Lighting.FogStart = kVars.origFog
	else
		game.Lighting.FogStart = 100000000
	end
end)

pages.e:addToggle("Sun Rays", kVars.sunRaysBool, function(bool)
	kVars.sunRaysBool = bool
	game:GetService("Lighting").SunRays.Enabled = bool
end)

pages.e:addToggle("Blur", kVars.blurBool, function(bool)
	kVars.blurBool = bool
	game:GetService("Lighting").Blur.Enabled = bool
end)

pages.e:addToggle("Bloom", kVars.bloomBool , function(bool)
	kVars.bloomBool = bool
	game:GetService("Lighting").Bloom.Enabled = bool
end)

pages.e:addToggle("Player Name Plates", kVars.nameplatsBool, function(bool)
	kVars.namePlatesBool = bool
end)

pages.e:addToggle("Click To Delete Pet", kVars.MTBool, function(bool)
	kVars.MTBool = bool
end)

pages.e:addToggle("Egg/Crate Reveal Frame", kVars.ECOGUIBool, function(bool)
	game:GetService("Players").LocalPlayer.PlayerGui.MainGui.EggRevealFrame.Visible = bool
end)

---- buy robux frame ----

pages.e:addToggle("Purchase Prompt", kVars.purchasePromptBool, function(bool)
	kVars.purchasePromptBool = bool
	if bool then
		game:GetService("CoreGui").PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.Visible = bool
	else
		--game:GetService("CoreGui").PurchasePrompt.ProductPurchaseContainer.Animator.Prompt:TweenPosition(UDim2.new(0.5, 0, 2, 0), nil, nil, 0, true)
		game:GetService("CoreGui").PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.Visible = bool
	end
end)
---- reload bar tween to move off screen to screen ----
pages.e:addToggle("Reload Bar", kVars.reloadBarBool, function(bool)
	kVars.reloadBarBool = bool
	if bool then
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Reload:TweenPosition(UDim2.new(0.5, 0, 0.9, 0), nil, nil, 0, true)
	else
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Reload:TweenPosition(UDim2.new(0.5, 0, 2, 0), nil, nil, 0, true)
	end
end)

pages.e:addButton("Distroy GUI", function()
	game:GetService("CoreGui")["Sizzling Simulator GUI By Keathunsar"]:Remove()
end)
---- auto attack function ----
function autoAttackFunc()
	---- auto attack find target ----
	spawn(function()
		while kVars.autoAttackBool do
			wait()
			if kVars.closing then break end
			for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
				if v:FindFirstChild('CharId') and v.HealthGui.Health.Amount.Text:sub(1,1) ~= "0" then
					if kVars.autoAttackAnimalName == "Closest" and kVars.lplr.Character:FindFirstChild('HumanoidRootPart') then 	
						local distance = (kVars.lplr.Character.HumanoidRootPart.Position - v:FindFirstChildWhichIsA('Part').Position).magnitude
						if distance < last then
							last = distance
							nearest = v:FindFirstChildWhichIsA('Part') 
							id = v.CharId.Value
						end
					elseif v.Name == kVars.autoAttackAnimalName then
						nearest = v:FindFirstChildWhichIsA('Part') 
						id = v.CharId.Value					
					end
				end
			end			
		end
	end)
	spawn(function()
		---- Auto Attack ----
		while kVars.autoAttackBool do
			wait()
			for i,v in pairs(game:GetService("Workspace"):GetChildren()) do	
				if nearest ~= nil and id ~= nil and v:FindFirstChild('CharId') and v.CharId.Value == id and v.HealthGui.Health.Amount.Text:sub(1,1) ~= "0" then
					currentTarget = v.CharId.Value
					RemoteEvent:FireServer("Animal Selected", v.CharId.Value)
					if kVars.walkToTarget then
						game:GetService('Players').LocalPlayer.Character.Humanoid.WalkToPart = v:FindFirstChildWhichIsA('Part')
						game:GetService('Players').LocalPlayer.Character.Humanoid.WalkToPoint = Vector3.new(0,0,0)
					end
					repeat
						wait()
						if kVars.autoAttackBool == false then break end
						if v:FindFirstChild('CharId') then
							RemoteEvent:FireServer("Animal Hit", v.CharId.Value)
						end
					until v == nil or v:FindFirstChild('CharId') == nil or v:FindFirstChildWhichIsA('Part') == nil or v.HealthGui.Health.Amount.Text:sub(1,1) == "0"
					last,nearest,id = math.huge, nil, nil
				end
			end			
		end
	end)
end
---- Meat/Item Magnet ----
function magnetMeatItemsFunc()
	spawn(function()
		while kVars.magnetMeatItemsBool do
			wait()
			if kVars.magnetMeatItemsBool then
				local amount = kVars.lplr.PlayerGui.MainGui.SideMenu.Fork.Amount.Text
				local cAmount, mAmount = unpack(string.split(amount, "/"))
				local leaveArea = false
				for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
					if leaveArea then break end
					if string.find(v.Name:lower(), "meat") or string.find(v.Name:lower(), "item") and v.Name ~= "DropOffMeat" and v.Name ~= "ItemCapsules" then
						for x,z in pairs(v:GetChildren()) do
							if z.Name == "Part" and z:FindFirstChild("TouchInterest") then
								if cAmount == mAmount then leaveArea = true break end
								if kVars.lplr.Character:FindFirstChild('RightFoot') then
									firetouchinterest(kVars.lplr.Character.RightFoot, z, 0)
								end
							end
						end
					end
				end	
			end
		end
	end)
end
---- collect coins from the ground ----
function collectCoinsFunc()
	spawn(function()
		while kVars.collectCoinsBool do
			wait()
			if kVars.collectCoinsBool then
				for i,v in pairs(game:GetService("Workspace").Currency:GetChildren()) do
					if v and kVars.lplr.Character:FindFirstChild('RightFoot') then
						firetouchinterest(kVars.lplr.Character.RightFoot, v.Part, 0)
					end
				end
			end
		end
	end)
end
---- unlock areas ----
local areaList = {}
function unlockAreaFunc()
	spawn(function()
		while kVars.unlockNextAreaBool do
			wait()
			local v1, v2 = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Get Area Data")
			local areaUnlock = {}
			for i,v in pairs(v1) do
				table.insert(areaUnlock, tostring(i))
			end
			local areaToUnlock = #areaUnlock
			if #areaUnlock ~= nil and #areaUnlock ~= 13 then
				RemoteEvent:FireServer("Purchase Area", #areaUnlock)
			end
		end
	end)
end
---- upgrade grills ----
function upgradeGrillsFunc()
	spawn(function()
		while kVars.upgradeGrillsBool do
			wait()
			if kVars.upgradeGrillsBool then
				local grillNum = 0
				for i,v in pairs(game:GetService("Workspace").DropOffMeat:getChildren()) do

						local grillFrame = kVars.lplr.PlayerGui.MainGui.GrillMenuFrame.GrillsContents.Contents.ScrollingFrame
						if grillFrame:FindFirstChild('5') then
							break
						elseif grillFrame:FindFirstChild('4') then
							grillNum = 1
							break
						elseif grillFrame:FindFirstChild('3') then
							grillNum = 2
							break
						elseif grillFrame:FindFirstChild('2') then
							grillNum = 3
							break
						elseif grillFrame:FindFirstChild('1') then
							grillNum = 4
							break
						end
				end
				if grillNum ~= 0 then
					for i=1,grillNum do
						RemoteEvent:FireServer("Buy +1 Grill")
					end
				end
				for i=1,5 do
					RemoteEvent:FireServer("Upgrade Grill", i)
				end
			end
		end
	end)
end
---- buy best weapon ----
function  buyBestWeaponFunc()
	spawn(function()
		while kVars.buyBestWeaponBool do
			wait()
			if kVars.buyBestWeaponBool then
				local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency");
				local WeaponInv, curWeaponId = RemoteFunc:InvokeServer("Get Weapon Data")
				local wantToBuy = nil
				---- stops if you have the best weapon in game equiped
				if curWeaponId ~= 42 then
					---- set robux weapons ID equal to equivlent 
					if curWeaponId == 40 then curWeaponId = 3 end
					if curWeaponId == 5 then curWeaponId = 22 end
					---- get want to buyitems
					for i,v in pairs(weaponData) do
						if v.price then
							if v.price > pCoins and v.id > curWeaponId then
								if curWeaponId == 1 then
									wantToBuy = weaponData[1].id
									break
								end
								wantToBuy = weaponData[i-1].id
								if wantToBuy == 40 then wantToBuy = 39 end
								if wantToBuy == 5 then wantToBuy = 4 end
								break
							elseif i == #weaponData then
								wantToBuy = 42
							end
						end
					end
					if wantToBuy ~= nil and wantToBuy ~= curWeaponId then
						RemoteEvent:FireServer("Buy Weapon", wantToBuy)
					end
				end
				
			end
		end
	end)
end

---- buy best fork ----
function  buyBestForkFunc()
	spawn(function()
		while kVars.buyBestForkBool do
			wait()
			if kVars.buyBestForkBool then
				local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency")
				local forkInv, curForkId = RemoteFunc:InvokeServer("Get Fork Data")
				if curForkId == 30 then break end
				local forkWantToBuy = nil
				if curForkId ~= 29 then
					for i,v in pairs(forkData) do
						if v.price then
							if v.price > pCoins and v.id > curForkId and v.id ~= 30  then
								forkWantToBuy = i-1
								break
							elseif i == #forkData or i == 29 then
								forkWantToBuy = 29
							end
						end
					end
					if forkWantToBuy ~= nil and forkWantToBuy ~= curForkId then
						RemoteEvent:FireServer("Buy Fork", forkWantToBuy)
					end
				end
			end
		end	
	end)
end

---- open Eggs ----
function  openEggFunc()
	spawn(function()
		while kVars.openEggBool do
			wait()
			if kVars.openEggBool then
				if kVars.openThreeEggsBool then
					game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase Three Eggs",kVars.eggSelection)
				else
					game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",kVars.eggSelection)
				end
			end
		end
	end)
end

---- open crates ----
function  openCrateFunc()
	spawn(function()
		while kVars.openHatBool do
			wait()
			if kVars.openHatBool then
				if kVars.openThreeCrateBool then
					game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase Three Eggs",kVars.crateSelection)
				else
					game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",kVars.crateSelection)
				end
			end
		end
	end)
end

---- open chests ----
function  openChestsFunc()
	spawn(function()
		while kVars.chestBool do
			wait()
			for i,v in pairs(game:GetService("Workspace").Chests:getChildren()) do
				if v.Bottom:FindFirstChild('Emitter') and game:GetService('Players').LocalPlayer.Character:FindFirstChild('RightFoot') then
					firetouchinterest(kVars.lplr.Character.RightFoot, v.Bottom.Emitter, 0)
					firetouchinterest(kVars.lplr.Character.RightFoot, v.Bottom.Emitter, 1)
				end
			end	
		end
	end)
end

---- dropoff meat ----
function  dropOffMeatFunc()
	spawn(function()
		while kVars.dropOffMeatBool do
			wait()
			if kVars.dropOffMeatBool then
				RemoteEvent:FireServer('Drop Off Meat')
			end
		end
	end)
end

---- collect grill coins ----
function  collectGrillCoinsFunc()
	spawn(function()
		while kVars.collectGrillCoinsBool do
			wait()
			if kVars.collectGrillCoinsBool then
				RemoteEvent:FireServer('Collect Grill Coins')
			end
		end
	end)
end

---- rebirth ----
function rebirthFunc()
	spawn(function()
		while kVars.rebirthBool do
			wait()
			local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency")
			local getRebirths = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("Get Rebirths")
			local cost = nil
			if kVars.rebirthMulti == "x5" then
				cost = math.floor(getRebirths ^ 0.9) * 1000000000000000 + 1E+17
			elseif kVars.rebirthMulti == "x3" then
				cost = math.floor(getRebirths ^ 0.9) * 5000000000000 + 500000000000000
			elseif kVars.rebirthMulti == "x1" then
				cost = math.floor(getRebirths ^ 0.9) * 1000000000 + 1000000000
			end
			if pCoins >= cost then
				local num = string.match(kVars.rebirthMulti, "%d")
				RemoteEvent:FireServer('Rebirth',tonumber(num))
			end
		end
	end)
end

---- walkspeed ----
spawn(function()
	while wait() do
		if kVars.closing then break end
		if kVars.walkSpeed ~= nil then
			game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = kVars.walkSpeed
		end
		if kVars.jumpPower ~= nil then
			game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = kVars.jumpPower
		end
		if kVars.namePlatesBool then
			for i,v in pairs(game.Players:GetChildren()) do
				if v:FindFirstChild("Character") and v.Character:FindFirstChild("Humanoid") then
					v.Character.Humanoid.NameOcclusion = 'NoOcclusion'
					v.Character.Humanoid.NameDisplayDistance = 'inf'
				end
			end
		end
		if kVars.buyCoinMultiplierBool then
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase Rebirth Shop", "Coins")
		end
		if kVars.buyXpMultiplierBool then
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase Rebirth Shop", "XP")
		end
		if kVars.buyPetStartLevelBool then
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase Rebirth Shop", "PetLevel")
		end
	end
end)

---- inf jump ----
kVars.JRC = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.varInfJump then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)

---- click pet destroy ----
local mouse = game:GetService("Players").LocalPlayer:GetMouse()
kVars.MT = mouse.Button1Down:Connect(function()
	if kVars.MTBool then
		for i,v in pairs(mouse.Target.Parent:GetChildren()) do
			if v.Name == "PetId" then
				v.Parent:Destroy()
			end
		end
	end
end)

success, response = pcall(function()
kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == "Sizzling Simulator GUI By Keathunsar" then
		kVars.closing = true
		wait(.1)
		kVars.JRC:Disconnect()
		kVars.MT:Disconnect()

		game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = 65
		game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = 50
		game.Lighting.FogStart = kVars.origFog
		game:GetService("Lighting").SunRays.Enabled = true
		game:GetService("Lighting").Blur.Enabled = true
		game:GetService("Lighting").Bloom.Enabled = true
		for i,v in pairs(kVars) do
			if type(v) == "boolean" then
				v = false
			end
		end
		kVars.closeing:Disconnect()
		script:Destroy()

	end
end)
end)
if success == false then
	local string1 = 'closing:\n'.. 'success:' .. tostring(success) .. ' response:' .. tostring(response)
	print(string1)
end
----- theme ----

local theme = venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")
for theme, color in pairs(kVars.themes) do -- all in one theme changer, i know, im cool
colors:addColorPicker(theme, color, function(color3)
venyx:setTheme(theme, color3)
end)
end
pages.saveButton = theme:addSection("Save Theme")
pages.saveButton:addButton("Save",function()
	kVars.saveStringSaving = 'local save = {\n  theme = {'
	for i,v in pairs(game:GetService("CoreGui")["Sizzling Simulator GUI By Keathunsar"].Main.Theme.Colors.Container:GetChildren()) do
		kVars.saveIntCount = i 
	end
	for i,v in pairs(game:GetService("CoreGui")["Sizzling Simulator GUI By Keathunsar"].Main.Theme.Colors.Container:GetChildren()) do

		if v.Name == "ColorPicker" and i ~= kVars.saveIntCount then
			kVars.saveStringSaving = kVars.saveStringSaving .. v.Title.Text .. " = " .. 'Color3.new(' .. convertColor3(v.Button.ImageColor3) .. '), '
		elseif v.Name == "ColorPicker" and i == kVars.saveIntCount then
			kVars.saveStringSaving = kVars.saveStringSaving .. v.Title.Text .. " = " .. 'Color3.new(' .. convertColor3(v.Button.ImageColor3) .. ')},\n'   
		end
	end
	kVars.saveStringSaving = kVars.saveStringSaving .. 'rebirth = "'.. kVars.rebirthMulti ..'"\n}\ndo\n  return save\nend\n'
	if isfile( "Sizzling Simulator GUI/settings.lua") then
		delfile( "Sizzling Simulator GUI/settings.lua")
	end
	writefile( "Sizzling Simulator GUI/settings.lua",kVars.saveStringSaving)
end)


---- end theme ----
---- save function ----
success, response = pcall(function()

function convertColor3(value)
	local tmpstring = ""
	tmpstring = value.R .. ", " .. value.G .. ", " .. value.B
	return tmpstring
end
end)
if success == false then
	local string1 = 'savefunction:\n'.. 'success:' .. tostring(success) .. ' response:' .. tostring(response)
	print(string1)
end

---- Set Main Page on load ----
venyx:SelectPage(venyx.pages[1], true)