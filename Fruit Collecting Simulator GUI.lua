--[[
Game : https://www.roblox.com/games/4934958405
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = "Fruit Collecting Simulator GUI"
kVars.lp = game:GetService("Players").LocalPlayer
kVars.VirtualUser = game:service('VirtualUser')
kVars.rsEvents = game:GetService("ReplicatedStorage").Events
kVars.foodToCollect = "Apple"
kVars.TBList = require(game:GetService("ReplicatedStorage").Modules.Shared.ShopPricesModule)
kVars.backpackTable = {"Starter Backpack","Shoulder Backpack","Drawstring Backpack","Balloon Backpack","Phoenix Backpack","Unicorn Backpack","Dragon Hatchling Backpack","Playful Puppy Backpack","Robot Backpack","Red 8-Bit Backpack","Green 8-Bit Backpack","Black 8-Bit Backpack","Glowing Neon Backpack","Cookie Jar Backpack","Milk Carton Backpack","Upcycled Backpack","Beach Bucket Backpack","Lifeguard Backpack","Chocolate Backpack","Lollipop Backpack","Lava Drawstring Backpack","Lava 8-Bit Backpack","UFO Backpack","Spaceship Backpack","Red Sailor Duffel Bag","Medic Bag","Ninja Backpack","Ninja Shuriken","Apple Juice Box","XXL Fries To-Go","Jar O' Stars","Boombox"}
kVars.toolTable = {"Trowel","Small Shovel","Shovel","Leaf Rake","Soade","Scissors","Pickaxe","Flat Shovel","Mallet","Crowbar","Pitchfork","Battle Axe","Saw","Small Sickle","Sickle","Reaper Scythe","Rake","Hammer","Bucket","Magnet","Chainsaw","CandyCane","Lava Shovel","Lava Crowbar","Lava Saw","Lava Pickaxe","Lava Chainsaw","Axe","Machete","Bamboo Katana","Katana"}
kVars.trailTable = {"Default","Red","Blue","Pink","Green","Roblox Logo","Rainbow","Sand","Toy Brick","Water","Lava","Paint","Galaxy"}



---- if re-injecting script, we wait for the old one to close and turn all option off
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    wait(.15)
end

---- antiAFK ----
kVars.AntiAfk = kVars.lp.Idled:connect(function()
    kVars.VirtualUser:CaptureController()
    kVars.VirtualUser:ClickButton2(Vector2.new())
end)

---- GUI Library ----
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

---- pages ----
local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageBuy = MainUI.AddPage("Buy")
local pageEggPets = MainUI.AddPage("Egg/Pets")
local pageCrates = MainUI.AddPage("Crates")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
----  ----
kVars.toggleFruit = pageFarm.AddToggle("Fruit", false, function(bool)
    kVars.boolFruit = bool
    if bool then fFruit() end
end)

function fFruit()
    spawn(function()
        while kVars.boolFruit do
            wait()
            if game:GetService('Players').LocalPlayer.Character:FindFirstChildWhichIsA('Tool') then
                local curTool = kVars.lp.CurrentToolEquipped.Value
                if kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
                    if kVars.lp.Areas:FindFirstChild("Dojo") then
                        kVars.foodToCollect = "Coconut"
                    elseif kVars.lp.Areas:FindFirstChild("Camping") then
                        kVars.foodToCollect = "Grape"
                    elseif kVars.lp.Areas:FindFirstChild("Toy Paradise") then
                        kVars.foodToCollect = "Cherry"
                    elseif kVars.lp.Areas:FindFirstChild("Food Heaven") then
                        kVars.foodToCollect = "Lime"
                    elseif kVars.lp.Areas:FindFirstChild("Moon") then
                        kVars.foodToCollect = "Orange"
                    elseif kVars.lp.Areas:FindFirstChild("Volcano") then
                        kVars.foodToCollect = "Pineapple"
                    elseif kVars.lp.Areas:FindFirstChild("Candyland") then
                        kVars.foodToCollect = "Pear"
                    elseif kVars.lp.Areas:FindFirstChild("Beach") then
                        kVars.foodToCollect = "Watermelon"
                    elseif kVars.lp.Areas:FindFirstChild("Desert") then
                        kVars.foodToCollect = "Banana"
                    elseif kVars.lp.Areas:FindFirstChild("Winter") then
                        kVars.foodToCollect = "StrawBerry"
                    else
                        kVars.foodToCollect = "Apple"
                    end
                    if game:GetService('Players').LocalPlayer.Character:FindFirstChildWhichIsA('Tool') then
                        kVars.rsEvents.Collect:FireServer(kVars.foodToCollect, game:GetService('Players').LocalPlayer.Character:FindFirstChildWhichIsA('Tool'))
                    end
                end
            else
                if game:GetService('Players').LocalPlayer:FindFirstChild('Backpack') and game:GetService('Players').LocalPlayer.Character:FindFirstChild('Humanoid') then
                    local tool = game:GetService('Players').LocalPlayer:FindFirstChild('Backpack'):FindFirstChildWhichIsA('Tool')
                    game:GetService('Players').LocalPlayer.Character.Humanoid:EquipTool(tool)
                end
            end
        end
    end)
end

kVars.toggleSell = pageFarm.AddToggle("Sell", false, function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)

function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
			if kVars.lp.Character:FindFirstChild("RightFoot") then
				firetouchinterest(kVars.lp.Character.RightFoot, game:GetService("Workspace").MapFolder.TouchParts.SellPart, 0)
				wait(.1)
				firetouchinterest(kVars.lp.Character.RightFoot, game:GetService("Workspace").MapFolder.TouchParts.SellPart, 1)
			end
        end
    end)
end

kVars.toggleRebirth = pageFarm.AddToggle("Rebirth", false, function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait(2)
            if kVars.boolRebirth == false then return end
			if kVars.lp:FindFirstChild("Tools") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				kVars.rsEvents.MultiRebirth:FireServer("Rebirth4", kVars.lp)
			end
        end
    end)
end


---------- Buy Page ----------
kVars.toggleBackPack = pageBuy.AddToggle("BackPack", false, function(bool)
    kVars.boolBackPack = bool
    if bool then fBackPack() end
end)

function fBackPack()
    spawn(function()
        while kVars.boolBackPack do
            wait()
            local currentBackpack = kVars.lp.CurrentBackpackEquipped.Value
			if game.workspace:FindFirstChild(kVars.lp.Name) and kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				if currentBackpack ~= kVars.backpackTable[#kVars.backpackTable] and table.find(kVars.backpackTable, currentBackpack) then
					kVars.rsEvents.Server:InvokeServer("PurchaseBackpack", kVars.backpackTable[table.find(kVars.backpackTable, currentBackpack)+1])
				end
			end
        end
    end)
end

kVars.toggleTool = pageBuy.AddToggle("Tool", false, function(bool)
    kVars.boolTool = bool
    if bool then fTool() end
end)

function fTool()
    spawn(function()
        while kVars.boolTool do
            wait()
            local currentTool = kVars.lp.CurrentToolEquipped.Value
			if game.workspace:FindFirstChild(kVars.lp.Name) and kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				if currentTool ~= kVars.toolTable[#kVars.toolTable] and table.find(kVars.toolTable, currentTool) then
					kVars.rsEvents.Server:InvokeServer("PurchaseTool", kVars.toolTable[table.find(kVars.toolTable, currentTool)+1])
				end
			end
        end
    end)
end

kVars.toggleTrail = pageBuy.AddToggle("Trail", false, function(bool)
    kVars.boolTrail = bool
    if bool then fTrail() end
end)

function fTrail()
    spawn(function()
        while kVars.boolTrail do
            wait()
            local curTrail = kVars.lp.TrailEquipped.Value
			if game.workspace:FindFirstChild(kVars.lp.Name) and kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				local tI = table.find(kVars.trailTable, curTrail)
				if kVars.trailTable[tI] ~= kVars.trailTable[#kVars.trailTable] then
					kVars.rsEvents.TrailPurchase:FireServer(kVars.trailTable[tI+1], kVars.lp)
					kVars.rsEvents.TrailEquip:FireServer(kVars.trailTable[tI+1], kVars.lp)
				end
			end
        end
    end)
end

kVars.toggleAreas = pageFarm.AddToggle("Areas", false, function(bool)
    kVars.boolAreas = bool
    if bool then fAreas() end
end)

function fAreas()
    spawn(function()
        while kVars.boolAreas do
            wait()
            if game.workspace:FindFirstChild(kVars.lp.Name) and kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				if kVars.lp.Areas:FindFirstChild("Dojo") then
				elseif kVars.lp.Areas:FindFirstChild("Camping") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Dojo")
				elseif kVars.lp.Areas:FindFirstChild("Toy Paradise") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Camping")
				elseif kVars.lp.Areas:FindFirstChild("Food Heaven") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Toy Paradise")
				elseif kVars.lp.Areas:FindFirstChild("Moon") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Food Heaven")
				elseif kVars.lp.Areas:FindFirstChild("Volcano") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Moon")
				elseif kVars.lp.Areas:FindFirstChild("Candyland") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Volcano")
				elseif kVars.lp.Areas:FindFirstChild("Beach") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Candyland")
				elseif kVars.lp.Areas:FindFirstChild("Desert") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Beach")
				elseif kVars.lp.Areas:FindFirstChild("Winter") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Desert")
				elseif not kVars.lp.Areas:FindFirstChild("Winter") then
					kVars.rsEvents.Server:InvokeServer("UnlockArea", "Winter")
				end
			end
        end
    end)
end

kVars.toggleGemMulti = pageBuy.AddToggle("Gem Multi", false, function(bool)
    kVars.boolGemMulti = bool
    if bool then fGemMulti() end
end)

function fGemMulti()
    spawn(function()
        while kVars.boolGemMulti do
            wait()
            if game.workspace:FindFirstChild(kVars.lp.Name) and kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				kVars.rsEvents.Upgrade:FireServer("GemUpgrade", "Coins", kVars.lp)
			end
        end
    end)
end

kVars.toggleXpMulti = pageBuy.AddToggle("Xp Multi", false, function(bool)
    kVars.boolXpMulti = bool
    if bool then fXpMulti() end
end)

function fXpMulti()
    spawn(function()
        while kVars.boolXpMulti do
            wait()
            if game.workspace:FindFirstChild(kVars.lp.Name) and kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				kVars.rsEvents.Upgrade:FireServer("ExpUpgrade", "Gems", kVars.lp)
			end
        end
    end)
end

kVars.toggleFoodMulti = pageBuy.AddToggle("Food Multi", false, function(bool)
    kVars.boolFoodMulti = bool
    if bool then fFoodMulti() end
end)

function fFoodMulti()
    spawn(function()
        while kVars.boolFoodMulti do
            wait()
            if game.workspace:FindFirstChild(kVars.lp.Name) and kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				kVars.rsEvents.Upgrade:FireServer("FruitUpgrade", "Gems", kVars.lp)
			end
        end
    end)
end

---------- EggPets Page ----------
kVars.labelEggPets = pageEggPets.AddLabel("Eggs")
kVars.SelectedEgg = "CommonEgg"
kVars.eggsTable = {"CommonEgg", "UncommonEgg", "RareEgg", "IceEgg", "IdolEgg", "BallEgg", "IceCream", "FlameEgg", "RocketEgg", "GourmetEgg", "ZombieEgg", "ScoutEgg", "FabergeEgg"}
kVars.DropdownEggSelection = pageEggPets.AddDropdown("Egg Selection", kVars.eggsTable, function(Value)
    kVars.SelectedEgg = Value
end)

kVars.toggleOpenEgg = pageEggPets.AddToggle("Open", false, function(bool)
    kVars.boolOpenEgg = bool
    if bool then fOpenEgg() end
end)

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            if kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				kVars.rsEvents.Egg:FireServer("OpenEgg",{kVars.SelectedEgg})
			end
        end
    end)
end

kVars.labelEggPets = pageEggPets.AddLabel("Delete Pets")

kVars.petTable = {}
table.insert(kVars.petTable, "1none1")
for i,v in pairs(game:GetService("ReplicatedStorage").Pets:getChildren()) do
	table.insert(kVars.petTable, v.Name)
end
table.sort(kVars.petTable)
kVars.DelSelPet1 = "1none1"
kVars.DelSelPet2 = "1none1"
kVars.DelSelPet3 = "1none1"
kVars.DelSelPet4 = "1none1"
kVars.DropdownDelPetSelection1 = pageEggPets.AddDropdown("Select a Pet", kVars.petTable, function(Value)
    kVars.DelSelPet1 = Value
 end)
 kVars.DropdownDelPetSelection2 = pageEggPets.AddDropdown("Select a Pet", kVars.petTable, function(Value)
    kVars.DelSelPet2 = Value
 end)
 kVars.DropdownDelPetSelection3 = pageEggPets.AddDropdown("Select a Pet", kVars.petTable, function(Value)
    kVars.DelSelPet3 = Value
 end)
 kVars.DropdownDelPetSelection4 = pageEggPets.AddDropdown("Select a Pet", kVars.petTable, function(Value)
    kVars.DelSelPet4 = Value
 end)

 kVars.toggleDelPet = pageEggPets.AddToggle("Delete", false, function(bool)
    kVars.boolDelPet = bool
    if bool then fDelPet() end
end)

function fDelPet()
    spawn(function()
        while kVars.boolDelPet do
            wait()
            if kVars.lp.Tools:FindFirstChild("Trowel") and kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				if kVars.DelSelPet1 ~= "1none1" then
					local del = nil
					for i,v in pairs(kVars.lp.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection1 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {kVars.lp.Pets:FindFirstChild(del)})
						end
					end				
				end
				if kVars.DelSelPet2 ~= "1none1" then
					local del = nil
					for i,v in pairs(kVars.lp.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection2 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {kVars.lp.Pets:FindFirstChild(del)})
						end
					end	
				end
				if kVars.DelSelPet3 ~= "1none1" then
					local del = nil
					for i,v in pairs(kVars.lp.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection3 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {kVars.lp.Pets:FindFirstChild(del)})
						end
					end	
				end
				if kVars.DelSelPet4 ~= "1none1" then
					local del = nil
					for i,v in pairs(kVars.lp.Pets:getChildren()) do
						if v.PetName.Value == petDelSelection4 then
							del = tostring(v)
							game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {kVars.lp.Pets:FindFirstChild(del)})
						end
					end	
				end
			end
        end
    end)
end



---------- Crates Page ----------
kVars.labelCrates = pageCrates.AddLabel("Crates")
kVars.crateTable = {"CommonCrate", "uncommonCrate", "RareCrate", "IceCrate", "IdolCrate", "BeachCrate", "IceCreamCrate", "FlameCrate", "RocketCrate", "GourmetCrate", "ToyCrate", "ScoutCrate", "FabergeCrate"}
kVars.SelectedCrate = "CommonCrate"

kVars.DropdownCrateSelection = pageCrates.AddDropdown("Crate Selection", kVars.crateTable, function(Value)
   kVars.SelectedCrate = Value
end)

kVars.toggleOpenCrate = pageCrates.AddToggle("Open", false, function(bool)
    kVars.boolOpenCrate = bool
    if bool then fOpenCrate() end
end)

function fOpenCrate()
    spawn(function()
        while kVars.boolOpenCrate do
            wait()
            if kVars.lp.Character:FindFirstChild('HumanoidRootPart') then
				kVars.rsEvents.Crate:FireServer("OpenCrate",{kVars.SelectedCrate})
			end
        end
    end)
end

---------- Character Page ----------
---- Walk Speed ----
kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.WalkSpeed}, function(num)
    kVars.lp.Character.Humanoid.WalkSpeed = num
end)

---- Jump Power ----
kVars.sliderJumpPower = pageCharacter.AddSlider("Jump Power",  {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.JumpPower}, function(num)
    kVars.lp.Character.Humanoid.JumpPower = num
end)

---- Inf Jump ----
kVars.sliderInfJump = pageCharacter.AddToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

kVars.InfJumpConnect = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump and kVars.lp.Character:FindFirstChild("Humanoid") then
		kVars.lp.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)

---------- Credits Page ----------
kVars.labelCodedBy = pageCredits.AddLabel("Coded by : Keathunsar")
kVars.labelCodedByLink = pageCredits.AddLabel("https://github.com/dady172172/Roblox-Cheats")
kVars.labelGuiBy = pageCredits.AddLabel("Gui made by : FungBert")
kVars.labelGuiByLink = pageCredits.AddLabel("v3rmillion.net/member.php?action=profile&uid=1078854")

---------- Closing ----------
kVars.ClosingConnect = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.WindowName then
		kVars.closing = true
		wait(.1)
		kVars.InfJumpConnect:Disconnect()
		for i,v in pairs(kVars) do
			if type(v) == "boolean" then
				v = false
			end
		end
		kVars.ClosingConnect:Disconnect()
		script:Destroy()
	end
end)