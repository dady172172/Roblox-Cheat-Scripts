--[[
Game : https://www.roblox.com/games/5490351219
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Clicker Madness GUI"
kVars.placeID = 5490351219
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
kVars.pGui = kVars.lp:WaitForChild("PlayerGui")

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
local sectionPets = pageEggsPets:CreateSection("Pets")


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
            firesignal(kVars.pGui.Click.Button.MouseButton1Down)
        end
    end)
end

sectionFarm:Create("Toggle", "Collect",function(bool)
    kVars.boolCollect = bool
    if bool then
        fCollect()
    end
end,{default = kVars.boolCollect})

function fCollect()
    spawn(function()
        while kVars.boolCollect do
            wait()
            for i,v in pairs(game:GetService("Workspace").ScriptObjects:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    firetouchinterest(kVars.hrp, v.HumanoidRootPart, 0)
                end
            end
        end
    end)
end

sectionFarm:Create("Button", "Unlock Auto Rebirth", function()
    kVars.lp.Gamepasses.AutoRebirth.Value = true
end,{animated = true})

----========== page Eggs/Pets ==========----
---- section Eggs ----
kVars.eggsList = {}
for i,v in pairs(game:GetService("Workspace").EggCapsules:GetChildren()) do
    table.insert(kVars.eggsList, tostring(v.EggID.Value))
end
table.sort(kVars.eggsList)

kVars.selectedEgg = kVars.eggsList[1]
sectionEggs:Create("DropDown", "Select and egg to open", function(value)
    kVars.selectedEgg = value
end,{options = kVars.eggsList, default = kVars.eggsList[1], search = true})

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
            kVars.rs.Aero.AeroRemoteServices.EggService.Purchase:FireServer(kVars.selectedEgg)
        end
    end)
end

---- section Pets ----
sectionPets:Create("Toggle", "Craft",function(bool)
    kVars.boolCraft = bool
    if bool then
        fCraft()
    end
end,{default = kVars.boolCraft})

function fCraft()
    spawn(function()
        while kVars.boolCraft do
            wait()
            for i,v in pairs(kVars.lp.PlayerGui.Pets.Main.Content.Main:GetChildren()) do
                wait()
                if kVars.boolCraft == false then break end
                pcall(function()
                    if v:FindFirstChild("Craft") then
                        firesignal(v:FindFirstChild("Craft").MouseButton1Down)
                    end
                end)
            end
        end
    end)
end



kVars.petsList = require(game.ReplicatedStorage.Aero.Shared.List.Pets)
kVars.petsNamesList = {}
for i,v in pairs(kVars.petsList) do
    if not table.find(kVars.petsList,v.DisplayName) then
        table.insert(kVars.petsNamesList, tostring(v.DisplayName))
    end    
end
table.sort(kVars.petsNamesList)
table.insert(kVars.petsNamesList, 1, "NONE")


for i=1,5 do
    kVars["selectedPet" .. i] = kVars.petsNamesList[1]
    sectionPets:Create("DropDown", "Select a pet", function(value)
        kVars["selectedPet" .. i] = value
    end,{options = kVars.petsNamesList, default = kVars.petsNamesList[1], search = true})
    
end

sectionPets:Create("Toggle", "Delete pet by name *Carful",function(bool)
    kVars.boolDpbn = bool
    if bool then
        fDpbn()
    end
end,{default = kVars.boolDpbn})

function fDpbn()
    spawn(function()
        while kVars.boolDpbn do
            wait()
            local plrPets = game:GetService("HttpService"):JSONDecode(kVars.lp.Data.Pets.Value)
            local delPetsList = {}
            for a=1,5 do
                local b = kVars["selectedPet" .. a]
                for i,v in pairs(plrPets) do
                    if string.find(string.lower(v.ID), string.lower(b)) then
                        table.insert(delPetsList, i)
                    end
                end                
            end
            if delPetsList[1] then
                kVars.rs.Aero.AeroRemoteServices.PetService.DeletePets:FireServer(delPetsList)
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
kVars.boolDisPopEff = kVars.pGui.PopupEffects.Enabled
sectionMisc:Create("Toggle", "Disable Popup Effects",function(bool)
    kVars.boolDisPopEff = bool
    kVars.pGui.PopupEffects.Enabled = bool
end,{default = kVars.boolDisPopEff})


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



--[[
    ---- Toggle ----
sectionFarm:Create("Toggle", "",function(bool)
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