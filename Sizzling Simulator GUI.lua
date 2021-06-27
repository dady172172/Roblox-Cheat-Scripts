--[[
Game : https://www.roblox.com/games/4572547530/Sizzling-Simulator?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--
--local Try = loadstring(game:HttpGet('https://raw.githubusercontent.com/F3XTeam/RBX-Try-Library/master/TryLibrary.lua'))()

local kVars = {}
kVars.autoAttackBool = false
kVars.magnetMeatItemsBool = false
kVars.dropOffMeatBool = false
kVars.collectCoinsBool = false
kVars.collectGrillCoinsBool = false
kVars.unlockNextAreaBool = false
kVars.upgradGrillsBool = false
kVars.buyBestWeaponBool = false
kVars.buyBestForkBool = false
kVars.chestBool = false
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
kVars.walkSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
kVars.origWalkSpeed = 65
kVars.eggSelected = "100"
kVars.crateSelected = "250"
kVars.hatNum = 1
kVars.eggNum = 1
kVars.rebirthMulti = "x1"
kVars.themeSizzle = {Background = Color3.fromRGB(24, 24, 24), Glow = Color3.fromRGB(0, 0, 0), Accent = Color3.fromRGB(10, 10, 10), LightContrast = Color3.fromRGB(20, 20, 20), DarkContrast = Color3.fromRGB(14, 14, 14), TextColor = Color3.fromRGB(255, 255, 255)}
kVars.autoAttackAnimalName = "Closest"
kVars.closing = false
kVars.plr = game:GetService('Players').LocalPlayer
kVars.plrName = kVars.plr.Name
local forkData = {}
local weaponData = {}

for i,v in pairs(require(game:GetService("ReplicatedStorage").ScriptData.ForkData)) do
	table.insert(forkData, v)
end
for i,v in pairs(require(game:GetService("ReplicatedStorage").ScriptData.WeaponData)) do
	table.insert(weaponData, v)
end






local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent
local RemoteFunc = game:GetService("ReplicatedStorage").RemoteFunction
local RunService = game:GetService("RunService")
if game:GetService("CoreGui"):FindFirstChild("Sizzling Simulator GUI By Keathunsar") then
	game:GetService("CoreGui")["Sizzling Simulator GUI By Keathunsar"]:Remove()
end
---- anti AFK ----
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

---- librarys for GUI ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))() --someone reuploaded it so I put it in place of the original back up so guy can get free credit.
local venyx = library.new("Sizzling Simulator GUI By Keathunsar", 5013109572)

-- pages
local page = venyx:addPage("Farm", 5012544693)
local a = page:addSection("Collect")
local pageRebirth = venyx:addPage("Rebirth", 5012544693)
local aRebirth = pageRebirth:addSection("Rebirth")
local bRebirth = pageRebirth:addSection("Menu")
local page2 = venyx:addPage("Menus", 5012544693)
local b = page2:addSection("Menus")
local ba = page2:addSection("Crafting")
local page3 = venyx:addPage("Buy", 5012544693)
local c = page3:addSection("Weapon")
local ca = page3:addSection("Fork")
local cb = page3:addSection("Egg")
local cc = page3:addSection("Crate")
local cd = page3:addSection("Delete Pet")
local page4 = venyx:addPage("Teleport", 5012544693)
local d = page4:addSection("Teleport")
local pageKeyBinds = venyx:addPage("Keybinds", 5012544693)
local aKeyBinds = pageKeyBinds:addSection("Keybinds")
local page5 = venyx:addPage("Misc", 5012544693)
local e = page5:addSection("Misc")
----- theme ----
local theme = venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")
for theme, color in pairs(kVars.themeSizzle) do -- all in one theme changer, i know, im cool
colors:addColorPicker(theme, color, function(color3)
venyx:setTheme(theme, color3)
end)
end
---- end theme ----
---- save Work in progress ----
function save(name, value)
	-- name:value
	-- look through save file for name
	-- read line by line text file
	local foundName = false
	for i,v in pairs() do
		if string.find(v,name) then
			--edit line to include value	
		end
	end
	if foundName == false then  -- if name not found then we need to create a new line
		
	end
end

---------------------------------------- Vars ---------------------------------------------------
local Locations = {
	[1] = {name = "Spawn", cf = CFrame.new(-60, 5, 35)},
	[2] = {name = "Duck", cf = CFrame.new(248, 5, 35)},
	[3] = {name = "Cow", cf = CFrame.new(516, 5, 35)},
	[4] = {name = "Turkey", cf = CFrame.new(794, 5, 35)},
	[5] = {name = "Pig", cf = CFrame.new(1069, 5, 35)},
	[6] = {name = "WildWest", cf = CFrame.new(1339, 5, 35)},
	[7] = {name = "GrassLand", cf = CFrame.new(1620, 5, 35)},
	[8] = {name = "DarkForest", cf = CFrame.new(1898, 5, 35)},
	[9] = {name = "Moose", cf = CFrame.new(2177, 5, 35)},
	[10] = {name = "Prehistoric", cf = CFrame.new(2460, 5, 35)},
	[11] = {name = "BlackForest", cf = CFrame.new(-1389, 5, -19)},
	[12] = {name = "WinterForest", cf = CFrame.new(-422, 5, 676)},
	[13] = {name = "BossBattle", cf = CFrame.new(366, 5, 882)},
	[14] = {name = "VIP", cf = CFrame.new(-151, 5, -180)}
} 

-- list of animals names

local animalNamesList = {}
for i,v in pairs(game:GetService("ReplicatedStorage").InstanceData.Animals:GetChildren()) do
	table.insert(animalNamesList,v.Name)
end
table.sort(animalNamesList)
table.insert(animalNamesList,1,"Closest")
---------------------------------------- Main ---------------------------------------------------
local meat = false
local coin = false
local last = math.huge
local nearest = nil
local id = nil
local currentTarget = 8
---- Auto Attack ----
a:addDropdown(animalNamesList[1],animalNamesList,function(value)
	kVars.autoAttackAnimalName = value
end)
a:addToggle("Auto Attack", kVars.autoAttackBool, function(bool)
	kVars.autoAttackBool = bool
	if bool then 
		autoAttackFunc()
	else
		RemoteEvent:FireServer("Animal Deselected", currentTarget)
	end
end)


---- Magnet meat/items ----
a:addToggle("Magnet Meat/Items", kVars.magnetMeatItemsBool, function(bool)
	kVars.magnetMeatItemsBool = bool 
	if bool then magnetMeatItemsFunc() end
end)

---- Drop Off Meat ----
a:addToggle("Drop Off Meat", kVars.dropOffMeatBool, function(bool)
	kVars.dropOffMeatBool  = bool
	if bool then dropOffMeatFunc() end
end)

---- Collect Grill Coins ----
a:addToggle("Collect Grill Coins", kVars.collectGrillCoinsBool, function(bool)
	kVars.collectGrillCoinsBool  = bool
	if bool then collectGrillCoinsFunc() end
end)

---- Collect Coins ----
a:addToggle("Collect Coins", kVars.collectCoinsBool, function(bool)
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

a:addToggle("Unlock Areas", kVars.unlockNextAreaBool, function(bool)
	kVars.unlockNextAreaBool = bool
	if bool then unlockAreaFunc() end
end)

---- upgrade grills ----
a:addToggle("Upgrade Grills", kVars.upgradGrillsBool, function(bool)
	kVars.upgradGrillsBool = bool
	if bool then upgradeGrillsFunc() end
end)

---- buy best weapon auto ----
a:addToggle("Buy Best Weapon", kVars.buyBestWeaponBool, function(bool)
	kVars.buyBestWeaponBool = bool
	if bool then buyBestWeaponFunc() end
end)

---- buy best fork auto ----

a:addToggle("Buy Best Fork", kVars.buyBestForkBool, function(bool)
	kVars.buyBestForkBool = bool
	if bool then buyBestForkFunc() end
end)

---- auto chests ----

a:addToggle("Chests", kVars.chestBool, function(bool)
	kVars.chestBool = bool
	if bool then openChestsFunc() end
end)

----------------------------------------------------------- Rebirth Section -----------------------------------------------------------
---- Rebirth Dropdown ----	
aRebirth:addDropdown(kVars.rebirthMulti,{"x1","x3","x5"},function(num)
	kVars.rebirthMulti = num
end)

---- Rebirth Button ----

aRebirth:addButton("Rebirth",function()
	if kVars.rebirthMulti == "x1" then RemoteEvent:FireServer('Rebirth',1) end
	if kVars.rebirthMulti == "x3" then RemoteEvent:FireServer('Rebirth',3) end
	if kVars.rebirthMulti == "x5" then RemoteEvent:FireServer('Rebirth',5) end
end)

-------- Respawn Menus --------
---- x1 ----
bRebirth:addButton("x1", function()
	if game:GetService("Workspace"):FindFirstChild('RebirthButton') then
		fireTouch(game:GetService("Workspace").RebirthButton.TouchPart)
	end
end)
---- x3 ----
bRebirth:addButton("x3", function()
	if game:GetService("Workspace"):FindFirstChild('Rebirth3Button') then
		fireTouch(game:GetService("Workspace").Rebirth3Button.TouchPart)
	end
end)
---- x5 ----
bRebirth:addButton("x5", function()
	if game:GetService("Workspace"):FindFirstChild('Rebirth5Button') then
		fireTouch(game:GetService("Workspace").Rebirth5Button.TouchPart)
	end
end)

----------------------------------------------------------- Menus -----------------------------------------------------------
---- Grills Upgrade Menu ----
b:addButton("Grills Upgrade",function()
	game:GetService("Players").LocalPlayer.PlayerGui.MainGui.GrillMenuFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)

---- Rebirth Shop ----
b:addButton("Rebirth Shop",function()
	game:GetService("Players").keathunsar.PlayerGui.MainGui.RebirthShopFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)
---- Hats Upgrade ----
b:addButton("Hats Upgrade",function()
	if game:GetService("Workspace"):FindFirstChild("Caleb Touch") then
		fireTouch(game:GetService("Workspace")["Caleb Touch"].TouchPart)
	end
end)
---- Potions Shop ----
b:addButton("Potions Shop",function()
	if game:GetService("Workspace"):FindFirstChild("Pet Scientist Touch") then
		fireTouch(game:GetService("Workspace")["Pet Scientist Touch"].TouchPart)
	end
	
end)

-------- Crafting Menus --------
---- Julia [Zone 6 ----
ba:addButton("Julia [Zone 6]", function()
	if game:GetService("Workspace"):FindFirstChild("Julia Touch") then
		fireTouch(game:GetService("Workspace")["Julia Touch"].TouchPart)
	end
end)
---- Ancient Dragon [Zone 10] ----
ba:addButton("Ancient Dragon [Zone 10]", function()
	if game:GetService("Workspace"):FindFirstChild("Ancient Dragon Touch") then
		fireTouch(game:GetService("Workspace")["Ancient Dragon Touch"].TouchPart)
	end
end)
---- Henry [Black Forest] ----
ba:addButton("Henry [Black Forest]", function()
	if game:GetService("Workspace"):FindFirstChild("Henry Touch") then
		fireTouch(game:GetService("Workspace")["Henry Touch"].TouchPart)
	end
end)
---- Trevor [Winter Forest] ----
ba:addButton("Trevor [Winter Forest]", function()
	if game:GetService("Workspace"):FindFirstChild("Trevor Touch") then
		fireTouch(game:GetService("Workspace")["Trevor Touch"].TouchPart)
	end
end)
---- Steven [VIP] ----
ba:addButton("Steven [VIP]", function()
	if game:GetService("Workspace"):FindFirstChild("Steven Touch") then
		fireTouch(game:GetService("Workspace")["Steven Touch"].TouchPart)
	end
end)

function fireTouch(part)
	if game.Players.LocalPlayer.Character:FindFirstChild('RightFoot') then
		firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, part, 0)
		wait(.5)
		firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, part, 1)
	end
end

----------------------------------------------------------- BUY -----------------------------------------------------------
---- weapon dropdown prep ----
weaponDropDownNames = {}
weaponDropDownTable = {}
for i,v in pairs(weaponData) do
	if i~= 40 and i ~= 5 and i ~= 1 then
		if v.Cost.Amount and v.Title then
			local string1 = "$" .. tostring(v.Cost.Amount) .. " - " .. v.Title
			table.insert(weaponDropDownNames, string1)
			table.insert(weaponDropDownTable, {name = string1, id = i})
		end
	end
end

---- Weapon DropDown ----
c:addDropdown(weaponDropDownNames[1],weaponDropDownNames,function(num)
	kVars.weaponNum = num
end)

---- Weapon Button ----
c:addButton("Buy",function()
	for i,v in pairs(weaponDropDownTable) do
		if kVars.weaponNum ~= nil then
			if v.name == kVars.weaponNum then
				RemoteEvent:FireServer("Buy Weapon", v.id)
				break
			end
		end
	end	
end)

---- Weapon Buy Best ----
c:addButton("Buy Best",function()
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
			if v.Cost.Amount then
				if v.Cost.Amount > pCoins and v.ID > curWeaponId then
					wantToBuy = weaponData[i-1].ID
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

---- Fork DropDown Prep ----
local forkDropDownNames = {}
local forkDropDownTable = {}
for i,v in pairs(forkData) do
	if i ~= 1 and i ~= 30 then
		if v.Cost.Amount then
			local string1 = "$" .. tostring(v.Cost.Amount) .." - " .. v.Title
			table.insert(forkDropDownNames, string1)
			table.insert(forkDropDownTable, {name = string1, id = i})
		end
	end
end
---- fork dropdown ----
ca:addDropdown(forkDropDownNames[1], forkDropDownNames,function(num)
	kVars.forkNum = num
end)

---- Fork Button ----
ca:addButton("Buy",function()
	local thisone = nil
	for i,v in pairs(forkDropDownTable) do
		if v.name == kVars.forkNum then
			RemoteEvent:FireServer("Buy Fork", v.id)
			break
		end
	end
end)
	

---- Fork Buy Best ----e
ca:addButton("Buy Best",function()
	funcBuyBestFork()
end)
function funcBuyBestFork()
	local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency")
	local forkInv, curForkId = RemoteFunc:InvokeServer("Get Fork Data")
	if curForkId == 30 then return end
	local forkWantToBuy = nil
	if curForkId ~= 29 then
		for i,v in pairs(forkData) do
			if v.Cost.Amount then
				if v.Cost.Amount > pCoins and i > curForkId and i ~= 30 and i ~= #weaponData and i ~= 29  then
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
cb:addDropdown(kVars.eggSelected,{"100", "1500", "10K", "50K", "150K", "750K", "2M", "5M", "20M", "75M", "100T", "10Qa"},function(num)
	if num == "100" then kVars.eggNum = 1 end
	if num == "1500" then kVars.eggNum = 2 end
	if num == "10K" then kVars.eggNum = 3 end
	if num == "50K" then kVars.eggNum = 4 end
	if num == "150K" then kVars.eggNum = 5 end
	if num == "750K" then kVars.eggNum = 6 end
	if num == "2M" then kVars.eggNum = 7 end
	if num == "5M" then kVars.eggNum = 8 end
	if num == "20M" then kVars.eggNum = 9 end
	if num == "75M" then kVars.eggNum = 10 end
	if num == "100T" then kVars.eggNum = 19 end
	if num == "10Qa" then kVars.eggNum = 21 end
end)

cb:addToggle("Open Egg", kVars.openEggBool, function(bool)
	kVars.openEggBool = bool
	if bool then openEggFunc() end
end)

---- Hats ----
cc:addDropdown(kVars.crateSelected,{"250", "2K", "15K", "200K", "1M", "5M", "15M", "50M", "150T", "750Gems"},function(num)
	if num == "250" then kVars.hatNum = 11 end
	if num == "2K" then kVars.hatNum = 12 end
	if num == "15K" then kVars.hatNum = 13 end
	if num == "200K" then kVars.hatNum = 14 end
	if num == "1M" then kVars.hatNum = 15 end
	if num == "5M" then kVars.hatNum = 16 end
	if num == "15M" then kVars.hatNum = 17 end
	if num == "50M" then kVars.hatNum = 18 end
	if num == "150T" then kVars.hatNum = 20 end
	if num == "750Gems" then kVars.hatNum = 22 end
end)

cc:addToggle("Open Crate", kVars.openHatBool, function(bool)
	kVars.openHatBool = bool
	if bool then openHatFunc() end
end)

---- delete pets ----
local petList = {}
for i,v in pairs(game:GetService("ReplicatedStorage").InstanceData.Pets:getChildren()) do
	table.insert(petList,v.Name)
end
table.sort(petList)
table.insert(petList,1,"None")
cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel1 = value
end)
cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel2 = value
end)
cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel3 = value
end)
cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel4 = value
end)
cd:addDropdown(petList[1],petList,function(value)
	kVars.petDel5 = value
end)
cd:addToggle("Delete *Rename Equiped*", kVars.petDelBool, function(bool)
	kVars.petDelBool = bool
	if bool then petDelFunc() end
end)
function petDelFunc()
	spawn(function()
		while kVars.petDelBool do
			wait()
			for i,v in pairs(game:GetService("Players").keathunsar.PlayerGui.MainGui.InventoryFrame.Contents.ScrollingFrame:GetChildren()) do
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
	d:addButton(tostring(v.name),function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Locations[k].cf		
	end)
end 

----------------------------------------------------------- KeyBinds -----------------------------------------------------------
---- open close menu ----
aKeyBinds:addKeybind("Open/Close Menu", Enum.KeyCode.Backquote, function()
venyx:toggle()
end, function()
end)

---- Auto Attack ----
aKeyBinds:addKeybind("Auto Attack", nil, function()
	if kVars.autoAttackBool == false then
		kVars.autoAttackBool = true
	else
		kVars.autoAttackBool = false
		RemoteEvent:FireServer("Animal Deselected", currentTarget)
	end
end, function()
end)

---- magnet meat items ----
aKeyBinds:addKeybind("Magnet Meat/Items", nil, function()
	if kVars.magnetMeatItemsBool == false then
		kVars.magnetMeatItemsBool = true
	else
		kVars.magnetMeatItemsBool = false
	end
end, function()
end)

---- Drop Off Meat ----
aKeyBinds:addKeybind("Drop Off Meat", nil, function()
	if kVars.dropOffMeatBool == false then
		kVars.dropOffMeatBool  = true
	else
		kVars.dropOffMeatBool  = false
	end
end, function()
end)

---- Collect Grill Coins ----
aKeyBinds:addKeybind("Collect Grill Coins", nil, function()
	if collectGrillCoinsBool == false then
		collectGrillCoinsBool  = true
	else
		collectGrillCoinsBool  = false
	end
end, function()
end)

---- collectCoinsBool ----
aKeyBinds:addKeybind("Collect Coins", nil, function()

	if collectCoinsBool == false then
		collectCoinsBool = true
	else
		collectCoinsBool = false
	end
end, function()
end)

---- Buy Best Weapon ----
aKeyBinds:addKeybind("Buy Best Weapon", Enum.KeyCode.Minus, function()
	funcBuyBestWeapon()
end, function()
end)

---- Buy Best Fork ----
aKeyBinds:addKeybind("Buy Best Fork", Enum.KeyCode.Equals, function()
	funcBuyBestFork()
end, function()
end)

----------------------------------------------------------- Misc -----------------------------------------------------------
---- walk speed -----
e:addSlider("Speed",kVars.walkSpeed,1,300,function(value)
    kVars.walkSpeed = value
end)
---- time day ----
e:addButton("Always Day",function(bool)
		game:GetService("Lighting").Name = "Lighting1"
		game.Lighting1.TimeOfDay = "12:00:00"
end)

e:addToggle("Fog", kVars.fogBool, function(bool)
	kVars.fogBool = bool
	if bool then
		game.Lighting.FogStart = kVars.origFog
	else
		game.Lighting.FogStart = 100000000
	end
end)

e:addToggle("Sun Rays", kVars.sunRaysBool, function(bool)
	kVars.sunRaysBool = bool
	game:GetService("Lighting").SunRays.Enabled = bool
end)

e:addToggle("Blur", kVars.blurBool, function(bool)
	kVars.blurBool = bool
	game:GetService("Lighting").Blur.Enabled = bool
end)

e:addToggle("Bloom", kVars.bloomBool , function(bool)
	kVars.bloomBool = bool
	game:GetService("Lighting").Bloom.Enabled = bool
end)
---- buy robux frame ----

e:addToggle("Purchase Prompt", kVars.purchasePromptBool, function(bool)
	kVars.purchasePromptBool = bool
	game:GetService("CoreGui").PurchasePromptApp.ProductPurchase.Visible = bool
end)

local reloadBarOrigPos = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Reload.Position
e:addToggle("Reload Bar", kVars.reloadBarBool, function(bool)
	kVars.reloadBarBool = bool
	if bool then
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Reload.Position = reloadBarOrigPos
	else
		game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Reload.Position:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
	end
end)

e:addButton("Distroy GUI", function()
	game:GetService("CoreGui")["Sizzling Simulator GUI By Keathunsar"]:Remove()
end)



function autoAttackFunc()
	---- auto attack find target ----
	spawn(function()
		while kVars.autoAttackBool do
			wait()
			if kVars.closing then break end
			for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
				if v:FindFirstChild('CharId') and v.HealthGui.Health.Amount.Text:sub(1,1) ~= "0" then
					if kVars.autoAttackAnimalName == "Closest" and game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then 	
						local distance = (game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChildWhichIsA('Part').Position).magnitude
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
				local amount = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.SideMenu.Fork.Amount.Text
				local cAmount, mAmount = unpack(string.split(amount, "/"))
				local leaveArea = false
				for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
					if leaveArea then break end
					if string.find(v.Name:lower(), "meat") or string.find(v.Name:lower(), "item") and v.Name ~= "DropOffMeat" and v.Name ~= "ItemCapsules" then
						for x,z in pairs(v:GetChildren()) do
							if z.Name == "Part" and z:FindFirstChild("TouchInterest") then
								if cAmount == mAmount then leaveArea = true break end
								if game.Players.LocalPlayer.Character:FindFirstChild('RightFoot') then
									firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, z, 0)
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
					if v and game.Players.LocalPlayer.Character:FindFirstChild('RightFoot') then
					firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Part, 0)
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
		while kVars.upgradGrillsBool do
			wait()
			if kVars.upgradGrillsBool then
				local grillNum = 0
				for i,v in pairs(game:GetService("Workspace").DropOffMeat:getChildren()) do

						local grillFrame = game:GetService("Players").LocalPlayer.PlayerGui.MainGui.GrillMenuFrame.GrillsContents.Contents.ScrollingFrame
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
						if v.Cost.Amount then
							if v.Cost.Amount > pCoins and v.ID > curWeaponId then
								wantToBuy = weaponData[i-1].ID
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
						if v.Cost.Amount then
							if v.Cost.Amount > pCoins and i > curForkId and i ~= 30 and i ~= #weaponData and i ~= 29  then
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
				game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",kVars.eggNum)
			end
		end
	end)
end

---- open crates ----
function  openHatFunc()
	spawn(function()
		while kVars.openHatBool do
			wait()
			if kVars.openHatBool then
				game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",kVars.hatNum)
			end
		end
	end)
end

---- open chests ----
function  openChestsFunc()
	spawn(function()
		while kVars.chestBool do
			wait()
			if kVars.chestBool then
				for i, v in pairs(game:GetService("Workspace").Chests:getChildren()) do
					if v.Bottom:FindFirstChild('Emitter') and game.Players.LocalPlayer.Character:FindFirstChild('RightFoot') then
						firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Bottom.Emitter, 0)
						wait(.1)
						firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Bottom.Emitter, 1)
					end
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

---- walkspeed ----
spawn(function()
	while wait() do
		if kVars.closing then break end
		if game:GetService('Players').LocalPlayer.Character:FindFirstChild('Humanoid') then
			game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = kVars.walkSpeed
		end
	end

end)


kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == "Sizzling Simulator GUI By Keathunsar" then
		kVars.closing = true
		wait(.1)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = kVars.origWalkSpeed
		if game:FindFirstChild('Lighting1') then
			game.Lighting1.Name = "Lighting"
		end
		game.Lighting.FogStart = kVars.origFog
		game:GetService("Lighting").SunRays.Enabled = true
		game:GetService("Lighting").Blur.Enabled = true
		game:GetService("Lighting").Bloom.Enabled = true
		game:GetService("CoreGui").PurchasePromptApp.ProductPurchase.Visible = true
		table.clear(kVars)
		kVars.closeing:Disconnect()
		script:Destroy()

	end
end)

--[[
spawn(function()
	while wait() do
		if removeSizzling then break end
		if game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart') then
			if removeSizzling then break end
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
			
		end
	end
end)]]--

---- Set Main Page on load ----
venyx:SelectPage(venyx.pages[1], true)