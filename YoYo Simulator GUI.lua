--[[
Game : https://www.roblox.com/games/7606302010
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "YoYo Simulator GUI"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.char = kVars.lp.Character
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
local sectionBuy = pageMain:CreateSection("Buy")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPArea = pageTeleport:CreateSection("Teleport Area")
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
sectionFarm:Create("Toggle", "Use YoYo",function(bool)
    kVars.boolUseYoYo = bool
    if bool then
        fUseYoYo()
    end
end,{default = kVars.boolUseYoYo})

function fUseYoYo()
    spawn(function()
        while kVars.boolUseYoYo do
            wait(.1)
            local tempTool = kVars.char
            if kVars.char:FindFirstChildWhichIsA("Tool") then
                tempTool = kVars.char:FindFirstChildWhichIsA("Tool").name
            else
                game:GetService("ReplicatedStorage").GameEvents.ToolEvents.UpdateTool:FireServer(nil, game.Players.LocalPlayer)
                Wait(.1)
                tempTool = kVars.char:FindFirstChildWhichIsA("Tool").name
            end

            if tempTool ~= kVars.char then
                local args = {
                    [1] = tempTool,
                    [2] = game:GetService("Players").LocalPlayer
                }
                
                game:GetService("ReplicatedStorage").GameEvents.ToolEvents.ToolEvent:FireServer(unpack(args))
            end
            
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
            local closestSell = "Home"
            local dist = math.huge
            
            for i,v in pairs(game:GetService("Workspace").MapFunctions.Sell:GetChildren()) do
                local curDist = math.huge
                if v:FindFirstChild("HitBox") then
                    curDist = (kVars.hrp.Position - v.HitBox.Position).Magnitude
                    if curDist < dist then
                        dist = curDist
                        closestSell = v.name
                    end
                end 
            end
            local args = {
                [1] = closestSell,
                [2] = game:GetService("Players").LocalPlayer
            }
            
            game:GetService("ReplicatedStorage").GameEvents.SellEvent:FireServer(unpack(args))
        end
    end)
end

sectionFarm:Create("Toggle", "Collect Items",function(bool)
    kVars.boolCollectItems = bool
    if bool then
        fCollectItems()
    end
end,{default = kVars.boolCollectItems})

function fCollectItems()
    spawn(function()
        while kVars.boolCollectItems do
            wait()
            for i,v in pairs(game:GetService("Workspace").MapFunctions.Spawns.Storage:GetChildren()) do
                wait()
                if kVars.boolCollectItems == false then break end

                if v:FindFirstChild("HitBox") and v:FindFirstChild("Floor").Value == kVars.lp.ClientData.CurrentArea.Value then
                    local count = 0
                    repeat
                        wait()
                        count = count + 1
                        if (v:FindFirstChild("HitBox").Position - kVars.hrp.Position).Magnitude > 6 or count >= 2 then
                            kVars.hrp.CFrame = v.HitBox.CFrame
                            wait(.3)
                            count = 0
                        end
                        if kVars.boolCollectItems == false then break end
                    until not v:FindFirstChild("HitBox")

                end

            end
        end
    end)
end




--[[
sectionUpgrades:Create("Toggle", "",function(bool)
    kVars.bool = bool
    if bool then
        f()
    end
end,{default = kVars.bool})

function f()
    spawn(function()
        while kVars.bool do
            wait()
            local args = {
                [1] = "Skilled",
                [2] = game:GetService("Players").LocalPlayer
            }

            game:GetService("ReplicatedStorage").GameEvents.RankEvents.BuyRank:FireServer(unpack(args))
        end
    end)
end]]--



----- Buy section -----
sectionBuy:Create("Toggle", "YOYO",function(bool)
    kVars.boolBuyYOYO = bool
    if bool then
        fBuyYOYO()
    end
end,{default = kVars.boolBuyYOYO})

function fBuyYOYO()
    spawn(function()
        while kVars.boolBuyYOYO do
            wait(.5)
            local args = {
                [1] = game:GetService("Players").LocalPlayer
            }
            
            game:GetService("ReplicatedStorage").GameEvents.ToolEvents.BuyAllTools:FireServer(unpack(args))
        end
    end)
end

sectionBuy:Create("Toggle", "DNA",function(bool)
    kVars.boolBuyDNA = bool
    if bool then
        fBuyDNA()
    end
end,{default = kVars.boolBuyDNA})

function fBuyDNA()
    spawn(function()
        while kVars.boolBuyDNA do
            wait(.5)
            local args = {
                [1] = game:GetService("Players").LocalPlayer
            }
            
            game:GetService("ReplicatedStorage").GameEvents.BackpackEvents.BuyAllBackpacks:FireServer(unpack(args))
        end
    end)
end



----========== page teleport ==========----
---- section area teleport ----
kVars.Areas = {
    {n = "Home", cf = CFrame.new(-206, 31, -104)}, 
    {n = "Floating Island", cf = CFrame.new(-6194, 78, -327)}, 
    {n = "Candyland", cf = CFrame.new(633, 49, -58)}, 
    {n = "Desert", cf = CFrame.new(-206, 31, -104)}, 
    {n ="Magma", cf = CFrame.new(-206, 31, -104)},
    {n = "Atlantis", cf = CFrame.new(-206, 31, -104)}, 
    {n = "Food", cf = CFrame.new(-206, 31, -104)}, 
    {n = "Toyland", cf = CFrame.new(-206, 31, -104)}, 
    {n = "Magic", cf = CFrame.new(-206, 31, -104)}, 
    {n = "Ninja", cf = CFrame.new(-206, 31, -104)}, 
    {n = "Winter", cf = CFrame.new(-206, 31, -104)}, 
    {n = "Beach", cf = CFrame.new(-206, 31, -104)}
}

for i,v in pairs(kVars.Areas) do
    sectionTPArea:Create("Button", v.n, function()
        kVars.hrp.CFrame = v.cf
    end,{animated = true})
end



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



--[[
    ---- Toggle ----
sectionUpgrades:Create("Toggle", "",function(bool)
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
    ---- Button ----
section:Create("Button", "", function()

end,{animated = true})
    ---- DropDown ----
section:Create("DropDown", "", function(value)

end,{options = kVars., default = kVars.[1], search = true})
    ---- Slider ----
section:Create("Slider", "", function(value)

end,{min = 0, max = 5, default = 2, precise = false, changablevalue = true})
    ---- Textbox ----
section:Create("TextBox", "", function(value)

end,{text = "I am texty"})
    ---- KeyBind ----
section:Create("KeyBind", "", function()

end,{default = Enum.KeyCode.k})
    ---- ColorPicker ----
section:Create("ColorPicker", "", function(color)

end,{default = Color3.fromRGB(255,255,255)})
    ---- Label ----
section:Create("Textlabel","Suck It")

]]