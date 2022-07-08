--[[
Game : https://www.roblox.com/games/4934958405
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = "Fruit Collecting Simulator GUI"
kVars.txtName = kVars.WindowName .. ".txt"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.rs = game:GetService('ReplicatedStorage')
kVars.vu = game:GetService('VirtualUser')
kVars.HttpService = game:GetService("HttpService")
kVars.themes = {}
kVars.tmp = {}
---- Load Settings ----
if readfile and isfile and isfile(kVars.txtName) then
    kVars.tmp = kVars.HttpService:JSONDecode(readfile(kVars.txtName))
    for i,v in pairs(kVars.tmp) do
        kVars.themes[i] = Color3.fromRGB(v[1], v[2], v[3])
    end
else
    print("Loading defult theme")
    kVars.themes = {
        Background = Color3.fromRGB(24, 24, 24),
        Glow = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(10, 10, 10),
        LightContrast = Color3.fromRGB(20, 20, 20),
        DarkContrast = Color3.fromRGB(14, 14, 14),  
        TextColor = Color3.fromRGB(255, 255, 255)
   }
end

---- Save Settings ----
function saveSettings()
    if writefile then
        kVars.themes = {}
        for i,v in pairs(game:GetService('CoreGui')[kVars.WindowName]:GetChildren()) do
            if v.Name == "ColorPicker" then
                kVars.themes[v.Title.Text] = {v.Container.Inputs.R.Textbox.text, v.Container.Inputs.G.Textbox.text, v.Container.Inputs.B.Textbox.text}
            end
        end
        writefile(kVars.txtName, kVars.HttpService:JSONEncode(kVars.themes))
    else
        print("You injector does not support writefile.")
    end
end

---- Destroy multiple instances ----
if game:GetService('CoreGui'):FindFirstChild(kVars.WindowName) then
   game:GetService('CoreGui'):FindFirstChild(kVars.WindowName):Destroy()
   wait(.2)
end

---- antiAFK ----
kVars.AntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
   kVars.vu:CaptureController()
   kVars.vu:ClickButton2(Vector2.new())
end)

---- Load window ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))()
local Window = library.new(kVars.WindowName, 5013109572)

---- pages and sections ----
local pageFarm = Window:addPage("Farm", 3117485989)
local sectionAutoFarm = pageFarm:addSection("Auto Farm")
local sectionRebirth = pageFarm:addSection("Rebirth")

local pageEggs = Window:addPage("Buy", 9255744883)
local sectionBuy = pageEggs:addSection("Buy")

local pageEggs = Window:addPage("Eggs", 9194077649)
local sectionEggs = pageEggs:addSection("Open Eggs")
local sectionPets = pageEggs:addSection("Delete Pets *Carful")
local sectionCrates = pageEggs:addSection("Open Crates")
local sectionDelHats = pageEggs:addSection("Delete Hats *Carful")

local pagePlayer = Window:addPage("Player", 5012544693)
local sectionPlayerStats = pagePlayer:addSection("Stats")
local sectionTpToPlayer = pagePlayer:addSection("Teleport To Player")

local pageSettings = Window:addPage("Settings", 6942070576)
local sectionTheme = pageSettings:addSection("Theme")
local sectionKeybinds = pageSettings:addSection("Keybinds")

----  ----
sectionAutoFarm:addToggle("Fruit", false, function(bool)
    kVars.boolFruit = bool
    if bool then fFruit() end
end)

function fFruit()
    spawn(function()
        while kVars.boolFruit do
            wait()
            local call = pcall(function()   
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
            end)
        end
    end)
end


sectionAutoFarm:addToggle("Sell", false, function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)

function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
            local call = pcall(function()
                firetouchinterest(kVars.lp.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").MapFolder.TouchParts.SellPart, 0)
                firetouchinterest(kVars.lp.Character:WaitForChild("HumanoidRootPart"), game:GetService("Workspace").MapFolder.TouchParts.SellPart, 1)
            end)
        end
    end)
end

kVars.selectedRebirthAmount = "1"
sectionRebirth:addDropdown("Amount", {"+5","+10","+50","+100"}, function(value)
    if value == "+5" then
        kVars.selectedRebirthAmount = "1"
    elseif value == "+10" then
        kVars.selectedRebirthAmount = "2"
    elseif value == "+50" then
        kVars.selectedRebirthAmount = "3"
    else
        kVars.selectedRebirthAmount = "4"
    end
end)

sectionRebirth:addToggle("Rebirth", false, function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            pcall(function()
                kVars.rs.Events.MultiRebirth:FireServer("Rebirth" .. kVars.selectedRebirthAmount, kVars.lp)
            end)
        end
    end)
end

sectionAutoFarm:addToggle("Areas", false, function(bool)
    kVars.boolAreas = bool
    if bool then fAreas() end
end)

function fAreas()
    spawn(function()
        while kVars.boolAreas do
            wait()
            pcall(function()
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
            end)
        end
    end)
end

---- section buy ----
kVars.backpackTable = {"Starter Backpack","Shoulder Backpack","Drawstring Backpack","Balloon Backpack","Phoenix Backpack","Unicorn Backpack","Dragon Hatchling Backpack","Playful Puppy Backpack","Robot Backpack","Red 8-Bit Backpack","Green 8-Bit Backpack","Black 8-Bit Backpack","Glowing Neon Backpack","Cookie Jar Backpack","Milk Carton Backpack","Upcycled Backpack","Beach Bucket Backpack","Lifeguard Backpack","Chocolate Backpack","Lollipop Backpack","Lava Drawstring Backpack","Lava 8-Bit Backpack","UFO Backpack","Spaceship Backpack","Red Sailor Duffel Bag","Medic Bag","Ninja Backpack","Ninja Shuriken","Apple Juice Box","XXL Fries To-Go","Jar O' Stars","Boombox"}
kVars.toolTable = {"Trowel","Small Shovel","Shovel","Leaf Rake","Soade","Scissors","Pickaxe","Flat Shovel","Mallet","Crowbar","Pitchfork","Battle Axe","Saw","Small Sickle","Sickle","Reaper Scythe","Rake","Hammer","Bucket","Magnet","Chainsaw","CandyCane","Lava Shovel","Lava Crowbar","Lava Saw","Lava Pickaxe","Lava Chainsaw","Axe","Machete","Bamboo Katana","Katana"}
kVars.trailTable = {"Default","Red","Blue","Pink","Green","Roblox Logo","Rainbow","Sand","Toy Brick","Water","Lava","Paint","Galaxy"}

sectionBuy:addToggle("Backpack", false, function(bool)
    kVars.boolBackpack = bool
    if bool then fBackpack() end
end)

function fBackpack()
    spawn(function()
        while kVars.boolBackpack do
            wait()
            pcall(function()
                local currentBackpack = kVars.lp.CurrentBackpackEquipped.Value
                if currentBackpack ~= kVars.backpackTable[#kVars.backpackTable] and table.find(kVars.backpackTable, currentBackpack) then
					kVars.rs.Events.Server:InvokeServer("PurchaseBackpack", kVars.backpackTable[table.find(kVars.backpackTable, currentBackpack)+1])
				end
            end)
        end
    end)
end

sectionBuy:addToggle("Tool", false, function(bool)
    kVars.boolTool = bool
    if bool then fTool() end
end)

function fTool()
    spawn(function()
        while kVars.boolTool do
            wait()
            pcall(function()
                local currentTool = kVars.lp.CurrentToolEquipped.Value
                if currentTool ~= kVars.toolTable[#kVars.toolTable] and table.find(kVars.toolTable, currentTool) then
					kVars.rs.Events.Server:InvokeServer("PurchaseTool", kVars.toolTable[table.find(kVars.toolTable, currentTool)+1])
				end
            end)
            
        end
    end)
end

sectionBuy:addToggle("Trail", false, function(bool)
    kVars.boolTrail = bool
    if bool then fTrail() end
end)

function fTrail()
    spawn(function()
        while kVars.boolTrail do
            wait()
            pcall(function()
                local curTrail = kVars.lp.TrailEquipped.Value
                if kVars.trailTable[tI] ~= kVars.trailTable[#kVars.trailTable] then
					kVars.rs.Events.TrailPurchase:FireServer(kVars.trailTable[tI+1], kVars.lp)
					kVars.rs.Events.TrailEquip:FireServer(kVars.trailTable[tI+1], kVars.lp)
				end
            end)
        end
    end)
end



sectionBuy:addToggle("Gem Multi", false, function(bool)
    kVars.boolGemMulti = bool
    if bool then fGemMulti() end
end)

function fGemMulti()
    spawn(function()
        while kVars.boolGemMulti do
            wait()
            pcall(function()
                if kVars.lp.GemUpgrade.Value ~= 10 then
                    kVars.rs.Events.Upgrade:FireServer("GemUpgrade", "Coins", kVars.lp)
                end
            end)
        end
    end)
end

sectionBuy:addToggle("XP Multi", false, function(bool)
    kVars.boolXPMulti = bool
    if bool then fXPMulti() end
end)

function fXPMulti()
    spawn(function()
        while kVars.boolXPMulti do
            wait()
            pcall(function()
                if kVars.lp.ExpUpgrade.Value ~= 10 then
                    kVars.rs.Events.Upgrade:FireServer("ExpUpgrade", "Gems", kVars.lp)
                end
            end)
        end
    end)
end

sectionBuy:addToggle("Food Multi", false, function(bool)
    kVars.boolFoodMulti = bool
    if bool then fFoodMulti() end
end)

function fFoodMulti()
    spawn(function()
        while kVars.boolFoodMulti do
            wait()
            pcall(function()
                if kVars.lp.FruitUpgrade ~= 10 then
                    kVars.rs.Events.Upgrade:FireServer("FruitUpgrade", "Gems", kVars.lp)
                end
            end)
        end
    end)
end

---- section eggs ----
kVars.SelectedEgg = "CommonEgg"
kVars.eggsTable = {"CommonEgg", "UncommonEgg", "RareEgg", "IceEgg", "IdolEgg", "BallEgg", "IceCream", "FlameEgg", "RocketEgg", "GourmetEgg", "ZombieEgg", "ScoutEgg", "FabergeEgg", "5M EGG"}
sectionEggs:addDropdown("Select and Egg",kVars.eggsTable,function(value)
    kVars.selectedEgg = value
end)

sectionEggs:addToggle("Open Egg", false, function(bool)
    kVars.boolOpenEgg = bool
    if bool then fOpenEgg() end
end)

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            pcall(function()
                kVars.rs.Events.Egg:FireServer("OpenEgg",{kVars.SelectedEgg})
            end)
        end
    end)
end

---- section pets ----
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
sectionPets:addDropdown("Select a Pet To Delete",kVars.petTable,function(value)
    kVars.DelSelPet[1] = value
end)
sectionPets:addDropdown("Select a Pet To Delete",kVars.petTable,function(value)
    kVars.DelSelPet[2] = value
end)
sectionPets:addDropdown("Select a Pet To Delete",kVars.petTable,function(value)
    kVars.DelSelPet[3] = value
end)
sectionPets:addDropdown("Select a Pet To Delete",kVars.petTable,function(value)
    kVars.DelSelPet[4] = value
end)

sectionPets:addToggle("Delete", false, function(bool)
    kVars.boolDelPet = bool
    if bool then fDelPet() end
end)

function fDelPet()
    spawn(function()
        while kVars.boolDelPet do
            wait()
            pcall(function()
                for g,h in pairs(kVars.DelSelPet) do
                    if h ~= "NONE" then
                        for i,v in pairs(kVars.lp.Pets:getChildren()) do
                            if v.PetName.Value == h then
                                game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeletePet", {kVars.lp.Pets:FindFirstChild(tostring(v))})
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
for i,v in pairs(game:GetService("ReplicatedStorage").Crates:GetChildren()) do
    table.insert(kVars.crateTable,v.name)
end
table.sort(kVars.crateTable)
kVars.selectedCrate = "CommonCrate"
sectionCrates:addDropdown("Select a crate to open",kVars.crateTable,function(value)
    kVars.selectedCrate = value
end)

sectionCrates:addToggle("Open", false, function(bool)
    kVars.boolOpenCrate = bool
    if bool then fOpenCrate() end
end)

function fOpenCrate()
    spawn(function()
        while kVars.boolOpenCrate do
            wait()
            pcall(function()
                kVars.rs.Events.Crate:FireServer("OpenCrate",{kVars.selectedCrate})
            end)
        end
    end)
end

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

sectionDelHats:addDropdown("Select a hat",kVars.hatsTable,function(value)
    kVars.DelSelHat[1] = value
end)
sectionDelHats:addDropdown("Select a hat",kVars.hatsTable,function(value)
    kVars.DelSelHat[2] = value
end)
sectionDelHats:addDropdown("Select a hat",kVars.hatsTable,function(value)
    kVars.DelSelHat[3] = value
end)
sectionDelHats:addDropdown("Select a hat",kVars.hatsTable,function(value)
    kVars.DelSelHat[4] = value
end)

sectionDelHats:addToggle("Delete", false, function(bool)
    kVars.boolDelHat = bool
    if bool then fDelHat() end
end)

function fDelHat()
    spawn(function()
        while kVars.boolDelHat do
            wait()
            pcall(function()
                for g,h in pairs(kVars.DelSelHat) do
                    if h ~= "NONE" then
                        for i,v in pairs(kVars.lp.Hats:getChildren()) do
                            if v.HatName.Value == h then
                                game:GetService("ReplicatedStorage").Events.PetInventory:FireServer("DeleteHat", {kVars.lp.Pets:FindFirstChild(tostring(v))})
                            end
                        end
                    end
                end
            end)
        end
    end)
end





---- player stats section ----
sectionPlayerStats:addSlider("Walk Speed", 16, kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed, 1024, function(value)
    kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed = value
end)

sectionPlayerStats:addSlider("Jump Power", 50, kVars.lp.Character:WaitForChild('Humanoid').JumpPower, 1024, function(value)
    kVars.lp.Character:WaitForChild('Humanoid').JumpPower = value
end)

sectionPlayerStats:addToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

kVars.InfJumpConnect = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump and kVars.lp.Character:FindFirstChild("Humanoid") then
		kVars.lp.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)

---- tp to player section ----
sectionTpToPlayer:addTextbox("PlayerName", "Name", function(value, focusLost)
    if focusLost then
        kVars.teleportToPlayer = value
        print(value)
    end
end)

sectionTpToPlayer:addButton("Teleport", function()
    local cnf = true
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") and kVars.teleportToPlayer ~= nil then
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            local hrp = game:GetService('Players').LocalPlayer.Character:WaitForChild('HumanoidRootPart')
            if string.find(string.lower(v.DisplayName), string.lower(kVars.teleportToPlayer)) then
                hrp.CFrame = v.Character.HumanoidRootPart.CFrame
                cnf = false
            elseif string.find(string.lower(v.Name), string.lower(kVars.teleportToPlayer)) then
                hrp.CFrame = v.Character.HumanoidRootPart.CFrame
                cnf = false
            end
        end
        if cnf == true then
            Window:Notify("Error", "Could not find player.")
        end
    else
        Window:Notify("Error", "You didn't put a valid playername in the textbox.")
    end
end)

---- Theme ----
for theme, color in pairs(kVars.themes) do
    sectionTheme:addColorPicker(theme, color, function(color3)
        Window:setTheme(theme, color3)
    end)
    Window:setTheme(theme, color)
end

sectionTheme:addButton("Save Theme", function()
    saveSettings()
end)

sectionKeybinds:addKeybind("Open/Close Menu", Enum.KeyCode.Backquote, function()
	Window:toggle()
end, function()
end)

---- Select main page to display ----
Window:SelectPage(Window.pages[1], true)

---- Closing ----
kVars.ClosingConnect = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.WindowName then
	    kVars.InfJumpConnect:Disconnect()
        kVars.AntiAfk:Disconnect()
		for i,v in pairs(kVars) do
			if type(v) == "boolean" then
				v = false
			end
		end
        wait(.1)
		kVars.ClosingConnect:Disconnect()
		script:Destroy()
	end
end)

syn.protect_gui(game:GetService("CoreGui")[kVars.WindowName])