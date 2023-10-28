--[[
Game : https://www.roblox.com/games/8884334497
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Mining Clicker Simulator GUI"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
local suf = require(game:GetService("ReplicatedStorage").Modules.SuffixModule)
local statModule = require(game:GetService("ReplicatedStorage").Modules.statModule)
kVars.HttpService = game:GetService("HttpService")

---- destroy old gui if exists ----
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
    task.wait(2)
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
    MinSize = UDim2.new(0,400,0,300),
    MaxSize = UDim2.new(0,750,0,500)
})

local pageMain = Window:CreateCategory("Main")
local sectionFarm = pageMain:CreateSection("Farm")
local sectionBuyPickaxe = pageMain:CreateSection("Buy Pickaxe")

local pageEgg = Window:CreateCategory("Eggs/Pets")
local sectionPetUtilities = pageEgg:CreateSection("Pet Utilities")
local sectionOpenEggs = pageEgg:CreateSection("Open Eggs")
local sectionDelPetsByRarity = pageEgg:CreateSection("Delete Pet By Rarity *Lock pets you want to keep")
local sectionDelPetsByName = pageEgg:CreateSection("Delete Pet By Name *Lock pets you want to keep")

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
kVars.boolClick = false
sectionFarm:Create("Toggle", "Auto Click",function(bool)
    kVars.boolClick = bool
    if bool then
        if kVars.lp.PlayerGui.MainUI.RightSide.AutoClicker.tweenItem.amtOfCurrency.Text == "OFF" then
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.RightSide.AutoClicker.TextButton.Activated)
        end
        game.Players.LocalPlayer:SetAttribute("autoClickSpeed", 0)
    else
        if kVars.lp.PlayerGui.MainUI.RightSide.AutoClicker.tweenItem.amtOfCurrency.Text == "ON" then
            firesignal(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.RightSide.AutoClicker.TextButton.Activated)
        end
    end
end,{default = kVars.boolClick})

kVars.boolFarmDrill = false
sectionFarm:Create("Toggle", "Auto Collect Drill",function(bool)
    kVars.boolFarmDrill = bool
    if bool then
        fFarmDrill()
    end
end,{default = kVars.boolFarmDrill})

function fFarmDrill()
    spawn(function()
        while kVars.boolFarmDrill do
            
                if not game:GetService("Workspace"):FindFirstChild("Drill"):FindFirstChild("TPPart") then
                    game:GetService("ReplicatedStorage").Remotes.TeleportToPlace:InvokeServer("Cave")
                end
                task.wait(1)
                local drill = game:GetService("Workspace").Drill:WaitForChild("TPPart", 60000)
                if (kVars.lp.Character.HumanoidRootPart.Position - drill.Position).magnitude > 5 then 
                    local playerHalf = (kVars.lp.character.Head.Position - kVars.lp.character.LeftFoot.Position).magnitude / 2
                    local cf = CFrame.new(drill.CFrame.x, drill.CFrame.y + playerHalf, drill.CFrame.z)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
                end
                fireproximityprompt(game:GetService("Workspace").Drill.Drill.collectDrill)
        end
    end)
end
print("hello")
kVars.boolRebirth = false
sectionFarm:Create("Toggle", "Auto Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then
        fRebirth()
    end
end,{default = kVars.boolRebirth})
print("hello1")
function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            task.wait()
            local rebirthNeeded = 5000 + math.floor((game.Players.LocalPlayer:GetAttribute("Rebirths") + 1) ^ 4.29205 * 5000)
            local coins = game.Players.LocalPlayer:GetAttribute("Coins")
            if coins > rebirthNeeded then
                game:GetService("ReplicatedStorage").Remotes.Rebirth:FireServer()
            end
        end
    end)
end
print("hello2")
---- section buy pickaxe ----

local pickaxesModule = require(game:GetService("ReplicatedStorage").Modules.pickaxesModule)
kVars.pickaxeNameList = {}
kVars.pickaxeList = {}
kVars.pickaxelistcount = 0
for _ in pairs(pickaxesModule.picksInZone) do
    kVars.pickaxelistcount = kVars.pickaxelistcount + 1
end
kVars.pickaxelistcount = kVars.pickaxelistcount - 1
for i=0,kVars.pickaxelistcount do
    for b,v in pairs(pickaxesModule.picksInZone[tostring(i)]) do
        for g,h in pairs(pickaxesModule.picks) do
            if g == v then
                table.insert(kVars.pickaxeList,#kVars.pickaxeList + 1,{name = g .. " - $" .. suf.Suffix(h.Cost) , price = h.Cost, key = g})
                table.insert(kVars.pickaxeNameList,#kVars.pickaxeNameList + 1, g .. " - $" .. suf.Suffix(h.Cost))
                break
            end
        end

    end
end

kVars.selectedPickaxe = kVars.pickaxeNameList[1]
sectionBuyPickaxe:Create("DropDown", "Select pickaxe", function(value)   
    kVars.selectedPickaxe = value
end,{options = kVars.pickaxeNameList, default = kVars.pickaxeNameList[1], search = true})

sectionBuyPickaxe:Create("Button", "Buy", function()
    for i,v in pairs(kVars.pickaxeList) do
        if v.name == kVars.selectedPickaxe then
            if v.price < game:GetService("Players").LocalPlayer:GetAttribute("Coins") then
                game:GetService("ReplicatedStorage").Remotes.BuyPickaxe:InvokeServer(v.key)
                break
            end
        end
    end
end,{animated = true})


kVars.boolUpgradePick = false
sectionBuyPickaxe:Create("Toggle", "Auto Buy Next Pick",function(bool)
    kVars.boolUpgradePick = bool
    if bool then
        fUpgradePick()
    end
end,{default = kVars.boolUpgradePick})

function fUpgradePick()
    spawn(function()
        while kVars.boolUpgradePick do
            
            local plrCoins = kVars.lp:GetAttribute("Coins")
            local currentPickaxe = kVars.lp.Character:FindFirstChildOfClass("Tool").Name
            if currentPickaxe == kVars.pickaxeList[#kVars.pickaxeList]["key"] then
                --boolUpgradePick = false
                firesignal(game:GetService("CoreGui")[kVars.WindowName].Motherframe.Categories.MainCategory["Buy PickaxeSection"]["Auto Buy Next PickToggle"].MouseButton1Click)
                break
            end
            for i,v in pairs(kVars.pickaxeList) do
                if v.key == currentPickaxe then
                    if kVars.pickaxeList[i+1]["price"] <= plrCoins then
                        kVars.rs.Remotes.BuyPickaxe:InvokeServer(kVars.pickaxeList[i+1]["key"])
                    end
                    break
                end
            end
            task.wait(3)
        end
    end)
end

----========== page eggs ==========----
---- section pet utilities ----
kVars.boolUpgradePets = false
sectionPetUtilities:Create("Toggle", "Auto Upgrade pets",function(bool)
    kVars.boolUpgradePets = bool
    if bool then
        fUpgradePets()
    end
end,{default = kVars.boolUpgradePets})

function fUpgradePets()
    spawn(function()
        while kVars.boolUpgradePets do
            task.wait()
            local petInv = kVars.HttpService:JSONDecode(game.Players.LocalPlayer:GetAttribute("inventory"))
            local pets = {}
            pets.norm ={}
            pets.golden = {}
            pets.diamond = {}
            pets.emerald = {}
            pets.darkmatter = {}
            for i,v in pairs(petInv) do
                if v[2] ~= nil then
                    if v[2] == "Golden" then
                        table.insert(pets.golden,{name = v[1],id = i})
                    elseif v[2] == "Diamond" then
                        table.insert(pets.diamond,{name = v[1], id = i})
                    elseif v[2] == "Emerald" then
                        table.insert(pets.emerald,{name = v[1], id = i})
                    elseif v[2] == "Darkmatter" then
                        table.insert(pets.darkmatter,{name = v[1], id = i})                   
                    end
                else
                    table.insert(pets.norm,{name = v[1], id = i})
                end
            end

            for g,h in pairs(pets) do
                if kVars.lp:FindFirstChild("Better Upgrade") then
                    local count = math.floor(#pets[g]/2)
                    local type = nil
                    
                    if g ~= "norm" then
                        type = tostring(g)
                    end
                    if count ~= 0 then   
                        for i=1,count,2 do
                            

                            game:GetService("ReplicatedStorage").Remotes.CraftToGold:FireServer(h[i]["name"], type, {[h[i]["id"]] = true, [h[i+1]["id"]] = true})
                        end
                    end
                else
                    local count = math.floor(#pets[g]/3)
                    if count ~= 0 then   
                        for i=1,count,3 do
                            local t = {[pets[g][i].id] = true, [pets[g][i+1].id] = true, [pets[g][i+2].id] = true}
                            game:GetService("ReplicatedStorage").Remotes.CraftToGold:FireServer(pets[g][i].name,t)
                        end
                    end

                end
            end
            game:GetService("ReplicatedStorage").Remotes.UpdatePetValues:FireServer()
            task.wait(1)
        end
    end)
end

kVars.boolAutoEquipBest = false
sectionPetUtilities:Create("Toggle", "Auto Equip Best",function(bool)
    kVars.boolAutoEquipBest = bool
    if bool then
        fAutoEquipBest()
    end
end,{default = kVars.boolAutoEquipBest})

kVars.module_inventoryController = require(game.ReplicatedStorage.Modules.inventoryController)
function fAutoEquipBest()
    spawn(function()
        while kVars.boolAutoEquipBest do
            kVars.module_inventoryController:equipBest()
            task.wait(15)
        end
    end)
end

---- section open eggs ----
kVars.eggsList = {}
local tmpEggInfo = statModule.eggCosts
kVars.eggInfo = {}
table.foreach(tmpEggInfo, function(i,v) table.insert(kVars.eggInfo, {i,v}) end)
table.sort(kVars.eggInfo, function(a,b) return a[2] < b[2] end)
kVars.eggsListNames = {}
table.foreach(kVars.eggInfo, function(i,v) table.insert(kVars.eggsListNames, v[1] .. " - $" .. suf.Suffix(v[2])) end)
kVars.selectedEgg = kVars.eggsListNames[1]
sectionOpenEggs:Create("DropDown", "Select an egg to open", function(value)
    kVars.selectedEgg = value
end,{options = kVars.eggsListNames, default = kVars.eggsListNames[1], search = true})

kVars.openAmount = 1
kVars.boolOpen3Eggs = false
sectionOpenEggs:Create("Toggle", "Open three Eggs *Need Gamepass",function(bool)
    if bool then
        kVars.openAmount = 3
    else
        kVars.openAmount = 1
    end
end,{default = kVars.boolOpen3Eggs})

kVars.boolOpenEgg = false
sectionOpenEggs:Create("Toggle", "Auto Open Egg",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            task.wait()
            game.Players.LocalPlayer:SetAttribute("hatchSpeed", 0)
            local a = nil
            table.foreach(kVars.eggsListNames, function(i,v) if v == kVars.selectedEgg then a = i end end)
            game:GetService("ReplicatedStorage").Remotes.buyEgg:InvokeServer(kVars.eggInfo[a][1],tonumber(kVars.openAmount))
        end
    end)
end





---- pet delete by rarity ----

local petList = {}
local petNamesList = {}
for i,v in pairs(statModule.itemInfo) do 
        table.insert(petList, {name = i, rarity = v['Rarity']})
end
---- common  Rare  Unique  Epic  Legendary  Mythical  Secret Exclusive
function fDeletePetsByRarity()
    spawn(function()
        while kVars.boolDeletePetsByRarity do
            task.wait()
            local petInv = kVars.HttpService:JSONDecode(game.Players.LocalPlayer:GetAttribute("inventory"))
            local petInInv = nil
            petInInv = {}
            local delList = nil
            delList = {}
            for i,v in pairs(petInv) do
                table.insert(petInInv, {name = v[1], id = i})
            end
            for i,v in pairs(petInInv) do
                if kVars.boolCommon then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Common" then
                            delList[v.id] = true
                        end
                    end
                end
                if kVars.boolRare then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Rare" then
                            delList[v.id] = true
                        end
                    end
                end
                if kVars.boolUnique then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Unique" then
                            delList[v.id] = true
                        end
                    end
                end
                if kVars.boolEpic then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Epic" then
                            delList[v.id] = true
                        end
                    end
                end
                if kVars.boolLegendary then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Legendary" then
                            delList[v.id] = true
                        end
                    end
                end
                if kVars.boolMythical then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Mythical" then
                            delList[v.id] = true
                        end
                    end
                end
                if kVars.boolSecret then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Sectret" then
                            delList[v.id] = true
                        end
                    end
                end
                if kVars.boolExclusive then
                    for g,h in pairs(petList) do
                        if v.name == h.name and h.rarity == "Exclusive" then
                            delList[v.id] = true
                        end
                    end
                end
            end
            if next(delList) then
                game:GetService("ReplicatedStorage").Remotes.deleteItems:InvokeServer(delList)
            end
        end
    end)
end

kVars.boolCommon = false
sectionDelPetsByRarity:Create("Toggle", "Common",function(bool)
    kVars.boolCommon = bool
end,{default = kVars.boolCommon})

kVars.boolRare = false
sectionDelPetsByRarity:Create("Toggle", "Rare",function(bool)
    kVars.boolRare = bool
end,{default = kVars.boolRare})

kVars.boolUnique = false
sectionDelPetsByRarity:Create("Toggle", "Unique",function(bool)
    kVars.boolUnique = bool
end,{default = kVars.boolUnique})

kVars.boolEpic = false
sectionDelPetsByRarity:Create("Toggle", "Epic",function(bool)
    kVars.boolEpic = bool
end,{default = kVars.boolEpic})

kVars.boolLegendary = false
sectionDelPetsByRarity:Create("Toggle", "Legendary",function(bool)
    kVars.boolLegendary = bool
end,{default = kVars.boolLegendary})

kVars.boolMythical = false
sectionDelPetsByRarity:Create("Toggle", "Mythical",function(bool)
    kVars.boolMythical = bool
end,{default = kVars.boolMythical})

kVars.boolSecret = false
sectionDelPetsByRarity:Create("Toggle", "Secret",function(bool)
    kVars.boolSecret = bool
end,{default = kVars.boolSecret})

kVars.boolExclusive = false
sectionDelPetsByRarity:Create("Toggle", "Exclusive",function(bool)
    kVars.boolExclusive = bool
end,{default = kVars.boolExclusive})

kVars.boolDeletePetsByRarity = false
sectionDelPetsByRarity:Create("Toggle", "Auto Delete *Carful",function(bool)
    kVars.boolDeletePetsByRarity = bool
    if bool then
        fDeletePetsByRarity()
    end
end,{default = kVars.boolDeletePetsByRarity})

---- delete pet by name ----
kVars.petModelData = {game:GetService("ReplicatedStorage").PetModels, game:GetService("ReplicatedStorage").Golden, game:GetService("ReplicatedStorage").Exclusive, game:GetService("ReplicatedStorage").Emerald, game:GetService("ReplicatedStorage").Diamond, game:GetService("ReplicatedStorage").Darkmatter, game:GetService("ReplicatedStorage").Sunfire}
kVars.petModels = {}
for i,v in pairs(kVars.petModelData) do
    for g,h in pairs(v:GetChildren()) do
        if v.name ~= "PetModels" then
            table.insert(kVars.petModels, v.name .. " " .. h.name)
        else
            table.insert(kVars.petModels, h.name)
        end
    end
end
table.sort(kVars.petModels)
table.insert(kVars.petModels, 1, "NONE")
kVars.SelectedDeletePets = {"NONE","NONE","NONE","NONE","NONE"}


for i,v in pairs(kVars.SelectedDeletePets) do
    sectionDelPetsByName:Create("DropDown", "Select a pet to delete", function(value)
        kVars.SelectedDeletePets[i] = value
    end,{options = kVars.petModels, default = kVars.petModels[1], search = true})
end

kVars.boolDeletePetsByName = false
sectionDelPetsByName:Create("Toggle", "Auto Delete *Carful",function(bool)
    kVars.boolDeletePetsByName = bool
    if bool then
        fDeletePetsByName()
    end
end,{default = kVars.boolDeletePetsByName})

function fDeletePetsByName()
    spawn(function()
        while kVars.boolDeletePetsByName do
            task.wait()
            local petInv2 = kVars.HttpService:JSONDecode(game.Players.LocalPlayer:GetAttribute("inventory"))
            local petInInv2 = nil
            petInInv2 = {}
            local delList2 = nil
            delList2 = {}
            
            for i,v in pairs(petInv2) do
                if v[2] ~= nil then
                    table.insert(petInInv2, {name = v[2] .. " " .. v[1], id = i})
                else
                    table.insert(petInInv2, {name = v[1], id = i})
                end
            end
            
            for i,v in pairs(kVars.SelectedDeletePets) do
                if v ~= "NONE" then
                    for g,h in pairs(petInInv2) do
                        if v == h.name then
                            delList2[h.id] = true
                        end
                    end
                end
            end
            if next(delList2) then
                game:GetService("ReplicatedStorage").Remotes.deleteItems:InvokeServer(delList2)
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


kVars.locations = {}
for i,v in ipairs(game:GetService("Players").keathunsar.PlayerGui.teleport.teleportController.a1.ScrollingFrame:GetChildren()) do
    if v.ClassName == "Frame" then
        table.insert(kVars.locations, v.Name)
    end
end

for i,v in ipairs(kVars.locations) do
    sectionLocations:Create("Button", v, function()
        game:GetService("ReplicatedStorage").Remotes.TeleportToPlace:InvokeServer(v)
    end,{animated = true})
end

----========== page character ==========----
---- section Character ----
 kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.walkSpeed, precise = false, changablevalue = true})

if kVars.jumpHeight == nil then
    kVars.jumpHeight = kVars.humanoid.JumpHeight
end
sectionCharacter:Create("Slider", "Jump Height", function(value)
    kVars.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 1, max = 500, default = kVars.humanoid.jumpHeight, precise = true, changablevalue = true})


kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpHeight = kVars.jumpHeight
end)

if kVars.boolInfJump == nil then
    kVars.boolInfJump = false
end
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

sectionWorld:Create("Toggle", "Sun Rays",function(bool)
    game:GetService("Lighting").SunRays.Enabled = bool
end,{default = game:GetService("Lighting").SunRays.Enabled})

sectionWorld:Create("Toggle", "Bloom",function(bool)
    game:GetService("Lighting").Bloom.Enabled = bool
end,{default = game:GetService("Lighting").Bloom.Enabled})

---- sections options ----
sectionMisc:Create("Button", "Destroy this GUI",function()
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
end,{animated = true})

if kVars.boolPurchasePrompt == nil then
    kVars.boolPurchasePrompt = game:GetService("CoreGui").PurchasePrompt.Enabled
end
sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = kVars.boolPurchasePrompt})

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
    messagebox("Copied to clipboard!", "Message", 0)
end,{animated = true})

sectionCreditsKeath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
    messagebox("Copied to clipboard!", "Message", 0)
end,{animated = true})

---- alex ----
sectionCreditsAlex:Create("Button", "https://teppyboy.github.io/", function()
    setclipboard('https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/main.html')
    messagebox("Copied to clipboard!", "Message", 0)
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
        task.wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)

