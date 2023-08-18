--[[
Game : https://www.roblox.com/games/4972091010
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----

kVars = {}
kVars.WindowName = "Zombie Uprising GUI"
kVars.placeID = 4972091010
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')

---- check for correct game ----
if kVars.placeID ~= game.PlaceId then 
    warn("#### - This Script is not for this game. - ####")
    script:Destroy()
    return 
end

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
local sectionAimBot = pageMain:CreateSection("AimBot")
local sectionESP = pageMain:CreateSection("ESP")
local sectionCollectables = pageMain:CreateSection("Collect")

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

----========== functions ==========----
---- check for obscured ----
function obscured(part)
    local castPoints = {game:GetService("Workspace").CurrentCamera.CFrame.Position, part.CFrame.Position}
    local ignoreList = {}
    local obscure = workspace.CurrentCamera:GetPartsObscuringTarget(castPoints, ignoreList)
    return next(obscure) ~= nil
end

----========== page main ==========----
---- section aimbot ----
game.Players.LocalPlayer.CameraMode = "Classic"
kVars.boolAimBot = false
sectionAimBot:Create("Toggle", "AimBot *LeftControl",function(bool)
    kVars.boolAimBot = bool
end,{default = kVars.boolAimBot})

kVars.closestZombie = nil
function fGetClosest()
    spawn(function()
        while task.wait() do
            local last = math.huge
            local ZombiesList = game:GetService("Workspace").Zombies:GetChildren()
            if next(ZombiesList) ~= nil then
                for i,v in pairs(ZombiesList) do
                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") then
                        if v.Humanoid.Health ~= 0 then
                            if obscured(v.Head) == false then
                                local distance = (kVars.lp.Character.HumanoidRootPart.Position - v.Head.Position).magnitude
                                if distance < last then
                                    last = distance
                                    kVars.closestZombie = v
                                end 
                            elseif obscured(v.HumanoidRootPart) == false then
                                local distance = (kVars.lp.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
                                if distance < last then
                                    last = distance
                                    kVars.closestZombie = v
                                end
                            end
                        end
                    end
                end
            else
                kVars.closestZombie = nil
            end
        end
    end)
end
fGetClosest()


kVars.mouseButton1Down = false
function fAimBot()
    spawn(function()
        local ignoreList = {}
        while task.wait()  do -- aimbot toggle is on   
            if kVars.boolLeftControl and kVars.closestZombie ~= nil and kVars.boolAimBot then -- pressing left control
                local closest = kVars.closestZombie
                game.Players.LocalPlayer.CameraMode = "LockFirstPerson"
                if closest ~= nil then
                    repeat
                        wait()
                        local part = nil
                        if closest:FindFirstChild("Head") then
                            game:GetService("Workspace").CurrentCamera.CFrame = CFrame.lookAt(game:GetService("Workspace").CurrentCamera.CFrame.Position, closest.Head.CFrame.Position)
                            part = closest.Head
                            
                        elseif closest:FindFirstChild("HumanoidRootPart") then
                            game:GetService("Workspace").CurrentCamera.CFrame = CFrame.lookAt(game:GetService("Workspace").CurrentCamera.CFrame.Position, closest.HumanoidRootPart.CFrame.Position)
                            part = closest.HumanoidRootPart
                        end
                        if kVars.boolTriggerBot then
                            mouse1press()
                        end
                    until not closest:FindFirstChild("Humanoid") or closest == nil or closest.Humanoid.Health == 0 or kVars.boolAimBot == false or kVars.boolLeftControl == false or obscured(part) or part == nil
                    --kVars.closestZombie = nil
                    mouse1release()
                end
            end
        end
    end)
end
fAimBot()

kVars.UIS = game:GetService("UserInputService").InputBegan:Connect(function(input)
    --[[if game:GetService("Workspace").Ignore:FindFirstChild("Map") then 
        for i,v in pairs(game:GetService("Workspace").Ignore.Map:GetChildren()) do
            v:Destroy()
        end
        game:GetService("Workspace").Ignore.Map:Destroy()
    end]]--
    --[[if game:GetService("Workspace").Map:FindFirstChild("Boundaries") then
        for i,v in pairs(game:GetService("Workspace").Map.Boundaries:GetChildren()) do
            v:Destroy()
        end
    end]]--
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        
            kVars.boolLeftControl = true
            kVars.lp.CameraMode = "LockFirstPerson"
        
    end
end)

kVars.UISEnd = game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        
            kVars.boolLeftControl = false
        
    end
end)

kVars.boolTriggerBot = false
sectionAimBot:Create("Toggle", "Trigger Bot",function(bool)
    kVars.boolTriggerBot = bool
    --[[if bool then
        fTriggerBot()
    end]]--
end,{default = kVars.boolTriggerBot})

function fTriggerBot()
    spawn(function()
        local mouseD = false
        while kVars.boolTriggerBot do
            task.wait()
            local mouse = kVars.lp:GetMouse()
            if mouse ~= nil then
                if mouse.Target ~= nil then
                    print(mouse.Target:GetFullName())
                    if string.find(string.lower(mouse.Target:GetFullName()), "zombie") then
                    
                        mouse1press()  
                        mouseD = true
                    else
                        mouse1release()
                        mouseD = false
                    end

                end
            end
            
        end
    end)
end

---- section collect ----
kVars.boolCollectPowerUps = false
sectionCollectables:Create("Toggle", "Collect PowerUps",function(bool)
    kVars.boolCollectPowerUps = bool
    if bool then
        fCollectPowerUps()
    end
end,{default = kVars.boolCollectPowerUps})

function fCollectPowerUps()
    spawn(function()
        while kVars.boolCollectPowerUps do
            task.wait()
            if game:GetService("Workspace").Ignore:FindFirstChild("PowerUps") then
                for i,v in pairs(game:GetService("Workspace").Ignore.PowerUps:GetChildren()) do
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                    task.wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                end
            end
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



kVars.jumpHeight = kVars.humanoid.JumpPower
sectionCharacter:Create("Slider", "Jump Height", function(value)
    kVars.jumpHeight = value
    kVars.humanoid.JumpPower = value
end,{min = 1, max = 500, default = kVars.humanoid.jumpHeight, precise = false, changablevalue = true})
pcall(function()
game.Players.LocalPlayer.Character.Humanoid:AddGetHook("WalkSpeed",16)
game.Players.LocalPlayer.Character.Humanoid:AddSetHook("WalkSpeed")
kVars.lp.Character.Humanoid.WalkSpeed = kVars.walkSpeed
game.Players.LocalPlayer.Character.Humanoid:AddSetHook("JumpPower",50)
game.Players.LocalPlayer.Character.Humanoid:AddSetHook("JumpPower")
kVars.lp.Character.Humanoid.JumpPower = kVars.jumpHeight
end)

kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpPower = kVars.jumpHeight
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
            kVars.lp.CameraMode = "Classic"
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
        kVars.UIS:Disconnect()
        kVars.UISEnd:Disconnect()
        kVars.connectAntiAfk:Disconnect()
        kVars.connectInputBegan:Disconnect()
        kVars.connectJumpRequest:Disconnect()
        kVars.plrAdded:Disconnect()
        kVars.plrRemovingConnect:Disconnect()
        task.wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
        return
    end
end)


