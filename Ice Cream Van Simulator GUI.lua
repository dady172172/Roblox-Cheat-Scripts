--[[
Game : https://www.roblox.com/games/2970570231
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "ICE CREAM VAN SIMULATOR GUI"
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
local sectionFarm = pageMain:CreateSection("Auto Farm *Only one on at a time")
local sectionMenus = pageMain:CreateSection("Menus")

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
local updateStockEvent = game.ReplicatedStorage.RemoteEvents.UpdateStock.OnClientEvent
kVars.boolBuySellClostest = false
sectionFarm:Create("Toggle", "Buy/sell to closest of inventory type",function(bool)
    kVars.boolBuySellClostest = bool
    if bool then
        fBuySellClostest()
    else
        wait(.3)
        for _, connection in pairs(getconnections(updateStockEvent)) do
            connection:Fire()
        end
    end
end,{default = kVars.boolBuySellClostest})

function fBuySellClostest()
    spawn(function()
        kVars.last = math.huge
        kVars.selectedNPC = nil
        while kVars.boolBuySellClostest do
            wait()
            pcall(function()
                local firstInvSlotType = game:GetService("Players").keathunsar.PlayerGui.HUD.Main.StockDisplay.Stock.ScrollingFrame:FindFirstChildOfClass("Frame")
                local gen = "Normal"
                if string.find(firstInvSlotType.name, "Lolly") or string.find(firstInvSlotType.name, "Cone") or string.find(firstInvSlotType.name, "Cream") then
                    gen = "Normal"
                elseif string.find(firstInvSlotType.name, "Slushy") then
                    gen = "Slushy"
                elseif string.find(firstInvSlotType.name, "Parcel") then
                    gen = "Parcel"
                elseif string.find(firstInvSlotType.name, "Astro") then
                    gen = "Astro"
                elseif string.find(firstInvSlotType.name, "Ghost") then
                    gen = "Ghost"
                end
                for i,v in pairs(game:GetService("Workspace")["_NPCLocations"]:GetChildren()) do
                    for g,h in pairs(v.NPCs:GetChildren()) do
                        local dist = (h.HumanoidRootPart.Position - kVars.hrp.Position).magnitude
                        if dist < kVars.last and h.HasIceCream.Value == false and h.Generation.Value == gen then
                            kVars.last = dist
                            kVars.selectedNPC = h
                        end 
                    end
                end
                kVars.last = math.huge
            end)
        end
    end)
    spawn(function()
        while kVars.boolBuySellClostest do
            wait()
            pcall(function()
                if kVars.selectedNPC ~= nil and kVars.selectedNPC.HasIceCream.Value == false then
                    local closest = kVars.selectedNPC
                    local cFlavour = closest.Flavour.Value
                    local cGen
                    if closest.Generation.Value == nil or closest.Generation.Value == "Normal" then
                        for i,v in pairs(game:GetService("Players").keathunsar.PlayerGui.HUD.Main.StockDisplay.Stock.ScrollingFrame:GetChildren()) do
                            if string.find(v.name, "Cream") then
                                cGen = "Cream"
                            elseif string.find(v.name, "Cone") and cGen ~= "Cream" then
                                cGen = "Cone"
                            elseif string.find(v.name, "Lolly") and cGen ~= "Cone" then
                                cGen = "Lolly"
                            end
                        end
                        
                    else
                        cGen = closest.Generation.Value
                    end
                    wait()
                    if (closest.HumanoidRootPart.Position - kVars.hrp.Position).magnitude > 6 then
                        kVars.hrp.CFrame = closest.HumanoidRootPart.CFrame
                    end
                    kVars.rs.RemoteEvents.PurchaseIceCream:InvokeServer(cGen, cFlavour, 1)
                    for _, connection in pairs(getconnections(updateStockEvent)) do
                        connection:Fire()
                    end
                    wait(.2)
                    local count = 1
                    repeat
                        kVars.rs.RemoteEvents.SellIceCream:FireServer(closest)
                        wait()
                        count = count + 1
                    until kVars.boolBuySellClostest == false or closest.HasIceCream.Value or count == 100
                    for _, connection in pairs(getconnections(updateStockEvent)) do
                        connection:Fire()
                    end
                end
            end)
        end
    end)
end


kVars.boolSellIceCream = false
sectionFarm:Create("Toggle", "Sell Ice Cream thats in inventory", function(bool)
    kVars.boolSellIceCream = bool
    if bool then
        fSellIceCream()
    else
        for _, connection in pairs(getconnections(updateStockEvent)) do
            connection:Fire()
        end
    end
end,{default = kVars.boolSellIceCream})

function fSellIceCream()
    spawn(function()
        while kVars.boolSellIceCream do
            wait()
            pcall(function()
                local a = game:GetService("Players").LocalPlayer.Stock:GetChildren()
                if next(a) ~= nil then
                    for i,v in pairs(game:GetService("Players").LocalPlayer.Stock:GetChildren()) do
                        if v.Stock.Value ~= 0 then
                            repeat
                                wait()
                                for b,n in pairs(game:GetService("Workspace")["_NPCLocations"]:GetChildren()) do
                                    for g,h in pairs(n.NPCs:GetChildren()) do
                                        if v:FindFirstChild("Flavour") then
                                            if  v.Flavour.Value == h.Flavour.Value and h.HasIceCream.Value == false and h.Generation.Value == v.Type.Value then
                                                if (h.HumanoidRootPart.Position - kVars.hrp.Position).magnitude > 6 then
                                                    kVars.hrp.CFrame = h.HumanoidRootPart.CFrame
                                                end
                                                wait(.2)
                                                local count = 1
                                                repeat
                                                    kVars.rs.RemoteEvents.SellIceCream:FireServer(h)
                                                    wait()
                                                    count = count + 1
                                                until v.Stock.Value == 0 or kVars.boolSellIceCream == false or h.HasIceCream.Value or count == 10
                                                for _, connection in pairs(getconnections(updateStockEvent)) do
                                                    connection:Fire()
                                                end
                                                if v.Stock.Value == 0 or kVars.boolSellIceCream == false then
                                                    for _, connection in pairs(getconnections(updateStockEvent)) do
                                                        connection:Fire()
                                                    end
                                                    break 
                                                end
                                            end
                                        end
                                    end
                                    if v.Stock.Value == 0 or kVars.boolSellIceCream == false then
                                        for _, connection in pairs(getconnections(updateStockEvent)) do
                                            connection:Fire()
                                        end
                                        break 
                                    end
                                end
                            until v.Stock.Value == 0 or kVars.boolSellIceCream == false
                        end
                    end
                end
            end)
        end
    end)
end

sectionMenus:Create("Button", "Ice Cream Menu", function()
    firesignal(game.ReplicatedStorage.RemoteEvents.DisplayIceCreamShop.OnClientEvent)
end,{animated = true})

sectionMenus:Create("Button", "Ice Cream Menu", function()
    firesignal(game.ReplicatedStorage.RemoteEvents.DisplayIceCreamShop.OnClientEvent)
end,{animated = true})


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

kVars.locationsList = {
    [1] = {name = "Spawn", cf = game:GetService("Workspace").SpawnLocation.CFrame},
    [2] = {name = "Equipment Shop", cf = CFrame.new(-1043, 6, 843)},
    [3] = {name = "Ice Cream Shop", cf = CFrame.new(-1039, 6, 759)},
    [4] = {name = "House Area 1", cf = CFrame.new(-639, 5, 872)},
    [5] = {name = "Windmill", cf = CFrame.new(326, 5, 1166)},
    [6] = {name = "Medeval Tent", cf = CFrame.new(-1006, 5, 457)},
    [7] = {name = "School", cf = CFrame.new(-806, 5, -13)},
    [8] = {name = "Park", cf = CFrame.new(-561, 5, 231)},
    [9] = {name = "Large Field", cf = CFrame.new(-35, 5, 19)},
    [10] = {name = "Launchpad", cf = CFrame.new(-320, 5, -677)},
    [11] = {name = "Truck Depot", cf = CFrame.new(-905, 5, 1118)},
    [12] = {name = "Sky Scraper", cf = CFrame.new(-290, 6, -1897)},
    [13] = {name = "Top of Sky Scraper", cf = CFrame.new(-288, 469, -1801)},
    [14] = {name = "Airstrip 1", cf = CFrame.new(-159, 5, -1288)},
    [15] = {name = "Airstrip 2", cf = CFrame.new(-4764, 6, -1720)},
    [16] = {name = "House Area 2", cf = CFrame.new(-498, 5, -1938)},
    [17] = {name = "Super Market", cf = CFrame.new(64, 5, -2086)},
    [18] = {name = "Beach", cf = CFrame.new(-59, 6, -2395)},
    [19] = {name = "Harbour", cf = CFrame.new(-1086, 6, -2387)},
    [20] = {name = "Island 1", cf = CFrame.new(-580, 6, -2888)},
    [21] = {name = "Island 2", cf = CFrame.new(-908, 6, -3197)},
    [22] = {name = "Ice Cave", cf = CFrame.new(122, 34, -3165)},
    [23] = {name = "Cave", cf = CFrame.new(588, 10, -2567)},
    [24] = {name = "Moon", cf = CFrame.new(28, 3298, -470)},
    [25] = {name = "Neptune", cf = CFrame.new(-11, 13686, -466)},
    [26] = {name = "Epic", cf = CFrame.new(-10, 18093, -460)},
    [27] = {name = "Train Station", cf = CFrame.new(349, -105, 425)},
    [28] = {name = "Ghost Area", cf = CFrame.new(7417, -104, 480)}
    
}

for i,v in ipairs(kVars.locationsList) do
    sectionLocations:Create("Button", v.name, function()
        kVars.hrp.CFrame = v.cf
    end,{animated = true})
end


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
end,{min = 50, max = 500, default = kVars.humanoid.JumpPower, precise = false, changablevalue = true})

spawn(function()
    while wait() do
        pcall(function()
            kVars.humanoid.WalkSpeed = kVars.walkSpeed
            kVars.humanoid.JumpPower = kVars.jumpHeight
        end)
    end
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