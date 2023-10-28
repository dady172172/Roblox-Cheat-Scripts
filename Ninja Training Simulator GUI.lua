--[[
Game : https://www.roblox.com/games/9397663086
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Ninja Training Simulator GUI"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')

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
local sectionUpgrades = pageMain:CreateSection("Upgrades")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")
local sectionLocations = pageTeleport:CreateSection("Locations")

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
kVars.boolClick = false
sectionFarm:Create("Toggle", "Click",function(bool)
    kVars.boolClick = bool
    if bool then
        fClick()
        game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Bottom.Auto.Enabled.Value = true
    else
        game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Bottom.Auto.Enabled.Value = false
    end
end,{default = kVars.boolClick})

function fClick()
    spawn(function()
        while kVars.boolClick do
            wait()
                game:GetService("ReplicatedStorage").Events.Click:FireServer()
        end
    end)
end

sectionFarm:Create("Button", "Open Auto Rebirth", function()
    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.AutoRebirthsFrame.Visible = true
    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.AutoRebirthsFrame:TweenSize(UDim2.new(0.253, 0, 0.599), "Out", "Quad", 0.05, true)
end,{animated = true})

sectionFarm:Create("Button", "Open Teleport", function()
    local a = game:GetService("Players").keathunsar.PlayerGui.MainUI.Boosts
    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.TeleportFrame.Visible = true
    game:GetService("Players").LocalPlayer.PlayerGui.MainUI.TeleportFrame:TweenSize(UDim2.new(0.253, 0, 0.599), "Out", "Quad", 0.05, true)
end,{animated = true})

sectionFarm:Create("Button", "Walk on Woda. lol", function()
    if game:GetService("Workspace").Woda:FindFirstChild("TouchInterest") then
        game:GetService("Workspace").Woda.TouchInterest:Destroy()
        game:GetService("Workspace").Woda.CanCollide = true
    end
end,{animated = true})



---- section upgrades ----
sectionUpgrades:Create("Toggle", "Master",function(bool)
    kVars.boolMaster = bool
    if bool then
        fMaster()
    end
end,{default = kVars.boolMaster})

function fMaster()
    spawn(function()
        while kVars.boolMaster do
            wait()
            game:GetService("ReplicatedStorage").Functions.Masters:InvokeServer()
        end
    end)
end

kVars.boolRank = false
sectionUpgrades:Create("Toggle", "Rank",function(bool)
    kVars.boolRank = bool
    if bool then
        fRank()
    end
end,{default = kVars.boolRank})

function fRank()
    spawn(function()
        while kVars.boolRank do
            wait()
            game:GetService("ReplicatedStorage").Functions.Rank:InvokeServer(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.GameShopFrame.Ranks.Value + 1)
        end
    end)
end


kVars.boolGem = false
sectionUpgrades:Create("Toggle", "Gem",function(bool)
    kVars.boolGem = bool
    if bool then
        fGem()
    end
end,{default = kVars.boolGem})

function fGem()
    spawn(function()
        while kVars.boolGem do
            wait()
            game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Gems")
        end
    end)
end

kVars.boolPower = false
sectionUpgrades:Create("Toggle", "Power",function(bool)
    kVars.boolPower = bool
    if bool then
        fPower()
    end
end,{default = kVars.boolPower})

function fPower()
    spawn(function()
        while kVars.boolPower do
            wait()
            game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Power")
        end
    end)
end

kVars.boolPetEquip = false
sectionUpgrades:Create("Toggle", "Pet Equip",function(bool)
    kVars.boolPetEquip = bool
    if bool then
        fPetEquip()
    end
end,{default = kVars.boolPetEquip})

function fPetEquip()
    spawn(function()
        while kVars.boolPetEquip do
            wait()
            game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("PetEquip")
        end
    end)
end

kVars.boolPetStorage = false
sectionUpgrades:Create("Toggle", "Pet Storage",function(bool)
    kVars.boolPetStorage = bool
    if bool then
        fPetStorage()
    end
end,{default = kVars.boolPetStorage})

function fPetStorage()
    spawn(function()
        while kVars.boolPetStorage do
            wait()
            game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("PetStorage")
        end
    end)
end

kVars.boolLuck = false
sectionUpgrades:Create("Toggle", "Luck Multiplier",function(bool)
    kVars.boolLuck = bool
    if bool then
        fLuck()
    end
end,{default = kVars.boolLuck})

function fLuck()
    spawn(function()
        while kVars.boolLuck do
            wait()
            game:GetService("ReplicatedStorage").Functions.Upgrade:InvokeServer("Luck")
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

---- section locations ----
kVars.locations = {
    [1] = "Spawn",
    [2] = "Ocean",
    [3] = "Volcano",
    [4] = "Forest",
    [5] = "Candy",
    [6] = "Cyber",
    [7] = "Desert"
}

for i,v in ipairs(kVars.locations) do
    sectionLocations:Create("Button", v, function()
        game:GetService("ReplicatedStorage").Events.Teleport:FireServer("Teleport",v)
    end,{animated = true})
end


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
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpPower = kVars.jumpPower
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

sectionWorld:Create("Toggle", "Blur",function(bool)
    game:GetService("Lighting").Blur.Enabled = bool
end,{default = game:GetService("Lighting").Blur.Enabled})

---- sections options ----
sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

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