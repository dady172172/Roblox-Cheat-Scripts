--[[
Game : https://www.roblox.com/games/245440965
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- variables ----
kVars = {} -- Table for all the variables
kVars.WindowName = "Shipping Lanes GUI"
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
local pageTeleport = MainUI.AddPage("Teleport")
local pageCharacter = MainUI.AddPage("Player")
local pageCredits = MainUI.AddPage("Credits")

---------- Farm Page ----------
----  ----
kVars.Ports = {
    {name = "Stanley Harbor", cf = CFrame.new(540.420349, 235.11731, 6159.98047, -0.588217914, -0.000591370161, 0.80870229, -0.00129665574, 0.999999166, -0.000211878287, -0.808701456, -0.00117323908, -0.588218153)},
    {name = "Rockfall Port", cf = CFrame.new(151.157089, 234.540207, 161.405823, 0.89730984, 0.000956618809, -0.44140023, 1.46861721e-05, 0.999997616, 0.00219708658, 0.441401243, -0.00197794987, 0.897307634)},
    {name = "Newport", cf = CFrame.new(5747.02686, 233.413498, 13983.3672, -0.167286068, 0.000682048034, 0.985908151, 0.000356477452, 0.999999762, -0.000631310511, -0.985908329, 0.000245844567, -0.167286262)},
    {name = "Long Island", cf = CFrame.new(14893.082, 234.118469, 4408.12842, -0.499146372, 0.00693209376, 0.866489947, 0.00760493102, 0.999964535, -0.00361905433, -0.866484344, 0.00478315866, -0.49918139)},
    {name = "Norfolk Port", cf = CFrame.new(21963.8359, 235.483948, 19977.752, -0.69759208, 0.00409356831, -0.716483474, 0.00507862726, 0.999986827, 0.000768620754, 0.716477156, -0.00310256868, -0.697603643)},
    {name = "Davenport", cf = CFrame.new(-4586.24854, 234.591751, 24147.1953, -0.197188631, -0.000774772663, -0.980365276, -0.00748127606, 0.999971747, 0.000714500784, 0.980337024, 0.00747527415, -0.197188869)},
    {name = "Newhaven Harbor", cf = CFrame.new(-23860.4316, 234.35994, -3674.8689, 0.982195735, -0.00094546983, -0.187858015, 0.00035496385, 0.999994874, -0.00317697949, 0.187860057, 0.00305373291, 0.982191086)},
    {name = "Emerald Harbor", cf = CFrame.new(11760.917, 235.537308, -20761.1816, -0.647549093, -0.00553944241, -0.762003601, -0.00428856397, 0.999984205, -0.00362504786, 0.762011647, 0.00092050503, -0.647562623)},
    {name = "Bayview Port", cf = CFrame.new(26040.0078, 226.191772, -4320.48877, -0.0546442159, 0.00159063959, 0.998504639, 0.00530379685, 0.999985099, -0.00130274217, -0.998491824, 0.0052246782, -0.0546518378)},
    {name = "Woodside Inlet", cf = CFrame.new(-33206.2188, 224.337341, -2874.49146, 0.0856137574, -0.00241552247, 0.996325493, -0.00595548516, 0.999977946, 0.00293612969, -0.996310592, -0.00618497469, 0.0855974853)}
}

for g,b in pairs(kVars.Ports) do
    pageTeleport.AddButton(b.name, function()
        local ship = v
        for i,v in pairs(game:GetService("Workspace").SpawnedShips:GetChildren()) do
            if tostring(v.Storage.Owner.Value) == tostring(game.Players.LocalPlayer.Name) then
                ship = v
                break
            end
        end
        ship:SetPrimaryPartCFrame(b.cf)
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