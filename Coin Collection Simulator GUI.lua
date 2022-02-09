--[[
Game : https://www.roblox.com/games/5093293793
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = "Coin Collection Simulator GUI"
kVars.lp = game:GetService("Players").LocalPlayer
kVars.VirtualUser = game:GetService('VirtualUser')

---- if re-injecting script, we wait for the old one to close and turn all option off
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    wait(.15)
end

---- antiAFK ----
kVars.AntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.VirtualUser:CaptureController()
    kVars.VirtualUser:ClickButton2(Vector2.new())
end)

---- GUI Library ----
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

---- pages ----
local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageTeleport = MainUI.AddPage("Teleport")
local pageEggsPets = MainUI.AddPage("Eggs/Pets")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
----  ----
kVars.toggleCoins = pageFarm.AddToggle("Collect Coins", false, function(bool)
    kVars.boolCoins = bool
    if bool then fCoins() end
end)

function fCoins()
    spawn(function()
        while kVars.boolCoins do
            wait()
            for i,v in pairs(game:GetService("Workspace").AllCoins:FindFirstChildWhichIsA("Model"):GetChildren()) do
                if v:FindFirstChild("Coin") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Coin, 0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Coin, 1)
                end
            end
        end
    end)
end

kVars.toggleClickCoin = pageFarm.AddToggle("Click Coin", false, function(bool)
    kVars.boolClickCoin = bool
    if bool then fClickCoin() end
end)

function fClickCoin()
    spawn(function()
        while kVars.boolClickCoin do
            wait()
            if kVars.lp.Character:FindFirstChildWhichIsA("Tool") then
                kVars.VirtualUser:CaptureController()
                kVars.VirtualUser:ClickButton1(Vector2.new())
            else
                keypress(0x31)
            end
        end
    end)
end

---------- EggsPets Page ----------
kVars.eggslist = {
    [1] = "StarterCage",
    [2] = "DesertCage",
    [3] = "SnowCage",
    [4] = "CityCage",
    [5] = "LavaCage",
    [6] = "OceanCage",
    [7] = "CandyCage",
    [8] = "JungleCage",
    [9] = "SpaceCage"
}
kVars.cageSelection = kVars.eggslist[1]
pageEggsPets.AddDropdown("Select a cage to open", kVars.eggslist, function(Value)
    kVars.cageSelection = Value
end)

kVars.toggleEggsOpen = pageEggsPets.AddToggle("Open", false, function(bool)
    kVars.boolEggsOpen = bool
    if bool then fEggsOpen() end
end)

function fEggsOpen()
    spawn(function()
        while kVars.boolEggsOpen do
            wait()
            if kVars.cageSelection ~= nil then
                game:GetService("Workspace").petInfo:InvokeServer(kVars.cageSelection)
            end
        end
    end)
end

kVars.toggleSacrifice = pageFarm.AddToggle("Sacrifice", false, function(bool)
    kVars.boolSacrifice = bool
    if bool then fSacrifice() end
end)

function fSacrifice()
    spawn(function()
        while kVars.boolSacrifice do
            wait()
            game:GetService("ReplicatedStorage").SacrificeMoney:FireServer(0)
        end
    end)
end



---------- Teleport Page ----------
kVars.locations = {
    {name = "Spawn", cf = CFrame.new(-425, 8, -578)},
    {name = "Starter", cf = CFrame.new(-39, 8, -569)},
    {name = "Desert", cf = CFrame.new(295, 8, -567)},
    {name = "Snow", cf = CFrame.new(724, 7, -567)},
    {name = "City", cf = CFrame.new(1077, 7, -567)},
    {name = "Lava", cf = CFrame.new(1464, 8, -567)},
    {name = "Ocean", cf = CFrame.new(1854, 8, -564)},
    {name = "Candy", cf = CFrame.new(2205, 8, -563)},
    {name = "Jungle", cf = CFrame.new(2593, 8, -572)},
    {name = "Space", cf = CFrame.new(2934, 8, -569)}
}

for i,v in ipairs(kVars.locations) do
    pageTeleport.AddButton(v.name, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.cf
    end)
end

---------- Character Page ----------
---- Walk Speed ----
kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.WalkSpeed}, function(num)
    kVars.WalkSpeed = num
end)

---- Jump Power ----
kVars.sliderJumpPower = pageCharacter.AddSlider("Jump Power",  {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.JumpPower}, function(num)
    kVars.JumpPower = num
end)

spawn(function()
    while wait() do
        if kVars.lp.Character:FindFirstChild("Humanoid") then
            if kVars.WalkSpeed ~= nil then
                wait()
                kVars.lp.Character.Humanoid.WalkSpeed = kVars.WalkSpeed
            end
            if kVars.JumpPower ~= nil then
                wait()
                kVars.lp.Character.Humanoid.JumpPower = kVars.JumpPower
            end
        end
    end
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



--[[
---- label ----    
local FirstLabel = FirstPage.AddLabel("Section 1")

---- button ----
local FirstButton = FirstPage.AddButton("Hello", function()
    print("Hello")
end)

---- toggle ----
local FirstToggle = FirstPage.AddToggle("Hello", false, function(Value)
    print(Value)
end)

---- Slider ----
local FirstSlider = FirstPage.AddSlider("Hello", {Min = 0, Max = 255, Def = 50}, function(Value)
    print(Value)
end)

---- color picker ----
local FirstPicker = FirstPage.AddColourPicker("Hello", "white", function(Value)
    print(Value)
end)

---- dropdown ----
local FirstDropdown = FirstPage.AddDropdown("Hello", {}, function(Value)
    print(Value)
end)
]]--