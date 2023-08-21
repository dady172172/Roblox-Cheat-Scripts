--[[
Game : 
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = ""
kVars.placeID = 
kVars.txtName = kVars.WindowName .. ".txt"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.HttpService = game:GetService("HttpService")
kVars.themes = {}
kVars.tmp = {}

---- check for correct game ----
if kVars.placeID ~= game.PlaceId then 
    warn("#### - This Script is not for this game. - ####")
    script:Destroy()
    return 
end

---- Load Settings ----
if isfile and isfile(kVars.txtName) then
    kVars.tmp = kVars.HttpService:JSONDecode(readfile(kVars.txtName))
    for i,v in pairs(kVars.tmp) do
        kVars.themes[i] = Color3.fromRGB(v[1], v[2], v[3])
    end
else
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
   task.wait(1)
end

---- antiAFK ----
kVars.connectAntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
   kVars.vu:CaptureController()
   kVars.vu:ClickButton2(Vector2.new())
end)

---- Load window ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zxciaz/VenyxUI/main/Reuploaded"))()
local Window = library.new(kVars.WindowName, 5013109572)

---- pages and sections ----
local pageFarm = Window:addPage("Farm", 3117485989)
local sectionAutoFarm = pageFarm:addSection("Auto Farm")

local pageTeleport = Window:addPage("Teleport", 6723742952)
local sectionTeleportToPlayer = pageTeleport:addSection("Teleport To Player")

local pagePlayer = Window:addPage("Player", 5012544693)
local sectionPlayerStats = pagePlayer:addSection("Stats")

local pageESP = Window:addPage("ESP", 6523858394)
local sectionPlayerESP = pageESP:addSection("Player ESP")

local pageSettings = Window:addPage("Settings", 6942070576)
local sectionTheme = pageSettings:addSection("Theme")
local sectionKeybinds = pageSettings:addSection("Keybinds")
local sectionMisc = pageSettings:addSection("Misc")

local pageCredit = Window:addPage("Credits", 13780996931)
local sectionCreditsKeath = pageCredit:addSection("Coded by : Keathunsar")
local sectionCreditsDino = pageCredit:addSection("UI-Lib by : Dino")


----========== page farm ==========----
----  ----
sectionAutoFarm:addToggle("", false, function(bool)
    kVars.bool = bool
    if bool then f() end
end)

function f()
    spawn(function()
        while kVars.bool do
            wait()
            
        end
    end)
end


----========== page player ==========----
---- player stats section ----
kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionPlayerStats:addSlider("Walk Speed", kVars.walkSpeed, 1, 1024, function(value)
    kVars.lp.Character:WaitForChild('Humanoid').WalkSpeed = value
    kVars.walkSpeed = value
end)

kVars.jumpPower = kVars.humanoid.JumpPower
sectionPlayerStats:addSlider("Jump Power", kVars.jumpPower, 1, 1024, function(value)
    kVars.lp.Character:WaitForChild('Humanoid').JumpPower = value
    kVars.jumpPower = value
end)

kVars.jumpHeight = kVars.humanoid.JumpHeight
sectionPlayerStats:addSlider("Jump Height", kVars.jumpHeight, 1, 1024, function(value)
    kVars.lp.Character:WaitForChild('Humanoid').JumpHeight = value
    kVars.jumpHeight = value
end)

kVars.boolInfJump = false
sectionPlayerStats:addToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

kVars.connectInfJump = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)

kVars.connectPlayerAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpPower = kVars.jumpPower
    kVars.humanoid.JumpHeight = kVars.jumpHeight
end)

---- tp to player section ----
kVars.SelectedTPToPlayer = kVars.lp.name
sectionTeleportToPlayer:addTextbox("PlayerName", "Name", function(value, focusLost)
    if focusLost then
        kVars.SelectedTPToPlayer = value
    end
end)

sectionTeleportToPlayer:addButton("Teleport", function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if kVars.SelectedTPToPlayer ~= nil and kVars.SelectedTPToPlayer ~= kVars.lp.name then
            if string.find(string.lower(v.DisplayName), string.lower(kVars.SelectedTPToPlayer)) then
                kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame
                break                
            end
        end
    end    
end)


----========== page esp ==========----
---- section player esp ----
kVars.Esp = {}
kVars.boolEsp = false
sectionPlayerESP:addToggle("Player ESP", kVars.boolEsp, function(bool)
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

kVars.connectPlayerRemoving = game:GetService("Players").PlayerRemoving:Connect(function(player)
    if kVars.Esp[player] then
        kVars.Esp[player].Drawing:Remove()
    end
end)

----========== page settings ==========----
---- section theme ----
for theme, color in pairs(kVars.themes) do
    sectionTheme:addColorPicker(theme, color, function(color3)
        Window:setTheme(theme, color3)
    end)
    Window:setTheme(theme, color)
end

sectionTheme:addButton("Save Theme", function()
    saveSettings()
    Window:Notify("Saved Theme", "Theme saved to file " .. kVars.txtName)
end)

---- section keybind -----
sectionKeybinds:addKeybind("Open/Close Menu", Enum.KeyCode.F5, function()
	Window:toggle()
end, function()
end)

---- section misc ----
sectionMisc:addToggle("Purchase Prompt", game:GetService("CoreGui").PurchasePrompt.Enabled, function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
 end)

sectionMisc:addButton("Destroy this GUI",function()
    game:GetService('CoreGui'):FindFirstChild(kVars.WindowName):Destroy()
end)


----========== page credits ==========----
---- section credit keath ----
sectionCreditsKeath:addButton("https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
    Window:Notify("Link Copied", "Link copied to clipboard.")
 end)
 sectionCreditsKeath:addButton("https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
    Window:Notify("Link Copied", "Link copied to clipboard.")
 end)
---- section credit dino ----
sectionCreditsDino:addButton("Dino's V3ermillion", function()
    setclipboard('https://v3rmillion.net/member.php?action=profile&uid=244024')
    Window:Notify("Link Copied", "Link copied to clipboard.")
 end)

----========== window finish loading and closing ==========----
---- Select main page to display ----
Window:SelectPage(Window.pages[1], true)

---- Closing ----
local connectClosing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.WindowName then
	    kVars.connectInfJump:Disconnect()
        kVars.connectAntiAfk:Disconnect()
        kVars.connectPlayerAdded:Disconnect()
        kVars.connectPlayerRemoving:Disconnect()
		table.clear(kVars)
        task.wait(.1)
		--connectClosing:Disconnect()
		script:Destroy()
        return
	end
end)

-- only for synapsex --> syn.protect_gui(game:GetService("CoreGui")[kVars.WindowName])



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