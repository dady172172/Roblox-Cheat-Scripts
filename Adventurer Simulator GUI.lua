--[[
Game : https://www.roblox.com/games/5932564241
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Adventurer Simulator GUI"
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
local sectionUpgrade = pageMain:CreateSection("Upgrades")

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
sectionFarm:Create("Toggle", "Attack",function(bool)
    kVars.boolAttack = bool
    if bool then
        fAttack()
    end
end,{default = kVars.boolAttack})

function fAttack()
    spawn(function()
        while kVars.boolAttack do
            wait(.1)
            game:GetService("ReplicatedStorage").Remotes.Events.Weapon:FireServer({["Action"] = "Attack"})
        end
    end)
end

sectionFarm:Create("Toggle", "Sell",function(bool)
    kVars.boolSell = bool
    if bool then
        fSell()
    end
end,{default = kVars.boolSell})

function fSell()
    spawn(function()
        while kVars.boolSell do
            wait(.1)
            pcall(function()
                game.ReplicatedStorage.Remotes.Events.Shop:FireServer({["Action"] = "Sell",["Request"] = "Sell"})
            end)
        end
    end)
end

sectionFarm:Create("Toggle", "Coins/Gems",function(bool)
    kVars.boolCoinsGems = bool
    if bool then
        fCoinsGems()
    end
end,{default = kVars.boolCoinsGems})

function fCoinsGems()
    spawn(function()
        while kVars.boolCoinsGems do
            wait()
            for j,h in pairs(game:GetService("Workspace").Client.Worlds:GetChildren()) do
                if h:FindFirstChild("Collectables") then
                    for i,v in pairs(h.Collectables.Projectiles:GetDescendants()) do
                        
                        pcall(function()
                            if v.name == "TouchInterest" then
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                                wait(.01)
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                            end
                        end)
                    end
                end
            end
        end
    end)
end

sectionFarm:Create("Toggle", "Boss",function(bool)
    kVars.boolBoss = bool
    if bool then
        game:GetService("Workspace").Gravity = 0
        fBoss()
    else
        game:GetService("Workspace").Gravity = 196.2
    end
end,{default = kVars.boolBoss})


kVars.tableBossNames = {}
kVars.varWorld = nil
for i,v in pairs(game:GetService("ReplicatedStorage").Bosses:GetChildren()) do
    table.insert(kVars.tableBossNames, v.Name)
end
function fBoss()
    spawn(function()
        kVars.Boss = nil
        if kVars.attackBool == false then
            print("Must have Attack on!!")
            return
        end
        for i,v in pairs(game:GetService("Workspace").Client.Worlds:GetChildren()) do
            kVars.varWorld = v.Name
        end
        if game:GetService("Workspace").Client.Worlds:FindFirstChild(kVars.varWorld) then
            local bossFolder = game:GetService("Workspace").Client.Worlds[kVars.varWorld].Boss
            for i,v in pairs(bossFolder:GetChildren()) do
                if table.find(kVars.tableBossNames, v.Name) then
                    kVars.Boss = v.Head
                end
            end
        end
        game:GetService("Workspace").Gravity = 0
        while kVars.boolBoss do
            wait()
            if kVars.Boss ~= nil then
                cfBoss2 = CFrame.new(kVars.Boss.CFrame.x,kVars.Boss.CFrame.y + 1,kVars.Boss.CFrame.z)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cfBoss2
            else
                wait()
            end
        end
    end)
end

---- section buy -----
sectionUpgrade:Create("Toggle", "Weapon",function(bool)
    kVars.boolWeapon = bool
    if bool then
        fWeapon()
    end
end,{default = kVars.boolWeapon})

function fWeapon()
    spawn(function()
        while kVars.boolWeapon do
            wait()
            
        end
    end)
end

sectionUpgrade:Create("Toggle", "Genetics",function(bool)
    kVars.boolGenetics = bool
    if bool then
        fGenetics()
    end
end,{default = kVars.boolGenetics})

function fGenetics()
    spawn(function()
        while kVars.boolGenetics do
            wait()
            
        end
    end)
end

sectionUpgrade:Create("Toggle", "",function(bool)
    kVars.bool = bool
    if bool then
        f()
    end
end,{default = kVars.bool})

function f()
    spawn(function()
        while kVars.bool do
            wait()
            
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
    if not bool then
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
    kVars.Esp[player].Drawing:Remove()
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

