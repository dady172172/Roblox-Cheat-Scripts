--[[
Game : https://www.roblox.com/games/6961712970
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--


kVars = {}
kVars.WindowName = "Shoe Simulator! GUI"
kVars.placeID = 6961712970
kVars.lp = game:GetService("Players").LocalPlayer
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

---- check for correct game ----
if kVars.placeID ~= game.PlaceId then 
    warn("#### - This Script is not for this game. - ####")
    script:Destroy()
    return 
end

---- antiAFK ----
kVars.connectAntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.vu:CaptureController()
    kVars.vu:ClickButton2(Vector2.new())
 end)

local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageEggPet = MainUI.AddPage("Egg/Pet")
local pageTeleport = MainUI.AddPage("Teleport")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
pageFarm.AddToggle("Click", false, function(bool)
    kVars.boolClick = bool
    if bool then fClick() end
end)

function fClick()
    spawn(function()
        while kVars.boolClick do
            wait()
            game:GetService("Players").LocalPlayer.Character.Shoes.PutShoe:FireServer()
        end
    end)
end

pageFarm.AddToggle("Sell", false, function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)

function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
            game:GetService("ReplicatedStorage").Remote.Sell:FireServer()
        end
    end)
end

pageFarm.AddToggle("Coins", false, function(bool)
    kVars.boolCoins = bool
    if bool then fCoins() end
end)

function fCoins()
    spawn(function()
        while kVars.boolCoins do
            wait()
            for i,v in pairs(game:GetService("Workspace").Boosts:GetChildren()) do
                wait()
                if kVars.boolCoins == false then return end
                local pos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                if v:IsA("Model") and v:FindFirstChild("Primary") then
                    v.Primary.Position = pos
                elseif v:IsA("MeshPart") then
                    v.Position = pos
                end
            end
        end
    end)
end


pageFarm.AddButton("Unlock Islands", function()
    for i,v in pairs(game:GetService("Workspace").Islands:GetChildren()) do
        game:GetService("ReplicatedStorage").Remote.PlayerEvent:FireServer("UnlockIsland",workspace.Islands[v.Name].UnlockPart)
        wait(.1)
    end
end)

---------- Egg/Pet Page ----------
kVars.eggList = {
    "Basic Egg", --500
    "Rare Egg", --5k
    "Flamming Egg", --25k
    "Nightmare Egg", --100k
    "Candy Egg", --10k
    "Steampunk Egg", --25k
    "Pirate Egg", --50k
    "Tech Egg", --100k
    "Space Egg", --idk
    "Secret Egg", --1M
    "Lava Egg",
    "Royal Egg",
    "Dark Egg",
    "Void Egg"
}

pageEggPet.AddDropdown("Select Egg To Open", kVars.eggList, function(Value)
    kVars.petToOpen = Value
end)

pageEggPet.AddToggle("Open", false, function(bool)
    kVars.boolOpen = bool
    if bool then fOpenEgg() end
end)

function fOpenEgg()
    spawn(function()
        while kVars.boolOpen do
            wait()
            if kVars.petToOpen ~= nil then
                game:GetService("ReplicatedStorage").Remote._PurchaseEgg:InvokeServer(kVars.petToOpen)
            end
        end
    end)
end

---------- Teleport Page ----------
local locations = {
    {name = "Spawn", cf = CFrame.new(97, 92, 70)},
    {name = "Candy", cf = CFrame.new(113, 1095, -96)},
    {name = "Steampunk", cf = CFrame.new(130, 6067, -43)},
    {name = "Pirate", cf = CFrame.new(117, 26137, -120)},
    {name = "Tech", cf = CFrame.new(75, 56134, -67)},
    {name = "Space", cf = CFrame.new(116, 106123, -81)},
    {name = "Void", cf = CFrame.new(1276, 426, 763)},
    {name = "Secret", cf = CFrame.new(-1110, 150, 50)}
}
for i,v in ipairs(locations) do
    pageTeleport.AddButton(v.name, function()
        kVars.lp.Character.HumanoidRootPart.CFrame = v.cf
    end)
end

---------- Character Page ----------
kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 2000, Def = kVars.lp.Character.Humanoid.WalkSpeed}, function(num)
    kVars.lp.Character.Humanoid.WalkSpeed = num
end)

kVars.sliderJumpPower = pageCharacter.AddSlider("Jump Power",  {Min = 16, Max = 2000, Def = kVars.lp.Character.Humanoid.JumpPower}, function(num)
    kVars.lp.Character.Humanoid.JumpPower = num
end)

kVars.sliderInfJump = pageCharacter.AddToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump and kVars.lp.Character:FindFirstChild("Humanoid") then
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
local FirstDropdown = FirstPage.AddDropdown("Hello", {}, function(Value)
    print(Value)
end)
]]--