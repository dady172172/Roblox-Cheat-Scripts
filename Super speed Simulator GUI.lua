--[[
Game : https://www.roblox.com/games/6137522359
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--
kVars = {}
kVars.WindowName = "Super speed Simulator GUI"
kVars.EggsList = {}
kVars.lp = game:GetService("Players").LocalPlayer
for i,v in pairs(game:GetService("Workspace").Map.Eggs:GetChildren()) do
    table.insert(kVars.EggsList,v.Name)
end
table.sort(kVars.EggsList)

local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageOpenEggs = MainUI.AddPage("Eggs/Pets")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
kVars.toggleClick = pageFarm.AddToggle("Click", false, function(bool)
    kVars.boolClick = bool
    if bool then fClick() end
end)

function fClick()
    spawn(function()
        while kVars.boolClick do
            wait()
            game:GetService("ReplicatedStorage").Remotes.Lift:FireServer()
            wait()
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
            if kVars.lp.leaderstats.Energy.Value >= math.floor(2500 + kVars.lp.leaderstats.Rebirths.Value * 7500) then
                game:GetService("ReplicatedStorage").Remotes.Rebirth:InvokeServer()
            end
        end
    end)
end

kVars.toggleReset = pageFarm.AddToggle("Reset", false, function(bool)
    kVars.boolReset = bool
    if bool then fReset() end
end)

function fReset()
    spawn(function()
        while kVars.boolReset do
            wait()
            if kVars.lp.leaderstats.Rebirths.Value >= math.floor(10 + kVars.lp:GetAttribute("TotalTokens") * 10) then
                game:GetService("ReplicatedStorage").Remotes.Reset:InvokeServer()
            end

        end
    end)
end

kVars.toggleOrbs = pageFarm.AddToggle("Orbs", false, function(bool)
    kVars.boolOrbs = bool
    if bool then fOrbs() end
end)

function fOrbs()
    spawn(function()
        while kVars.boolOrbs do
            wait()
            for i,v in pairs(game:GetService("Workspace").Map.Orbs:GetChildren()) do
                if string.find(v.Name, "Orb") and v:FindFirstChild("Main") and v.Main:FindFirstChild("TouchInterest") and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if kVars.boolOrbs == false then return end
                    firetouchinterest(kVars.lp.Character.HumanoidRootPart, v.Main, 0)
                    --wait()
                    firetouchinterest(kVars.lp.Character.HumanoidRootPart, v.Main, 1)
                end
            end
        end
    end)
end

kVars.buttonTPRaceWin = pageFarm.AddButton("Tp Race Win *Still need to walk forward", function()
    kVars.lp.Character.HumanoidRootPart.CFrame = CFrame.new(-625, 8, -82)
end)

---------- Open Eggs Page ----------
kVars.dropdownOpenEgg = pageOpenEggs.AddDropdown("Select Egg Name *Must be near dispenser", kVars.EggsList, function(Value)
    kVars.selectedEggName = Value
end)
kVars.toggleOpenEgg = pageOpenEggs.AddToggle("Open", false, function(bool)
    kVars.boolOpenEgg = bool
    if bool and kVars.selectedEggName ~= nil then fOpenEgg() end
end)

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            if kVars.selectedEggName == nil then return end
            game:GetService("ReplicatedStorage").Remotes.OpenEgg:InvokeServer(kVars.selectedEggName, "Single")
        end
    end)
end

kVars.toggleClickCraftPet = pageOpenEggs.AddToggle("Craft Pets", false, function(bool)
    kVars.boolClickCraftPet = bool
    if bool then fClickCraftPet() end
end)

function fClickCraftPet()
    spawn(function()
        while kVars.boolClickCraftPet do
            wait()
            for i,v in pairs(kVars.lp.Pets:GetChildren()) do
                local PetId = v:GetAttribute("PetId")
                game:GetService("ReplicatedStorage").Remotes.PetActionRequest:InvokeServer("Craft", {["PetId"] = tonumber(PetId)})
            end

--[[
            local PetId = kVars.lp.PlayerGui.Interface.Frames.Pets.Frame.Frames.PetInfo:GetAttribute("PetId")
            if tonumber(PetId) ~= nil then
                game:GetService("ReplicatedStorage").Remotes.PetActionRequest:InvokeServer("Craft", {["PetId"] = tonumber(PetId)})
            end
            ]]--
        end
    end)
end

---------- Character Page ----------
kVars.varWalkSpeed = kVars.lp.Character.Humanoid.WalkSpeed
kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.WalkSpeed}, function(num)
    kVars.varWalkSpeed = num
end)
spawn(function()
    while wait() do
        if kVars.varWalkSpeed ~= nil and kVars.lp.Character:FindFirstChild("Humanoid") then
            kVars.lp.Character.Humanoid.WalkSpeed = kVars.varWalkSpeed
        end
    end
end)

kVars.sliderJumpPower = pageCharacter.AddSlider("Jump Power",  {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.JumpPower}, function(num)
    kVars.lp.Character.Humanoid.JumpPower = num
end)

kVars.sliderInfJump = pageCharacter.AddToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump and game:GetService('Players').LocalPlayer.Character:FindFirstChild("Humanoid") then
		kVars.lp.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)

---------- Credits Page ----------
kVars.labelCodedBy = pageCredits.AddLabel("Coded by : Keathunsar")
kVars.labelCodedByLink = pageCredits.AddLabel("https://github.com/dady172172/Roblox-Cheats")
kVars.labelGuiBy = pageCredits.AddLabel("Gui made by : FungBert")
kVars.labelGuiByLink = pageCredits.AddLabel("v3rmillion.net/member.php?action=profile&uid=1078854")


--[[
local FirstLabel = FirstPage.AddLabel("Section 1")
local FirstButton = FirstPage.AddButton("Hello", function()
    print("Hello")
end)
local FirstToggle = FirstPage.AddToggle("Hello", false, function(Value)
print(Value)
end)
local FirstSlider = FirstPage.AddSlider("Hello", {Min = 0, Max = 255, Def = 50}, function(Value)
print(Value)
end)
local FirstPicker = FirstPage.AddColourPicker("Hello", "white", function(Value)
print(Value)
end)
local FirstDropdown = FirstPage.AddDropdown("Hello", {
"Hello",
"Goodbye"
}, function(Value)
print(Value)
end)
]]--