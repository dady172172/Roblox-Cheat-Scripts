--[[
Game : https://www.roblox.com/games/9498006165
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = "Tapping Simulator GUI"
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
local sectionAutoFarm = pageFarm:addSection("Auto Farm")
local sectionRebirth = pageFarm:addSection("Rebirth")
local sectionBuy = pageFarm:addSection("Buy")

local pageEggs = Window:addPage("Eggs", 9194077649)
local sectionEggs = pageEggs:addSection("Auto Open")

local pageTeleport = Window:addPage("Teleport", 4814045731)
local sectionLocations = pageTeleport:addSection("Locations")

local pagePlayer = Window:addPage("Player", 5012544693)
local sectionPlayerStats = pagePlayer:addSection("Stats")
local sectionTpToPlayer = pagePlayer:addSection("Teleport To Player")

local pageSettings = Window:addPage("Settings", 6942070576)
local sectionTheme = pageSettings:addSection("Theme")
local sectionKeybinds = pageSettings:addSection("Keybinds")

----  ----
sectionAutoFarm:addToggle("Tap", false, function(bool)
    kVars.boolTap = bool
    if bool then fTap() end
end)

function fTap()
    spawn(function()
        while kVars.boolTap do
            wait()
            game:GetService("ReplicatedStorage").Events.Tap:FireServer("Main")
        end
    end)
end

local RebirthBtnData = require(game:GetService("ReplicatedStorage").Data.RebirthButtonData)

local rebirthList =  {"1","5","10","20","100","500","2000","4500","32000"}
kVars.selectedRebirth = nil
sectionRebirth:addDropdown("Rebirth Amount", rebirthList, function(txt)
    kVars.selectedRebirth = txt
end)

sectionRebirth:addToggle("Rebirth", false, function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            if kVars.selectedRebirth ~= nil and kVars.selectedRebirth ~= "Rebirth Amount" then
                game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(kVars.selectedRebirth)
            end
        end
    end)
end

---- upgrades section ----
sectionBuy:addToggle("Rebirth Buttons Upgrade", false, function(bool)
    kVars.boolRebirthUpgrades = bool
    if bool then fRebirthUpgrades() end
end)

function fRebirthUpgrades()
    spawn(function()
        while kVars.boolRebirthUpgrades do
            wait()
            game:GetService("ReplicatedStorage").Events.Upgrade:FireServer("rebirthUpgrades")
        end
    end)
end

sectionBuy:addToggle("Jumps Upgrade", false, function(bool)
    kVars.boolJumpsUpgrade = bool
    if bool then fJumpsUpgrade() end
end)

function fJumpsUpgrade()
    spawn(function()
        while kVars.boolJumpsUpgrade do
            wait()
            game:GetService("ReplicatedStorage").Events.Upgrade:FireServer("jumpsUpgrade")
        end
    end)
end


sectionBuy:addToggle("Gems Upgrade", false, function(bool)
    kVars.boolGemUpgrade = bool
    if bool then fGemUpgrade() end
end)

function fGemUpgrade()
    spawn(function()
        while kVars.boolGemUpgrade do
            wait()
            game:GetService("ReplicatedStorage").Events.Upgrade:FireServer("gemMultiplierUpgrade")
        end
    end)
end

sectionBuy:addToggle("Storage Upgrade", false, function(bool)
    kVars.boolStorageUpgrade = bool
    if bool then fStorageUpgrade() end
end)

function fStorageUpgrade()
    spawn(function()
        while kVars.boolStorageUpgrade do
            wait()
            game:GetService("ReplicatedStorage").Events.Upgrade:FireServer("storageUpgrade")
        end
    end)
end

---- open eggs ----
kVars.eggsList = {
    [1] = {name = "Starter", price = "200"},
    [2] = {name = "Wood Egg", price = "2500"},
    [3] = {name = "Jungle Egg", price = "150K"},
    [4] = {name = "Forest Egg", price = "1.5M"},
    [5] = {name = "Bee Egg", price = "5M"},
    [6] = {name = "Swamp Egg", price = "80M"},
    [7] = {name = "Snow Egg", price = "800M"},
    [8] = {name = "Desert Egg", price = "300B"},
    [9] = {name = "Death Egg", price = "2T"},
    [10] = {name = "Beach Egg", price = "15T"},
    [11] = {name = "2M Egg", price = "600T"},
    [12] = {name = "Mine Egg", price = "2Qa"},
    [13] = {name = "Cloud Egg", price = "25Qa"},
    [14] = {name = "Dominus Egg", price = "800T"}
}
kVars.eggPriceList = {}
for i,v in ipairs(kVars.eggsList) do
    table.insert(kVars.eggPriceList, v.price)
end

kVars.selectedEgg = "Starter"

sectionEggs:addDropdown("Select Egg to Open", kVars.eggPriceList,function(value)
    kVars.selectedEgg = value
end)

sectionEggs:addToggle("Open 3", false, function(bool)
    kVars.boolOpen3 = bool
end)

sectionEggs:addToggle("Open Egg", false, function(bool)
    kVars.boolOpenEgg = bool
    if bool then fOpenEgg() end
end)

function fOpenEgg()
    spawn(function()
        while kVars.boolOpenEgg do
            wait()
            for i,v in pairs(kVars.eggsList) do
                if v.price == kVars.selectedEgg then
                    if kVars.boolOpen3 then
                        game:GetService("ReplicatedStorage").Events.HatchEgg:InvokeServer({},v.name,3)
                    else
                        game:GetService("ReplicatedStorage").Events.HatchEgg:InvokeServer({},v.name,1)
                    end
                end
            end
        end
    end)
end

---- teleport ----
kVars.teleportLocations = {
    [1] = {name = "Spawn", cf = CFrame.new(-193.519, 63.174, -461.695)},
    [2] = {name = "Forest Island", cf = CFrame.new(-165, 979, -440)},
    [3] = {name = "Flower Island", cf = CFrame.new(-179, 1517, -647)},
    [4] = {name = "Swamp Island", cf = CFrame.new(-263, 2116, -656)},
    [5] = {name = "Snow Island", cf = CFrame.new(-241, 2937, -470)},
    [6] = {name = "Desert Island", cf = CFrame.new(-203, 4228, -780)},
    [7] = {name = "Death Island", cf = CFrame.new(-319, 5418, -480)},
    [8] = {name = "Beach Island", cf = CFrame.new(-183, 6875, -495)},
    [9] = {name = "Mine Island", cf = CFrame.new(-281, 8368, -484)},
    [10] = {name = "Cloud Island", cf = CFrame.new(-335, 11238, -238)},
    [11] = {name = "Dominus Island", cf = CFrame.new(699, 125, 2161)}
}


for i,v in ipairs(kVars.teleportLocations) do
    sectionLocations:addButton(v.name,function()
        kVars.lp.Character.HumanoidRootPart.CFrame = v.cf
    end)
end


---- player stats section ----
sectionPlayerStats:addSlider("Walk Speed", 16, kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed, 1024, function(value)
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

--syn.protect_gui(game:GetService("CoreGui")[kVars.WindowName])



--[[
section1:addToggle("Title", false, function(bool)
   kVars.bool = bool
   if bool then function() end
end)
section1:addButton("Title", function()
   print("Clicked")
end)
section1:addTextbox("Notification", "Default", function(value, focusLost)
   print("Input", value)

   if focusLost then
      Window:Notify("Title", value)
   end
end)

section2:addKeybind("Toggle Keybind", Enum.KeyCode.One, function()
   print("Activated Keybind")
   Window:toggle()
end, function()
   print("Changed Keybind")
end)
section2:addColorPicker("ColorPicker", Color3.fromRGB(50, 50, 50))
section2:addColorPicker("ColorPicker2")
section2:addSlider("Slider", min, current, max, function(value)
   print("Dragged", value)
end)
kVars.list1 = {"Hello", "World", "Hello World", "Word", 1, 2, 3}
section2:addDropdown("Dropdown", kVars.list1, function(txt)
   print(txt)
end)
section2:addButton("Button", function()
   kVars.list1 = {"fuck you", "and your", "mom"}
end)

-- second page
local theme = Window:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")

for theme, color in pairs(themes) do --all in one theme changer, i know, im cool
   colors:addColorPicker(theme, color, function(color3)
      Window:setTheme(theme, color3)
   end)
end
Window:Notify("title", "msg")
-- load
Window:SelectPage(Window.pages[1], true) -- no default for more freedom
]]--