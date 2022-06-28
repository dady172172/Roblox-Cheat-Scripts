--[[
Game : https://www.roblox.com/games/8540346411
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = "Rebirth Champions X GUI"
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
        print("Your injector does not support writefile.")
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

---- pages ----
local pageFarm = Window:addPage("Farm", 3117485989)
local sectionAutoFarm = pageFarm:addSection("Auto Farm")
local sectionAutoRebirth = pageFarm:addSection("Rebirth")
local sectionAutoOther = pageFarm:addSection("Other")
local sectionAutoSpecialEvent= pageFarm:addSection("Special Event")

local pageEggs = Window:addPage("Eggs", 9194077649)
local sectionEggs = pageEggs:addSection("Eggs")
local sectionPets = pageEggs:addSection("Pets")

local pageTeleport = Window:addPage("Teleport", 4814045731)
local sectionTeleport = pageTeleport:addSection("Locations")

local pageMenus = Window:addPage("Menus", 7347408509)
local sectionMenu = pageMenus:addSection("Menus")

local pagePlayer = Window:addPage("Player", 5012544693)
local sectionPlayerStats = pagePlayer:addSection("Stats")
local sectionTpToPlayer = pagePlayer:addSection("Teleport To Player")

local pageSettings = Window:addPage("Settings", 6942070576)
local sectionTheme = pageSettings:addSection("Theme")
local sectionKeybinds = pageSettings:addSection("Keybinds")

---- section auto farm ----
sectionAutoFarm:addToggle("Clicks", false, function(bool)
    kVars.boolClick = bool
    if bool then fClick() end
end)

function fClick()
    spawn(function()
        while kVars.boolClick do
            task.wait()
            game:GetService("ReplicatedStorage").Events.Click3:FireServer()
        end
    end)
end

sectionAutoFarm:addToggle("Chests", false, function(bool)
    kVars.boolChests = bool
    if bool then fChests() end
end)

function fChests()
    spawn(function()
        while kVars.boolChests do
            wait(1)
            for i,v in pairs(game:GetService("Workspace").Scripts.Chests:GetChildren()) do
                if v.Touch and v.Touch.TouchInterest then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Touch, 0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Touch, 1)
                end
            end
        end
    end)
end

sectionAutoSpecialEvent:addToggle("Coconuts", false, function(bool)
    kVars.boolCoconuts = bool
    if bool then fCoconuts() end
end)

function fCoconuts()
    spawn(function()
        while kVars.boolCoconuts do
            wait()
            for i,v in pairs(game:GetService("Workspace").Scripts.CoconutsFolder.Storage:GetChildren()) do
                for j,n in pairs(v:GetChildren()) do
                    if not string.find(n.name, "sphere") then
                        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, n, 0)
                    end
                end
            end
        end
    end)
end

kVars.rebirthList = {}
for i=1,100 do
    table.insert(kVars.rebirthList,i)
end
sectionAutoRebirth:addDropdown("Selection", kVars.rebirthList, function(num)
    if tonumber(num) then
        kVars.selectedRebirthNum = num
    end
 end)

sectionAutoRebirth:addToggle("Rebirth", false, function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(tonumber(kVars.selectedRebirthNum))
        end
    end)
end

sectionAutoOther:addButton("Unlock Passes *Some May not work", function()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Passes:GetChildren()) do
        if type(v) == "userdata" and v.ClassName == "BoolValue" and not string.find(v.name,"banned") and not string.find(v.name,"ban") then
            v.Value = true
        end
    end
 end)

 ---- egg/pet section ----
kVars.eggsList = {}
for i,v in pairs(game:GetService("Workspace").Scripts.Eggs:GetChildren()) do
    table.insert(kVars.eggsList, tostring(v))
end

 sectionEggs:addDropdown("Select Egg", kVars.eggsList, function(egg)
    kVars.selectedEgg = egg
 end)
 kVars.txtTriple = "Single"
 sectionEggs:addToggle("Triple *may need gamepass", false, function(bool)
    if bool then
        kVars.txtTriple = "Triple"
    else
        kVars.txtTriple = "Single"
    end
end)

 sectionEggs:addToggle("Open *Must be near the egg container", false, function(bool)
    kVars.boolOpen = bool
    if bool then fOpen() end
end)

function fOpen()
    spawn(function()
        while kVars.boolOpen do
            wait()
            if kVars.selectedEgg and kVars.txtTriple then
                game:GetService("ReplicatedStorage").Functions.Unbox:InvokeServer(tostring(kVars.selectedEgg), tostring(kVars.txtTriple))
            end
        end
    end)
end

sectionPets:addToggle("CraftAll", false, function(bool)
    kVars.boolCraftAll = bool
    if bool then fCraftAll() end
end)

function fCraftAll()
    spawn(function()
        while kVars.boolCraftAll do
            wait()
            game:GetService("ReplicatedStorage").Functions.Request:InvokeServer("CraftAll",{})
        end
    end)
end

---- teleport section ----
local teleportList = game:GetService("Workspace").Scripts.TeleportTo:GetChildren()
table.sort(teleportList, function(k1,k2)
    return k1.name < k2.name
end)
for k,n in ipairs(teleportList) do
    sectionTeleport:addButton(n.name,function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = n.CFrame
    end)
end

---- menu section ----
kVars.menusList = game:GetService("Workspace").Scripts.Spawn:GetChildren()
table.sort(kVars.menusList,function(k1,k2)
    return k1.name < k2.name
end)
for i,v in ipairs(kVars.menusList) do
    sectionMenu:addButton(v.name, function()
        if v.Touch then
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Touch, 0)
            wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Touch, 1)
        end
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

syn.protect_gui(game:GetService("CoreGui")[kVars.WindowName])