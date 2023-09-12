--[[
Game : https://www.roblox.com/games/4857069142
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Clicking Simulator 2.0 GUI"
kVars.placeID = 4857069142
kVars.players = game:GetService('Players')
kVars.lp = kVars.players.LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.char = kVars.lp.Character or kVars.lp.CharacterAdded:Wait()
kVars.humanoid = kVars.char:WaitForChild('Humanoid')
kVars.hrp = kVars.char:WaitForChild('HumanoidRootPart')
kVars.connect = {}
kVars.bool = {}
kVars.str = {}
kVars.num = {}

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
kVars.connect.antiAFK = game:GetService('Players').LocalPlayer.Idled:connect(function()
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
kVars.GUI.section.rebirth = kVars.GUI.page.main:CreateSection("Rebirth")

kVars.GUI.page.teleport = kVars.GUI.window:CreateCategory("Teleport")
kVars.GUI.section.tpToPlayer = kVars.GUI.page.teleport :CreateSection("Teleport To Player")

kVars.GUI.page.character = kVars.GUI.window:CreateCategory("Character")
kVars.GUI.section.character = kVars.GUI.page.character:CreateSection("Options")

kVars.GUI.page.misc = kVars.GUI.window:CreateCategory("Misc")
kVars.GUI.section.keybinds = kVars.GUI.page.misc:CreateSection("KeyBinds")
kVars.GUI.section.world = kVars.GUI.page.misc:CreateSection("World Options")
kVars.GUI.section.options = kVars.GUI.page.misc:CreateSection("Options")
kVars.GUI.section.esp = kVars.GUI.page.misc:CreateSection("ESP")

kVars.GUI.page.credits = kVars.GUI.window:CreateCategory("Credits")
kVars.GUI.section.keath = kVars.GUI.page.credits:CreateSection("Coded by : Keathunsar")
kVars.GUI.section.alex = kVars.GUI.page.credits:CreateSection("UI-Lib by : xTheAlex14")

----========== page main ==========----
---- Farm ----
kVars.GUI.section.farm:Create("Toggle", "Click",function(bool)
    kVars.bool.Click = bool
    if bool then
        fClick()
    end
end,{default = kVars.bool.Click})

function fClick()
    spawn(function()
        while kVars.bool.Click do
            task.wait()
            game:GetService("Workspace").Events.Give:FireServer()
        end
    end)
end

kVars.GUI.section.farm:Create("Toggle", "Collect Farmers Clicks",function(bool)
    kVars.bool.farmersClicks = bool
    if bool then
        ffarmersClicks()
    end
end,{default = kVars.bool.farmersClicks})

function ffarmersClicks()
    spawn(function()
        while kVars.bool.farmersClicks do
            wait()
            game:GetService("Workspace").Events.Collect:FireServer()
        end
    end)
end


kVars.rebirthList = {
    {name = "1", id = 2},
    {name = "5", id = 3},
    {name = "15", id = 4},
    {name = "50", id = 5},
    {name = "100", id = 7},
    {name = "250", id = 8},
    {name = "750", id = 9},
    {name = "2.5k", id = 10},
    {name = "10k", id = 11}, 
    {name = "25k", id = 12},
    {name = "100k", id = 13},
    {name = "500k", id = 14}
}
kVars.rebirthListNames = {}
for i,v in pairs(kVars.rebirthList) do
    table.insert(kVars.rebirthListNames, v.name)
end
kVars.str.selectedRebirth = "1"
kVars.GUI.section.rebirth:Create("DropDown", "Select Amount", function(value)
    for i,v in pairs(kVars.rebirthList) do
        if v.name == value then
            kVars.str.selectedRebirth = tostring(v.id)
        end
    end
end,{options = kVars.rebirthListNames, default = kVars.rebirthListNames[1], search = true})


kVars.GUI.section.rebirth:Create("Toggle", "Rebirth",function(bool)
    kVars.bool.rebirth = bool
    if bool then
        frebirth()
    end
end,{default = kVars.bool.rebirth})

function frebirth()
    spawn(function()
        while kVars.bool.rebirth do
            wait()
            game:GetService("Workspace").Events["Give" .. kVars.str.selectedRebirth]:FireServer()
        end
    end)
end


----========== page teleport ==========----
---- section teleport to player ----
kVars.SelectedTPToPlayer = kVars.lp.name
kVars.GUI.section.tpToPlayer:Create("TextBox", "Enter Users Name", function(value)
    kVars.SelectedTPToPlayer = value
end,{text = "Enter Users Name"})

kVars.GUI.section.tpToPlayer:Create("Button", "Teleport To Player", function()
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
kVars.num.walkSpeed = kVars.humanoid.WalkSpeed
kVars.GUI.section.character:Create("Slider", "Walk Speed", function(value)
    kVars.num.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.num.walkSpeed, precise = false, changablevalue = true})

kVars.num.jumpPower = kVars.humanoid.JumpPower
kVars.GUI.section.character:Create("Slider", "Jump Power", function(value)
    kVars.num.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 7.2, max = 500, default = kVars.num.jumpPower, precise = true, changablevalue = true})

kVars.num.jumpHeight = kVars.humanoid.JumpHeight
kVars.GUI.section.character:Create("Slider", "Jump Height", function(value)
    kVars.num.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 7.2, max = 500, default = kVars.num.jumpHeight, precise = true, changablevalue = true})


kVars.connect.CharacterAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.num.walkSpeed
    kVars.humanoid.JumpHeight = kVars.num.jumpHeight
    kVars.humanoid.JumpPower = kVars.num.jumpPower
end)

kVars.bool.infJump = false
kVars.GUI.section.character:Create("Toggle", "Inf Jump",function(bool)
    kVars.bool.infJump = bool
end,{default = kVars.bool.infJump})

kVars.connect.jumpRequest = game:GetService("UserInputService").JumpRequest:Connect(function()
	if kVars.bool.infJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)

----========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.F5
kVars.GUI.section.keybinds:Create("KeyBind", "Open Close Menu", function(key)
    kVars.OpenCloseMenuKey = key
end,{default = kVars.OpenCloseMenuKey})


kVars.connect.inputBegan = kVars.uis.InputBegan:Connect(function(key)
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
    kVars.bool.fog = true
else
    kVars.bool.fog = false
end
kVars.GUI.section.world:Create("Toggle", "Fog",function(bool)
    kVars.bool.fog = bool
    if bool then
        game.Lighting.FogStart = 0
    else
        game.Lighting.FogStart = math.huge
    end
end,{default = kVars.bool.fog})

---- sections options ----
kVars.GUI.section.options:Create("Button", "Destroy this GUI",function()
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
end,{animated = true})

kVars.GUI.section.options:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})


local sides = {Enum.NormalId.Top, Enum.NormalId.Bottom, Enum.NormalId.Left, Enum.NormalId.Right, Enum.NormalId.Front, Enum.NormalId.Back}

function EspChar()
    --pcall(function()
        local players = game:GetService("Players")
        for i,v in pairs(players:GetChildren()) do
            local char = v.Character or v.CharacterAdded:Wait()
            if v.Name ~= game.Players.LocalPlayer.Name then
                for _,a in pairs(char:GetChildren()) do
                    if not a:FindFirstChild("ESP") then
                        if a.ClassName == "MeshPart" or a.ClassName == "Part" then
                            for _,y in pairs(sides) do
                                local sg = Instance.new("SurfaceGui")
                                sg.Name = "ESP"
                                sg.Face = y
                                sg.Adornee = a
                                sg.Parent = a
                                sg.AlwaysOnTop = true
                                sg.MaxDistance = math.huge
                                sg.LightInfluence = 0
                                sg.Brightness = 1000
                                sg.ZOffset = 1
                                local fr = Instance.new("Frame")
                                fr.Name = "ESP"
                                fr.Parent = sg
                                fr.Size = UDim2.new(1,0,1,0)
                                fr.BackgroundColor3 = Color3.new(0, 1, 0)
                                fr.Transparency = 0.3
                            end
                        end
                    end
                end
            end
        end
    --end)
end

local function EspCharOFF()
    --pcall(function()
        for a,b in pairs(kVars.players:GetChildren()) do
            local char = b.Character or b.CharacterAdded:Wait()
            for c,d in pairs(char:GetChildren()) do
                for e,f in pairs(d:GetChildren()) do
                    if f.Name == "ESP" then
                        f:Destroy()
                    end
                end
            end
        end
    --end)
end

local function espChams()
    kVars.connect.playerAdded = kVars.players.PlayerAdded:Connect(function(player) ---- player joins game
        kVars.connect.characterAdded2 = player.CharacterAdded:Connect(function(char) ---- Character is added to workspace
            if player.Name ~= kVars.lp.Name then
                repeat
                    task.wait(.2)
                until player.Character and player.Character.Humanoid and player.Character.HumanoidRootPart
                task.wait(1)
                EspChar()
            end
        end)  
    end)
end

kVars.GUI.section.esp:Create("Toggle", "Player ESP Chams",function(bool)
    if bool then
        espChams()
        EspChar()
    elseif not bool then
        kVars.connect.playerAdded:Disconnect()
        EspCharOFF()
    end
end,{default = false})

kVars.Esp = {}
kVars.bool.Esp = false
kVars.GUI.section.esp:Create("Toggle", "Player ESP name/box",function(bool)
    kVars.bool.Esp = bool
    if not bool then
        for i,v in pairs(kVars.players:GetChildren()) do
            if kVars.Esp[v.Name] then
                wait()
                kVars.Esp[v.Name].txt.Visible = false   
            end
        end    
    else
        fEsp()
    end
end,{default = kVars.bool.Esp})

kVars.connect.playerRemoving = kVars.players.PlayerRemoving:Connect(function(p)
    if kVars.Esp[p.Name] then
        wait()
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
        local cam = game:GetService("Workspace").CurrentCamera
        while kVars.bool.Esp do
            task.wait()
            pcall(function()
                for i,v in pairs(kVars.players:GetChildren()) do
                    if not kVars.bool.Esp then break end
                    task.wait()
                    local char = v.Character or v.CharacterAdded:Wait()
                    local charHead = char:WaitForChild("Head")
                    local charHrp = char:WaitForChild("HumanoidRootPart")
                    if char and charHead then
                        if v.Name ~= kVars.lp.Name then
                            if not kVars.Esp[v.Name] then
                                kVars.Esp[v.Name] = {}
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
                            local vector1, onScreen1 = cam:WorldToViewportPoint(charHead.Position)

                            if onScreen1 then
                                local screenPosHead, onscreenPosHead = cam:WorldToViewportPoint(charHead.Position)
                                local screenPosHrp, onscreenPosHrp = cam:WorldToViewportPoint(charHrp.Position)
                                local diffScreen = (screenPosHead - screenPosHrp).Magnitude
                                kVars.Esp[v.Name].txt.Visible = true
                                kVars.Esp[v.Name].txt.Position = Vector2.new((screenPosHead.x), (screenPosHead.y - diffScreen))
                            else
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
kVars.GUI.section.keath:Create("Button", "https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
end,{animated = true})

kVars.GUI.section.keath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
end,{animated = true})

---- alex ----
kVars.GUI.section.alex:Create("Button", "https://teppyboy.github.io/", function()
    setclipboard('https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/main.html')
end,{animated = true})

----========== set window size after load ==========----
kVars.MotherFrame = game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):WaitForChild("Motherframe")
kVars.MotherFrame.Size = UDim2.new(0, 495, 0, 400)
kVars.screenSize = game:GetService("Workspace"):WaitForChild("Camera").ViewportSize
kVars.MotherFrame.Position = UDim2.new(0, (kVars.screenSize.X / 2) - (kVars.MotherFrame.Size.X.Offset / 2), 0, (kVars.screenSize.Y / 2) - (kVars.MotherFrame.Size.Y.Offset / 2))

----========== delete script if re-injecting ==========----

kVars.cR = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.name == kVars.WindowName then
        for i,v in pairs(kVars.bool) do
            v = false
        end
        for i,v in pairs(kVars) do
            if type(v) == "boolean" then
                kVars[i] = false
            end
        end
        for i,v in pairs(kVars.connect) do
            v:Disconnect()
        end
        wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)



--[[
    ---- Toggle ----
kVars.bool.
kVars.GUI.section.farm:Create("Toggle", "",function(bool)
    kVars.bool. = bool
    if bool then
        kVars.func.()
    end
end,{default = kVars.bool})

function kVars.func.()
    spawn(function()
        while kVars.bool. do
            wait()
            
        end
    end)
end

    ---- Button ----
kVars.GUI.section.farm:Create("Button", "", function()

end,{animated = true})

    ---- DropDown ----
kVars.List = 
kVars.GUI.section.farm:Create("DropDown", "", function(value)

end,{options = kVars.List, default = kVars.List[1], search = true})

    ---- Slider ----
kVars.GUI.section.farm:Create("Slider", "", function(value)

end,{min = 0, max = 5, default = 2, precise = false, changablevalue = true})

    ---- Textbox ----
kVars.str. = "default"
kVars.GUI.section.farm:Create("TextBox", "", function(value)
    kVars.str. = value
end,{text = kVars.str.})

    ---- KeyBind ----
kVars.GUI.section.farm:Create("KeyBind", "", function()

end,{default = Enum.KeyCode.k})

    ---- ColorPicker ----
kVars.GUI.section.farm:Create("ColorPicker", "", function(color)

end,{default = Color3.fromRGB(255,255,255)})

    ---- Label ----
kVars.GUI.section.farm:Create("Textlabel", "Suck It")

]]