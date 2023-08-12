--[[
Game : https://www.roblox.com/games/2662100821
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Jetpack Simulator GUI"
kVars.placeID = 2662100821
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
kVars.char = kVars.lp.Character

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
local sectionFarm = pageMain:CreateSection("Farm")
local sectionBuy = pageMain:CreateSection("Buy/Upgrade")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")
local sectionTpToLocation = pageTeleport:CreateSection("Teleport To Location")

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
sectionFarm:Create("Toggle", "Resource",function(bool)
    kVars.boolResource = bool
end,{default = kVars.boolResource})


sectionFarm:Create("Toggle", "Sell",function(bool)
    kVars.boolSell = bool
end,{default = kVars.boolSell})

kVars.sellAreas = {
    game:GetService("Workspace").Areas.Area1.Bank.Sell,
    game:GetService("Workspace").Areas.Area3.Bank.Sell,
    game:GetService("Workspace").Areas.Area5.Bank.Sell,
    game:GetService("Workspace").Areas.Area7.Bank.Sell,
    game:GetService("Workspace").Areas.Area9.Bank.Sell,
    game:GetService("Workspace").Areas.Area11.Bank.Sell,
    game:GetService("Workspace").Areas.Area13.Bank.Sell,
    game:GetService("Workspace").Areas.Area15.Bank.Sell,
    game:GetService("Workspace").Areas.Area17.Bank.Sell,
    game:GetService("Workspace").Areas.Area19.Bank.Sell
}


    spawn(function()
        kVars.clock = os.clock() 
        while wait() do
            if kVars.boolResource then
                local jp = game:GetService('ReplicatedStorage').DataFolder[kVars.lp.Name].JetpackData.EnergyLevel.Value
                local target = nil
                if jp == 1 and game:GetService('Workspace').Areas.Area1.Coal:FindFirstChild('Coal') then
                    target = game:GetService('Workspace').Areas.Area1.Coal:FindFirstChild('Coal').HitPart
                elseif  jp == 2 and game:GetService('Workspace').Areas.Area2.Battery:FindFirstChild("Battery") then 
                    target = game:GetService('Workspace').Areas.Area1.Battery:FindFirstChild("Battery").HitPart
                elseif  jp == 3 and game:GetService('Workspace').Areas.Area2.Solar:FindFirstChild("Solar") then
                    target = game:GetService('Workspace').Areas.Area2.Solar:FindFirstChild("Solar").HitPart
                elseif jp == 4 and game:GetService('Workspace').Areas.Area4.Wind:FindFirstChild("Wind") then
                    target = game:GetService('Workspace').Areas.Area3.Wind:FindFirstChild("Wind").HitPart
                elseif jp == 5 and game:GetService('Workspace').Areas.Area7.Nuclear:FindFirstChild("Nuclear") then					
                    target = game:GetService('Workspace').Areas.Area7.Nuclear:FindFirstChild("Nuclear").HitPart
                elseif jp == 6 and game:GetService('Workspace').Areas.Area7.Plasma:FindFirstChild("Plasma") then
                    target = game:GetService('Workspace').Areas.Area7.Plasma:FindFirstChild("Plasma").HitPart
                elseif jp == 7 and game:GetService('Workspace').Areas.Area11.Aetherium:FindFirstChild("Aetherium") then
                    target = game:GetService('Workspace').Areas.Area11.Aetherium:FindFirstChild("Aetherium").HitPart
                elseif jp == 8 and game:GetService('Workspace').Areas.Area13.Corrodium:FindFirstChild("Corrodium") then
                    target = game:GetService('Workspace').Areas.Area13.Corrodium:FindFirstChild("Corrodium").HitPart
                elseif jp == 9 and game:GetService('Workspace').Areas.Area13["Element 99"]:FindFirstChild("Element 99") then
                    target = game:GetService('Workspace').Areas.Area13["Element 99"]:FindFirstChild("Element 99").HitPart
                elseif jp == 10 and game:GetService('Workspace').Areas.Area15.Galacticium:FindFirstChild("Galacticium") then
                    target = game:GetService('Workspace').Areas.Area15.Galacticium:FindFirstChild("Galacticium").HitPart
                elseif jp == 11 and game:GetService('Workspace').Areas.Area17.Magmatium:FindFirstChild("Magmatium") then
                    target = game:GetService('Workspace').Areas.Area17.Magmatium:FindFirstChild("Magmatium").HitPart
                elseif jp == 12 and game:GetService('Workspace').Areas.Area19["Lightning Orb"]:FindFirstChild("Lightning Orb") then
                    target = game:GetService('Workspace').Areas.Area19["Lightning Orb"]:FindFirstChild("Lightning Orb").HitPart
                end
                
                
                if target ~= nil and kVars.char then
                    kVars.char:SetPrimaryPartCFrame(target.CFrame)
                    wait()
                end
            end

            if kVars.boolSell then 
                local jetpackFuel = game:GetService("ReplicatedStorage").DataFolder[kVars.lp.Name].JetpackData.FuelLevel.Value 
                local jetpackMaxFuel = (game:GetService("ReplicatedStorage").DataFolder[kVars.lp.Name].JetpackData.MaxFuel.Value / 3) * 2
                local closest = nil
                if jetpackFuel >= jetpackMaxFuel or (os.clock() - kVars.clock) > 2 then
                    kVars.clock = os.clock()     
                    local last = math.huge
                    for i,v in pairs(kVars.sellAreas) do
                        if kVars.boolSell == false then return end
                        if (v.Position - kVars.char.PrimaryPart.Position).magnitude < last then
                            closest = v
                            last = (v.Position - kVars.char.PrimaryPart.Position).magnitude
                        end
                    end
                end
                if kVars.char and closest ~= nil then
                    local a = closest.CFrame
                    repeat
                        kVars.char:SetPrimaryPartCFrame( CFrame.new(a.x, a.y + 5, a.z))
                        wait()
                    until game:GetService("ReplicatedStorage").DataFolder[kVars.lp.Name].JetpackData.FuelLevel.Value == 0 or kVars.boolSell == false
                end
            end
                
        end
    end)


sectionFarm:Create("Toggle", "Prestige",function(bool)
    kVars.boolPrestige = bool
    if bool then
        fPrestige()
    end
end,{default = kVars.boolPrestige})

function fPrestige()
    spawn(function()
        while kVars.boolPrestige do
            wait()
            local plrPrestigeValue = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\140\159 Prestige").Value
            local money = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\146\176 Cash").Value
            local costToUpgrade = (10000000 * (plrPrestigeValue + 1))
            if money >= costToUpgrade then
                game:GetService("ReplicatedStorage").ServerToClient.RequestPrestige:FireServer()
                wait(1)
                local a = kVars.char:WaitForChild("HumanoidRootPart")
            end
        end
    end)
end


---- section buy ----

sectionBuy:Create("Toggle", "Jetpack",function(bool)
    kVars.boolJetpack = bool
    if bool then
        fJetpack()
    end
end,{default = kVars.boolJetpack})

function fJetpack()
    spawn(function()
        while kVars.boolJetpack do
            wait()
            local jp = game:GetService('ReplicatedStorage').DataFolder[game:GetService('Players').LocalPlayer.Name].JetpackData.EnergyLevel.Value
            local money = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\146\176 Cash").Value
            local costToUpgrade = (math.floor(math.pow(jp, 3.85)) * 100)
            if money >= costToUpgrade then
                game:GetService("ReplicatedStorage").ClientToServer.PurchaseJetpackUpgrade:FireServer()
                wait(1)
            end
        end
    end)
end

sectionBuy:Create("Toggle", "Fuel",function(bool)
    kVars.boolFuel = bool
    if bool then
        fFuel()
    end
end,{default = kVars.boolFuel})

function fFuel()
    spawn(function()
        while kVars.boolFuel do
            wait()
            local fuel = game:GetService('ReplicatedStorage').DataFolder[game:GetService('Players').LocalPlayer.Name].JetpackData.MaxFuel.Value
            local money = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\146\176 Cash").Value
            local costToUpgrade = (math.floor(math.pow(fuel, 1.5)))
            if money >= costToUpgrade then
                game:GetService("ReplicatedStorage").ClientToServer.PurchaseFuelUpgrade:FireServer()
                wait(1)
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


---- section teleport to location ----
kVars.Locations = {
	{name = "Spawn/Earth", cf = CFrame.new(116, 5, -1)},
	{name = "Floating Island", cf = CFrame.new(34, 598, -19)},
	{name = "Moon", cf = CFrame.new(34, 1159, -19)},
	{name = "Mars", cf = CFrame.new(34, 2118, -19)},
	{name = "Neptune", cf = CFrame.new(34, 3212, -19)},
	{name = "Jupiter", cf = CFrame.new(34, 4609, -19)},
	{name = "Planet X", cf = CFrame.new(34, 6767, -19)},
	{name = "Diamond Planet", cf = CFrame.new(34, 8739, -19)},
	{name = "Magma Planet", cf = CFrame.new(34, 10748, -19)},
	{name = "Void Star", cf = CFrame.new(34, 12631, -19)}
}
for i,v in pairs(kVars.Locations) do
    sectionTpToLocation:Create("Button", v.name, function()
        kVars.lp.Character:SetPrimaryPartCFrame(v.cf)
    end,{animated = true})
end



----========== page character ==========----
---- section Character ----
kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    if kVars.lp.PlayerGui:FindFirstChild('ResourceCollectVisualizer') then
        kVars.lp.PlayerGui.ResourceCollectVisualizer:Destroy()
    end
    if game:GetService("StarterGui"):FindFirstChild("ResourceCollectVisualizer") then
        game:GetService("StarterGui").ResourceCollectVisualizer:Destroy()
    end
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.walkSpeed, precise = false, changablevalue = true})

kVars.jumpPower = kVars.humanoid.JumpPower
sectionCharacter:Create("Slider", "Jump Power", function(value)
    kVars.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 7.2, max = 1000, default = kVars.humanoid.jumpPower, precise = true, changablevalue = true})


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


