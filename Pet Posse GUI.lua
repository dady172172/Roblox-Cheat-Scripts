--[[
Game : https://www.roblox.com/games/8303902695
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = "Pet Posse GUI"
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

---- pages ----
local pageFarm = Window:addPage("Farm", 3117485989)
local sectionAutoFarm = pageFarm:addSection("Auto Farm")
local sectionRebirth = pageFarm:addSection("Rebirth")
local sectionUnlocks = pageFarm:addSection("Unlocks *Some may not always work!")

local pageEggs = Window:addPage("Eggs", 9194077649)
local sectionEggs = pageEggs:addSection("Auto Open")

local pageMenus = Window:addPage("Menus", 7347408509)
local sectionMenus = pageMenus:addSection("Menus")

local pagePlayer = Window:addPage("Player", 5012544693)
local sectionPlayerStats = pagePlayer:addSection("Stats")
local sectionTpToPlayer = pagePlayer:addSection("Teleport To Player")

local pageSettings = Window:addPage("Settings", 6942070576)
local sectionTheme = pageSettings:addSection("Theme")
local sectionKeybinds = pageSettings:addSection("Keybinds")

---- auto farm ----


local closestCoin = nil
local lastCoin = math.huge
spawn(function()
    while wait() do
        lastCoin = math.huge
        local tmpclosest = nil
        if game:GetService("Workspace")["__THINGS"].Coins:FindFirstChildWhichIsA("Folder") then
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Coins:FindFirstChildWhichIsA("Folder"):GetChildren()) do
                if v ~= nil and v:FindFirstChild("Coin") ~= nil and game:GetService("Workspace")["__THINGS"].Coins:FindFirstChildWhichIsA("Folder")  then
                    local distance = (game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position - v.Coin.Position).magnitude
                    if distance < lastCoin then
                        tmpclosest = v
                        lastCoin = distance
                    end
                end
            end
        end
        closestCoin = tmpclosest
    end   
end)

sectionAutoFarm:addToggle("Collect Coins", false, function(bool)
    kVars.boolCollectCoins = bool
    if bool then fCollectCoins() end
end)

function fCollectCoins()
    spawn(function()
        while kVars.boolCollectCoins do
            wait()
            ccCheck = closestCoin
            if closestCoin ~= nil and closestCoin:FindFirstChild("Coin") then
                if workspace["__THINGS"].Pets[kVars.lp.name]:GetChildren() ~= 0 then
                    for i=1,#workspace["__THINGS"].Pets[kVars.lp.name]:GetChildren() do
                        task.wait(.02)
                        fireclickdetector(closestCoin.Coin.ClickDetector)
                    end
                end
                repeat
                    task.wait()
                    if kVars.boolRebirth and kVars.lp.PlayerGui.Notifications.Level.Text == "MAX LEVEL!" then task.wait(2) end
                    local response1 = pcall(function()  
                        game:GetService("Workspace")["__THINGS"]["__REMOTES"].clickedButton:FireServer(closestCoin.Coin,closestCoin)
                    end) 
                    if not response1 then
                        fCollectCoins() 
                        return
                    end
                until kVars.boolCollectCoins == false or closestCoin ~= ccCheck
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
            if kVars.lp.PlayerGui.Notifications.Level.Text == "MAX LEVEL!" then
                game:GetService("Workspace").__THINGS.__REMOTES.rebirth:InvokeServer(kVars.lp)
            end
        end
    end)
end

sectionUnlocks:addButton("Teleport Unlock", function()
    game:GetService("Players").LocalPlayer.Leaderstats.teleport.Value = true
end)

sectionUnlocks:addButton("TripleEggs Unlock", function()
    game:GetService("Players").LocalPlayer.Leaderstats.tripleEggs.Value = true
end)

sectionUnlocks:addButton("FastHatch Unlock", function()
    game:GetService("Players").LocalPlayer.Leaderstats.fastHatch.Value = true
end)

sectionUnlocks:addButton("AutoHatch Unlock", function()
    game:GetService("Players").LocalPlayer.Leaderstats.autoHatch.Value = true
end)

---- eggs section ----

local eggsList = {}
for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Billboards.AutoHatch:GetChildren()) do
    table.insert(eggsList, v.name)
end
table.sort(eggsList)
sectionEggs:addDropdown("Select Egg To Hatch", eggsList ,function(txt)
    kVars.selectedEgg = txt
end)

sectionEggs:addToggle("Triple Egg *needs pass", false, function(bool)
    kVars.openTriple = bool
end)

sectionEggs:addToggle("Open", false, function(bool)
    kVars.openEgg = bool
    if bool then fOpenEgg() end
    if kVars.selectedEgg ~= nil then
        game:GetService("Workspace").__THINGS.__REMOTES.buyEgg:InvokeServer(kVars.selectedEgg)
    end
end)

function fOpenEgg()
    spawn(function()
        while kVars.openEgg do
            wait()
            if kVars.selectedEgg ~= nil and kVars.openTriple == false then
                game:GetService("Workspace").__THINGS.__REMOTES.buyEgg:InvokeServer(kVars.selectedEgg)
            elseif kVars.selectedEgg ~= nil and kVars.openTriple then
                game:GetService("Workspace").__THINGS.__REMOTES.buyEgg:InvokeServer(kVars.selectedEgg, "tripleEgg")
            end
        end
    end)
end

---- menu section ----
sectionMenus:addButton("Merchant", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Merchant.Enabled = true
end)

sectionMenus:addButton("Upgrade", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Upgrade.Enabled = true
end)

sectionMenus:addButton("Teleport", function()
    game:GetService("Players").LocalPlayer.PlayerGui.Teleport.Enabled = true
end)

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