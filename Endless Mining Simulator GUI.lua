--[[
Game : https://www.roblox.com/games/5264342538
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = "Endless Mining Simulator GUI"
kVars.lp = game:GetService("Players").LocalPlayer
kVars.VirtualUser = game:service('VirtualUser')

---- if re-injecting script, we wait for the old one to close and turn all option off
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    wait(.15)
end

---- antiAFK ----
local VirtualUser = game:service('VirtualUser')
kVars.AntiAfk = game:service('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

---- GUI Library ----
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

---- pages ----
local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
---- Mine ----
kVars.toggleMine = pageFarm.AddToggle("Mine", false, function(bool)
    kVars.boolMine = bool
    if bool then 
        fMine() 
    end
end)

function fMine()
    spawn(function()
        while kVars.boolMine do
            wait()
            game:GetService("ReplicatedStorage").GameSystem.PlayerClick:FireServer()
        end
    end)
end

---- Drop Boxes ----
kVars.toggleDropBoxes = pageFarm.AddToggle("Drop Boxes", false, function(bool)
    kVars.boolDropBoxes = bool
    if bool then 
        fDropBoxes() 
    end
end)

function fDropBoxes()
    spawn(function()
        while kVars.boolDropBoxes do
            wait()
            for i,v in pairs(game:GetService("Workspace").GameWorkspace.AirdropBoxes:GetChildren()) do
                if v:IsA("Part") and v:FindFirstChild("TouchInterest") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v,0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v,1)
                end
            end  
        end
    end)
end

---- Open Chests ----
kVars.ChestList = {
    game:GetService("Workspace").GameWorkspace.System.ChestZone.ChestA,
    game:GetService("Workspace").GameWorkspace.System.ChestZone.ChestB,
    game:GetService("Workspace").GameWorkspace.System.ChestZone.ChestC
}
kVars.toggleOpenChests = pageFarm.AddToggle("Open Chests", false, function(bool)
    kVars.boolOpenChests = bool
    if bool then 
        fOpenChests() 
    end
end)

function fOpenChests()
    spawn(function()
        while kVars.boolOpenChests do
            wait()
            for i,v in pairs(kVars.ChestList) do
                if v.BillboardGui.TextLabel.Text == "UNLOCKED" then
                    game:GetService("ReplicatedStorage").GameSystem.ChestEvent:FireServer(v.Name)
                end
            end
        end
    end)
end

---- Rail Gems ----
kVars.toggleRailGems = pageFarm.AddToggle("Gems *Start the cart ride", false, function(bool)
    kVars.boolRailGems = bool
    if bool then 
        fRailGems() 
    end
end)

function fRailGems()
    spawn(function()
        while kVars.boolRailGems do
            wait()
            if game:GetService("ReplicatedStorage"):FindFirstChild("MineCart") and game:GetService("Workspace"):FindFirstChild("GameWorkspace") then
                game:GetService("ReplicatedStorage").MineCart.GameEvent:FireServer("Gem")
                if game:GetService("Workspace").GameWorkspace.MineCartGame.ClientSpace:FindFirstChild("Trap") then
                    game:GetService("Workspace").GameWorkspace.MineCartGame.ClientSpace:findFirstChild("Trap"):Destroy()
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
        kVars.AntiAfk:Disconnect()
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
local FirstLabel = FirstPage.AddLabel("Section 1")
local FirstButton = FirstPage.AddButton("Hello", function()
    print("Hello")
end)
local FirstToggle = FirstPage.AddToggle("Hello", false, function(Value)
    print(Value)
end)
local FirstSlider = FirstPage.AddSlider("Hello", {Min = 0, Max = 255, Def = 50}, function(Value)
    print(Value)
end)
local FirstPicker = FirstPage.AddColourPicker("Hello", "white", function(Value)
    print(Value)
end)
local FirstDropdown = FirstPage.AddDropdown("Hello", {}, function(Value)
    print(Value)
end)
]]--