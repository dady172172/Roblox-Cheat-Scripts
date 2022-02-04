--[[
Game : https://www.roblox.com/games/4535346003
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--
---- antiAFK ----
if game:GetService("Players").LocalPlayer.PlayerScripts:FindFirstChild("AFKDetector") then
    game:GetService("Players").LocalPlayer.PlayerScripts.AFKDetector:Destroy()
    game.ReplicatedStorage.IsAFK:FireServer(false)
end

kVars = {}
kVars.WindowName = "Wing Simulator GUI"
kVars.lp = game:GetService("Players").LocalPlayer
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageTeleport = MainUI.AddPage("Teleport")
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
            game:GetService("ReplicatedStorage").Events.Click:FireServer(1)
        end
    end)
end


kVars.toggleSell = pageFarm.AddToggle("Sell *Stand near sell spot", false, function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)
kVars.SellAreas = {
    workspace.Map.Areas:FindFirstChild("Wing Land"):FindFirstChild("Main Land").Stores.Sellers.Normal,
    workspace.Map.Areas:FindFirstChild("Wing Land"):FindFirstChild("Space Island").Seller.OnePointSix,
    workspace.Map.Areas:FindFirstChild("Wing Land"):FindFirstChild("Ruins Island").Seller.Double,
    workspace.Map.Areas:FindFirstChild("Wing Land"):FindFirstChild("Heavenly Island").Seller.FiftyPerc
}
function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
            local last = math.huge
            local sellArea = nil
            for _,s in pairs(kVars.SellAreas) do
                local distance = (kVars.lp.Character.HumanoidRootPart.Position - s:FindFirstChild("SellRing").Position).magnitude
                if distance < last then
                    last = distance
                    sellArea = s
                end
            end
            game:GetService("ReplicatedStorage").Events.SellFeathers:FireServer(sellArea)
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
            for i,v in pairs(game:GetService("Workspace").Pickups:GetChildren()) do
                if kVars.boolCoins == false then return end
                wait()
                if v:IsA("MeshPart") then
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                elseif v:FindFirstChildWhichIsA("MeshPart") then
                    wait()
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChildWhichIsA("MeshPart").CFrame
                end
            end
        end
    end)
end

---------- Teleport Page ----------
local locations = {
    {name = "Spawn", cf = game:GetService("Workspace").Map.SpawnLocation.CFrame},
    {name = "Ruins", cf = game:GetService("Workspace").Map.Areas["Wing Land"]["Ruins Island"].TeleportPoint.CFrame},
    {name = "Cloud", cf = game:GetService("Workspace").Map.Areas["Wing Land"]["Cloud Island"].TeleportPoint.CFrame},
    {name = "Rainbow", cf = game:GetService("Workspace").Map.Areas["Wing Land"]["Rainbow Island"].TeleportPoint.CFrame},
    {name = "Heavenly", cf = game:GetService("Workspace").Map.Areas["Wing Land"]["Heavenly Island"].TeleportPoint.CFrame},
    {name = "Space", cf = game:GetService("Workspace").Map.Areas["Wing Land"]["Space Island"].TeleportPoint.CFrame},
    {name = "Cosmic", cf = game:GetService("Workspace").Map.Areas["Wing Land"]["Cosmic Island"].TeleportPoint.CFrame},
    {name = "Buy1", cf = CFrame.new(447, 66, 92)},
    {name = "Buy2", cf = CFrame.new(281, 4500, -187)},
    {name = "Best Sell Pad", cf = CFrame.new(-81, 6693, 162)}
}
for i,v in ipairs(locations) do
    pageTeleport.AddButton(v.name, function()
        kVars.lp.Character.HumanoidRootPart.CFrame = v.cf
    end)
end


---------- Character Page ----------
kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.WalkSpeed}, function(num)
    kVars.lp.Character.Humanoid.WalkSpeed = num
end)

kVars.sliderJumpPower = pageCharacter.AddSlider("Jump Power",  {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.JumpPower}, function(num)
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
local FirstDropdown = FirstPage.AddDropdown("Hello", {
"Hello",
"Goodbye"
}, function(Value)
print(Value)
end)
]]--