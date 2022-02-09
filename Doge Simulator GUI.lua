--[[
Game :
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = ""
kVars.lp = game:GetService("Players").LocalPlayer
kVars.VirtualUser = game:GetService('VirtualUser')

---- if re-injecting script, we wait for the old one to close and turn all option off
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    wait(.15)
end

---- antiAFK ----
kVars.AntiAfk = game:service('Players').LocalPlayer.Idled:connect(function()
    kVars.VirtualUser:CaptureController()
    kVars.VirtualUser:ClickButton2(Vector2.new())
end)

---- GUI Library ----
local UILibrary = loadstring(game:HttpGet("https://pastebin.com/raw/V1ca2q9s"))()

---- pages ----
local MainUI = UILibrary.Load(kVars.WindowName)
local pageFarm = MainUI.AddPage("Farm")
local pageTeleport = MainUI.AddPage("Teleport")
local pageCharacter = MainUI.AddPage("Player")
local pageMisc = MainUI.AddPage("Misc")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
----  ----
kVars.toggleBark = pageFarm.AddToggle("Barks", false, function(bool)
    kVars.boolBark = bool
    if bool then fBark() end
end)

function fBark()
    spawn(function()
        while kVars.boolBark do
            wait()
            if kVars.lp.Character:FindFirstChildWhichIsA("Tool") then
                kVars.VirtualUser:CaptureController()
                kVars.VirtualUser:ClickButton1(Vector2.new())
            else
                keypress(0x31)
            end
        end
    end)
end

kVars.toggleRebirth = pageFarm.AddToggle("Rebirth", false, function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            if (100000 * (2 + kVars.lp.leaderstats.Rebirths.Value)) <= kVars.lp.leaderstats.Barks.Value and kVars.lp.Character:FindFirstChild("Humanoid") then
                game:GetService("ReplicatedStorage").RebirthEvent:FireServer()
            end
        end
    end)
end

kVars.CurrentZone = nil
for i,v in pairs(game:GetService("Players").LocalPlayer.stats:GetChildren()) do
    if v.ClassName == "BoolValue" and v.Name ~= "Banned" and v.Value == true then
        kVars.CurrentZone = v.Name
    end
end

kVars.toggleCoinsZone1 = pageFarm.AddToggle("Coins Zone1", false, function(bool)
    kVars.boolCoinsZone1 = bool
    if bool then fCoinsZone1() end
end)

function fCoinsZone1()
    spawn(function()
        while kVars.boolCoinsZone1 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Coin1:GetChildren()) do
                v.CanCollide = false
                if v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone1 == false
                    if kVars.boolCoinsZone1 == false then return end
                end
            end   
        end
    end)
end

kVars.toggleCoinsZone2 = pageFarm.AddToggle("Coins Zone2", false, function(bool)
    kVars.boolCoinsZone2 = bool
    if bool then fCoinsZone2() end
end)

function fCoinsZone2()
    spawn(function()
        while kVars.boolCoinsZone2 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Coin2:GetChildren()) do
                v.CanCollide = false
                if v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone2 == false
                    if kVars.boolCoinsZone2 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone3 = pageFarm.AddToggle("Coins Zone3", false, function(bool)
    kVars.boolCoinsZone3 = bool
    if bool then fCoinsZone3() end
end)

function fCoinsZone3()
    spawn(function()
        while kVars.boolCoinsZone3 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Coin3:GetChildren()) do
                v.CanCollide = false
                if v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone3 == false
                    if kVars.boolCoinsZone3 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone4 = pageFarm.AddToggle("Coins Zone4", false, function(bool)
    kVars.boolCoinsZone4 = bool
    if bool then fCoinsZone4() end
end)

function fCoinsZone4()
    spawn(function()
        while kVars.boolCoinsZone4 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Coin4:GetChildren()) do
                v.CanCollide = false
                if v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone4 == false
                    if kVars.boolCoinsZone4 == false then return end
                end
            end
            for i,v in pairs(game:GetService("Workspace").Coins.Chest1:GetChildren()) do
                v.CanCollide = false
                if v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone4 == false
                    if kVars.boolCoinsZone4 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone5 = pageFarm.AddToggle("Coins Zone5", false, function(bool)
    kVars.boolCoinsZone5 = bool
    if bool then fCoinsZone5() end
end)

function fCoinsZone5()
    spawn(function()
        while kVars.boolCoinsZone5 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Chest1F:GetChildren()) do
                v.CanCollide = false
                if v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone5 == false
                    if kVars.boolCoinsZone5 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone6 = pageFarm.AddToggle("Coins Zone6", false, function(bool)
    kVars.boolCoinsZone6 = bool
    if bool then fCoinsZone6() end
end)

function fCoinsZone6()
    spawn(function()
        while kVars.boolCoinsZone6 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Chest2:GetChildren()) do
                v.CanCollide = false
                if v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone6 == false
                    if kVars.boolCoinsZone6 == false then return end
                end
            end
            for i,v in pairs(game:GetService("Workspace").Coins.Chest3:GetChildren()) do
                v.CanCollide = false
                if v.Name == "Chest3 Big" and v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone6 == false
                    if kVars.boolCoinsZone6 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone7 = pageFarm.AddToggle("Coins Zone7", false, function(bool)
    kVars.boolCoinsZone7 = bool
    if bool then fCoinsZone7() end
end)

function fCoinsZone7()
    spawn(function()
        while kVars.boolCoinsZone7 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Chest3:GetChildren()) do
                v.CanCollide = false
                if v.Name ~= "Chest3 Big" and v.Transparency == 0 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone7 == false
                    if kVars.boolCoinsZone7 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone8 = pageFarm.AddToggle("Coins Zone8", false, function(bool)
    kVars.boolCoinsZone8 = bool
    if bool then fCoinsZone8() end
end)

function fCoinsZone8()
    spawn(function()
        while kVars.boolCoinsZone8 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Diamond1:GetChildren()) do
                v.CanCollide = false
                if v.Transparency ~= 1 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone8 == false
                    if kVars.boolCoinsZone8 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone9 = pageFarm.AddToggle("Coins Zone9", false, function(bool)
    kVars.boolCoinsZone9 = bool
    if bool then fCoinsZone9() end
end)

function fCoinsZone9()
    spawn(function()
        while kVars.boolCoinsZone9 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Diamond2:GetChildren()) do
                v.CanCollide = false
                if v.Transparency ~= 1 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone9 == false
                    if kVars.boolCoinsZone9 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsZone10 = pageFarm.AddToggle("Coins Zone10", false, function(bool)
    kVars.boolCoinsZone10 = bool
    if bool then fCoinsZone10() end
end)

function fCoinsZone10()
    spawn(function()
        while kVars.boolCoinsZone10 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Diamond3:GetChildren()) do
                v.CanCollide = false
                if v.Transparency ~= 1 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsZone10 == false
                    if kVars.boolCoinsZone10 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsSpace1 = pageFarm.AddToggle("Gems Space1", false, function(bool)
    kVars.boolCoinsSpace1 = bool
    if bool then fCoinsSpace1() end
end)

function fCoinsSpace1()
    spawn(function()
        while kVars.boolCoinsSpace1 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Space1:GetChildren()) do
                v.CanCollide = false
                if v.Transparency ~= 1 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsSpace1 == false
                    if kVars.boolCoinsSpace1 == false then return end
                end
            end
        end
    end)
end

kVars.toggleCoinsSpace2 = pageFarm.AddToggle("Gems Space2", false, function(bool)
    kVars.boolCoinsSpace2 = bool
    if bool then fCoinsSpace2() end
end)

function fCoinsSpace2()
    spawn(function()
        while kVars.boolCoinsSpace2 do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Space2:GetChildren()) do
                v.CanCollide = false
                if v.Transparency ~= 1 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolCoinsSpace2 == false
                    if kVars.boolCoinsSpace2 == false then return end
                end
            end
        end
    end)
end

kVars.toggleScrap = pageFarm.AddToggle("Scrap", false, function(bool)
    kVars.boolScrap = bool
    if bool then fScrap() end
end)

function fScrap()
    spawn(function()
        while kVars.boolScrap do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins.Scrap:GetChildren()) do
                v.CanCollide = false
                if v.Transparency ~= 1 and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    repeat
                        wait()
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    until v.Transparency == 1 or kVars.boolScrap == false
                    if kVars.boolScrap == false then return end
                end
            end
        end
    end)
end
---------- Teleport Page ----------
kVars.Zones = {
    [1] = {name = "Spawn", cf = game:GetService("Workspace").SpawnLocation.CFrame},
    [2] = {name = "Zone1", cf = CFrame.new(-24, 5, -32)},
    [3] = {name = "Zone2", cf = CFrame.new(-46, 5, -242)},
    [4] = {name = "Zone3", cf = CFrame.new(-12, 5, -461)},
    [5] = {name = "Zone4", cf = CFrame.new(-67, 5, -690)},
    [6] = {name = "Zone5", cf = CFrame.new(83, 5, -848)},
    [7] = {name = "Zone6", cf = CFrame.new(205, 5, -936)},
    [8] = {name = "Zone7", cf = CFrame.new(164, 5, -1138)},
    [9] = {name = "Zone8", cf = CFrame.new(126, 5, -1357)},
    [10] = {name = "Zone9", cf = CFrame.new(139, 26, -1705)},
    [11] = {name = "Zone10", cf = CFrame.new(138, 25, -1957)},
    [12] = {name = "Space1", cf =  CFrame.new(372, 165, -4779)},
    [13] = {name = "Space2", cf = CFrame.new(373, 165, -5215)},
    [14] = {name = "Areana", cf = CFrame.new(-1116, 5, -100)}
}

for i,v in ipairs(kVars.Zones) do
    pageTeleport.AddButton(v.name, function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.cf
    end)
end



---------- Character Page ----------
---- Walk Speed ----
kVars.sliderWalkSpeed = pageCharacter.AddSlider("Walk Speed", {Min = 16, Max = 255, Def = kVars.lp.Character.Humanoid.WalkSpeed}, function(num)
    kVars.lp.Character.Humanoid.WalkSpeed = num
    kVars.varWalkSpeed = num
end)
spawn(function()
    wait()
    if kVars.lp.Character:FindFirstChild("Humanoid") and kVars.varWalkSpeed ~= nil then
        kVars.lp.Character:WaitForChild("Humanoid").WalkSpeed = kVars.varWalkSpeed
    end
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

---------- Misc Page ----------
kVars.buttonDeleteBarriers = pageMisc.AddButton("Delete Barriers", function()
    if game:GetService("Workspace"):FindFirstChild("Barriers") then
        game:GetService("Workspace").Barrier:Destroy()
    end
end)

kVars.buttonDeleteBarriers = pageMisc.AddButton("Remove Blurryness", function()
    if game:GetService("Lighting"):FindFirstChild("DepthOfField") then
        game:GetService("Lighting").DepthOfField:Destroy()
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