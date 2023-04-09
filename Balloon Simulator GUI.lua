local SocialService = game:GetService("SocialService")
--[[
Game : https://www.roblox.com/games/2756231960
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = "Balloon Simulator GUI"
kVars.lp = game:GetService("Players").LocalPlayer or game:GetService("Players"):WaitForChild("LocalPlayer")
kVars.hrp = kVars.lp.Character:FindFirstChild("HumanoidRootPart") or kVars.lp:WaitForChild("Character"):WaitForChild("HumanoidRootPart")
kVars.VirtualUser = game:service('VirtualUser')
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
local pageEggPet = MainUI.AddPage("Egg/Pet")
local pageTeleport = MainUI.AddPage("Teleport")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
----  ----
kVars.toggleBalloons = pageFarm.AddToggle("Balloons", false, function(bool)
    kVars.boolBalloons = bool
    if bool then fBalloons() end
end)

function fBalloons()
    spawn(function()
        while kVars.boolBalloons do
            wait()
            game:GetService("ReplicatedStorage").FillBalloon:FireServer()
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
            game:GetService("ReplicatedStorage").Sell:FireServer(game:GetService("Workspace").UITriggers.Sell2)
        end
    end)
end

kVars.toggleCoins = pageFarm.AddToggle("Coins", false, function(bool)
    kVars.boolCoins = bool
    if bool then fCoins() end
end)

function fCoins()
    spawn(function()
        while kVars.boolCoins do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins:GetChildren()) do
                if kVars.boolCoins == false then return end
                if kVars.lp.Character:FindFirstChild("HumanoidRootPart") and kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
            end
        end
    end)
end

kVars.toggleGems = pageFarm.AddToggle("Gems", false, function(bool)
    kVars.boolGems = bool
    if bool then fGems() end
end)

function fGems()
    spawn(function()
        while kVars.boolGems do
            wait()
            for i,v in pairs(game:GetService("Workspace").Gems:GetChildren()) do
                if kVars.boolGems == false then return end
                if kVars.lp.Character:FindFirstChild("HumanoidRootPart") and kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
            end
        end
    end)
end


kVars.toggleTooths = pageFarm.AddToggle("Teeth", false, function(bool)
    kVars.boolTooths = bool
    if bool then fTooths() end
end)

function fTooths()
    spawn(function()
        while kVars.boolTooths do
            wait()
            for i,v in pairs(game:GetService("Workspace").Tooths:GetChildren()) do
                if kVars.boolTooths == false then return end
                if kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
            end
        end
    end)
end

kVars.toggleChest = pageFarm.AddToggle("Chests", false, function(bool)
    kVars.boolChests = bool
    if bool then fChests() end
end)

function fChests()
    spawn(function()
        while kVars.boolChests do
            wait()
            for i,v in pairs(game:GetService("Workspace").Chests:GetChildren()) do
                if v.Transparency ~= 0.9 and kVars.lp.Character:FindFirstChild("HumanoidRootPart") and kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
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
            wait()
            local coins = kVars.lp.leaderstats.Coins.Value
            local rebirths = kVars.lp.leaderstats.Rebirths.Value
            if rebirths == nil or rebirths == 0 then
                rebirths = 0
            else
                rebirths =  25000000 *  kVars.lp.leaderstats.Rebirths.Value
            end
            if coins >= rebirths and kVars.lp.Character:FindFirstChild("Humanoid") then
                if not kVars.lp.UnlockedIslandsFolder:FindFirstChild("Roboland") and kVars.lp.Character:FindFirstChild("HumanoidRootPart") then
                    kVars.hrp.CFrame = CFrame.new(218, 63363, 2001)
                end
                game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
                wait(.2)
                kVars.lp = game:GetService("Players").LocalPlayer
                kVars.hrp = kVars.lp.Character.HumanoidRootPart
            end
        end
    end)
end
---------- Buy Page ----------
kVars.HeliumTable = {"Normal", "Stretchy", "Very Stretchy", "Quiet", "Loud", "Cool", "Epic", "Super", "Super Duper", "Unreal", "Legendary", "Mythical", "Heroic", "Godly", "Out of This World", "Extraterrestrial", "Experimental", "Radioactive", "Nuclear", "Futuristic", "Quantum", "Bubblegum", "Toy", "Formal", "Almighty", "XTREME", "Olympian", "Hades", "Poseidon", "Zeus"}
kVars.toggleHelium = pageBuy.AddToggle("Helium", false, function(bool)
    kVars.boolHelium = bool
    if bool then fHelium() end
end)

function fHelium()
    spawn(function()
        while kVars.boolHelium do
            wait()
            if kVars.lp:FindFirstChild("CurrentHelium") and kVars.lp:FindFirstChild("CurrentHelium").Value ~= "Zeus" then
                for i,v in pairs(kVars.HeliumTable) do
                    if v == kVars.lp:FindFirstChild("CurrentHelium").Value then
                        if tonumber(game:GetService("ReplicatedStorage").HeliumStats.HeliumPrice:FindFirstChild(kVars.HeliumTable[i + 1]).Value) <= tonumber(kVars.lp.leaderstats.Coins.Value) then
                            game:GetService("ReplicatedStorage").BuyHelium:InvokeServer(kVars.HeliumTable[i + 1])
                            game:GetService("ReplicatedStorage").EquipHelium:FireServer(kVars.HeliumTable[i + 1])
                            break
                        end
                    end
                end
            end                        
        end
    end)
end

kVars.BalloonTable = {"Red", "Blue", "Pink", "Yellow", "Green", "Black", "White", "PinkPolkaDots", "Black and White", "Rainbow", "Birthday", "Venom", "Aquatic", "Radioactive", "Alien", "Lava", "Galaxy", "Ruby", "Sapphire", "Emerald", "MLG", "Angelic", "Demonic", "Gumball", "Teddy Bear", "Toy", "Plasma", "Star", "X-Ray", "VOID"}
kVars.toggleBuyBalloons = pageBuy.AddToggle("Balloons", false, function(bool)
    kVars.boolBuyBalloons = bool
    if bool then fBuyBalloons() end
end)

function fBuyBalloons()
    spawn(function()
        while kVars.boolBuyBalloons do
            wait()
            if kVars.lp:FindFirstChild("CurrentBalloon") and kVars.lp:FindFirstChild("CurrentBalloon").Value ~= "VOID" then
                for i,v in pairs(kVars.BalloonTable) do
                    if v == kVars.lp:FindFirstChild("CurrentBalloon").Value  then
                        if tonumber(game:GetService("ReplicatedStorage").BalloonStats.BalloonPrice:FindFirstChild(kVars.BalloonTable[i + 1]).Value) <= tonumber(kVars.lp.leaderstats.Coins.Value) then
                            game:GetService("ReplicatedStorage").BuyBalloon:InvokeServer(kVars.BalloonTable[i + 1])
                            game:GetService("ReplicatedStorage").EquipBalloon:FireServer(kVars.BalloonTable[i + 1])
                            break
                        end
                    end
                end
            end
        end
    end)
end

---------- Egg Pet Page ----------
kVars.EggsList = {}
for i,v in pairs(game:GetService("Workspace").PetDispensers:GetChildren()) do
    table.insert(kVars.EggsList, v.Name)
end
table.sort(kVars.EggsList)
kVars.SelectedEgg = game:GetService('Workspace').PetDispensers.Common
kVars.dropdownEggToOpen = pageEggPet.AddDropdown("Select and egg to open", kVars.EggsList, function(Value)
    kVars.SelectedEgg = game:GetService("Workspace").PetDispensers[Value]
end)



kVars.EggsToOpen = 1
kVars.toggleOpen3 = pageEggPet.AddToggle("Open 3 *Must have bought", false, function(bool)
    kVars.boolOpen3 = bool
    if bool then
        kVars.EggsToOpen = 3
    else
        kVars.EggsToOpen = 1
    end
end)

kVars.toggleOpenEgg = pageEggPet.AddToggle("Open", false, function(bool)
    kVars.boolOpenEgg = bool
    if bool then fOpenEgg() end
end)

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            game:GetService("ReplicatedStorage").PurchasePetFunction:InvokeServer(kVars.SelectedEgg, kVars.EggsToOpen)
        end
    end)
end


pageEggPet.AddLabel("Delete Pets Section")

kVars.petList = {}
for i,v in pairs(game:GetService("ReplicatedStorage").PetImages:GetChildren()) do
    table.insert(kVars.petList, v.Name)
end
table.sort(kVars.petList)

kVars.dropdownPetDelete1 = pageEggPet.AddDropdown("Select a pet to auto delete", kVars.petList, function(Value)
    kVars.SelectedPet1 = Value
end)
kVars.dropdownPetDelete2 = pageEggPet.AddDropdown("Select a pet to auto delete", kVars.petList, function(Value)
    kVars.SelectedPet2 = Value
end)
kVars.dropdownPetDelete3 = pageEggPet.AddDropdown("Select a pet to auto delete", kVars.petList, function(Value)
    kVars.SelectedPet3 = Value
end)
kVars.dropdownPetDelete4 = pageEggPet.AddDropdown("Select a pet to auto delete", kVars.petList, function(Value)
    kVars.SelectedPet4 = Value
end)
kVars.dropdownPetDelete5 = pageEggPet.AddDropdown("Select a pet to auto delete", kVars.EggsList, function(Value)
    kVars.SelectedPet5 = Value
end)

kVars.toggleDeletePet = pageEggPet.AddToggle("Delete", false, function(bool)
    kVars.boolDeletePet = bool
    if bool then fDeletePet() end
end)

function fDeletePet()
    spawn(function()
        while kVars.boolDeletePet do
            wait()
            for i,v in pairs(game:GetService("Players").LocalPlayer.OwnedPets:GetChildren()) do
                if v.Name == kVars.SelectedPet1 or v.Name == kVars.SelectedPet2 or v.Name == kVars.SelectedPet3 or v.Name == kVars.SelectedPet4 or v.Name == kVars.SelectedPet5 then
                    game:GetService("ReplicatedStorage").DeletePet:FireServer(v)
                end
            end
        end
    end)
end

---------- Teleport Page ----------
kVars.Locations1 = {
   [1] = {name = "Spawn", cf = game:GetService("Workspace").NewThing.SpawnLocation.CFrame},
   [2] = {name = "Tropical Paradise", cf = CFrame.new(192, 974, 1705)},
   [3] = {name = "Ancient Greece", cf = CFrame.new(33, 3280, 1701)},
   [4] = {name = "CandyLand", cf = CFrame.new(90, 8062, 1696)},
   [5] = {name = "Archerville", cf = CFrame.new(74, 13968, 1498)},
   [6] = {name = "Toyland", cf = CFrame.new(193, 22661, 1762)},
   [7] = {name = "Alienland", cf = CFrame.new(177, 40996, 1944)},
   [8] = {name = "Dinoland", cf = CFrame.new(221, 53818, 2020)},
   [9] = {name = "Robloland", cf = CFrame.new(218, 63363, 2001)}
}
kVars.Locations2 = {
    [1] = {name = "Aquaworld", cf = CFrame.new(-2329, -1413, 199)},
    [2] = {name = "Aqualand", cf = CFrame.new(-2349, 1594, 57)},
    [3] = {name = "Dragonworld", cf = CFrame.new(158, 53, -84)},
    [4] = {name = "Dragonland", cf = CFrame.new(183, 3132, -210)}
}
pageTeleport.AddLabel("Main Islands")
for i,v in ipairs(kVars.Locations1) do
    pageTeleport.AddButton(v.name, function()
        kVars.hrp.CFrame = v.cf
    end)
end
pageTeleport.AddLabel("Special Islands")
for i,v in ipairs(kVars.Locations2) do
    pageTeleport.AddButton(v.name, function()
        kVars.hrp.CFrame = v.cf
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

syn.protect_gui(game:GetService("CoreGui")[kVars.WindowName])