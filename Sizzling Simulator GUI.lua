
--Made by : https://v3rmillion.net/member.php?action=profile&uid=244024
-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))() --someone reuploaded it so I put it in place of the original back up so guy can get free credit.
local venyx = library.new("Sizzling Simulator GUI By Keathunsar", 5013109572)

-- themes
local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(0, 0, 0),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(255, 255, 255)
}

-- pages
local page = venyx:addPage("Farm", 5012544693)
local a = page:addSection("Collect")
local aa = page:addSection("Rebirth")
local page2 = venyx:addPage("Menus", 5012544693)
local b = page2:addSection("Menus")
local ba = page2:addSection("Crafting")
local bb = page2:addSection("Rebirth")
local page3 = venyx:addPage("Buy", 5012544693)
local c = page3:addSection("Weapon")
local ca = page3:addSection("Fork")
local cb = page3:addSection("Egg")
local cc = page3:addSection("Hat")
local page4 = venyx:addPage("Teleport", 5012544693)
local d = page4:addSection("Teleport")
local page5 = venyx:addPage("Misc", 5012544693)
local e = page5:addSection("Misc")
local ea = page5:addSection("KeyBinds")
----- theme ----
local theme = venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")
for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
colors:addColorPicker(theme, color, function(color3)
venyx:setTheme(theme, color3)
end)
end
---- end theme ----

---------------------------------------- Vars ---------------------------------------------------
local dropOff = false
local pickUp = false
local coinCollect = false
local magnetCollect = false
local eggGo = false
local hatgo = false
local WalkSpeed = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
local RemoteEvent = game:GetService("ReplicatedStorage").RemoteEvent
local RemoteFunc = game:GetService("ReplicatedStorage").RemoteFunction
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
-- list of weaponId and cost
local weaponArray = {}
weaponArray[1] = {weaponId = 2, cost = 50}
weaponArray[2] = {weaponId = 3, cost = 100}
weaponArray[3] = {weaponId = 4, cost = 300}
weaponArray[4] = {weaponId = 6, cost = 700}
weaponArray[5] = {weaponId = 7, cost = 1000}
weaponArray[6] = {weaponId = 8, cost = 2000}
weaponArray[7] = {weaponId = 9, cost = 5000}
weaponArray[8] = {weaponId = 10, cost = 10000}
weaponArray[9] = {weaponId = 11, cost = 13000}
weaponArray[10] = {weaponId = 12, cost = 25000}
weaponArray[11] = {weaponId = 13, cost = 40000}
weaponArray[12] = {weaponId = 14, cost = 55000}
weaponArray[13] = {weaponId = 15, cost = 75000}
weaponArray[14] = {weaponId = 16, cost = 100000}
weaponArray[15] = {weaponId = 17, cost = 250000}
weaponArray[16] = {weaponId = 18, cost = 375000}
weaponArray[17] = {weaponId = 19, cost = 500000}
weaponArray[18] = {weaponId = 20, cost = 1000000}
weaponArray[19] = {weaponId = 21, cost = 1500000}
weaponArray[20] = {weaponId = 22, cost = 4000000}
weaponArray[21] = {weaponId = 23, cost = 7500000}
weaponArray[22] = {weaponId = 24, cost = 10000000}
weaponArray[23] = {weaponId = 25, cost = 15000000}
weaponArray[24] = {weaponId = 26, cost = 20000000}
weaponArray[25] = {weaponId = 27, cost = 25000000}
weaponArray[26] = {weaponId = 28, cost = 35000000}
weaponArray[27] = {weaponId = 29, cost = 50000000}
weaponArray[28] = {weaponId = 30, cost = 80000000}
weaponArray[29] = {weaponId = 31, cost = 120000000}
weaponArray[30] = {weaponId = 32, cost = 150000000}
weaponArray[31] = {weaponId = 33, cost = 200000000}
weaponArray[32] = {weaponId = 34, cost = 400000000}
weaponArray[33] = {weaponId = 35, cost = 750000000}
weaponArray[34] = {weaponId = 36, cost = 1500000000}
weaponArray[35] = {weaponId = 37, cost = 5000000000}
weaponArray[36] = {weaponId = 38, cost = 7500000000}
weaponArray[37] = {weaponId = 39, cost = 10000000000}
weaponArray[38] = {weaponId = 41, cost = 100000000000000}
weaponArray[39] = {weaponId = 42, cost = 100000000000000000}

-- list of forks and cost
local forkArray = {}
forkArray[1] = {forkId = 2, cost = 50}
forkArray[2] = {forkId = 3, cost = 150}
forkArray[3] = {forkId = 4, cost = 250}
forkArray[4] = {forkId = 5, cost = 500}
forkArray[5] = {forkId = 6, cost = 800}
forkArray[6] = {forkId = 7, cost = 2000}
forkArray[7] = {forkId = 8, cost = 5000}
forkArray[8] = {forkId = 9, cost = 10000}
forkArray[9] = {forkId = 10, cost = 20000}
forkArray[10] = {forkId = 11, cost = 35000}
forkArray[11] = {forkId = 12, cost = 75000}
forkArray[12] = {forkId = 13, cost = 150000}
forkArray[13] = {forkId = 14, cost = 250000}
forkArray[14] = {forkId = 15, cost = 400000}
forkArray[15] = {forkId = 16, cost = 750000}
forkArray[16] = {forkId = 17, cost = 1000000}
forkArray[17] = {forkId = 18, cost = 1200000}
forkArray[18] = {forkId = 19, cost = 3000000}
forkArray[19] = {forkId = 20, cost = 6000000}
forkArray[20] = {forkId = 21, cost = 12000000}
forkArray[21] = {forkId = 22, cost = 18000000}
forkArray[22] = {forkId = 23, cost = 30000000}
forkArray[23] = {forkId = 24, cost = 45000000}
forkArray[24] = {forkId = 25, cost = 80000000}
forkArray[25] = {forkId = 26, cost = 120000000}
forkArray[26] = {forkId = 27, cost = 200000000}
forkArray[27] = {forkId = 28, cost = 300000000}
forkArray[28] = {forkId = 29, cost = 500000000}

-- list of animals names
local animalNamesList = {"Closest", "Chicken", "Cornish Chicken", "Duck", "Blue Duck", "Cow", "Brown Cow", "Turkey", "Red Turkey", "Pig", "Fat Pig", "Bison", "Dark Bison", "Doe", "Buck", "Black Bear", "Grizzly Bear", "Moose", "Angry Moose", "Dinosaur", "Angry Dinosaur", "Fiery Dinosaur", "Wolf", "Brown Wolf", "Big Bad Wolf", "Arctic Fox", "Yeti"}

---------------------------------------- Main ---------------------------------------------------
---- Auto Attack ----
local autoAttackAnimalName = "Closest"
local meat = false
local coin = false
local last = math.huge
local nearest = nil
local id = nil
local autoAttackBool = false
local currentTarget = 8
local startLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
local gravity = workspace.Gravity
a:addDropdown(autoAttackAnimalName,animalNamesList,function(num)
	autoAttackAnimalName = num
end)
a:addToggle("Auto Attack", false, function(bool)
	autoAttackBool = bool
	if bool == false then
		for i,v in pairs(game.workspace:getChildren()) do
			if v.Name == 'Part' and v:FindFirstChild('Texture') then
				v.CanCollide = true
			end
		end
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = startLocation
		RemoteEvent:FireServer("Animal Deselected", currentTarget)
		game.workspace.Gravity = gravity
	else
		game.workspace.Gravity = 0
		startLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		for i,v in pairs(game.workspace:getChildren()) do
			if v.Name == 'Part' and v:FindFirstChild('Texture') then
				v.CanCollide = false
			end
		end
	end
end)
local autoAttackAnimalCoro = coroutine.create(function()
    while wait() do
        for i,v in pairs(game.workspace:GetChildren()) do	
            if v:FindFirstChild('CharId') and autoAttackBool and v.HealthGui.Health.Amount.Text:sub(1,1) ~= "0" then
				if v.Name ~= autoAttackAnimalName and autoAttackAnimalName == "Closest" then 	
					local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChildWhichIsA('Part').Position).magnitude
					if distance < last then
						last = distance
						nearest = v:FindFirstChildWhichIsA('Part') 
						id = v.CharId.Value
					end
				elseif v.Name == autoAttackAnimalName then
					nearest = v:FindFirstChildWhichIsA('Part') 
					id = v.CharId.Value					
				end
            end
        end
    end
end)
coroutine.resume(autoAttackAnimalCoro)
local autoAttackAnimalCoro2 = coroutine.create(function()
    while wait() do
        for i,v in pairs(game.workspace:GetChildren()) do	
            if nearest ~= nil and id ~= nil and v:FindFirstChild('CharId') and autoAttackBool and v.CharId.Value == id then
                currentTarget = v.CharId.Value
				RemoteEvent:FireServer("Animal Selected", v.CharId.Value)
				local nearestCFrame = nearest.CFrame
				local nx, ny, nz, r00, r01, r02, r10, r11, r12, r20, r21, r22 = nearestCFrame:components()
                repeat
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(nx,ny-22,nz)
                    RemoteEvent:FireServer("Animal Hit", v.CharId.Value)
                wait()
                until not v or not v:FindFirstChild('CharId') or not v:FindFirstChildWhichIsA('Part') or not nearest or not nearest.Parent or not autoAttackBool or v.HealthGui.Health.Amount.Text:sub(1,1) == "0"
                last,nearest,id = math.huge, nil, nil	
            end
        end
    end
end)
coroutine.resume(autoAttackAnimalCoro2)

---- Magnet meat/items ----
local magnetMeatItemsBool = false
a:addToggle("Magnet Meat/Items", false, function(bool)
	magnetMeatItemsBool = bool  
end)
local meatMagCoro = coroutine.create(function()
	while wait() do
		if magnetMeatItemsBool == true then
			for i,v in pairs(game.workspace:GetChildren()) do			
				if string.find(v.Name:lower(), "meat") or string.find(v.Name:lower(), "item") and v.Name ~= "DropOffMeat" and v.Name ~= "ItemCapsules" then
					for x,z in pairs(v:GetChildren()) do
						if z.Name == "Part" and z:FindFirstChild("TouchInterest") then
							firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, z, 0)
						end
					end
				end
			end	
		end
	end
end)
coroutine.resume(meatMagCoro)
---- Drop Off Meat ----
local dropOffMeatBool = false
a:addToggle("Drop Off Meat", false, function(bool)
	dropOffMeatBool = bool
end)
local meatDropCoro = coroutine.create(function()
	while wait() do
		if dropOffMeatBool == true then
			RemoteEvent:FireServer('Drop Off Meat')
		end
	end
end)
coroutine.resume(meatDropCoro)
---- Collect Grill Coins ----
local collectGrillCoinsBool = false
a:addToggle("Collect Grill Coins", false, function(bool)
	collectGrillCoinsBool = bool
end)
local collectGrillCoro = coroutine.create(function()
	while wait() do
		if collectGrillCoinsBool == true then
			RemoteEvent:FireServer('Collect Grill Coins')
		end
	end
end)
coroutine.resume(collectGrillCoro)
---- Collect Coins ----
local collectCoinsBool = false
a:addToggle("Collect Coins", false, function(bool)
	collectCoinsBool = bool
end)
local collectCoinsCoro = coroutine.create(function()
	while wait() do
		if collectCoinsBool == true then
			wait()
			for i,v in pairs(game:GetService("Workspace").Currency:GetChildren()) do
				if v then
				firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Part, 0)
				end
			end
		end
	end
end)
coroutine.resume(collectCoinsCoro)


---- Rebirth Dropdown ----
local rebirthNum = 1
aa:addDropdown("Select Multiplier",{"x1","x3","x5"},function(num)
	if num == "x1" then rebirthNum = 1 end
	if num == "x3" then rebirthNum = 3 end
	if num == "x5" then rebirthNum = 5 end
end)

---- Rebirth Button ----
aa:addButton("Rebirth",function()
	if rebirthNum == 1 then RemoteEvent:FireServer('Rebirth',1) end
	if rebirthNum == 3 then RemoteEvent:FireServer('Rebirth',3) end
	if rebirthNum == 5 then RemoteEvent:FireServer('Rebirth',5) end
end)

----------------------------------------------------------- Menus -----------------------------------------------------------
---- Grills Upgrade Menu ----
b:addButton("Grills Upgrade",function()
	game:GetService("Players").LocalPlayer.PlayerGui.MainGui.GrillMenuFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)

---- Rebirth Shop ----
b:addButton("Rebirth Shop",function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Rebirth Overlord Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Rebirth Overlord Touch"].TouchPart, 1)
end)
---- Hats Upgrade ----
b:addButton("Hats Upgrade",function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Caleb Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Caleb Touch"].TouchPart, 1)
end)
---- Potions Shop ----
b:addButton("Potions Shop",function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Pet Scientist Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Pet Scientist Touch"].TouchPart, 1)
end)


-------- Crafting Menus --------
---- Julia [Zone 6 ----
ba:addButton("Julia [Zone 6", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Julia Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Julia Touch"].TouchPart, 1)
end)
---- Ancient Dragon [Zone 10] ----
ba:addButton("Ancient Dragon [Zone 10]", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Ancient Dragon Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Ancient Dragon Touch"].TouchPart, 1)
end)
---- Henry [Black Forest] ----
ba:addButton("Henry [Black Forest]", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Henry Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Henry Touch"].TouchPart, 1)
end)
---- Trevor [Winter Forest] ----
ba:addButton("Trevor [Winter Forest]", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Trevor Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Trevor Touch"].TouchPart, 1)
end)
---- Steven [VIP] ----
ba:addButton("Steven [VIP]", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Steven Touch"].TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Steven Touch"].TouchPart, 1)
end)

-------- Respawn Menus --------
---- x1 ----
bb:addButton("x1", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").RebirthButton.TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").RebirthButton.TouchPart, 1)
end)
---- x3 ----
bb:addButton("x3", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Rebirth3Button.TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Rebirth3Button.TouchPart, 1)
end)
---- x5 ----
bb:addButton("x5", function()
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Rebirth5Button.TouchPart, 0)
	wait(.5)
	firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Rebirth5Button.TouchPart, 1)
end)

----------------------------------------------------------- BUY -----------------------------------------------------------

---- Weapon DropDown ----
local weaponNum = 2
c:addDropdown("Select Weapon",{"50", "100", "300", "700", "1K", "2K", "5K", "10K", "13K", "25K", "40K", "55K", "75K", "100K", "250K", "375K", "500K", "1M", "1.5M", "4M", "7.5M", "10M", "15M", "20M", "25M", "35M", "50M", "80M", "120M", "150M", "200M", "400M", "750M", "1.5B", "5B", "7.5B", "10B", "100T", "100Qa"},function(num)
	if num == "50" then weaponNum = 2 end
	if num == "100" then weaponNum = 3 end
	if num == "300" then weaponNum = 4 end
	if num == "700" then weaponNum = 6 end
	if num == "1K" then weaponNum = 7 end
	if num == "2K" then weaponNum = 8 end
	if num == "5K" then weaponNum = 9 end
	if num == "10K" then hweaponNum = 10 end
	if num == "13K" then weaponNum = 11 end
	if num == "25K" then weaponNum = 12 end
	if num == "40K" then weaponNum = 13 end
	if num == "55K" then weaponNum = 14 end
	if num == "75K" then weaponNum = 15 end
	if num == "100K" then weaponNum = 16 end
	if num == "250K" then weaponNum = 17 end
	if num == "375K" then weaponNum = 18 end
	if num == "500K" then weaponNum = 19 end
	if num == "1M" then weaponNum = 20 end
	if num == "1.5M" then weaponNum = 21 end
	if num == "4M" then weaponNum = 22 end
	if num == "7.5M" then weaponNum = 23 end
	if num == "10M" then weaponNum = 24 end
	if num == "15M" then weaponNum = 25 end
	if num == "20M" then weaponNum = 26 end
	if num == "25M" then weaponNum = 27 end
	if num == "35M" then weaponNum = 28 end
	if num == "50M" then weaponNum = 29 end
	if num == "80M" then weaponNum = 30 end
	if num == "120M" then weaponNum = 31 end
	if num == "150M" then weaponNum = 32 end
	if num == "200M" then weaponNum = 33 end
	if num == "400M" then weaponNum = 34 end
	if num == "750M" then weaponNum = 35 end
	if num == "1.5B" then weaponNum = 36 end
	if num == "5B" then weaponNum = 37 end
	if num == "7.5B" then weaponNum = 38 end
	if num == "10B" then weaponNum = 39 end
	if num == "100T" then weaponNum = 41 end
	if num == "100Qa" then weaponNum = 42 end
end)

---- Weapon Button ----
c:addButton("Buy",function()
	RemoteEvent:FireServer("Buy Weapon", weaponNum)
end)

---- Weapon Buy Best ----
c:addButton("Buy Best",function()
	local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency");
	local WeaponInv, curWeaponId = RemoteFunc:InvokeServer("Get Weapon Data")
	local wantToBuy = 2
	local wantToBuyIndex = 1
	if curWeaponId == 42 then
		print("You already have the best weapon!!")
		return
	end
	for i,v in ipairs(weaponArray) do
		if v.cost > pCoins and v.weaponId > curWeaponId then
			wantToBuy = weaponArray[i-1]["weaponId"]
			wantToBuyIndex = i-1
			break
		elseif i == #weaponArray then
			wantToBuy = v.weaponId
			wantToBuyIndex = 39
		end
	end
	if wantToBuy ~= curWeaponId and curWeaponId ~= 42 then
		RemoteEvent:FireServer("Buy Weapon", weaponArray[wantToBuyIndex]["weaponId"])
	elseif wantToBuy == 42 and curWeaponId == 42 then
		print("You already have the best weapon")
	else
		print("Not enough money to Buy Best Weapon!")
	end
end)

---- Fork DropDown ----
local ForkNum = 2
ca:addDropdown("Select Fork",{"50", "150", "250", "500", "800", "2K", "5K", "10K", "20K", "35K", "75K", "150K", "250K", "400K", "750K", "1M", "1.2M", "3M", "6M", "12M", "18M", "30M", "45M", "80M", "120M", "200M", "300M", "500M"},function(num)
	if num == "50" then ForkNum = 2 end
	if num == "150" then ForkNum = 3 end
	if num == "250" then ForkNum = 4 end
	if num == "500" then ForkNum = 5 end
	if num == "800" then ForkNum = 6 end
	if num == "2K" then ForkNum = 7 end
	if num == "5K" then ForkNum = 8 end
	if num == "10K" then ForkNum = 9 end
	if num == "20K" then ForkNum = 10 end
	if num == "35K" then ForkNum = 11 end
	if num == "75K" then ForkNum = 12 end
	if num == "150K" then ForkNum = 13 end
	if num == "250K" then ForkNum = 14 end
	if num == "400K" then ForkNum = 15 end
	if num == "750K" then ForkNum = 16 end
	if num == "1M" then ForkNum = 17 end
	if num == "1.2M" then ForkNum = 18 end
	if num == "3M" then ForkNum = 19 end
	if num == "6M" then ForkNum = 20 end
	if num == "12M" then ForkNum = 21 end
	if num == "18M" then ForkNum = 22 end
	if num == "30M" then ForkNum = 23 end
	if num == "45M" then ForkNum = 24 end
	if num == "80M" then ForkNum = 25 end
	if num == "120M" then ForkNum = 26 end
	if num == "200M" then ForkNum = 27 end
	if num == "300M" then ForkNum = 28 end
	if num == "500M" then ForkNum = 29 end
end)

---- Fork Button ----
ca:addButton("Buy",function()
	RemoteEvent:FireServer("Buy Fork", ForkNum)
end)

---- Fork Buy Best ----e
ca:addButton("Buy Best",function()
	local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency")
	local forkInv, curForkId = RemoteFunc:InvokeServer("Get Fork Data")
	local forkWantToBuy = 2
	local forkWantToBuyIndex = 1
	print(curForkId)
	if curForkId == 29 then
		print("You already have the best fork!!")
		return
	end
	for i,v in ipairs(forkArray) do
		if v.cost > pCoins and v.forkId > curForkId then
			forkWantToBuy = forkArray[i-1]["forkId"]
			forkWantToBuyIndex = i-1
			break		
		elseif i == #forkArray then
			forkWantToBuy = v.forkId
			forkWantToBuyIndex = 28
		end
	end
	
	if forkWantToBuy ~= curforkId and curforkId ~= 29 then
		RemoteEvent:FireServer("Buy Fork", forkArray[forkWantToBuyIndex]["forkId"])
	elseif forkWantToBuy == 29 and curforkId == 29 then
		print("You already have the best fork")
	else
		print("Not enough money")
	end
	
end)

---- Eggs ----
local eggNum = 1
cb:addDropdown("Select Egg",{"100", "1500", "10K", "50K", "150K", "750K", "2M", "5M", "20M", "75M", "100T", "10Qa"},function(num)
	if num == "100" then eggNum = 1 end
	if num == "1500" then eggNum = 2 end
	if num == "10K" then eggNum = 3 end
	if num == "50K" then eggNum = 4 end
	if num == "150K" then eggNum = 5 end
	if num == "750K" then eggNum = 6 end
	if num == "2M" then eggNum = 7 end
	if num == "5M" then eggNum = 8 end
	if num == "20M" then eggNum = 9 end
	if num == "75M" then eggNum = 10 end
	if num == "100T" then eggNum = 19 end
	if num == "10Qa" then eggNum = 21 end
end)
local openEggBool = false
cb:addToggle("Toggle", false, function(bool)
	openEggBool = bool
end)
local openEggCoro = coroutine.create(function()
	while wait() do
		if openEggBool == true then
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",eggNum)
		end
	end
end)
coroutine.resume(openEggCoro)
---- Hats ----
local hatNum = 1
cc:addDropdown("Select Hat",{"250", "2K", "15K", "200K", "1M", "5M", "15M", "50M", "150T", "750Gems"},function(num)
	if num == "250" then hatNum = 11 end
	if num == "2K" then hatNum = 12 end
	if num == "15K" then hatNum = 13 end
	if num == "200K" then hatNum = 14 end
	if num == "1M" then hatNum = 15 end
	if num == "5M" then hatNum = 16 end
	if num == "15M" then hatNum = 17 end
	if num == "50M" then hatNum = 18 end
	if num == "150T" then hatNum = 20 end
	if num == "750Gems" then hatNum = 22 end
end)
local openHatBool = false
cc:addToggle("Toggle", false, function(bool)
	openHatBool = bool
end)
local openHatsCoro = coroutine.create(function()
	while wait() do
		if openHatBool == true then
			game:GetService("ReplicatedStorage").RemoteEvent:FireServer("Purchase One Egg",hatNum)
		end
	end
end)
coroutine.resume(openHatsCoro)
----------------------------------------------------------- Teleports -----------------------------------------------------------
for k,v in ipairs(Locations) do
	d:addButton(tostring(v.name),function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Locations[k].cf		
	end)
end 

----------------------------------------------------------- Misc -----------------------------------------------------------
---- walkspeed -----
e:addSlider("Speed",game.Players.LocalPlayer.Character.Humanoid.WalkSpeed,1,300,function(value)
    WalkSpeed = value
end)
local walkspeedCoro = coroutine.create(function()
	while wait() do
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = WalkSpeed
	end
end)
coroutine.resume(walkspeedCoro)
----------------------------------------------------------- KeyBinds -----------------------------------------------------------
---- open close menu ----
ea:addKeybind("Open/Close Menu", Enum.KeyCode.Backquote, function()
venyx:toggle()
end, function()
end)

---- Auto Attack ----
ea:addKeybind("Auto Attack", Enum.KeyCode.One, function()
	if autoAttackBool == false then
		autoAttackBool = true
	else
		autoAttackBool = false
		RemoteEvent:FireServer("Animal Deselected", currentTarget)
	end
end, function()
end)

---- magnet meat items ----
ea:addKeybind("Magnet Meat/Items", Enum.KeyCode.Two, function()
	if magnetMeatItemsBool == false then
		magnetMeatItemsBool = true
	else
		magnetMeatItemsBool = false
	end
end, function()
end)

---- Drop Off Meat ----
ea:addKeybind("Drop Off Meat", Enum.KeyCode.Three, function()
	if dropOffMeatBool == false then
		dropOffMeatBool = true
	else
		dropOffMeatBool = false
	end
end, function()
end)

---- Collect Grill Coins ----
ea:addKeybind("Collect Grill Coins", Enum.KeyCode.Four, function()
	if collectGrillCoinsBool == false then
		collectGrillCoinsBool = true
	else
		collectGrillCoinsBool = false
	end
end, function()
end)

---- collectCoinsBool ----
ea:addKeybind("Collect Coins", Enum.KeyCode.Five, function()
	if collectCoinsBool == false then
		collectCoinsBool = true
	else
		collectCoinsBool = false
	end
end, function()
end)

---- Buy Best Gun ----
ea:addKeybind("Buy Best Gun", Enum.KeyCode.Minus, function()
	local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency");
	local WeaponInv, curWeaponId = RemoteFunc:InvokeServer("Get Weapon Data")
	local wantToBuy = 2
	local wantToBuyIndex = 1
	if curWeaponId == 42 then
		print("You already have the best weapon!!")
		return
	end
	for i,v in ipairs(weaponArray) do
		if v.cost > pCoins and v.weaponId > curWeaponId then
			wantToBuy = weaponArray[i-1]["weaponId"]
			wantToBuyIndex = i-1
			break
		elseif i == #weaponArray then
			wantToBuy = v.weaponId
			wantToBuyIndex = 39
		end
	end
	if wantToBuy ~= curWeaponId and curWeaponId ~= 42 then
		RemoteEvent:FireServer("Buy Weapon", weaponArray[wantToBuyIndex]["weaponId"])
	elseif wantToBuy == 42 and curWeaponId == 42 then
		print("You already have the best weapon")
	else
		print("Not enough money to Buy Best Weapon!")
	end
end, function()
end)

---- Buy Best Fork ----
ea:addKeybind("Buy Best Fork", Enum.KeyCode.Equals, function()
	local pCoins, Gems = RemoteFunc:InvokeServer("Get Currency")
	local forkInv, curForkId = RemoteFunc:InvokeServer("Get Fork Data")
	local forkWantToBuy = 2
	local forkWantToBuyIndex = 1
	print(curForkId)
	if curForkId == 29 then
		print("You already have the best fork!!")
		return
	end
	for i,v in ipairs(forkArray) do
		if v.cost > pCoins and v.forkId > curForkId then
			forkWantToBuy = forkArray[i-1]["forkId"]
			forkWantToBuyIndex = i-1
			break		
		elseif i == #forkArray then
			forkWantToBuy = v.forkId
			forkWantToBuyIndex = 28
		end
	end
	
	if forkWantToBuy ~= curforkId and curforkId ~= 29 then
		RemoteEvent:FireServer("Buy Fork", forkArray[forkWantToBuyIndex]["forkId"])
	elseif forkWantToBuy == 29 and curforkId == 29 then
		print("You already have the best fork")
	else
		print("Not enough money")
	end
end, function()
end)


---- Set Main Page on load ----
venyx:SelectPage(venyx.pages[1], true)