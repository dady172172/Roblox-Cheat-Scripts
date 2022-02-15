--[[
Game : https://www.roblox.com/games/8592863835
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=244024
]]--

---- Variables ----
kVars = {}
kVars.WindowName = "Magnet Simulator 2 GUI"
kVars.txtName = kVars.WindowName .. ".txt"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.hrp = kVars.lp.Character.HumanoidRootPart
kVars.h = kVars.lp.Character.Humanoid
kVars.rs = game:GetService('ReplicatedStorage')
kVars.vu = game:GetService('VirtualUser')
kVars.HttpService = game:GetService("HttpService")
kVars.themes = {}
kVars.tmp = {}
---- Load Settings ----
if readfile and isfile then
    if isfile(kVars.txtName) then
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
local pageTeleport = Window:addPage("Teleport", 6723742952)
local pagePlayer = Window:addPage("Player", 7992557358)
local pageSettings = Window:addPage("Settings", 6942070576)
local sectionAutoFarm = pageFarm:addSection("Auto Farm")
local sectionUpgradeBag = pageFarm:addSection("Upgrade Bag")
local sectionTeleportArea = pageTeleport:addSection("Teleport")
local sectionUpgradeCurrentMagnet = pageFarm:addSection("Upgrade Current Magnet")
local sectionPlayerStats = pagePlayer:addSection("Stats")
local sectionTpToPlayer = pagePlayer:addSection("Teleport To Player")
local sectionKeybinds = pageSettings:addSection("Keybinds")
local sectionTheme = pageSettings:addSection("Theme")

----  ----
sectionAutoFarm:addToggle("Coins", false, function(bool)
   kVars.boolCoins = bool
   if bool then fCoins() end
end)

function fCoins()
   spawn(function()
      while kVars.boolCoins do
         wait()
         for i,v in pairs(game:GetService("Workspace").Coins:GetChildren()) do
            wait()
            v:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0))
        end
        for i,v in pairs(game:GetService("Workspace")["_PlayerCoins"][kVars.lp.Name]:GetChildren()) do
            wait()
            v:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0))
        end
        for i,v in pairs(game:GetService("Workspace")["_PlayerPowerUps"][kVars.lp.Name]:GetChildren()) do
            if type(v) == "part" then
                wait()
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0)
            else
                wait()
                v:SetPrimaryPartCFrame(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-3,0))
            end
        end
      end
   end)
end

sectionAutoFarm:addToggle("Sell", false, function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
 end)
 
 function fSell()
    spawn(function()
       while kVars.boolSell do
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").Rings.Sellx25.Touch,0)
          wait()
          firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").Rings.Sellx25.Touch,1)
       end
    end)
 end

 sectionAutoFarm:addButton("Shhhh This gives some game passes.", function()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Gamepasses:GetChildren()) do
        if v.ClassName == "BoolValue" then
            v.Value = true
        end
    end
 end)

 sectionUpgradeBag:addToggle("Bag", false, function(bool)
    kVars.boolBag = bool
    if bool then fBag() end
 end)
 
 function fBag()
    spawn(function()
       while kVars.boolBag do
          wait(1)
          game:GetService("ReplicatedStorage").Events.GameEvents.UpgradeStorage:FireServer()
       end
    end)
 end

 sectionUpgradeCurrentMagnet:addToggle("Speed", false, function(bool)
    kVars.boolSpeed = bool
    if bool then fSpeed() end
 end)
 
 function fSpeed()
    spawn(function()
       while kVars.boolSpeed do
          wait(1)
          game:GetService("ReplicatedStorage").Events.GameEvents.UpgradeMagnet:FireServer(game:GetService("Players").LocalPlayer.StarterGear:FindFirstChildWhichIsA("Tool").Name, "Speed")
       end
    end)
 end

 sectionUpgradeCurrentMagnet:addToggle("Power", false, function(bool)
    kVars.boolPower = bool
    if bool then fPower() end
 end)
 
 function fPower()
    spawn(function()
       while kVars.boolPower do
          wait(1)
          game:GetService("ReplicatedStorage").Events.GameEvents.UpgradeMagnet:FireServer(game:GetService("Players").LocalPlayer.StarterGear:FindFirstChildWhichIsA("Tool").Name, "Power")
       end
    end)
 end

 sectionUpgradeCurrentMagnet:addToggle("Range", false, function(bool)
    kVars.boolRange = bool
    if bool then fRange() end
 end)
 
 function fRange()
    spawn(function()
       while kVars.boolRange do
          wait(1)
          game:GetService("ReplicatedStorage").Events.GameEvents.UpgradeMagnet:FireServer(game:GetService("Players").LocalPlayer.StarterGear:FindFirstChildWhichIsA("Tool").Name, "Range")
       end
    end)
 end

---- Teleport ----
kVars.Locations = {
    {name = "Spawn", cf = game:GetService("Workspace").Spawns.SpawnLocation.CFrame},
    {name = "Area1 Spawn", cf = game:GetService("Workspace")["_SingleCoinSpawns"][1].CFrame},
    {name = "Desert", cf = game:GetService("Workspace")["_SingleCoinSpawns"][14].CFrame},
    {name = "Jungle", cf = game:GetService("Workspace")["_SingleCoinSpawns"][120].CFrame},
    {name = "Aquatic", cf = game:GetService("Workspace")["_SingleCoinSpawns"][500].CFrame},
    {name = "Lava", cf = game:GetService("Workspace")["_SingleCoinSpawns"][5000].CFrame},
    {name = "Quarry", cf = game:GetService("Workspace")["_SingleCoinSpawns"][75000].CFrame},
    {name = "Wild West", cf = game:GetService("Workspace")["_SingleCoinSpawns"][1000000].CFrame},
    {name = "Graveyard", cf = game:GetService("Workspace")["_SingleCoinSpawns"][10000000].CFrame},
    {name = "Frost", cf = game:GetService("Workspace")["_SingleCoinSpawns"][100000000].CFrame},
    {name = "Hell", cf = game:GetService("Workspace")["_SingleCoinSpawns"][1000000000].CFrame},
    {name = "Heaven", cf = game:GetService("Workspace")["_SingleCoinSpawns"][10000000000].CFrame}
}
for i,v in pairs(kVars.Locations) do
    sectionTeleportArea:addButton(v.name, function()
        kVars.hrp.CFrame = v.cf
     end)
end


---- player stats section ----
sectionPlayerStats:addSlider("Walk Speed", 16, kVars.h.WalkSpeed, 1024, function(value)
   kVars.h.WalkSpeed = value
end)

sectionPlayerStats:addSlider("Jump Power", 50, kVars.h.JumpPower, 1024, function(value)
   kVars.h.JumpPower = value
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
   end
end)

sectionTpToPlayer:addButton("Teleport", function()
   local cnf = true
   if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and kVars.teleportToPlayer ~= nil then
      for i,v in pairs(game:GetService("Players"):GetChildren()) do
         if string.find(string.lower(v.DisplayName), string.lower(kVars.teleportToPlayer)) then
            kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame
            cnf = false
         elseif string.find(string.lower(v.Name), string.lower(kVars.teleportToPlayer)) then
            kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame
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

---- Keybinds ----
kVars.keybindOpencloseMenu = Enum.KeyCode.Backquote
sectionKeybinds:addKeybind("Open/Close Menu", kVars.keybindOpencloseMenu, function(key)  
    Window:toggle()
 end, function(key)
    Window:Notify("Changed Keybind","You changed the keybind for open/close menu!")
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
        wait(.5)
		script:Destroy()
	end
end)
