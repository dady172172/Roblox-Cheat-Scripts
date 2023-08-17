--[[
Game : https://www.roblox.com/games/6766156863
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
GUI Made by : https://v3rmillion.net/member.php?action=profile&uid=244024

Not the best script. but its the best I can do for now. til synapsex is back. Script was made for ELECTRON injector. May not work with other injectors


]]--
---- vars ----
kVars = {}
kVars.WindowName = "Strongman Simulator GUI"
kVars.placeID = 6766156863
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
kVars.head = kVars.lp.Character:WaitForChild("Head")

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
local sectionEnergy = pageMain:CreateSection("Energy")
local sectionWorkout = pageMain:CreateSection("Workout")
local sectionRebirth = pageMain:CreateSection("Rebirth")
local sectionExtra = pageMain:CreateSection("Extra")

local pageEggs = Window:CreateCategory("Eggs/Pets")
local sectionEggs = pageEggs:CreateSection("Eggs")
local sectionPets = pageEggs:CreateSection("Delete Pets *Careful")

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

--========== page main ==========----
---- Farm ----
sectionEnergy:Create("Textlabel","Only One active at a time, Farm energy or Farm workout!")

kVars.boolEnergy = false
sectionEnergy:Create("Toggle", "Farm Energy",function(bool)
    kVars.boolEnergy = bool
    if bool then
        fEnergy()
    end
end,{default = kVars.boolEnergy})

function fEnergy()
    spawn(function()
      
        local plrHalf = (kVars.head.Position - kVars.lp.Character.RightFoot.Position).magnitude/2
        kVars.hrp.CFrame = CFrame.new(-99, (10 + plrHalf), 19005)
        local pathToWagonInteraction = game:GetService("Workspace").Areas["Area24_Mineshaft"].DraggableItems:GetChildren()[1]
        for i,v in pairs(game:GetService("Workspace").Areas["Area24_Mineshaft"].DraggableItems:GetChildren()) do
            if v:FindFirstChild("Title") and v.Title.Value == "Crystal Minecart" then
                pathToWagonInteraction = v.InteractionPoint
                break
            end
        end
        local userId = kVars.lp.UserId
        while kVars.boolEnergy do
            wait()
            kVars.head = game.Players.LocalPlayer.Character:WaitForChild("Head")
            kVars.hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
            pcall(function()
                
                local plrHalf = (kVars.head.Position - kVars.hrp.Position).magnitude
                if kVars.lp.Character:FindFirstChild("Weights") then
                    kVars.humanoid.Jump = true
                end
                repeat
                    if kVars.boolEnergy == false then break end
                    task.wait()
                    kVars.hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
                    kVars.hrp.AssemblyAngularVelocity = Vector3.new(0,0,0) 
                    pathToWagonInteraction.CFrame = kVars.hrp.CFrame
                    local plrHalf = (kVars.head.Position - kVars.hrp.Position).magnitude
                    kVars.hrp.CFrame = CFrame.new(-99, (10 + plrHalf), 19005)           
                    fireproximityprompt(pathToWagonInteraction.ProximityPrompt)
                    local a1 = game:GetService("Workspace").PlayerDraggables[userId]:GetChildren()
                until next(a1) or kVars.boolEnergy == false
                task.wait()
                repeat
                    if kVars.boolEnergy == false then break end
                    task.wait()
                    local a1 = game:GetService("Workspace").PlayerDraggables[userId]:GetChildren()
                    local h = (kVars.head.Position - kVars.hrp.Position).Magnitude
                    local l = CFrame.new(-39, 10, 19652)
                    kVars.lp.Character:SetPrimaryPartCFrame(CFrame.new(l.x, (l.y + h), l.z))
                until not next(a1) or not kVars.boolEnergy               
                wait(.1)
                for i,v in pairs(game:GetService("Workspace").PlayerDraggables[userId]:GetChildren()) do
                    task.wait()
                    kVars.rs.TGSDraggableItems_DropItem:FireServer(v)
                end
            end)
        end
    end)
end


kVars.selectedWorkoutAmount = 1
sectionWorkout:Create("Slider", "Workout Amount", function(value)
    kVars.selectedWorkoutAmount = value
end,{min = 1, max = 3000, default = kVars.selectedWorkoutAmount, precise = false, changablevalue = true})

kVars.boolWorkout = false
sectionWorkout:Create("Toggle", "Farm Workout",function(bool)
    kVars.boolWorkout = bool
    if bool then
        fWorkout()
    else
        kVars.humanoid.Jump = true
    end
end,{default = kVars.boolWorkout})

function fWorkout()
    spawn(function()
        local h = (kVars.head.Position - kVars.hrp.Position).magnitude
        kVars.lp.Character:SetPrimaryPartCFrame(CFrame.new(460, (11 + h), 19110))
        
        kVars.lp.Character.PrimaryPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0) 
        task.wait()
        local col = game:GetService("Workspace").Areas["Area24_Mineshaft"].Gym["Gym Right"].TrainingEquipment.WorkoutStation.Collider
        
        repeat
            col.CFrame = kVars.hrp.CFrame
        until col.CFrame == kVars.hrp.CFrame
        wait()
        repeat
            fireproximityprompt(col.ProximityPrompt)
        until kVars.lp.Character:FindFirstChild("Weights")
        while kVars.boolWorkout do
            repeat
                task.wait()
                kVars.rs.StrongMan_UpgradeStrength:InvokeServer(tonumber(kVars.selectedWorkoutAmount))
            until not kVars.lp.Character:FindFirstChild("Weights") or kVars.boolEnergy == true or kVars.boolWorkout == false
            if kVars.boolWorkout == false then
                kVars.humanoid.Jump = true
            end
        end
    end)
end

sectionRebirth:Create("Toggle", "Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then
        fRebirth()
    end
end,{default = kVars.boolRebirth})

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            if game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD").ButtonContainer.Rebirth.Visible == true then
                if kVars.lp.Character:FindFirstChild("Weights") then
                    kVars.humanoid.Jump = true
                end
                kVars.rs["StrongMan_Rebirth"]:FireServer()
            end
        end
    end)
end

sectionExtra:Create("Button", "Delete Gates/Exits", function()
    for i,v in pairs(game:GetService("Workspace").Areas:GetDescendants()) do
        local a = string.lower(v.name)
        if string.find(a, "exit") or string.find(a, "gate") then
            v:Destroy()
        end
    end
end,{animated = true})



--========== page Eggs/Pets ==========----
---- section eggs ----
kVars.eggsList = {}
for i,v in ipairs(game:GetService("Workspace").Lib.Loot.LootTables.PetShops:GetChildren()) do
    table.insert(kVars.eggsList, v.name)
end
kVars.selectedEgg = kVars.eggsList[1]
sectionEggs:Create("DropDown", "Select egg to open", function(value)
    kVars.selectedEgg = value
end,{options = kVars.eggsList, default = kVars.eggsList[1], search = true})

sectionEggs:Create("Toggle", "Open Egg",function(bool)
    kVars.boolOpenEgg = bool
    if bool then
        fOpenEgg()
        for i,v in pairs(kVars.lp.PlayerGui.UnlockUI:GetChildren()) do
            if v.ClassName == "Frame" or v.ClassName == "ImageButton" then
                v.Visible = false
            end
        end
        kVars.lp.PlayerGui.UnlockUI.DisplayOrder = -1
        kVars.lp.PlayerGui.HUD.DisplayOrder = 5
    end
end,{default = kVars.boolOpenEgg})

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            kVars.lp.PlayerGui.HUD.Enabled = true
            kVars.rs.TGSPetShopRoll:InvokeServer(kVars.selectedEgg)
        end
    end)
end
---- section pets ---
kVars.petList = {}
for i,v in pairs(kVars.rs.Pets:GetChildren()) do
    table.insert(kVars.petList,v.name)
end
table.sort(kVars.petList)
table.insert(kVars.petList,1,"NONE")

for i=1,5 do
    kVars["SelectedDelPet" .. tostring(i)] = nil
    local n = "Del Pet " .. tostring(i)
    sectionPets:Create("DropDown", n ,function(value)
        kVars["SelectedDelPet" .. tostring(i)] = value
    end,{options = kVars.petList, default = kVars.petList[1], search = true})
end

kVars.boolSellPets = false
sectionPets:Create("Toggle", "Sell Pets",function(bool)
    kVars.boolSellPets = bool
    if bool then
        fSellPets()
    end
end,{default = kVars.boolSellPets})

function fSellPets()
    spawn(function()
        while kVars.boolSellPets do
            wait()
            local delPetList = {}
            if kVars.SelectedDelPet1 ~= nil and kVars.SelectedDelPet1 ~= "NONE" then
                table.insert(delPetList, kVars.SelectedDelPet1)
            end
            if kVars.SelectedDelPet2 ~= nil and kVars.SelectedDelPet2 ~= "NONE" then
                table.insert(delPetList, kVars.SelectedDelPet2)
            end
            if kVars.SelectedDelPet3 ~= nil and kVars.SelectedDelPet3 ~= "NONE" then
                table.insert(delPetList, kVars.SelectedDelPet3)
            end
            if kVars.SelectedDelPet4 ~= nil and kVars.SelectedDelPet4 ~= "NONE" then
                table.insert(delPetList, kVars.SelectedDelPet4)
            end
            if kVars.SelectedDelPet5 ~= nil and kVars.SelectedDelPet5 ~= "NONE" then
                table.insert(delPetList, kVars.SelectedDelPet5)
            end
            pcall(function()
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.CompanionUI.Layout.Layout.GridFrame.ScrollingFrame:GetChildren()) do
                    local a = v.name
                    if a ~= "UIGridLayout" and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("CompanionUI") then
                        local b = v.Frame.ItemViewportFrame:FindFirstChildWhichIsA("Model").name
                        for g,k in pairs(delPetList) do
                            if b == k then
                                kVars.rs.TGSPetSystem_SellPet:InvokeServer(a)
                                break
                            end
                        end
                    end
                end
            end)
        end
    end)
end

--========== page teleport ==========----
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

---- section locations ----
kVars.teleList = {
    [1] = {name = "Start Area", cf = CFrame.new(100, 10, -142.5)},
    [2] = {name = "Gym Area", cf = CFrame.new(100, 10, 89.75)},
    [3] = {name = "Food Area", cf = CFrame.new(100, 10, 325)},
    [4] = {name = "Arcade Area", cf = CFrame.new(100, 10, 89.75)},
    [5] = {name = "Farm Area", cf = CFrame.new(100, 10, 929.75)},
    [6] = {name = "Castle Area", cf = CFrame.new(100, 10, 1368.25)},
    [7] = {name = "Steampunk Area", cf = CFrame.new(100, 10, 2011)},
    [8] = {name = "Disco Area", cf = CFrame.new(100, 10, 2839.25)},
    [9] = {name = "Space Area", cf = CFrame.new(100, 10, 3761)},
    [10] = {name = "Candy Area", cf = CFrame.new(100, 10, 4628.75)},
    [11] = {name = "Lab Area", cf = CFrame.new(100, 10, 5527)},
    [12] = {name = "Tropical Area", cf = CFrame.new(100, 10, 6429.44)},
    [13] = {name = "Dino Area", cf = CFrame.new(100, 10, 7305.95)},
    [14] = {name = "Retro Area", cf = CFrame.new(100, 10, 8357.45)},
    [15] = {name = "Winter Area", cf = CFrame.new(100, 10, 9368.45)},
    [16] = {name = "Deep Sea Area", cf = CFrame.new(100, 10, 10375)},
    [17] = {name = "Wild West Area", cf = CFrame.new(100, 10, 11386)},
    [18] = {name = "Luxury Apartment Area", cf = CFrame.new(100, 10, 12362)},
    [19] = {name = "Treasure Vault Area", cf = CFrame.new(100, 10, 13406)},
    [20] = {name = "Fairy Tale Area", cf = CFrame.new(100, 10, 14416)},
    [21] = {name = "Asian", cf = CFrame.new(100, 10, 15505)},
    [22] = {name = "Kitchen", cf = CFrame.new(100, 10, 16802)},
    [23] = {name = "Sewer", cf = CFrame.new(100, 10, 18098)},
    [24] = {name = "Mineshaft", cf = CFrame.new(100, 10, 19201)}
}

for i,v in ipairs(kVars.teleList) do
    sectionLocations:Create("Button", v.name, function()
        local h = (kVars.lp.Character.Head.Position - kVars.hrp.Position).Magnitude
        local l = v.cf
        kVars.lp.Character:SetPrimaryPartCFrame(CFrame.new(l.x, (l.y + h), l.z))
    end,{animated = true})
end

--========== page character ==========----
---- section Character ----
kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.WalkSpeed, precise = false, changablevalue = true})

kVars.jumpPower = kVars.humanoid.JumpPower
sectionCharacter:Create("Slider", "Jump Power", function(value)
    kVars.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 50, max = 500, default = kVars.humanoid.JumpPower, precise = false, changablevalue = true})

kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
    kVars.head = kVars.lp.Character:WaitForChild("Head")
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
    task.wait(5)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpPower = kVars.jumpPower
end)

spawn(function()
    while task.wait() do
        kVars.humanoid.WalkSpeed = kVars.walkSpeed
    end
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

--========== page misc ==========----
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