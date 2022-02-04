--[[
Game : https://www.roblox.com/games/5714256147
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--
kVars = {}
kVars.WindowName = "Zombie Simulator GUI"
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageBuy = MainUI.AddPage("Buy")
local pageCharacter = MainUI.AddPage("Character")
local pageCredits = MainUI.AddPage("Credits")

kVars.toggleEat = pageFarm.AddToggle("Eat", false, function(bool)
    kVars.boolEat = bool
    if bool then fEat() end
end)

function fEat()
    spawn(function()
        while kVars.boolEat do
            wait()
            game:GetService("ReplicatedStorage").Events.Eat:FireServer()
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
            game:GetService("ReplicatedStorage").Events.Sell:FireServer()
        end
    end)
end

kVars.toggleBrains = pageBuy.AddToggle("Brains", false, function(bool)
    kVars.boolBrains = bool
    if bool then fBrains() end
end)

function fBrains()
    spawn(function()
        while kVars.boolBrains do
            wait()
            game:GetService("ReplicatedStorage").Events.BuyAllBrain:FireServer()
        end
    end)
end

kVars.toggleStomach = pageBuy.AddToggle("Stomach", false, function(bool)
    kVars.boolStomach = bool
    if bool then fStomach() end
end)

function fStomach()
    spawn(function()
        while kVars.boolStomach do
            wait()
            game:GetService("ReplicatedStorage").Events.BuyAllStorage:FireServer()
        end
    end)
end

kVars.toggleGene = pageBuy.AddToggle("Gene", false, function(bool)
    kVars.boolGene = bool
    if bool then fGene() end
end)

function fGene()
    spawn(function()
        while kVars.boolGene do
            wait()
            game:GetService("ReplicatedStorage").Events.BuyGene:FireServer()
        end
    end)
end

kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 255, Def = game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed}, function(num)
    game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = num
end)

kVars.sliderJumpPower = pageCharacter.AddSlider("Jump Power",  {Min = 16, Max = 255, Def = game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower}, function(num)
    game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = num
end)

kVars.sliderInfJump = pageCharacter.AddToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
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