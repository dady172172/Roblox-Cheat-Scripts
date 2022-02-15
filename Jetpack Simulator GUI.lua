--[[
Game : https://www.roblox.com/games/2662100821
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = "Jetpack Simulator GUI"
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
    print("Loading defult theme. Your injector does not support readfile or isfile.")
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
        print("You do not have injector dose not support writefile.")
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
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))() --someone reuploaded it so I put it in place of the original back up so guy can get free credit.
local Window = library.new(kVars.WindowName, 5013109572)

---- pages ----
local pageFarm = Window:addPage("Farm", 3117485989)
local pageTeleport = Window:addPage("Teleport", 4814045731)
local pagePlayer = Window:addPage("Player", 5012544693)
local pageSettings = Window:addPage("Settings", 6942070576)
local sectionAutoFarm = pageFarm:addSection("Auto Farm")
local sectionAutoUpgrade = pageFarm:addSection("Auto Upgrade")
local sectionTeleportAreas = pageTeleport:addSection("Areas")
local sectionPlayerStats = pagePlayer:addSection("Stats")
local sectionTpToPlayer = pagePlayer:addSection("Teleport To Player")
local sectionTheme = pageSettings:addSection("Theme")
local sectionHotkeys = pageSettings:addSection("Hotkeys")

---- Auto Farm ----
sectionAutoFarm:addToggle("Resource", false, function(bool)
    kVars.boolResource = bool
    if bool then fResource() end
end)

sectionAutoFarm:addToggle("Sell", false, function(bool)
kVars.boolSell = bool
end)

kVars.sellAreas = {
    game:GetService("Workspace").Areas.Area1.Bank.Sell,
    game:GetService("Workspace").Areas.Area3.Bank.Sell,
    game:GetService("Workspace").Areas.Area5.Bank.Sell,
    game:GetService("Workspace").Areas.Area7.Bank.Sell,
    game:GetService("Workspace").Areas.Area9.Bank.Sell,
    game:GetService("Workspace").Areas.Area11.Bank.Sell,
    game:GetService("Workspace").Areas.Area13.Bank.Sell,
    game:GetService("Workspace").Areas.Area15.Bank.Sell,
    game:GetService("Workspace").Areas.Area17.Bank.Sell,
    game:GetService("Workspace").Areas.Area19.Bank.Sell
}
function fResource()
    spawn(function()
        while kVars.boolResource do
            wait()
            local jp = game:GetService('ReplicatedStorage').DataFolder[game:GetService('Players').LocalPlayer.Name].JetpackData.EnergyLevel.Value
            local target = nil
            if jp == 1 and hrp then
                target = game:GetService('Workspace').Areas.Area1.Coal:FindFirstChild('Coal').HitPart
            elseif  jp == 2 and game:GetService('Workspace').Areas.Area2.Battery:FindFirstChild("Battery") then 
                target = game:GetService('Workspace').Areas.Area1.Battery:FindFirstChild("Battery").HitPart
            elseif  jp == 3 and game:GetService('Workspace').Areas.Area2.Solar:FindFirstChild("Solar") then
                target = game:GetService('Workspace').Areas.Area2.Solar:FindFirstChild("Solar").HitPart
            elseif jp == 4 and game:GetService('Workspace').Areas.Area4.Wind:FindFirstChild("Wind") then
                target = game:GetService('Workspace').Areas.Area3.Wind:FindFirstChild("Wind").HitPart
            elseif jp == 5 and game:GetService('Workspace').Areas.Area7.Nuclear:FindFirstChild("Nuclear") then					
                target = game:GetService('Workspace').Areas.Area7.Nuclear:FindFirstChild("Nuclear").HitPart
            elseif jp == 6 and game:GetService('Workspace').Areas.Area7.Plasma:FindFirstChild("Plasma") then
                target = game:GetService('Workspace').Areas.Area7.Plasma:FindFirstChild("Plasma").HitPart
            elseif jp == 7 and game:GetService('Workspace').Areas.Area11.Aetherium:FindFirstChild("Aetherium") then
                target = game:GetService('Workspace').Areas.Area11.Aetherium:FindFirstChild("Aetherium").HitPart
            elseif jp == 8 and game:GetService('Workspace').Areas.Area13.Corrodium:FindFirstChild("Corrodium") then
                target = game:GetService('Workspace').Areas.Area13.Corrodium:FindFirstChild("Corrodium").HitPart
            elseif jp == 9 and game:GetService('Workspace').Areas.Area13["Element 99"]:FindFirstChild("Element 99") then
                target = game:GetService('Workspace').Areas.Area13["Element 99"]:FindFirstChild("Element 99").HitPart
            elseif jp == 10 and game:GetService('Workspace').Areas.Area15.Galacticium:FindFirstChild("Galacticium") then
                target = game:GetService('Workspace').Areas.Area15.Galacticium:FindFirstChild("Galacticium").HitPart
            elseif jp == 11 and game:GetService('Workspace').Areas.Area17.Magmatium:FindFirstChild("Magmatium") then
                target = game:GetService('Workspace').Areas.Area17.Magmatium:FindFirstChild("Magmatium").HitPart
            elseif jp == 12 and game:GetService('Workspace').Areas.Area19["Lightning Orb"]:FindFirstChild("Lightning Orb") then
                target = game:GetService('Workspace').Areas.Area19["Lightning Orb"]:FindFirstChild("Lightning Orb").HitPart
            end
            local hrp = game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
            if target ~= nil and hrp then
                hrp.CFrame = target.CFrame
                wait()
            end
            if kVars.boolSell then
                local jetpackFuel = game:GetService("ReplicatedStorage").DataFolder[kVars.lp.Name].JetpackData.FuelLevel.Value 
                local jetpackMaxFuel = (game:GetService("ReplicatedStorage").DataFolder[kVars.lp.Name].JetpackData.MaxFuel.Value / 3) * 2
                local closest = nil
                if jetpackFuel >= jetpackMaxFuel then     
                    local last = math.huge
                    for i,v in pairs(kVars.sellAreas) do
                        if kVars.boolSell == false then return end
                        if (v.Position - hrp.Position).magnitude < last then
                            closest = v
                            last = (v.Position - hrp.Position).magnitude
                        end
                    end
                end
                if hrp and closest ~= nil then
                    local a = closest.CFrame
                    repeat
                        hrp.CFrame = CFrame.new(a.x, a.y + 5, a.z)
                        wait()
                    until game:GetService("ReplicatedStorage").DataFolder[kVars.lp.Name].JetpackData.FuelLevel.Value == 0 or kVars.boolSell == false
                end
            end
        end
    end)
end

sectionAutoFarm:addToggle("Prestige", false, function(bool)
    kVars.boolPrestige = bool
    if bool then fPrestige() end
end)

function fPrestige()
    spawn(function()
        while kVars.boolPrestige do
            wait()
            local plrPrestigeValue = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\140\159 Prestige").Value
            local money = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\146\176 Cash").Value
            local costToUpgrade = (10000000 * (plrPrestigeValue + 1))
            if money >= costToUpgrade then
                game:GetService("ReplicatedStorage").ServerToClient.RequestPrestige:FireServer()
            end
        end
    end)
end

sectionAutoUpgrade:addToggle("Jetpack", false, function(bool)
    kVars.boolJetpack = bool
    if bool then fJetpack() end
end)

function fJetpack()
    spawn(function()
        while kVars.boolJetpack do
            wait()
            local jp = game:GetService('ReplicatedStorage').DataFolder[game:GetService('Players').LocalPlayer.Name].JetpackData.EnergyLevel.Value
            local money = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\146\176 Cash").Value
            local costToUpgrade = (math.floor(math.pow(jp, 3.85)) * 100)
            if money >= costToUpgrade then
                game:GetService("ReplicatedStorage").ClientToServer.PurchaseJetpackUpgrade:FireServer()
            end
        end
    end)
end

sectionAutoUpgrade:addToggle("Fuel", false, function(bool)
    kVars.boolFuel = bool
    if bool then fFuel() end
end)

function fFuel()
    spawn(function()
        while kVars.boolFuel do
            wait()
            local fuel = game:GetService('ReplicatedStorage').DataFolder[game:GetService('Players').LocalPlayer.Name].JetpackData.MaxFuel.Value
            local money = game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("\240\159\146\176 Cash").Value
            local costToUpgrade = (math.floor(math.pow(fuel, 1.5)))
            if money >= costToUpgrade then
                game:GetService("ReplicatedStorage").ClientToServer.PurchaseFuelUpgrade:FireServer()
            end
        end
    end)
end



---- Teleport page ----
kVars.Locations = {
	{name = "Spawn/Earth", cf = CFrame.new(116, 5, -1)},
	{name = "Floating Island", cf = CFrame.new(34, 598, -19)},
	{name = "Moon", cf = CFrame.new(34, 1159, -19)},
	{name = "Mars", cf = CFrame.new(34, 2118, -19)},
	{name = "Neptune", cf = CFrame.new(34, 3212, -19)},
	{name = "Jupiter", cf = CFrame.new(34, 4609, -19)},
	{name = "Planet X", cf = CFrame.new(34, 6767, -19)},
	{name = "Diamond Planet", cf = CFrame.new(34, 8739, -19)},
	{name = "Magma Planet", cf = CFrame.new(34, 10748, -19)},
	{name = "Void Star", cf = CFrame.new(34, 12631, -19)}
}
for i,v in pairs(kVars.Locations) do
    sectionTeleportAreas:addButton(v.name, function()
        if game:GetService('Players').LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.cf
        end
    end)
end


---- player stats section ----

sectionPlayerStats:addSlider("Walk Speed", 16, kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed, 1024, function(value)
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild('ResourceCollectVisualizer') then
        game:GetService("Players").LocalPlayer.PlayerGui.ResourceCollectVisualizer:Destroy()
    end
    if game:GetService("StarterGui"):FindFirstChild("ResourceCollectVisualizer") then
        game:GetService("StarterGui").ResourceCollectVisualizer:Destroy()
    end
    kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed = value
end)

sectionPlayerStats:addSlider("Jump Power", 50, kVars.lp.Character:WaitForChild('Humanoid').JumpPower, 1000, function(value)
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
    --Window:setTheme(theme, color)
end

sectionTheme:addButton("Save Theme", function()
    saveSettings()
end)

sectionHotkeys:addKeybind("Open/Close Menu", Enum.KeyCode.Backquote, function()
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