--[[
Game : 
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Money Simulator X GUI"
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
local sectionMineOres = pageMain:CreateSection("Mine Ores")
local sectionBuy = pageMain:CreateSection("Buy")
local sectionBuyHat = pageMain:CreateSection("Buy Hat")

local pageMenus = Window:CreateCategory("Menus")
local sectionMenus = pageMenus:CreateSection("Menus")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")
local sectionTeleport = pageTeleport:CreateSection("Area")
local sectionOreTeleport = pageTeleport:CreateSection("Ore")

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
sectionFarm:Create("Toggle", "Refill Bag",function(bool)
    kVars.boolRefillBag = bool
    if bool then
        fRefillBag()
    end
end,{default = kVars.boolRefillBag})

function fRefillBag()
    spawn(function()
        while kVars.boolRefillBag do
            wait()
            kVars.rs.FillMoney:FireServer()
        end
    end)
end

sectionFarm:Create("Toggle", "Drop Money",function(bool)
    kVars.boolDropMoney = bool
    if bool then
        fDropMoney()
    end
end,{default = kVars.boolDropMoney})

function fDropMoney()
    spawn(function()
        while kVars.boolDropMoney do
            wait()
            kVars.rs.GetMoney:FireServer("DropOn", 0)
        end
    end)
end

sectionFarm:Create("Toggle", "Gems",function(bool)
    kVars.boolGems = bool
    if bool then
        fGems()
    end
end,{default = kVars.boolGems})

function fGems()
    spawn(function()
        while kVars.boolGems do
            wait()
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.find(string.lower(v.Name), "gem") and v:FindFirstChild("Click") then
                    fireclickdetector(v.Click,1)
                end
            end
        end
    end)
end

sectionFarm:Create("Toggle", "Digital Money",function(bool)
    kVars.boolDigitalMoney = bool
    if bool then
        fDigitalMoney()
    end
end,{default = kVars.boolDigitalMoney})

function fDigitalMoney()
    spawn(function()
        while kVars.boolDigitalMoney do
            wait()
            if game:GetService("Players").LocalPlayer.PlayerGui.GameGui.DigitalFrame.GenerateBtn.Button.Text == "Generate" then
                game:GetService("ReplicatedStorage").GenerateDigitalMoney:FireServer()
            end
        end
    end)
end

sectionFarm:Create("Toggle", "Viruses",function(bool)
    kVars.boolViruses = bool
    if bool then
        fViruses()
    end
end,{default = kVars.boolViruses})

function fViruses()
    spawn(function()
        while kVars.boolViruses do
            task.wait()
            if game:GetService("Workspace").ComputerDefence1.Enemies:FindFirstChild("EnemyCube") then
                fireclickdetector(game:GetService("Workspace").ComputerDefence1.Enemies:FindFirstChild("EnemyCube").ClickDetector,1)
            end
        end
    end)
end

sectionFarm:Create("Toggle", "Claim Missions",function(bool)
    kVars.boolClaimMissions = bool
    if bool then
        fClaimMissions()
    end
end,{default = kVars.boolClaimMissions})

kVars.MissionCompleteColor = "Completed"

function fClaimMissions()
    spawn(function()
        while kVars.boolClaimMissions do
            wait()
            local mf = game:GetService("Players").LocalPlayer.PlayerGui.GameGui.MissionFrame.Missions
            if mf.Mission1.MissionProgress.ProgressText.Text == kVars.MissionCompleteColor then
                --game:GetService("ReplicatedStorage").ClaimMission:FireServer(1)
                firesignal(mf.Mission1.ClaimBtn.Button.MouseButton1Click)

            end
            if mf.Mission2.MissionProgress.ProgressText.Text == kVars.MissionCompleteColor then
                --game:GetService("ReplicatedStorage").ClaimMission:FireServer(2)
                firesignal(mf.Mission2.ClaimBtn.Button.MouseButton1Click)
            end
            if mf.Mission3.MissionProgress.ProgressText.Text == kVars.MissionCompleteColor then
                --game:GetService("ReplicatedStorage").ClaimMission:FireServer(3)
                firesignal(mf.Mission3.ClaimBtn.Button.MouseButton1Click)
            end
        end
    end)
end

---- section mine ores ----
kVars.OreNames = {
    "ALL", "Silver", "Diamond", "Gold", "Ruby", "Gem", "Uranium", "Kryptonite", "Obsidian", "Unobtainium", "Bedrock", "Pumpkin", "Gift", "Egg"
}

kVars.MineSelectedOre = kVars.OreNames[1]
sectionMineOres:Create("DropDown", "Select an ore to mine", function(value)
    kVars.MineSelectedOre = value
end,{options = kVars.OreNames, default = kVars.OreNames[1], search = true})

sectionMineOres:Create("Toggle", "Closest Ores",function(bool)
    kVars.boolClosestOre = bool
    if bool then
        fClosestOre()
    end
end,{default = kVars.boolClosestOre})

function fClosestOre()
    spawn(function()
        while kVars.boolClosestOre do
            wait()
            last = math.huge
            closest = "nil"
            hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            for i,v in pairs(game.Workspace.Ores:GetChildren()) do
                if v:FindFirstChild("TouchInterest") and v.Transparency < 0.81 and string.match(v.Gui.HPBar.HP.Text, '%d+') ~= "0" and not(string.find(string.lower(v.Gui.HPBar.HP.Text), "wait"))  then
                    if string.find(string.lower(v.Name), string.lower(kVars.MineSelectedOre)) or kVars.MineSelectedOre == "ALL" then
                        local mag = (hrp.Position - v.Position).magnitude
                        if mag < last then
                            last = mag
                            closest = v
                        end
                    end
                end
            end
            if closest ~= "nil" then
                firetouchinterest(hrp, closest, 1)
                firetouchinterest(hrp, closest, 0)
                firetouchinterest(hrp, closest, 1)
                firetouchinterest(hrp, closest, 0)
            end
        end
    end)
end


---- section Buy ----
sectionBuy:Create("Toggle", "Power",function(bool)
    kVars.boolBuyPower = bool
    if bool then
        fBuyPower()
    end
end,{default = kVars.boolBuyPower})

function fBuyPower()
    spawn(function()
        while kVars.boolBuyPower do
            wait()
            kVars.rs.UpgradePower:FireServer()
        end
    end)
end

sectionBuy:Create("Toggle", "Bag",function(bool)
    kVars.boolBuyBag = bool
    if bool then
        fBuyBag()
    end
end,{default = kVars.boolBuyBag})

function fBuyBag()
    spawn(function()
        while kVars.boolBuyBag do
            wait()
            kVars.rs.UpgradeBag:FireServer()
        end
    end)
end

sectionBuy:Create("Toggle", "Rank",function(bool)
    kVars.boolBuyRank = bool
    if bool then
        fBuyRank()
    end
end,{default = kVars.boolBuyRank})

function fBuyRank()
    spawn(function()
        while kVars.boolBuyRank do
            wait()
            kVars.rs.UpgradeRank:FireServer()
        end
    end)
end

sectionBuy:Create("Toggle", "Tier",function(bool)
    kVars.boolBuyTier = bool
    if bool then
        fBuyTier()
    end
end,{default = kVars.boolBuyTier})

function fBuyTier()
    spawn(function()
        while kVars.boolBuyTier do
            wait()
            kVars.rs.TierUp:FireServer()
        end
    end)
end


kVars.HatsNumList = {}
kVars.HatsNamesList = {}

for i,v in pairs(game:GetService("Workspace").CrateData:GetChildren()) do
    local tmpName = v.Name .. " $" ..  v.Price.Value
    table.insert(kVars.HatsNumList, {num = i, name = tmpName})
    table.insert(kVars.HatsNamesList, tmpName)
end

table.insert(kVars.HatsNumList, 1, {num = 0, name = "NONE"})
table.insert(kVars.HatsNamesList, 1, "NONE")
kVars.SelectedHatToOpen = kVars.HatsNumList[1]
sectionBuyHat:Create("DropDown", "Select A Hat", function(value)
    kVars.SelectedHatToOpen = value
end,{options = kVars.HatsNamesList, default = kVars.HatsNamesList[1], search = true})

sectionBuyHat:Create("Button", "Buy", function()
    if kVars.SelectedHatToOpen == "NONE" then return end
    for i,v in pairs(kVars.HatsNumList) do
        if v['name'] == kVars.SelectedHatToOpen then
            game:GetService("ReplicatedStorage").BuyHat:FireServer(v.num)
        end
    end
end,{animated = true})

----========== page Menus ==========----
---- section Menus ----

function fTouch(p)
    firetouchinterest(kVars.lp.Character.HumanoidRootPart, p, 1)
    firetouchinterest(kVars.lp.Character.HumanoidRootPart, p, 0)
end

sectionMenus:Create("Button", "Power", function()
    fTouch(game:GetService("Workspace").ShopPad1)
end,{animated = true})

sectionMenus:Create("Button", "Bags", function()
    fTouch(game:GetService("Workspace").ShopPad2)
end,{animated = true})

sectionMenus:Create("Button", "Ranks", function()
    fTouch(game:GetService("Workspace").ShopPad3)
end,{animated = true})

sectionMenus:Create("Button", "Tier", function()
    fTouch(game:GetService("Workspace").ShopPad4)
end,{animated = true})

sectionMenus:Create("Button", "Upgrades", function()
    fTouch(game:GetService("Workspace").OrePad)
end,{animated = true})

sectionMenus:Create("Button", "Research", function()
    fTouch(game:GetService("Workspace").ResearchPad)
end,{animated = true})

sectionMenus:Create("Button", "Missions", function()
    fTouch(game:GetService("Workspace").MissionPad)
end,{animated = true})

sectionMenus:Create("Button", "Runes", function()
    fTouch(game:GetService("Workspace").RunesPad)
end,{animated = true})

sectionMenus:Create("Button", "Hats", function()
    fTouch(game:GetService("Workspace").HatsPad)
end,{animated = true})

sectionMenus:Create("Button", "Perks", function()
    fTouch(game:GetService("Workspace").PerksPad)
end,{animated = true})

sectionMenus:Create("Button", "Crystal", function()
    fTouch(game:GetService("Workspace").CrystalPad)
end,{animated = true})

sectionMenus:Create("Button", "Craft/Generate", function()
    fTouch(game:GetService("Workspace").CraftPad3)
end,{animated = true})

sectionMenus:Create("Button", "Elements/Lab", function()
    fTouch(game:GetService("Workspace").LabPad1)
end,{animated = true})

sectionMenus:Create("Button", "Upgrades/Lab", function()
    fTouch(game:GetService("Workspace").LabPad2)
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



---- section mine teleports ----
function fTele(l)
    kVars.lp.Character.HumanoidRootPart.CFrame = l
end

sectionTeleport:Create("Button", "Spawn", function()
    fTele(game:GetService("Workspace").SpawnLocation.CFrame)
end,{animated = true})

sectionTeleport:Create("Button", "Area1", function()
    fTele(CFrame.new(98, 8, 82))
end,{animated = true})

sectionTeleport:Create("Button", "Area2", function()
    fTele(CFrame.new(-39, 8, 141))
end,{animated = true})

sectionTeleport:Create("Button", "House Area", function()
    fTele(CFrame.new(1, 8, 392))
end,{animated = true})

sectionTeleport:Create("Button", "Area3", function()
    fTele(CFrame.new(-205, 19, 159))
end,{animated = true})

sectionTeleport:Create("Button", "Factory", function()
    fTele(CFrame.new(-344, 31, 152))
end,{animated = true})

sectionTeleport:Create("Button", "Lab", function()
    fTele(CFrame.new(-320, 34, 348))
end,{animated = true})


---- section mine ores ----
sectionOreTeleport:Create("Button", "Silver", function()
    fTele(CFrame.new(196, 14, -5))
end,{animated = true})

sectionOreTeleport:Create("Button", "Diamond", function()
    fTele(CFrame.new(177, 14, -103))
end,{animated = true})

sectionOreTeleport:Create("Button", "Gold", function()
    fTele(CFrame.new(263, 13, -8))
end,{animated = true})

sectionOreTeleport:Create("Button", "Ruby", function()
    fTele(CFrame.new(-115, 8, 183))
end,{animated = true})

sectionOreTeleport:Create("Button", "Gem", function()
    fTele(CFrame.new(-200, 32, 71))
end,{animated = true})

sectionOreTeleport:Create("Button", "Uranium", function()
    fTele(CFrame.new(-303, -65, 242))
end,{animated = true})

sectionOreTeleport:Create("Button", "Kryptonite", function()
    fTele(CFrame.new(-302, -65, 322))
end,{animated = true})

sectionOreTeleport:Create("Button", "Obsidian", function()
    fTele(CFrame.new(-320, -69, 348))
end,{animated = true})

sectionOreTeleport:Create("Button", "Unobtainium", function()
    fTele(CFrame.new(-319, -66, 426))
end,{animated = true})



----========== page character ==========----
---- section Character ----
kVars.walkSpeed = kVars.lp.Stats.MoreSpeed.Value
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.lp.Stats.MoreSpeed.Value = value
end,{min = 1, max = 500, default = kVars.lp.Stats.MoreSpeed.Value, precise = false, changablevalue = true})

kVars.jumpHeight = kVars.humanoid.JumpHeight
sectionCharacter:Create("Slider", "Jump Height", function(value)
    kVars.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 7.2, max = 500, default = kVars.humanoid.jumpHeight, precise = true, changablevalue = true})


kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.lp.Stats.MoreSpeed.Value = kVars.walkSpeed
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