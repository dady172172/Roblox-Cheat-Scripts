--[[
Game : https://www.roblox.com/games/4934958405
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Fruit Collecting Simulator GUI"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
kVars.Hold = false

---- destroy old gui if exists ----
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
    wait(2)
end

---- antiAFK ----
kVars.connectAntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.vu:CaptureController()
    kVars.vu:ClickButton2(Vector2.new())
 end)

---- gui build ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local Window = library:CreateMain({
    projName = kVars.WindowName,
    Resizable = true,
    MinSize = UDim2.new(0,400,0,400),
    MaxSize = UDim2.new(0,750,0,500),
})

local pageMain = Window:CreateCategory("Main")
local sectionFarm = pageMain:CreateSection("Farm")
local sectionRebirth = pageMain:CreateSection("Rebirth")

local pageUpgrades = Window:CreateCategory("Upgrades")
local sectionUpgrades = pageUpgrades:CreateSection("Upgrades")

local pageEggs = Window:CreateCategory("Eggs/Crates")
local sectionOpenEggs = pageEggs:CreateSection("Open Eggs")
local sectionDeletePets = pageEggs:CreateSection("Delete Pets *Carful")
local sectionOpenCrates = pageEggs:CreateSection("Open Crates")
local sectionDeleteHats = pageEggs:CreateSection("Delete Hats *Carful")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")

local pageCharacter = Window:CreateCategory("Character")
local sectionCharacter = pageCharacter:CreateSection("Options")

local pageMisc = Window:CreateCategory("Misc")
local sectionKeybinds = pageMisc:CreateSection("KeyBinds")
local sectionWorld = pageMisc:CreateSection("World Options")
local sectionMisc = pageMisc:CreateSection("Options")

local pageCredits = Window:CreateCategory("Credits")
local sectionCreditsKeath = pageCredits:CreateSection("Coded by : Keathunsar")
local sectionCreditsAlex = pageCredits:CreateSection("UI-Lib by : xTheAlex14")

----========== page main ==========----




---- Farm ----
kVars.boolFruit = false
sectionFarm:Create("Toggle", "Fruit",function(bool)
    kVars.boolFruit = bool
    if bool then
        fFruit()
    end
end,{default = kVars.boolFruit})

function fFruit()
    spawn(function()
        while kVars.boolFruit do
            wait(0.1)
            pcall(function() 
                if kVars.Hold == false then
                    kVars.lp.Character.Humanoid:EquipTool(kVars.lp.Backpack:FindFirstChildWhichIsA('Tool'))
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
                    kVars.rs.Events.Collect:FireServer(kVars.foodToCollect, kVars.lp.Character:FindFirstChildWhichIsA('Tool'))
                end
            end)
        end
    end)
end

kVars.boolSell = false
sectionFarm:Create("Toggle", "Sell",function(bool)
    kVars.boolSell = bool
    if bool then
        fSell()
    end
end,{default = kVars.boolSell})

function fSell()
    spawn(function()
        while kVars.boolSell do
            wait(0.1)
            pcall(function()
                if kVars.Hold == false then
                    firetouchinterest(kVars.lp.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").MapFolder.TouchParts.SellPart, 0)
                    firetouchinterest(kVars.lp.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").MapFolder.TouchParts.SellPart, 1)
                end
            end)
        end
    end)
end

---- section rebirth ----
kVars.selectedRebirthAmount = "1"
sectionRebirth:Create("DropDown", "Select Amount", function(value)
    if value == "+5" then
        kVars.selectedRebirthAmount = "1"
    elseif value == "+10" then
        kVars.selectedRebirthAmount = "2"
    elseif value == "+50" then
        kVars.selectedRebirthAmount = "3"
    else
        kVars.selectedRebirthAmount = "4"
    end
end,{options = {"+5","+10","+50","+100"}, default = "+5", search = true})

kVars.boolRebirth = false
sectionRebirth:Create("Toggle", "Rebirth",function(bool)
    kVars.boolRebirth = bool
end,{default = kVars.boolRebirth})

----========== page Upgrade ==========----
---- section upgrades ----
kVars.boolAreas = false
sectionUpgrades:Create("Toggle", "Areas",function(bool)
    kVars.boolAreas = bool
end,{default = kVars.boolAreas})


kVars.backpackTable = {"Starter Backpack","Shoulder Backpack","Drawstring Backpack","Balloon Backpack","Phoenix Backpack","Unicorn Backpack","Dragon Hatchling Backpack","Playful Puppy Backpack","Robot Backpack","Red 8-Bit Backpack","Green 8-Bit Backpack","Black 8-Bit Backpack","Glowing Neon Backpack","Cookie Jar Backpack","Milk Carton Backpack","Upcycled Backpack","Beach Bucket Backpack","Lifeguard Backpack","Chocolate Backpack","Lollipop Backpack","Lava Drawstring Backpack","Lava 8-Bit Backpack","UFO Backpack","Spaceship Backpack","Red Sailor Duffel Bag","Medic Bag","Ninja Backpack","Ninja Shuriken","Apple Juice Box","XXL Fries To-Go","Jar O' Stars","Boombox","Block Backpack", "Wind Up Backpack", "8-Bit Guitar Backpack", "Gamekid Backpack"}
kVars.toolTable = {"Trowel","Small Shovel","Shovel","Leaf Rake","Soade","Scissors","Pickaxe","Flat Shovel","Mallet","Crowbar","Pitchfork","Battle Axe","Saw","Small Sickle","Sickle","Reaper Scythe","Rake","Hammer","Bucket","Magnet","Chainsaw","CandyCane","Lava Shovel","Lava Crowbar","Lava Saw","Lava Pickaxe","Lava Chainsaw","Axe","Machete","Bamboo Katana","Katana","TeddyBear", "Toy Unicorn Blade", "SlingShot", "Robot"}
kVars.trailTable = {"Default","Red","Blue","Pink","Green","Roblox Logo","Rainbow","Sand","Toy Brick","Water","Lava","Paint","Galaxy"}

kVars.boolBackpack = false
sectionUpgrades:Create("Toggle", "Backpack",function(bool)
    kVars.boolBackpack = bool
end,{default = kVars.boolBackpack})

kVars.boolTool = false
sectionUpgrades:Create("Toggle", "Tool",function(bool)
    kVars.boolTool = bool
end,{default = kVars.boolTool})

kVars.boolTrail = false
sectionUpgrades:Create("Toggle", "Trail",function(bool)
    kVars.boolTrail = bool
end,{default = kVars.boolTrail})

kVars.boolGemMulti = false
sectionUpgrades:Create("Toggle", "Gem Multiplayer",function(bool)
    kVars.boolGemMulti = bool
end,{default = kVars.boolGemMulti})


kVars.boolXPMulti = false
sectionUpgrades:Create("Toggle", "XP Multiplayer",function(bool)
    kVars.boolXPMulti = bool
end,{default = kVars.boolXPMulti})


kVars.boolFoodMulti = false
sectionUpgrades:Create("Toggle", "Food Multiplayer",function(bool)
    kVars.boolFoodMulti = bool
end,{default = kVars.boolFoodMulti})

----========== page eggs/crates ==========----
---- section open eggs ----
kVars.eggsTable = {"CommonEgg", "UncommonEgg", "RareEgg", "IceEgg", "IdolEgg", "BallEgg", "IceCream", "FlameEgg", "RocketEgg", "GourmetEgg", "ZombieEgg", "ScoutEgg", "FabergeEgg", "5M EGG"}
kVars.SelectedEgg = kVars.eggsTable[1]
sectionOpenEggs:Create("DropDown", "Select and egg to hatch", function(value)
    kVars.SelectedEgg = value
end,{options = kVars.eggsTable, default = kVars.eggsTable[1], search = true})

kVars.boolOpenEgg = false
sectionOpenEggs:Create("Toggle", "Open",function(bool)
    kVars.boolOpenEgg = bool
end,{default = kVars.boolOpenEgg})

---- section delete pets ----
kVars.petTable = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Pets:getChildren()) do
	table.insert(kVars.petTable, v.Name)
end
table.sort(kVars.petTable)
table.insert(kVars.petTable,1,'NONE')
kVars.DelSelPet = {
    [1] = "NONE",
    [2] = "NONE",
    [3] = "NONE",
    [4] = "NONE"
}

for i=1,4 do
    sectionDeletePets:Create("DropDown", "Select a pet to delete", function(value)
        kVars.DelSelPet[i] = value
    end,{options = kVars.petTable, default = kVars.petTable[1], search = true})
end

kVars.boolDelPet = false
sectionDeletePets:Create("Toggle", "Delete",function(bool)
    kVars.boolDelPet = bool
    if bool then
        fDelPet()
    end
end,{default = kVars.boolDelPet})

function fDelPet()
    spawn(function()
        while kVars.boolDelPet do
            wait()
            pcall(function()
                if kVars.Hold == false then
                    for g,h in pairs(kVars.DelSelPet) do
                        if h ~= "NONE" then
                            for i,v in pairs(kVars.lp.Pets:getChildren()) do
                                if v.PetName.Value == h then
                                    game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {kVars.lp.Pets:FindFirstChild(tostring(v))})
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

---- section crates ----
kVars.crateTable = {}
kVars.crateNames = {}
kVars.CrateData = require(game:GetService("ReplicatedStorage").Modules.Client.CrateDataModule)
for i,v in pairs(kVars.CrateData) do
    if i ~= "RobuxCrate" then
        table.insert(kVars.crateTable,{name = tostring(i), cost = v.Cost[2]})
    end
end
table.sort(kVars.crateTable, function(a,b) return a.cost < b.cost end)
table.foreach(kVars.crateTable, function(i,v) table.insert(kVars.crateNames, v.name) end)

kVars.selectedCrate = kVars.crateNames[1]
sectionOpenCrates:Create("DropDown", "Select a crate to open", function(value)
    kVars.selectedCrate = value
end,{options = kVars.crateNames, default = kVars.crateNames[1], search = true})

kVars.boolOpenCrate = false
sectionOpenCrates:Create("Toggle", "Open",function(bool)
    kVars.boolOpenCrate = bool
end,{default = kVars.boolOpenCrate})

---- section delete hats ----
kVars.hatsTable = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Hats:GetChildren()) do
    table.insert(kVars.hatsTable,v.name)
end
table.sort(kVars.hatsTable)
table.insert(kVars.hatsTable,1,"NONE")
kVars.DelSelHat = {
    [1] = "NONE",
    [2] = "NONE",
    [3] = "NONE",
    [4] = "NONE"
}
for i=1,4 do
    sectionDeleteHats:Create("DropDown", "Select a hat to delete", function(value)
        kVars.DelSelHat[i] = value
    end,{options = kVars.hatsTable, default = kVars.hatsTable[1], search = true})
end

sectionDeleteHats:Create("Toggle", "Delete Hats *Carful",function(bool)
    kVars.boolDelHat = bool
    if bool then
        fDelHat()
    end
end,{default = kVars.boolDelHat})

function fDelHat()
    spawn(function()
        while kVars.boolDelHat do
            wait()
            pcall(function()
                for g,h in pairs(kVars.DelSelHat) do
                    print(g,h)
                    if h ~= "NONE" then
                        for i,v in pairs(kVars.lp.Hats:getChildren()) do
                            print(i,v)
                            if v.HatName.Value == h then
                                game:GetService("ReplicatedStorage").Events.HatInventory:FireServer("DeleteHat", {kVars.lp.Hats:FindFirstChild(tostring(v))})
                            end
                        end
                    end
                end
            end)
        end
    end)
end


----========== page teleport ==========----
---- section teleport to player ----
kVars.SelectedTPToPlayer = kVars.lp.name
sectionTPToPlayer:Create("TextBox", "Enter Users Name", function(value)
    kVars.SelectedTPToPlayer = value
end,{text = "Enter Users Name"})

sectionTPToPlayer:Create("Button", "Teleport To Player", function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if kVars.SelectedTPToPlayer ~= nil and kVars.SelectedTPToPlayer ~= kVars.lp.name then
            if string.lower(v.DisplayName) == string.lower(kVars.SelectedTPToPlayer) then
                kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame                
            end
        end
    end
end,{animated = true})


----========== page character ==========----
---- section Character ----
kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.WalkSpeed, precise = false, changablevalue = true})

kVars.jumpPower = kVars.humanoid.JumpPower
sectionCharacter:Create("Slider", "Jump Power", function(value)
    kVars.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 50, max = 500, default = kVars.humanoid.JumpPower, precise = false, changablevalue = true})


kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    wait()
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpPower = kVars.jumpPower
    kVars.Hold = false
end)

kVars.boolInfJump = false
sectionCharacter:Create("Toggle", "Inf Jump",function(bool)
    kVars.boolInfJump = bool
end,{default = kVars.boolInfJump})

kVars.connectJumpRequest = game:GetService("UserInputService").JumpRequest:Connect(function()
	if kVars.boolInfJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)

----========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.F5
sectionKeybinds:Create("KeyBind", "Open Close Menu", function(key)
    kVars.OpenCloseMenuKey = key
end,{default = kVars.OpenCloseMenuKey})


kVars.connectInputBegan = kVars.uis.InputBegan:Connect(function(key)
    if key.UserInputType == Enum.UserInputType.Keyboard and key.KeyCode == kVars.OpenCloseMenuKey then
        if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled then
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = false
        else
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = true
        end
    end
end)

---- section world ----
if game.Lighting.FogStart < 100 then
    kVars.boolFog = true
else
    kVars.boolFog = false
end
sectionWorld:Create("Toggle", "Fog",function(bool)
    kVars.boolFog = bool
    if bool then
        game.Lighting.FogStart = 0
    else
        game.Lighting.FogStart = math.huge
    end
end,{default = kVars.boolFog})

sectionWorld:Create("Toggle", "Sun Rays",function(bool)
    game:GetService("Lighting").SunRays.Enabled = bool
end,{default = game:GetService("Lighting").SunRays.Enabled})

---- sections options ----
sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

kVars.boolPopUps = true
sectionMisc:Create("Toggle", "Pop Ups",function(bool)
    kVars.boolPopUps = bool

    game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.PopUpFrame.Visible = bool
    game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.LevelUp.Visible = bool
    if bool then
        game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.BackpackFullFrame:TweenPosition(UDim2.new(0.5,0,0.5,0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, .2, true)
    else
        game:GetService("Players").LocalPlayer.PlayerGui.MainGui.ScreenFrame.BackpackFullFrame:TweenPosition(UDim2.new(-0.5,0,0.5,0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, .2, true)
    end
end,{default = kVars.boolPopUps})

----========== page credits ==========----
---- keaths ----
sectionCreditsKeath:Create("Button", "https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
end,{animated = true})

sectionCreditsKeath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
end,{animated = true})

---- alex ----
sectionCreditsAlex:Create("Button", "https://teppyboy.github.io/", function()
    setclipboard('https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/main.html')
end,{animated = true})

----========== delete script if re-injecting ==========----

kVars.cR = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.name == kVars.WindowName then
        for i,v in pairs(kVars) do
            if type(v) == "boolean" then
                kVars[i] = false
            end
        end
        kVars.connectAntiAfk:Disconnect()
        kVars.connectInputBegan:Disconnect()
        kVars.connectJumpRequest:Disconnect()
        kVars.plrAdded:Disconnect()
        wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)

---- main loop ----
kVars.boolMainLoop = true
spawn(function()
    while kVars.boolMainLoop do
        local a, b = pcall(function()
            wait()
            ---- rebirth ----
            if kVars.boolRebirth then
                local coinsNeeded = 0
                if kVars.selectedRebirthAmount == "1" then
                    coinsNeeded = 100000000 * (game.Players.LocalPlayer.leaderstats.Rebirths.Value + 1) / 2
                elseif kVars.selectedRebirthAmount == "2" then
                    coinsNeeded = 100000000 * (game.Players.LocalPlayer.leaderstats.Rebirths.Value + 1) 
                elseif kVars.selectedRebirthAmount == "3" then
                    coinsNeeded = 100000000 * (game.Players.LocalPlayer.leaderstats.Rebirths.Value + 1) * 5 
                elseif kVars.selectedRebirthAmount == "4" then
                    coinsNeeded = 100000000 * (game.Players.LocalPlayer.leaderstats.Rebirths.Value + 1) * 10 
                end
                if game.Players.LocalPlayer.leaderstats.Coins.Value > coinsNeeded then
                    kVars.rs.Events.MultiRebirth:FireServer("Rebirth" .. kVars.selectedRebirthAmount, game.Players.LocalPlayer) 
                    kVars.lp.Character:WaitForChild(game.Players.LocalPlayer.name, 10)
                    wait(2)
                end
                if game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool") == nil and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") == nil then
                    kVars.humanoid.Health = 0
                end
            end
            ---- Areas ----
            if kVars.boolAreas then
                if kVars.lp.Areas:FindFirstChild("Dojo") then
                elseif kVars.lp.Areas:FindFirstChild("Camping") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Dojo")
                elseif kVars.lp.Areas:FindFirstChild("Toy Paradise") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Camping")
                elseif kVars.lp.Areas:FindFirstChild("Food Heaven") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Toy Paradise")
                elseif kVars.lp.Areas:FindFirstChild("Moon") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Food Heaven")
                elseif kVars.lp.Areas:FindFirstChild("Volcano") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Moon")
                elseif kVars.lp.Areas:FindFirstChild("Candyland") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Volcano")
                elseif kVars.lp.Areas:FindFirstChild("Beach") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Candyland")
                elseif kVars.lp.Areas:FindFirstChild("Desert") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Beach")
                elseif kVars.lp.Areas:FindFirstChild("Winter") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Desert")
                elseif not kVars.lp.Areas:FindFirstChild("Winter") then
                    kVars.rs.Events.Server:InvokeServer("UnlockArea", "Winter")
                end
            end
            ---- backpacks ----
            if kVars.boolBackpack then
                local currentBackpack = kVars.lp.CurrentBackpackEquipped.Value
                if currentBackpack ~= kVars.backpackTable[#kVars.backpackTable] and table.find(kVars.backpackTable, currentBackpack) then
                    kVars.rs.Events.Server:InvokeServer("PurchaseBackpack", kVars.backpackTable[table.find(kVars.backpackTable, currentBackpack)+1])
                end
            end
            ---- tools ----
            if kVars.boolTool then
                local currentTool = kVars.lp.CurrentToolEquipped.Value
                if currentTool ~= kVars.toolTable[#kVars.toolTable] and table.find(kVars.toolTable, currentTool) then
                    kVars.rs.Events.Server:InvokeServer("PurchaseTool", kVars.toolTable[table.find(kVars.toolTable, currentTool)+1])
                end
            end
            ---- trail ----
            if kVars.boolTrail then
                local curTrail = kVars.lp.TrailEquipped.Value
                if curTrail ~= kVars.trailTable[#kVars.trailTable] then
                    kVars.rs.Events.TrailPurchase:FireServer(kVars.trailTable[table.find(kVars.trailTable,curTrail)+1], kVars.lp)
                    kVars.rs.Events.TrailEquip:FireServer(kVars.trailTable[table.find(kVars.trailTable,curTrail)+1], kVars.lp)
                end
            end
            ---- Gem ----
            if kVars.boolGemMulti then
                if kVars.lp.GemUpgrade.Value ~= 10 then
                    kVars.rs.Events.Upgrade:FireServer("GemUpgrade", "Coins", kVars.lp)
                end
            end
            ---- XP ----
            if kVars.boolXPMulti then
                if kVars.lp.ExpUpgrade.Value ~= 10 then
                    kVars.rs.Events.Upgrade:FireServer("ExpUpgrade", "Gems", kVars.lp)
                end
            end
            ---- Food ----
            if kVars.boolFruit then
                if kVars.lp.FruitUpgrade ~= 10 then
                    kVars.rs.Events.Upgrade:FireServer("FruitUpgrade", "Gems", kVars.lp)
                end
            end
            ---- Open Egg ----
            if kVars.boolOpenEgg then
                kVars.rs.Events.Egg:FireServer("OpenEgg",{kVars.SelectedEgg})
            end
            ---- Open Crate ----
            if kVars.boolOpenCrate then
                kVars.rs.Events.Crate:FireServer("OpenCrate",{kVars.selectedCrate})
            end
        end)
        if a == false then
            print(b)
        end
    end
end)