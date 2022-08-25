--[[
Game : https://www.roblox.com/games/1554960397
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = "Car Dealership Tycoon GUI"
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
kVars.toggleDrive = pageFarm.AddToggle("Drive", false, function(bool)
    kVars.boolDrive = bool
    if bool then
        fDrive()
    else
        keyrelease(87) 
    end
end)

function fDrive()
    spawn(function()
        kVars.plrcar = "nil"
        for i,v in pairs(game:GetService("Workspace").Cars:GetChildren()) do
            if v:FindFirstChild("Stats") and v.Stats:FindFirstChild("Owner") then
                if v.Stats.Owner.Value == kVars.lp.Name then
                    kVars.plrcar = v
                end
            end
        end
        while kVars.boolDrive do
            wait()
            if not workspace["Keaths Platform"] then
                local part = Instance.new("Part")
                part.Position = Vector3.new(0,60,0)
                part.Size = Vector3.new(1000,5,1000)
                part.Anchored = true
                part.Name = "Keaths Platform"
                part.CollisionGroupId = 5
                part.Parent = workspace
            end
            kVars.plrcar:SetPrimaryPartCFrame(CFrame.new(0, 65, 0))
            keypress(87)
            wait(5)
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