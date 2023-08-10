--[[
Game : https://www.roblox.com/games/2756231960
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Balloon Simulator GUI"
kVars.placeID = 2756231960
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
local sectionCollect = pageMain:CreateSection("Collect")

local pageBuy = Window:CreateCategory("Buy")
local sectionBuy = pageBuy:CreateSection("Buy")

local pageEggs = Window:CreateCategory("Eggs/Pets")
local sectionEggs = pageEggs:CreateSection("Open Eggs")
local sectionPets = pageEggs:CreateSection("Delete Pets")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")
local sectionTpLocations = pageTeleport:CreateSection("Teleport to Locations")

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
sectionFarm:Create("Toggle", "Balloons",function(bool)
    kVars.boolBalloons = bool
    if bool then
        fBalloons()
    end
end,{default = kVars.boolBalloons})

function fBalloons()
    spawn(function()
        while kVars.boolBalloons do
            wait()
            game:GetService("ReplicatedStorage").FillBalloon:FireServer()
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
            wait()
            game:GetService("ReplicatedStorage").Sell:FireServer(game:GetService("Workspace").UITriggers.Sell2)
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
            wait()
            local coins = kVars.lp.leaderstats.Coins.Value
            local rebirths = kVars.lp.leaderstats.Rebirths.Value
            if rebirths == nil or rebirths == 0 then
                rebirths = 0
            else
                rebirths =  25000000 *  kVars.lp.leaderstats.Rebirths.Value
            end
            if coins >= rebirths and kVars.lp.Character:FindFirstChild("Humanoid") then
                if not kVars.lp.UnlockedIslandsFolder:FindFirstChild("Roboland") and kVars.lp.Character:FindFirstChild("HumanoidRootPart") then
                    kVars.hrp.CFrame = CFrame.new(218, 63363, 2001)
                end
                game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
                wait(.2)
            end
        end
    end)
end

---- secton collect ----
sectionCollect:Create("Toggle", "Coins",function(bool)
    kVars.boolCoins = bool
    if bool then
        fCoins()
    end
end,{default = kVars.boolCoins})

function fCoins()
    spawn(function()
        while kVars.boolCoins do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins:GetChildren()) do
                if kVars.boolCoins == false then break end
                if kVars.lp.Character:FindFirstChild("HumanoidRootPart") and kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
            end
        end
    end)
end


sectionCollect:Create("Toggle", "Gems",function(bool)
    kVars.boolGems = bool
    if bool then
        fGems()
    end
end,{default = kVars.boolGems})

function fGems()
    spawn(function()
        while kVars.boolGems do
            wait()
            for i,v in pairs(game:GetService("Workspace").Gems:GetChildren()) do
                if kVars.boolGems == false then break end
                if kVars.lp.Character:FindFirstChild("HumanoidRootPart") and kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
            end
        end
    end)
end


sectionCollect:Create("Toggle", "Teeth",function(bool)
    kVars.boolTeeth = bool
    if bool then
        fTeeth()
    end
end,{default = kVars.boolTeeth})

function fTeeth()
    spawn(function()
        while kVars.boolTeeth do
            wait()
            for i,v in pairs(game:GetService("Workspace").Tooths:GetChildren()) do
                if kVars.boolTooths == false then break end
                if kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
            end
        end
    end)
end


sectionCollect:Create("Toggle", "Chests",function(bool)
    kVars.boolChests = bool
    if bool then
        fChests()
    end
end,{default = kVars.boolChests})

function fChests()
    spawn(function()
        while kVars.boolChests do
            wait()
            for i,v in pairs(game:GetService("Workspace").Chests:GetChildren()) do
                if kVars.boolChests == false then break end
                if v.Transparency ~= 0.9 and kVars.lp.Character:FindFirstChild("HumanoidRootPart") and kVars.lp.Character:FindFirstChild("Humanoid") then
                    firetouchinterest(kVars.hrp,v,0)
                    wait()
                    firetouchinterest(kVars.hrp,v,1)
                end
            end
        end
    end)
end


----========== page buy ==========----
---- section buy ----


sectionBuy:Create("Toggle", "Helium",function(bool)
    kVars.boolHelium = bool
    if bool then
        fHelium()
    end
end,{default = kVars.boolHelium})

--kVars.heliumList = {}
kVars.heliumNamesList = {}
for i,v in pairs(kVars.rs.HeliumStats.HeliumPrice:GetChildren()) do
    if v.Name ~= "VIP" then
        --table.insert(kVars.heliumList, {name = v.Name, displayName = v.Name .. " $" .. v.Value, cost = v.Value})
        table.insert(kVars.heliumNamesList, v.Name)
    end
end

function fHelium()
    spawn(function()
        while kVars.boolHelium do
            wait()
            for i=#kVars.heliumNamesList, 1, -1 do
                if i > table.find(kVars.heliumNamesList, kVars.lp:WaitForChild("CurrentHelium").Value) then
                    if tonumber(kVars.rs.HeliumStats.HeliumPrice[kVars.heliumNamesList[i]].Value) <= tonumber(kVars.lp.leaderstats.Coins.Value) then
                        if kVars.lp:WaitForChild("CurrentHelium").Value ~= "Zeus" and kVars.lp:WaitForChild("CurrentHelium").Value ~= kVars.heliumNamesList[i] then
                            game:GetService("ReplicatedStorage").BuyHelium:InvokeServer(kVars.heliumNamesList[i])
                            game:GetService("ReplicatedStorage").EquipHelium:FireServer(kVars.heliumNamesList[i])
                        end
                    end
                end
            end     
        end
    end)
end




kVars.balloonNamesList = {}
for i,v in pairs(kVars.rs.BalloonStats.BalloonPrice:GetChildren()) do
    if not string.find(v.Name, "VIP") then
        --table.insert(kVars.heliumList, {name = v.Name, displayName = v.Name .. " $" .. v.Value, cost = v.Value})
        table.insert(kVars.balloonNamesList, v.Name)
    end
end

sectionBuy:Create("Toggle", "Ballon",function(bool)
    kVars.boolBuyBalloon = bool
    if bool then
        fBuyBalloon()
    end
end,{default = kVars.boolBuyBalloon})

function fBuyBalloon()
    spawn(function()
        while kVars.boolBuyBalloon do
            wait()
            for i=#kVars.balloonNamesList, 1, -1 do
                if i > table.find(kVars.balloonNamesList, kVars.lp:WaitForChild("CurrentBalloon").Value) then
                    if tonumber(kVars.rs.BalloonStats.BalloonPrice[kVars.balloonNamesList[i]].Value) <= tonumber(kVars.lp.leaderstats.Coins.Value) then
                        if kVars.lp:WaitForChild("CurrentHelium").Value ~= "VOID" and kVars.lp:WaitForChild("CurrentHelium").Value ~= kVars.balloonNamesList[i] then
                            game:GetService("ReplicatedStorage").BuyBalloon:InvokeServer(kVars.balloonNamesList[i])
                            game:GetService("ReplicatedStorage").EquipBalloon:FireServer(kVars.balloonNamesList[i])
                        end
                    end
                end
            end   
        end
    end)
end


----========== page eggs/pets ==========----
---- section eggs ----
kVars.eggsList = {}
kVars.eggNamesList = {}
for i,v in pairs(game:GetService("Workspace").PetDispensers:GetChildren()) do
    if v:FindFirstChild("PriceType").Value == "Coins" then
        local price = tonumber(v.Price.Value)
        table.insert(kVars.eggsList, {name = v.name, displayName = v.name .. " $" .. price, cost = price})
        table.insert(kVars.eggNamesList, v.name .. " $" .. price)
    end
end
table.sort(kVars.eggsList,function(a,b)
    return a.cost < b.cost
end)
local b = {}
for i,v in pairs(game:GetService("Workspace").PetDispensers:GetChildren()) do
    if v:FindFirstChild("PriceType").Value == "Gems" then
        local price = tonumber(v.Price.Value)
        table.insert(b, {name = v.name, displayName = v.name .. " G" .. price, cost = price})
    end
end
table.sort(b,function(a,b)
    return a.cost < b.cost
end)
for i,v in pairs(b) do
    table.insert(kVars.eggsList, v)
    table.insert(kVars.eggNamesList, v.displayName)
end

kVars.selectedEgg = kVars.eggNamesList[1]
sectionEggs:Create("DropDown", "Select and egg to open", function(value)
    kVars.selectedEgg = value
end,{options = kVars.eggNamesList, default = kVars.eggNamesList[1], search = true})

kVars.EggsToOpen = 1
sectionEggs:Create("Toggle", "Open 3 *Must have bought",function(bool)
    if bool then
        kVars.EggsToOpen = 3
    else
        kVars.EggsToOpen = 1
    end
end,{default = false})


sectionEggs:Create("Toggle", "Open",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()

            local num = 1
            for i,v in pairs(kVars.eggsList) do
                if kVars.selectedEgg == v.displayName then
                    num = i
                    break
                end
            end
            kVars.rs.PurchasePetFunction:InvokeServer(workspace.PetDispensers[kVars.eggsList[num].name], kVars.EggsToOpen)
        end
    end)
end

---- section pet ---

kVars.petList = {}
for i,v in pairs(game:GetService("ReplicatedStorage").PetImages:GetChildren()) do
    table.insert(kVars.petList, v.Name)
end
table.sort(kVars.petList)
table.insert(kVars.petList, 1, "NONE")

kVars.SelectedPet1 = "NONE"
sectionPets:Create("DropDown", "Select pet to delete", function(value)
    kVars.SelectedPet1 = value
end,{options = kVars.petList, default = kVars.petList[1], search = true})

kVars.SelectedPet2 = "NONE"
sectionPets:Create("DropDown", "Select pet to delete", function(value)
    kVars.SelectedPet2 = value
end,{options = kVars.petList, default = kVars.petList[1], search = true})

kVars.SelectedPet3 = "NONE"
sectionPets:Create("DropDown", "Select pet to delete", function(value)
    kVars.SelectedPet3 = value
end,{options = kVars.petList, default = kVars.petList[1], search = true})

kVars.SelectedPet4 = "NONE"
sectionPets:Create("DropDown", "Select pet to delete", function(value)
    kVars.SelectedPet4 = value
end,{options = kVars.petList, default = kVars.petList[1], search = true})

kVars.SelectedPet5 = "NONE"
sectionPets:Create("DropDown", "Select pet to delete", function(value)
    kVars.SelectedPet5 = value
end,{options = kVars.petList, default = kVars.petList[1], search = true})


sectionPets:Create("Toggle", "Delete Pets",function(bool)
    kVars.boolDeletePet = bool
    if bool then
        fDeletePet()
    end
end,{default = kVars.boolDeletePet})

function fDeletePet()
    spawn(function()
        while kVars.boolDeletePet do
            wait()
            for i,v in pairs(kVars.lp.OwnedPets:GetChildren()) do
                if kVars.boolDeletePet == false then break end
                if v.Name == kVars.SelectedPet1 or v.Name == kVars.SelectedPet2 or v.Name == kVars.SelectedPet3 or v.Name == kVars.SelectedPet4 or v.Name == kVars.SelectedPet5 then
                    kVars.rs.DeletePet:FireServer(v)
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


---- section teleport locations ----
---------- Teleport Page ----------
kVars.Locations = {
    [1] = {name = "Spawn", cf = game:GetService("Workspace").NewThing.SpawnLocation.CFrame},
    [2] = {name = "Tropical Paradise", cf = CFrame.new(192, 974, 1705)},
    [3] = {name = "Ancient Greece", cf = CFrame.new(33, 3280, 1701)},
    [4] = {name = "CandyLand", cf = CFrame.new(90, 8062, 1696)},
    [5] = {name = "Archerville", cf = CFrame.new(74, 13968, 1498)},
    [6] = {name = "Toyland", cf = CFrame.new(193, 22661, 1762)},
    [7] = {name = "Alienland", cf = CFrame.new(177, 40996, 1944)},
    [8] = {name = "Dinoland", cf = CFrame.new(221, 53818, 2020)},
    [9] = {name = "Robloland", cf = CFrame.new(218, 63363, 2001)},
    [10] = {name = "Aquaworld", cf = CFrame.new(-2329, -1413, 199)},
    [11] = {name = "Aqualand", cf = CFrame.new(-2349, 1594, 57)},
    [12] = {name = "Dragonworld", cf = CFrame.new(158, 53, -84)},
    [13] = {name = "Dragonland", cf = CFrame.new(183, 3132, -210)}
}

for i,v in pairs(kVars.Locations) do
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