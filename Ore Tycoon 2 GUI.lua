--[[
Game : https://www.roblox.com/games/1113197103
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = "Ore Tycoon 2 GUI"
kVars.lp = game:GetService("Players").LocalPlayer
kVars.VirtualUser = game:GetService('VirtualUser')

---- if re-injecting script, we wait for the old one to close and turn all option off
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    wait(.15)
end

---- antiAFK ----
kVars.AntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.VirtualUser:CaptureController()
    kVars.VirtualUser:ClickButton2(Vector2.new())
end)

---- GUI Library ----
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

---- pages ----
local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
----  ----
kVars.toggleClick = pageFarm.AddToggle("Click", false, function(bool)
    kVars.boolClick = bool
    if bool then fClick() end
end)

function fClick()
    spawn(function()
        while kVars.boolClick do
            wait()
            fireclickdetector(game:GetService("Workspace").Tycoons.Teal.PurchasedObjects["00SpecialMine"].Skin.Button.ClickDetector, 10)
        end
    end)
end

kVars.toggleBoxes = pageFarm.AddToggle("Boxes", false, function(bool)
    kVars.boolBoxes = bool
    if bool then fBoxes() end
end)

function fBoxes()
    spawn(function()
        while kVars.boolBoxes do
            wait()
            for i,v in pairs(game:GetService("Workspace").container:GetChildren()) do
                if kVars.lp.Character:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("TouchInterest") then
                    firetouchinterest(kVars.lp.Character:FindFirstChild("HumanoidRootPart"), v, 0)
                    wait()
                    firetouchinterest(kVars.lp.Character:FindFirstChild("HumanoidRootPart"), v, 1)
                end
            end
        end
    end)
end



kVars.toggleUpgrade = pageFarm.AddToggle("Upgrade", false, function(bool)
    kVars.boolUpgrade = bool
    if bool then fUpgrade() end
end)

function fUpgrade()
    spawn(function()
        while kVars.boolUpgrade do
            wait()
            for i,v in pairs(game:GetService("Workspace").Buttons:GetChildren()) do
                if kVars.lp.Character:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Touch") and v.Touch:FindFirstChild("TouchInterest") then
                    kVars.lp.Character.HumanoidRootPart.CFrame = CFrame.new(v.Touch.CFrame.x, v.Touch.CFrame.y + 4, v.Touch.CFrame.z)
                    wait(.5)
                end   
            end
        end
    end)
end


---------- Character Page ----------
---- Walk Speed ----
kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.WalkSpeed}, function(num)
    kVars.lp.Character.Humanoid.WalkSpeed = num
end)

---- Jump Power ----
kVars.sliderJumpPower = pageCharacter.AddSlider("Jump Power",  {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.JumpPower}, function(num)
    kVars.lp.Character.Humanoid.JumpPower = num
end)

---- Inf Jump ----
kVars.sliderInfJump = pageCharacter.AddToggle("Inf Jump", false, function(bool)
    kVars.boolInfJump = bool
end)

kVars.InfJumpConnect = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump and kVars.lp.Character:FindFirstChild("Humanoid") then
		kVars.lp.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)

---------- Credits Page ----------
kVars.labelCodedBy = pageCredits.AddLabel("Coded by : Keathunsar")
kVars.labelCodedByLink = pageCredits.AddLabel("https://github.com/dady172172/Roblox-Cheats")
kVars.labelGuiBy = pageCredits.AddLabel("Gui made by : FungBert")
kVars.labelGuiByLink = pageCredits.AddLabel("v3rmillion.net/member.php?action=profile&uid=1078854")

---------- Closing ----------
kVars.ClosingConnect = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.WindowName then
		kVars.closing = true
		wait(.1)
		kVars.InfJumpConnect:Disconnect()
		for i,v in pairs(kVars) do
			if type(v) == "boolean" then
				v = false
			end
		end
		kVars.ClosingConnect:Disconnect()
		script:Destroy()
	end
end)



--[[
---- label ----    
local FirstLabel = FirstPage.AddLabel("Section 1")

---- button ----
local FirstButton = FirstPage.AddButton("Hello", function()
    print("Hello")
end)

---- toggle ----
local FirstToggle = FirstPage.AddToggle("Hello", false, function(Value)
    print(Value)
end)

---- Slider ----
local FirstSlider = FirstPage.AddSlider("Hello", {Min = 0, Max = 255, Def = 50}, function(Value)
    print(Value)
end)

---- color picker ----
local FirstPicker = FirstPage.AddColourPicker("Hello", "white", function(Value)
    print(Value)
end)

---- dropdown ----
local FirstDropdown = FirstPage.AddDropdown("Hello", {}, function(Value)
    print(Value)
end)
]]--