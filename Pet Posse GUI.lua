--[[
Game : https://www.roblox.com/games/8303902695
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Pet Posse GUI"
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
local sectionAutoFarm = pageMain:CreateSection("Farm")
local sectionRebirth = pageMain:CreateSection("Rebirth")
local sectionGifts = pageMain:CreateSection("Gifts")
local sectionUnlocks = pageMain:CreateSection("Unlocks")

local pageEggs = Window:CreateCategory("Eggs")
local sectionEggs = pageEggs:CreateSection("Open Eggs")

local pageMenus = Window:CreateCategory("Menus")
local sectionMenus = pageMenus:CreateSection("Menus")

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

--========== page main ==========----
---- Farm ----
kVars.closestCoin = nil
kVars.lastCoin = math.huge
spawn(function()
    while wait() do
        lastCoin = math.huge
        local tmpClosest = nil
        if game:GetService("Workspace")["__THINGS"].Coins:FindFirstChildWhichIsA("Folder") then
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:FindFirstChildWhichIsA("Folder"):GetChildren()) do
                if v ~= nil and v:FindFirstChild("Coin") ~= nil and game:GetService("Workspace")["__THINGS"].Coins:FindFirstChildWhichIsA("Folder")  then
                    local distance = (game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position - v.Coin.Position).magnitude
                    if distance < lastCoin then
                        tmpClosest = v
                        lastCoin = distance
                    end
                end
            end
        end
        kVars.closestCoin = tmpClosest
    end   
end)

kVars.boolAutoFarm = false
sectionAutoFarm:Create("Toggle", "Auto Farm",function(bool)
    kVars.boolAutoFarm = bool
    if bool then
        fAutoFarm()
    end
end,{default = kVars.boolAutoFarm})

function fAutoFarm()
    spawn(function()
        while kVars.boolAutoFarm do
            wait()
            local ccCheck = kVars.closestCoin
            if kVars.closestCoin ~= nil and kVars.closestCoin:FindFirstChild("Coin") then
                if workspace["__THINGS"].Pets[kVars.lp.name]:GetChildren() ~= 0 then
                    for i=1,#workspace["__THINGS"].Pets[kVars.lp.name]:GetChildren() do
                        task.wait(.02)
                        fireclickdetector(kVars.closestCoin.Coin.ClickDetector)
                    end
                end
                repeat
                    wait()
                    pcall(function()
                        if game:GetService("Players").LocalPlayer.PlayerGui.Buttons[kVars.closestCoin.name].Enabled then
                            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.Buttons[kVars.closestCoin.name].Frame.ImageButton.MouseButton1Click)
                        end
                    end) 
                until kVars.boolAutoFarm == false or kVars.closestCoin ~= ccCheck
            end
        end
    end)
end

---- section rebirth ----
kVars.boolRebirth = false
sectionRebirth:Create("Toggle", "Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then
        fRebirth()
    end
end,{default = kVars.boolRebirth})

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            if kVars.lp.PlayerGui.Notifications.Level.Text == "MAX LEVEL!" then
                game:GetService("Workspace").__THINGS.__REMOTES.rebirth:InvokeServer(kVars.lp)
            end
        end
    end)
end

---- section collect gifts ----
kVars.boolGifts = false
sectionGifts:Create("Toggle", "Gifts",function(bool)
    kVars.boolGifts = bool
    if bool then fGifts() end
end,{default = kVars.boolGifts})

function fGifts()
    spawn(function()
        while kVars.boolGifts do
            wait()
            pcall(function()
                for i,v in pairs(game.Players.LocalPlayer.PlayerGui.ExclusiveShop.Frame.Container.Gifts.SmallGifts:GetChildren()) do
                    if v.name == "1" and v.Timer.Time.Text == "Claim" then
                        workspace.__THINGS.__REMOTES.claimGift:InvokeServer("1")
                    elseif v.name == "2" and v.Timer.Time.Text == "Claim" then
                        workspace.__THINGS.__REMOTES.claimGift:InvokeServer("2")
                    elseif v.name == "3" and v.Timer.Time.Text == "Claim" then
                        workspace.__THINGS.__REMOTES.claimGift:InvokeServer("3")
                    elseif v.name == "4" and v.Timer.Time.Text == "Claim" then
                        workspace.__THINGS.__REMOTES.claimGift:InvokeServer("4")
                    end
                end
                if game.Players.LocalPlayer.PlayerGui.ExclusiveShop.Frame.Container.Gifts.BigGift[5].Timer.Time.Text == "Claim" then
                    workspace.__THINGS.__REMOTES.claimGift:InvokeServer("5")
                end
            end)
        end
    end)
end

---- section unlocks ----
sectionUnlocks:Create("Button", "Teleport", function()
    game:GetService("Players").LocalPlayer.Leaderstats.teleport.Value = true
end,{animated = true})

sectionUnlocks:Create("Button", "Triple Egg", function()
    game:GetService("Players").LocalPlayer.Leaderstats.tripleEggs.Value = true
end,{animated = true})

sectionUnlocks:Create("Button", "Fast Hatch", function()
    game:GetService("Players").LocalPlayer.Leaderstats.fastHatch.Value = true
end,{animated = true})

sectionUnlocks:Create("Button", "Auto Hatch", function()
    game:GetService("Players").LocalPlayer.Leaderstats.autoHatch.Value = true
end,{animated = true})

--========== page eggs ==========----
---- section open eggs
kVars.eggsList = {}
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Billboards.AutoHatch:GetChildren()) do
    table.insert(kVars.eggsList, v.name)
end
table.sort(kVars.eggsList)

kVars.selectedEgg = kVars.eggsList[1]
sectionEggs:Create("DropDown", "Select and egg to hatch", function(value)
    kVars.selectedEgg = value
end,{options = kVars.eggsList, default = kVars.eggsList[1], search = true})

kVars.boolTripleEgg = false
sectionEggs:Create("Toggle", "Triple Egg",function(bool)
    kVars.boolTripleEgg = bool
end,{default = kVars.boolTripleEgg})

kVars.boolOpenEgg = false
sectionEggs:Create("Toggle", "Open Egg",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            pcall(function()
                if kVars.selectedEgg ~= nil and kVars.boolTripleEgg == false then
                    workspace.__THINGS.__REMOTES.openEgg:InvokeServer(kVars.selectedEgg)
                    workspace.__THINGS.__REMOTES.buyEgg:InvokeServer(kVars.selectedEgg)
                elseif kVars.selectedEgg ~= nil and kVars.boolTripleEgg then
                    workspace.__THINGS.__REMOTES.openEgg:InvokeServer(kVars.selectedEgg)
                    workspace.__THINGS.__REMOTES.buyEgg:InvokeServer(kVars.selectedEgg, "tripleEgg")
                end
            end)
        end
    end)
end

--========== page menus ==========----
---- section menus ----
sectionMenus:Create("Button", "Merchant", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Merchant.Enabled = true
end,{animated = true})

sectionMenus:Create("Button", "Upgrade", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Upgrade.Enabled = true
end,{animated = true})

sectionMenus:Create("Button", "Teleport", function()
    firesignal(game:GetService("Players").LocalPlayer.PlayerGui.Main.Left.Tools.Teleport.MouseButton1Click)
end,{animated = true})

--========== page teleport ==========----
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

--========== page character ==========----
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

--========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.KeypadMinus
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

---- sections options ----
sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

--========== page credits ==========----
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

--========== delete script if re-injecting ==========----

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
        script:Remove()
        kVars.cR:Disconnect()
    end
end)