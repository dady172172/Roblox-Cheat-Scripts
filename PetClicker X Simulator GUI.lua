--[[
Game : https://www.roblox.com/games/12721734118
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "PetClicker X Simulator GUI"
kVars.placeID = 12721734118
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
local sectionFarm = pageMain:CreateSection("Farm")

local pageEggsPets = Window:CreateCategory("Eggs/Pets")
local sectionEggs = pageEggsPets:CreateSection("Eggs")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")
local sectionTpLocations = pageTeleport:CreateSection("Teleport To Locations")

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
sectionFarm:Create("Toggle", "Click",function(bool)
    kVars.boolClick = bool
    if bool then
        fClick()
    end
end,{default = kVars.boolClick})

function fClick()
    spawn(function()
        while kVars.boolClick do
            task.wait()
            game:GetService("ReplicatedStorage").events.ClickEvent:FireServer("cReq", false)
        end
    end)
end

sectionFarm:Create("Toggle", "Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then
        fRebirth()
    end
end,{default = kVars.boolRebirth})

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            task.wait(1)
            if kVars.boolRebirth == false then break end
            local plrClicks = tonumber(kVars.lp.leaderstats.Clicks.Value)
            if plrClicks > 10250 then
                local num = math.floor(plrClicks/10250)
                game:GetService("ReplicatedStorage").events.RebirthEvent:FireServer("req_Rebirth", num)
            end
        end
    end)
end


sectionFarm:Create("Toggle", "Collect Stars/Presents",function(bool)
    kVars.boolCollectStars = bool
    if bool then
        fCollectStars()
    end
end,{default = kVars.boolCollectStars})

function fCollectStars()
    spawn(function()
        while kVars.boolCollectStars do
            wait()
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.find(v.Name, "Star") and v:FindFirstChild("TouchInterest")  then
                    firetouchinterest(kVars.hrp, v, 0)
                    wait()
                    firetouchinterest(kVars.hrp, v, 1)
                elseif string.find(v.Name, "PresentBox") then
                    local g = v:FindFirstChild("Box001")
                    firetouchinterest(kVars.hrp, g, 0)
                    wait()
                    firetouchinterest(kVars.hrp, g, 1)
                    
                end
            end
        end
    end)
end

sectionFarm:Create("Toggle", "Finish Obby",function(bool)
    kVars.boolFinishObby = bool
    if bool then
        fFinishObby()
    end
end,{default = kVars.boolFinishObby})

function fFinishObby()
    spawn(function()
        while kVars.boolFinishObby do
            wait()
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if v:FindFirstChild("FinishPart") then
                    firetouchinterest(kVars.hrp, v.FinishPart, 0)
                    wait()
                    firetouchinterest(kVars.hrp, v.FinishPart, 1)
                end
            end
        end
    end)
end

sectionFarm:Create("Button", "Unlock Areas", function()
    kVars.lp.cache.unlockedZones.Value = ";1;3;2;5;4;7;6;9;8;11;10;12"
end,{animated = true})


sectionFarm:Create("Button", "Redeem all codes", function()
    local a = require(kVars.rs.Data.CodesData)
    for i,v in pairs(a) do
        kVars.rs.events.redeemCodeEvent:FireServer("redeem",tostring(i))
    end
end,{animated = true})

sectionFarm:Create("Button", "Chat all codes", function()
    local a = require(kVars.rs.Data.CodesData)
    for i,v in pairs(a) do
        kVars.rs.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(i),"All")
    end
end,{animated = true})




----========== page eggs pets ==========----
---- section eggs ----

kVars.EggsList = {}
for i,v in pairs(game:GetService("Workspace").map:GetChildren()) do
    if string.find(v.Name, "zone_") then
        table.insert(kVars.EggsList, v.Name)
    end
end
table.sort(kVars.EggsList, function(a,b)
    return tonumber(string.match(a, "%d+")) < tonumber(string.match(b, "%d+"))
end)

kVars.selectedEgg = kVars.EggsList[1]
sectionEggs:Create("DropDown", "", function(value)
    kVars.selectedEgg = value
end,{options = kVars.EggsList, default = kVars.EggsList[1], search = true})


sectionEggs:Create("Toggle", "Open Egg",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            task.wait()
            local args = {
                [1] = "egg_Hatch", -- all are this
                [2] = tostring(kVars.selectedEgg):gsub("^%l", string.upper), -- zone is the egg
                [3] = "hatch" -- all are this
            }
            game:GetService("ReplicatedStorage").events.HatcherEvent:FireServer(unpack(args))
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

--- section teleport locations ----
kVars.tpLocations = {
    {name = "Spawn", cf = game:GetService("Workspace").map.spawnLocs:FindFirstChild("SpawnLocation").CFrame},
    {name = "zone_1", cf = CFrame.new(-222, 6, 628)},
    {name = "zone_2", cf = CFrame.new(330, -5, 167)},
    {name = "zone_3", cf = CFrame.new(296, 6, 753)},
    {name = "zone_4", cf = CFrame.new(194, 9, -459)},
    {name = "zone_5", cf = CFrame.new(-152, 5, -810)},
    {name = "zone_6", cf = CFrame.new(529, 5, -1013)},
    {name = "zone_7", cf = CFrame.new(904, 1, -1457)},
    {name = "zone_8", cf = CFrame.new(-106, 5, 1101)},
    {name = "zone_9", cf = CFrame.new(701, 1, -405)},
    {name = "zone_11", cf = CFrame.new(1000, 6, 794)},
    {name = "zone_12", cf = CFrame.new(889, 5, 130)},
    {name = "VIP", cf = CFrame.new(171, -11, 1576)},
    {name = "Upgrade", cf = CFrame.new(-71, 8, 162)},
    {name = "Make Gold Pets", cf = CFrame.new(-162, 7, 10)}
}

for i,v in pairs(kVars.tpLocations) do
    sectionTpLocations:Create("Button", v.name, function()
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

