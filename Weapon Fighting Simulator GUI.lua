--[[
Game : https://www.roblox.com/games/8554378337
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Weapon Fighting Simulator GUI"
kVars.placeID = 8554378337
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.char = kVars.lp.Character or kVars.lp.CharacterAdded:Wait()
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
kVars.connections = {}


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
kVars.connections.antiAFK = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.vu:CaptureController()
    kVars.vu:ClickButton2(Vector2.new())
 end)

---- gui build ----
kVars.GUI = {}
kVars.GUI.page = {}
kVars.GUI.section = {}
kVars.GUI.library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
kVars.GUI.window = kVars.GUI.library:CreateMain({
    projName = kVars.WindowName,
    Resizable = true,
    MinSize = UDim2.new(0,400,0,400),
    MaxSize = UDim2.new(0,750,0,500),
})

kVars.GUI.page.main = kVars.GUI.window:CreateCategory("Main")
kVars.GUI.section.farm = kVars.GUI.page.main:CreateSection("Farm")

kVars.GUI.page.teleport = kVars.GUI.window:CreateCategory("Teleport")
kVars.GUI.section.TPToPlayer = kVars.GUI.page.teleport:CreateSection("Teleport To Player")

kVars.GUI.page.character = kVars.GUI.window:CreateCategory("Character")
kVars.GUI.section.options = kVars.GUI.page.character:CreateSection("Options")

kVars.GUI.page.misc = kVars.GUI.window:CreateCategory("Misc")
kVars.GUI.section.keybinds = kVars.GUI.page.misc:CreateSection("KeyBinds")
kVars.GUI.section.world = kVars.GUI.page.misc:CreateSection("World Options")
kVars.GUI.section.misc = kVars.GUI.page.misc:CreateSection("Options")

kVars.GUI.page.credits = kVars.GUI.window:CreateCategory("Credits")
kVars.GUI.section.creditsKeath = kVars.GUI.page.credits:CreateSection("Coded by : Keathunsar")
kVars.GUI.section.creditsAlex = kVars.GUI.page.credits:CreateSection("UI-Lib by : xTheAlex14")

----========== page main ==========----
---- Farm ----

kVars.GUI.section.farm:Create("Toggle", "Attack Closest",function(bool)
    kVars.boolAttack = bool
    if bool then
        fAttack()
    end
end,{default = kVars.boolAttack})

function fAttack()
    spawn(function()
        while kVars.boolAttack do
            local a,b = pcall(function()
                task.wait()
                local closest = "nil"
                local dist = math.huge
                for i,v in pairs(game:GetService("Workspace").Fight.ClientChests:GetChildren()) do
                    local distTo = (v.Root.Position - kVars.hrp.Position).Magnitude
                    if distTo < dist then
                        closest = v
                        dist = distTo
                    end
                end
                if kVars.boolAttack == false then return end
                if closest ~= "nil" and closest:FindFirstChild("Root") then
                    repeat
                        kVars.humanoid.WalkToPoint = closest.Root.Position
                    until kVars.humanoid.MoveToFinished:Wait() or kVars.boolAttack == false
                    
                    local userid = game.Players.LocalPlayer.UserId
                    local firstpet = game:GetService("Workspace").Fight.Pets[userid.."_pets"]:GetChildren()[1]
                    
                    repeat
                        --print("clicked")
                        fireclickdetector(closest.Root.ClickDetector)
                        task.wait(0.1)
                        
                    until firstpet.PetTarget.Value ~= "" or kVars.boolAttack == false or not closest:FindFirstChild("Root")
                    repeat
                        --print(firstpet.PetTarget)
                        task.wait(0.1)
                    until firstpet.PetTarget.Value == "" or kVars.boolAttack == false
                    
                end
            end)
        end
    end)
end


kVars.GUI.section.farm:Create("Toggle", "Collect Drops",function(bool)
    kVars.boolDrops = bool
    if bool then
        fDrops()
    end
end,{default = kVars.boolDrops})

function fDrops()
    spawn(function()
        while kVars.boolDrops do
            wait()
            for i,v in pairs(game:GetService("Workspace"):WaitForChild("Rewards"):GetChildren()) do
                if v.ClassName == "Part" then
                    wait()
                    v.CFrame = kVars.hrp.CFrame
                end
            end
        end
    end)
end

----========== page teleport ==========----
---- section teleport to player ----
kVars.SelectedTPToPlayer = kVars.lp.name
kVars.GUI.section.TPToPlayer:Create("TextBox", "Enter Users Name", function(value)
    kVars.SelectedTPToPlayer = value
end,{text = "Enter Users Name"})

kVars.GUI.section.TPToPlayer:Create("Button", "Teleport To Player", function()
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
kVars.GUI.section.options:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.walkSpeed, precise = false, changablevalue = true})

local function fConnectWalkSpeed()
    kVars.connections.WalkSpeed = kVars.humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
        kVars.humanoid.WalkSpeed = kVars.walkSpeed
    end)
end
fConnectWalkSpeed()

kVars.jumpPower = kVars.humanoid.JumpPower
kVars.GUI.section.options:Create("Slider", "Jump Power", function(value)
    kVars.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 7.2, max = 500, default = kVars.humanoid.jumpPower, precise = true, changablevalue = true})

local function fConnectJumpPower()
    kVars.connections.JumpPower = kVars.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
        kVars.humanoid.JumpPower = kVars.jumpPower
    end)
end
fConnectJumpPower()

kVars.jumpHeight = kVars.humanoid.JumpHeight
kVars.GUI.section.options:Create("Slider", "Jump Height", function(value)
    kVars.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 7.2, max = 500, default = kVars.humanoid.jumpHeight, precise = true, changablevalue = true})

local function fConnectJumpHeight()
    kVars.connections.JumpHeight = kVars.humanoid:GetPropertyChangedSignal("JumpHeight"):Connect(function()
        kVars.humanoid.JumpHeight = kVars.jumpHeight
    end)
end
fConnectJumpHeight()

kVars.connections.playerAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpHeight = kVars.jumpHeight
    kVars.humanoid.JumpPower = kVars.jumpPower
    kVars.connections.WalkSpeed:Disconnect()
    kVars.connections.JumpHeight:Disconnect()
    kVars.connections.JumpPower:Disconnect()
    fConnectWalkSpeed()
    fConnectJumpPower()
    fConnectJumpHeight()
end)

kVars.boolInfJump = false
kVars.GUI.section.options:Create("Toggle", "Inf Jump",function(bool)
    kVars.boolInfJump = bool
end,{default = kVars.boolInfJump})

kVars.connections.infJump = game:GetService("UserInputService").JumpRequest:Connect(function()
	if kVars.boolInfJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)

----========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.F5
kVars.GUI.section.keybinds:Create("KeyBind", "Open Close Menu", function(key)
    kVars.OpenCloseMenuKey = key
end,{default = kVars.OpenCloseMenuKey})


kVars.connections.inputBegan = kVars.uis.InputBegan:Connect(function(key)
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
kVars.GUI.section.world:Create("Toggle", "Fog",function(bool)
    kVars.boolFog = bool
    if bool then
        game.Lighting.FogStart = 0
    else
        game.Lighting.FogStart = math.huge
    end
end,{default = kVars.boolFog})

---- sections options ----
kVars.GUI.section.misc:Create("Button", "Destroy this GUI",function()
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
end,{animated = true})

kVars.GUI.section.misc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

kVars.Esp = {}
kVars.boolEsp = false
kVars.GUI.section.misc:Create("Toggle", "Player ESP",function(bool)
    kVars.boolEsp = bool
    if not bool then
        for i,v in pairs(game.Players:GetPlayers()) do
            if kVars.Esp[v.Name] then
                wait()
                kVars.Esp[v.Name].sq.Visible = false
                kVars.Esp[v.Name].txt.Visible = false 

                
            end
        end
        
    else
        fEsp()
    end
end,{default = kVars.boolEsp})

kVars.connections.playerRemoving = game:GetService("Players").PlayerRemoving:Connect(function(p)
    if kVars.Esp[p.Name] then
        wait()
        kVars.Esp[p.Name].sq.Visible = false
        kVars.Esp[p.Name].txt.Visible = false
        table.remove(kVars.Esp[p.Name])
    end
end)

function mean(t)
    local add = 0
    for i,v in pairs(t) do
        add = add + v
    end
    return add / #t
end

function fEsp()
    spawn(function()
        while kVars.boolEsp do
            task.wait()
            pcall(function()
                for i,v in pairs(game.Players:GetChildren()) do
                    if not kVars.boolEsp then break end
                    task.wait()
                    if v.Character and v.Character:FindFirstChild("Head") then
                        local pHead = v.Character:WaitForChild("Head")
                        local pHrp = v.Character:WaitForChild("HumanoidRootPart") 
                        
                        if v.Name ~= kVars.lp.Name then
                            if not kVars.Esp[v.Name] then
                                kVars.Esp[v.Name] = {}
                                -- esp square
                                kVars.Esp[v.Name].sq = Drawing.new("Square")
                                kVars.Esp[v.Name].sq.Visible = false
                                kVars.Esp[v.Name].sq.Thickness = 1
                                kVars.Esp[v.Name].sq.Size = Vector2.new(10,10)
                                kVars.Esp[v.Name].sq.Filled = false
                                kVars.Esp[v.Name].sq.Color = Color3.fromRGB(0, 255, 60)
                                local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pHead.Position)
                                kVars.Esp[v.Name].sq.Position = Vector2.new(vector.x, vector.y)
                                -- esp text
                                kVars.Esp[v.Name].txt = Drawing.new("Text")
                                kVars.Esp[v.Name].txt.Visible = false
                                kVars.Esp[v.Name].txt.Size = 16
                                kVars.Esp[v.Name].txt.Color = Color3.fromRGB(0, 255, 60)
                                kVars.Esp[v.Name].txt.Transparency = 1
                                kVars.Esp[v.Name].txt.ZIndex = 1
                                kVars.Esp[v.Name].txt.Center = true
                                kVars.Esp[v.Name].txt.Font = 3
                                kVars.Esp[v.Name].txt.Outline = true
                                kVars.Esp[v.Name].txt.OutlineColor = Color3.fromRGB(0, 0, 0)
                                kVars.Esp[v.Name].txt.Text = v.Name
                            end
                            local vector1, onScreen1 = game.Workspace.CurrentCamera:WorldToViewportPoint(pHead.Position)

                            if onScreen1 then
                                local distBetHeadHrp = Vector3.new(mean({pHead.Position.x, pHrp.Position.x}),mean({pHead.Position.y, pHrp.Position.y}),mean({pHead.Position.z, pHrp.Position.z}))
                                local screenDistBetHeadHrp, onscreenDistBetHeadHrp = game.Workspace.CurrentCamera:WorldToViewportPoint(distBetHeadHrp)
                                local screenPosHead, onscreenPosHead = game.Workspace.CurrentCamera:WorldToViewportPoint(pHead.Position)
                                local screenPosHrp, onscreenPosHrp = game.Workspace.CurrentCamera:WorldToViewportPoint(pHrp.Position)
                                local diffScreen = (screenPosHead - screenPosHrp).Magnitude
                                kVars.Esp[v.Name].sq.Visible = true
                                kVars.Esp[v.Name].sq.Position = Vector2.new((screenDistBetHeadHrp.x - diffScreen), (screenDistBetHeadHrp.y - diffScreen)) 
                                kVars.Esp[v.Name].sq.Size = Vector2.new(diffScreen * 2, diffScreen * 3)
                                kVars.Esp[v.Name].txt.Visible = true
                                kVars.Esp[v.Name].txt.Position = Vector2.new((screenPosHead.x), (kVars.Esp[v.Name].sq.Position.y - diffScreen))
            
                            else
                                kVars.Esp[v.Name].sq.Visible = false
                                kVars.Esp[v.Name].txt.Visible = false
            
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
kVars.GUI.section.creditsKeath:Create("Button", "https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
end,{animated = true})

kVars.GUI.section.creditsKeath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
end,{animated = true})

---- alex ----
kVars.GUI.section.creditsAlex:Create("Button", "https://teppyboy.github.io/", function()
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
        for i,v in pairs(kVars.connections) do
            v:Disconnect()
        end
        wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)
