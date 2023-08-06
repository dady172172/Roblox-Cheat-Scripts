--[[
Game : https://www.roblox.com/games/13275270457
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Merge to Get Rich Tycoon! GUI"
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
sectionFarm:Create("Toggle", "Collect",function(bool)
    kVars.boolCollect = bool
    if bool then
        fCollect()
    end
end,{default = kVars.boolCollect})

function fCollect()
    spawn(function()
        while kVars.boolCollect do
            wait()
            for i,v in pairs(game.workspace.Tycoons[tostring(game:GetService("Workspace").LocalTycoon.Value)].CurrentDrops:GetChildren()) do        
                pcall(function()
                    if v:FindFirstChild("Bound") then
                        firetouchinterest(kVars.hrp, v.Bound, 0)
                        wait()
                        firetouchinterest(kVars.hrp, v.Bound, 1)
                    end
                end)
            end
        end
    end)
end

sectionFarm:Create("Toggle", "Deposit",function(bool)
    kVars.boolDeposit = bool
    if bool then
        fDeposit()
    end
end,{default = kVars.boolDeposit})

function fDeposit()
    spawn(function()
        while kVars.boolDeposit do
            local depositBtn = game.workspace.Tycoons[tostring(game:GetService("Workspace").LocalTycoon.Value)].OtherButtons.Deposit.ActivePart
            wait()
            pcall(function()
                firetouchinterest(kVars.hrp, depositBtn, 0)
                wait()
                firetouchinterest(kVars.hrp, depositBtn, 1)
            end)
        end
    end)
end

sectionFarm:Create("Toggle", "+1 Stack",function(bool)
    kVars.boolStack1 = bool
    if bool then
        fStack1()
    end
end,{default = kVars.boolStack1})

function fStack1()
    spawn(function()
        while kVars.boolStack1 do
            local stack1Btn = game.workspace.Tycoons[tostring(game:GetService("Workspace").LocalTycoon.Value)].BuyItemButtons.Item1Button.ActivePart
            wait()
            firetouchinterest(kVars.hrp, stack1Btn, 0)
            wait()
            firetouchinterest(kVars.hrp, stack1Btn, 1)
        end
    end)
end

sectionFarm:Create("Toggle", "Merge",function(bool)
    kVars.boolMerge = bool
    if bool then
        fMerge()
    end
end,{default = kVars.boolMerge})

function fMerge()
    spawn(function()
        while kVars.boolMerge do
            local mergeBtn = game.workspace.Tycoons[tostring(game:GetService("Workspace").LocalTycoon.Value)].OtherButtons.Merge.ActivePart
            wait()
            firetouchinterest(kVars.hrp, mergeBtn, 0)
            wait()
            firetouchinterest(kVars.hrp, mergeBtn, 1)
        end
    end)
end

sectionFarm:Create("Toggle", "Upgrade",function(bool)
    kVars.boolUpgrade = bool
    if bool then
        fUpgrade()
    end
end,{default = kVars.boolUpgrade})

function fUpgrade()
    spawn(function()
        while kVars.boolUpgrade do
            local UpgradeBtn = game.workspace.Tycoons[tostring(game:GetService("Workspace").LocalTycoon.Value)].OtherButtons.UpgradeSell.ActivePart
            wait()
            firetouchinterest(kVars.hrp, UpgradeBtn, 0)
            wait()
            firetouchinterest(kVars.hrp, UpgradeBtn, 1)
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
end,{min = 16, max = 500, default = kVars.humanoid.walkSpeed, precise = false, changablevalue = true})

kVars.jumpHeight = kVars.humanoid.JumpHeight
sectionCharacter:Create("Slider", "Jump Height", function(value)
    kVars.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 7.2, max = 500, default = kVars.humanoid.jumpHeight, precise = true, changablevalue = true})


kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpHeight = kVars.jumpHeight
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
sectionMisc:Create("Button", "Destroy this GUI",function()
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
end,{animated = true})

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

---- sections options ----
sectionMisc:Create("Button", "Destroy this GUI",function()
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
end,{animated = true})

sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

kVars.Esp = {}
kVars.boolEsp = false
sectionMisc:Create("Toggle", "Player ESP",function(bool)
    kVars.boolEsp = bool
    if not bool and next(kVars.Esp) ~= nil then
        for i,v in pairs(game.Players:GetPlayers()) do
            if kVars.Esp[v] then
                kVars.Esp[v].Drawing:Remove()
            end
        end
        kVars.Esp = {}
    else
        fEsp()
    end
end,{default = kVars.boolEsp})

kVars.plrRemovingConnect = game:GetService("Players").PlayerRemoving:Connect(function(player)
    if kVars.Esp[player] then
        kVars.Esp[player].Drawing:Remove()
    end
end)

function fEsp()
    spawn(function()
        while kVars.boolEsp do
            task.wait()
            pcall(function()
                for i,v in pairs(game.Players:GetPlayers()) do
                    if kVars.boolEsp == false then break end
                    if kVars.lp.name ~= v.name and kVars.boolEsp then
                        if not kVars.Esp[v] then
                            kVars.Esp[v] = {}
                            kVars.Esp[v].Drawing = Drawing.new("Text")
                            kVars.Esp[v].Drawing.Visible = false
                            kVars.Esp[v].Drawing.Size = 16
                            kVars.Esp[v].Drawing.Color = Color3.fromRGB(0, 255, 60)
                            kVars.Esp[v].Drawing.Transparency = 1
                            kVars.Esp[v].Drawing.ZIndex = 1
                            kVars.Esp[v].Drawing.Center = true
                            kVars.Esp[v].Drawing.Font = 3
                            kVars.Esp[v].Drawing.Outline = true
                            kVars.Esp[v].Drawing.OutlineColor = Color3.fromRGB(0,0,0)
                            kVars.Esp[v].Drawing.Text = v.name
                        end
                        if v.Character:FindFirstChild("Head") then
                            local vector, onScreen = game.Workspace.CurrentCamera:WorldToScreenPoint(game.Players[v.name].Character.Head.Position)
                            if onScreen then
                                kVars.Esp[v].Drawing.Visible = true
                                kVars.Esp[v].Drawing.Position = Vector2.new(vector.x, vector.y)
                            else
                                kVars.Esp[v].Drawing.Visible = false
                            end
                        end
                    end
                end
            end)
        end
    end)
end


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

----========== set window size after load ==========----
game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Motherframe.Size = UDim2.new(0, 495, 0, 400)

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
        kVars.plrRemovingConnect:Disconnect()
        wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)


