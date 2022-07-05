--[[
Game : https://www.roblox.com/games/6766156863
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = "Strongman GUI"
kVars.txtName = kVars.WindowName .. ".txt"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.rs = game:GetService('ReplicatedStorage')
kVars.vu = game:GetService('VirtualUser')
kVars.HttpService = game:GetService("HttpService")
kVars.themes = {}
kVars.tmp = {}
---- Load Settings ----
if readfile and isfile and isfile(kVars.txtName) then
    kVars.tmp = kVars.HttpService:JSONDecode(readfile(kVars.txtName))
    for i,v in pairs(kVars.tmp) do
        kVars.themes[i] = Color3.fromRGB(v[1], v[2], v[3])
    end
else
    print("Loading defult theme")
    kVars.themes = {
        Background = Color3.fromRGB(24, 24, 24),
        Glow = Color3.fromRGB(0, 0, 0),
        Accent = Color3.fromRGB(10, 10, 10),
        LightContrast = Color3.fromRGB(20, 20, 20),
        DarkContrast = Color3.fromRGB(14, 14, 14),  
        TextColor = Color3.fromRGB(255, 255, 255)
   }
end

---- Save Settings ----
function saveSettings()
    if writefile then
        kVars.themes = {}
        for i,v in pairs(game:GetService('CoreGui')[kVars.WindowName]:GetChildren()) do
            if v.Name == "ColorPicker" then
                kVars.themes[v.Title.Text] = {v.Container.Inputs.R.Textbox.text, v.Container.Inputs.G.Textbox.text, v.Container.Inputs.B.Textbox.text}
            end
        end
        writefile(kVars.txtName, kVars.HttpService:JSONEncode(kVars.themes))
    else
        print("You injector does not support writefile.")
    end
end

---- Destroy multiple instances ----
if game:GetService('CoreGui'):FindFirstChild(kVars.WindowName) then
   game:GetService('CoreGui'):FindFirstChild(kVars.WindowName):Destroy()
   wait(.2)
end

---- antiAFK ----
kVars.AntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
   kVars.vu:CaptureController()
   kVars.vu:ClickButton2(Vector2.new())
end)

---- Load window ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))()
local Window = library.new(kVars.WindowName, 5013109572)

---- pages and sections ----
local pageFarm = Window:addPage("Farm", 3117485989)
local sectionAutoFarm = pageFarm:addSection("Auto Farm *Only one active at a time!")
local sectionRebirth = pageFarm:addSection("Rebirth")

local pageEggs = Window:addPage("Eggs", 9194077649)
local sectionEggs = pageEggs:addSection("Open Eggs")
local sectionSellPets = pageEggs:addSection("Sell Pets")

local pageTeleport = Window:addPage("Teleport", 4814045731)
local sectionLocations = pageTeleport:addSection("Locations")

local pagePlayer = Window:addPage("Player", 5012544693)
local sectionPlayerStats = pagePlayer:addSection("Stats")
local sectionTpToPlayer = pagePlayer:addSection("Teleport To Player")

local pageSettings = Window:addPage("Settings", 6942070576)
local sectionTheme = pageSettings:addSection("Theme")
local sectionKeybinds = pageSettings:addSection("Keybinds")

----  ----
sectionAutoFarm:addToggle("Farm Energy", false, function(bool)
    kVars.boolFarmEnergy = bool
    if bool then
        fFarmEnergy()
    end
end)

local userId = game.Players.LocalPlayer.UserId

function fFarmEnergy()
    spawn(function()
        local plrHalf = (kVars.lp.Character.Head.Position - kVars.lp.Character.RightFoot.Position).magnitude/2
        kVars.lp.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(128, (30 + plrHalf), 14198)
        wait(1)
        local pathToWagonInteraction = nil
        for i,v in pairs(game:GetService("Workspace").Areas["Area20_Princess"].DraggableItems:GetChildren()) do
            if v:FindFirstChild("Title") and v.Title.Value == "Wagon" then
                pathToWagonInteraction = v.InteractionPoint
                break
            end
        end
        while kVars.boolFarmEnergy do
            wait()  
            local plrHalf = (kVars.lp.Character.Head.Position - kVars.lp.Character.RightFoot.Position).magnitude/2
            local PlrTmpList = kVars.lp.Character:GetChildren()
            if kVars.lp.Character:FindFirstChild("Weights") then
                kVars.lp.Character.Humanoid.Jump = true
            end
            repeat
                wait()
                pathToWagonInteraction.CFrame = kVars.lp.Character:WaitForChild("HumanoidRootPart").CFrame
                local a1 = game:GetService("Workspace").PlayerDraggables[userId]:GetChildren()
                local plrHalf = (kVars.lp.Character.Head.Position - kVars.lp.Character.RightFoot.Position).magnitude/2
                kVars.lp.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(128, (30 + plrHalf), 14198)           
                game:GetService('VirtualUser'):TypeKey("e")
                game:GetService('VirtualUser'):TypeKey("e")
            until a1[2] or kVars.boolFarmEnergy == false
            wait(.2)
            for i,v in pairs(game:GetService("Workspace").PlayerDraggables[userId]:GetChildren()) do
                v.Rope.Length = math.huge
                v.CFrame = CFrame.new(71, 21, 14644)
            end
            wait(.1)
            for i,v in pairs(game:GetService("Workspace").PlayerDraggables[userId]:GetChildren()) do
                wait()
                game:GetService("ReplicatedStorage").TGSDraggableItems_DropItem:FireServer(v)
            end
        
            
        end
    end)
end

kVars.workoutList = {}
kVars.selectedWorkoutNum = 1
for i=0,5000,10 do
    if i == 0 then
        table.insert(kVars.workoutList,1)
    else
        table.insert(kVars.workoutList,i)
    end
end
sectionAutoFarm:addDropdown("Select a workout amount", kVars.workoutList, function(txt)
    kVars.selectedWorkoutNum = txt
end)

sectionAutoFarm:addToggle("Workout", false, function(bool)
    kVars.boolWorkout = bool
    if bool then 
        fWorkout()
    end
end)

function fWorkout()
    spawn(function()
        while kVars.boolWorkout do
            wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(459, 86, 14299)
            game:GetService("Workspace").Areas["Area20_Princess"].Gym["Gym Right"].TrainingEquipment.WorkoutStation.Collider.CFrame = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
            repeat
                game:GetService("Workspace").Areas["Area20_Princess"].Gym["Gym Right"].TrainingEquipment.WorkoutStation.Collider.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait()
                game:GetService('VirtualUser'):SetKeyDown("e")
                task.wait(.5)
                game:GetService('VirtualUser'):SetKeyUp("e")
            until game.Players.LocalPlayer.Character:FindFirstChild("Weights") or kVars.boolFarmEnergy == true or kVars.boolWorkout == false
            repeat
                wait()
                game:GetService("ReplicatedStorage").StrongMan_UpgradeStrength:InvokeServer(tonumber(kVars.selectedWorkoutNum))
            until not game.Players.LocalPlayer.Character:FindFirstChild("Weights") or kVars.boolFarmEnergy == true or kVars.boolWorkout == false
            if kVars.boolWorkout == false then
                kVars.lp.Character.Humanoid.Jump = true
            end
        end
    end)
end

sectionRebirth:addToggle("Rebirth", false, function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            if game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD").ButtonContainer.Rebirth.Visible == true then
                if kVars.lp.Character:FindFirstChild("Weights") then
                    game.Players.LocalPlayer.Character.Humanoid.Jump = true
                end
                game:GetService("ReplicatedStorage")["StrongMan_Rebirth"]:FireServer()
            end
        end
    end)
end

---- Eggs ---
local eggsList = {}
for i,v in ipairs(game:GetService("Workspace").Lib.Loot.LootTables.PetShops:GetChildren()) do
    table.insert(eggsList, v.name)
end
sectionEggs:addDropdown("Select egg to open", eggsList, function(value)
    kVars.selectedEgg = value
end)

sectionEggs:addToggle("Open Egg", false, function(bool)
    kVars.boolOpenEgg = bool
    if bool then fOpenEgg() end
end)

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            game:GetService("ReplicatedStorage").TGSPetShopRoll:InvokeServer(kVars.selectedEgg)
        end
    end)
end

---- pets section ----
kVars.petList = {}
for i,v in pairs(game:GetService("ReplicatedStorage").Pets:GetChildren()) do
    table.insert(kVars.petList,v.name)
end
table.sort(kVars.petList)
table.insert(kVars.petList,1,"NONE")

for i=1,5 do
    kVars["SelectedDelPet" .. tostring(i)] = nil
    local n = "Del Pet " .. tostring(i)
    sectionSellPets:addDropdown(n,kVars.petList,function(value)
        kVars["SelectedDelPet" .. tostring(i)] = value
    end)
end

sectionSellPets:addToggle("Sell Pets", false, function(bool)
    kVars.boolSellPets = bool
    if bool then fSellPets() end
end)

function fSellPets()
    spawn(function()
        while kVars.boolSellPets do
            wait()
            local delPetList = {}
            if kVars.SelectedDelPet1 ~= nil and kVars.SelectedDelPet1 ~= "NONE" then
                table.insert(delPetList, kVars.SelectedDelPet1)
                print(kVars.SelectedDelPet1)
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

            for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.CompanionUI.Layout.Layout.GridFrame.ScrollingFrame:GetChildren()) do
                local a = v.name
                if a ~= "UIGridLayout" and game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("CompanionUI") then
                    local b = v.Frame.ItemViewportFrame:FindFirstChildWhichIsA("Model").name
                    for g,k in pairs(delPetList) do
                        if b == k then
                            game:GetService("ReplicatedStorage").TGSPetSystem_SellPet:InvokeServer(a)
                            break
                        end
                    end
                end
            end
            

        end
    end)
end

---- teleport ----
kVars.teleList = {
    [1] = {name = "Start Area", cf = CFrame.new(56.5, 10, -142.5)},
    [2] = {name = "Gym Area", cf = CFrame.new(86.5, 10, 89.75)},
    [3] = {name = "Food Area", cf = CFrame.new(86.5, 10, 325)},
    [4] = {name = "Arcade Area", cf = CFrame.new(86.5, 10, 89.75)},
    [5] = {name = "Farm Area", cf = CFrame.new(86.5, 10, 929.75)},
    [6] = {name = "Castle Area", cf = CFrame.new(86.5, 9.96722, 1368.25)},
    [7] = {name = "Steampunk Area", cf = CFrame.new(86.5, 9.96722, 2011)},
    [8] = {name = "Disco Area", cf = CFrame.new(86.5, 9.96722, 2839.25)},
    [9] = {name = "Space Area", cf = CFrame.new(90, 21.189, 3761)},
    [10] = {name = "Candy Area", cf = CFrame.new(35.0613, 9.96722, 4628.75)},
    [11] = {name = "Lab Area", cf = CFrame.new(106.436, 83.4001, 5527)},
    [12] = {name = "Tropical Area", cf = CFrame.new(81.1355, 77.54, 6429.44)},
    [13] = {name = "Dino Area", cf = CFrame.new(110.885, 141.092, 7305.95)},
    [14] = {name = "Retro Area", cf = CFrame.new(87.5613, 8.59299, 8357.45)},
    [15] = {name = "Winter Area", cf = CFrame.new(87.5613, 8.59299, 9368.45)},
    [16] = {name = "Deep Sea Area", cf = CFrame.new(71.6583, 8.0646, 10375)},
    [17] = {name = "Wild West Area", cf = CFrame.new(71.6583, 8.0646, 11386)},
    [18] = {name = "Luxury Apartment Area", cf = CFrame.new(83.9083, 10.9396, 12362)},
    [19] = {name = "Treasure Vault Area", cf = CFrame.new(71.6583, 8.0646, 13406)},
    [20] = {name = "Fairy Tale Area", cf = CFrame.new(71.6583, 8.0646, 14416)}
}
for i,v in ipairs(kVars.teleList) do
    sectionLocations:addButton(v.name,function()
        kVars.lp.Character:WaitForChild("HumanoidRootPart").CFrame = v.cf
    end)
end



---- player stats section ----
kVars.walkSpeed = 16
sectionPlayerStats:addSlider("Walk Speed", kVars.lp.Character.Humanoid.WalkSpeed, kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed, 1024, function(value)
    kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed = value
end)

sectionPlayerStats:addSlider("Jump Power", 50, kVars.lp.Character:WaitForChild('Humanoid').JumpPower, 1024, function(value)
    kVars.lp.Character:WaitForChild('Humanoid').JumpPower = value
end)

sectionPlayerStats:addToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

kVars.InfJumpConnect = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump and kVars.lp.Character:FindFirstChild("Humanoid") then
		kVars.lp.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)

---- tp to player section ----
sectionTpToPlayer:addTextbox("PlayerName", "Name", function(value, focusLost)
    if focusLost then
        kVars.teleportToPlayer = value
        print(value)
    end
end)

sectionTpToPlayer:addButton("Teleport", function()
    local cnf = true
    if game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart") and kVars.teleportToPlayer ~= nil then
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            local hrp = game:GetService('Players').LocalPlayer.Character:WaitForChild('HumanoidRootPart')
            if string.find(string.lower(v.DisplayName), string.lower(kVars.teleportToPlayer)) then
                hrp.CFrame = v.Character.HumanoidRootPart.CFrame
                cnf = false
            elseif string.find(string.lower(v.Name), string.lower(kVars.teleportToPlayer)) then
                hrp.CFrame = v.Character.HumanoidRootPart.CFrame
                cnf = false
            end
        end
        if cnf == true then
            Window:Notify("Error", "Could not find player.")
        end
    else
        Window:Notify("Error", "You didn't put a valid playername in the textbox.")
    end
end)

---- Theme ----
for theme, color in pairs(kVars.themes) do
    sectionTheme:addColorPicker(theme, color, function(color3)
        Window:setTheme(theme, color3)
    end)
    Window:setTheme(theme, color)
end

sectionTheme:addButton("Save Theme", function()
    saveSettings()
end)

sectionKeybinds:addKeybind("Open/Close Menu", Enum.KeyCode.Backquote, function()
	Window:toggle()
end, function()
end)

---- Select main page to display ----
Window:SelectPage(Window.pages[1], true)

---- Closing ----
kVars.ClosingConnect = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.WindowName then
	    kVars.InfJumpConnect:Disconnect()
        kVars.AntiAfk:Disconnect()
		for i,v in pairs(kVars) do
			if type(v) == "boolean" then
				v = false
			end
		end
        wait(.1)
		kVars.ClosingConnect:Disconnect()
		script:Destroy()
	end
end)

syn.protect_gui(game:GetService("CoreGui")[kVars.WindowName])