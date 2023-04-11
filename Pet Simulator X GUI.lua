--[[
Game : https://www.roblox.com/games/6284583030
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Pet Simulator X GUI"
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
local sectionMainCollect = pageMain:CreateSection("Collect")

local pageEggsPets = Window:CreateCategory("Eggs/Pets")
local sectionOpenEggs = pageEggsPets:CreateSection("Eggs")
local sectionDeletePetByName = pageEggsPets:CreateSection("Delete Pets By Type")

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


kVars.boolAutoClick = false
sectionFarm:Create("Toggle", "Auto Attack",function(bool)
    kVars.boolAutoClick = bool
    if bool then
        fAutoClick()
    end
end,{default = kVars.boolAutoClick})

kVars.scriptLibrary = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
kVars.SelectedCoin = ""
function fAutoClick()
    spawn(function()       
        while kVars.boolAutoClick do          
            local last = math.huge
            task.wait(0.5)
            local tmpSelection = ""
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:GetChildren()) do
                if kVars.boolAutoClick == false then
                    break 
                end
                if v:FindFirstChild("POS") then                   
                    local distance = (kVars.lp.Character.HumanoidRootPart.Position - v.POS.Position).magnitude
                    if distance < last then
                        if kVars.scriptLibrary.WorldCmds.HasArea((v:GetAttribute("Area"))) then
                            tmpSelection = v
                            last = distance
                        end
                    end
                end
            end
            if tmpSelection ~= "" then
                kVars.SelectedCoin = tmpSelection
            end
        end
    end)
    spawn(function()
        while kVars.boolAutoClick do
            task.wait(0.5)
            
            if kVars.SelectedCoin ~= "" and kVars.SelectedCoin:FindFirstChild("Coin") then
                kVars.scriptLibrary .Signal.Fire("Group Select Coin", kVars.SelectedCoin)
            end
        end
    end)
end


---- section collect ----
kVars.boolCollectOrbs = false
sectionMainCollect:Create("Toggle", "Collect Orbs",function(bool)
    kVars.boolCollectOrbs = bool
    if bool then
        fCollectOrbs()
    end
end,{default = kVars.boolCollectOrbs})

function fCollectOrbs()
    spawn(function()
        while kVars.boolCollectOrbs do
            task.wait(0.5)
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()) do
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                if kVars.varOrbs == false then return end
            end
        end
    end)
end


kVars.booCollectLootBags = false
sectionMainCollect:Create("Toggle", "Collect Loot Bags",function(bool)
    kVars.boolCollectLootBags = bool
    if bool then
        fCollectLootBags()
    end
end,{default = kVars.booCollectLootBags})

function fCollectLootBags()
    spawn(function()
        while kVars.boolCollectLootBags do
            task.wait(0.5)
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end)
end

kVars.booCollectAllGifts = false
sectionMainCollect:Create("Toggle", "Collect Gifts",function(bool)
    kVars.booCollectAllGifts = bool
    if bool then
        fCollectAllGifts()
    end
end,{default = kVars.booCollectAllGifts})

function fCollectAllGifts()
    spawn(function()
        while kVars.booCollectAllGifts do   
            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.FreeGifts.Frame.Container.Gifts:GetChildren()) do
                if v.ClassName == "TextButton" and string.find(v.name, "Gift") and v.Text ~= "" then
                    workspace.__THINGS.__REMOTES:FindFirstChild("redeem free gift"):InvokeServer({tonumber(string.match(v.name,"%d+"))})
                end
            end
            task.wait(20)
        end
    end)
end


----========== page Eggs pets ==========----

kVars.EggsList = {}

kVars.EggsListNames = {}

for i,v in pairs(kVars.rs["__DIRECTORY"].Eggs:GetDescendants()) do
    if v.ClassName == "ModuleScript" then
        local a = require(v)
        if a["hatchable"] then
            local costFormated = kVars.scriptLibrary.Functions.NumberShorten(a["cost"], false)
            table.insert(kVars.EggsList, {realName = v.name, name =  v.name .. " - " .. costFormated, cost = a["cost"], currency = a["currency"]})
        end
    end
end

table.sort(kVars.EggsList, function(a,b)
    return a["cost"] < b["cost"]
end)

table.foreach(kVars.EggsList, function(i,v) table.insert(kVars.EggsListNames, v["name"]) end)



kVars.selectedEgg = kVars.EggsList[1]["realName"]
sectionOpenEggs:Create("DropDown", "Select and egg to open", function(value)
    for i,v in pairs(kVars.EggsList) do
        if v["name"] == value then
            kVars.selectedEgg = v["realName"]
            break
        end
    end
end,{options = kVars.EggsListNames, default = kVars.selectedEgg, search = true})

kVars.boolOpenEgg = false
sectionOpenEggs:Create("Toggle", "Open",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            task.wait(0.5)
            kVars.scriptLibrary.Network.Invoke("buy egg", kVars.selectedEgg, false)
        end
    end)
end

---- section delete pet by name ----
sectionDeletePetByName:Create("Textlabel", "**CAUTION**")
sectionDeletePetByName:Create("Textlabel", 
[[Changing the name of your pet
will not stop the deletion!!]])

kVars.petsList = {}
kVars.petsListNames = {}
for i,v in pairs(kVars.rs["__DIRECTORY"].Pets:GetChildren()) do
    local a,b = string.find(v.name, "%a+")
    local str = string.sub(v.name,a,#v.name)
    local id = tonumber(string.split(v.name, "-")[1])
    table.insert(kVars.petsList,{name = str, id = id})
    table.insert(kVars.petsListNames, str)
end

table.sort(kVars.petsListNames)
table.insert(kVars.petsListNames, 1, "NONE")

kVars.selectedpet = {}
for i=1,6 do
    kVars.selectedpet[i] = kVars.petsListNames[1]
    sectionDeletePetByName:Create("DropDown", "Select a pet to delete", function(value)
        kVars.selectedpet[i] = value
    end,{options = kVars.petsListNames, default = kVars.petsListNames[1], search = true})
end

kVars.boolDeletePetByName = false
sectionDeletePetByName:Create("Toggle", "Delete",function(bool)
    kVars.boolDeletePetByName = bool
    if bool then
        fDeletePetByName()
    end
end,{default = kVars.boolDeletePetByName})

function fDeletePetByName()
    spawn(function()
        while kVars.boolDeletePetByName do    
            local petsListToDelete = {}
            for i,v in pairs(kVars.scriptLibrary.Save.Get().Pets) do
                for i=1,6 do
                    if kVars.selectedpet[i] ~= "NONE" then 
                        for g,h in pairs(kVars.petsList) do
                            if h.name == kVars.selectedpet[i] then
                                if v.id == h.id then
                                    table.insert(petsListToDelete, v.uid)
                                    break
                                end
                            end
                        end
                    end
                end
            end
            kVars.scriptLibrary.Network.Invoke("Delete Several Pets", petsListToDelete)
            task.wait(2)
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

kVars.jumpPower = kVars.humanoid.JumpPower
sectionCharacter:Create("Slider", "Jump Power", function(value)
    kVars.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 1, max = 500, default = kVars.humanoid.jumpPower, precise = false, changablevalue = true})


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
    if not bool and kVars.Loaded then
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
    if kVars.Esp[player] ~= nil then
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
kVars.Loaded = true