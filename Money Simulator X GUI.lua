--[[
Game : https://www.roblox.com/games/6628835921
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Money Simulator X GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local b = w:CreateFolder("Buy")
local c = w:CreateFolder("Charater")

f:Toggle("Refill Bag",function(bool)
    kVars.boolRefillBag = bool
    if bool then fRefillBag() end
end)
function fRefillBag()
    spawn(function()
        while kVars.boolRefillBag do
            wait()
            game:GetService("ReplicatedStorage").FillMoney:FireServer()
        end
    end)
end

f:Toggle("Drop Money",function(bool)
    kVars.boolDropMoney = bool
    if bool then fDropMoney() end
end)
function fDropMoney()
    spawn(function()
        while kVars.boolDropMoney do
            wait()
            game:GetService("ReplicatedStorage").GetMoney:FireServer("DropOn", 0)
        end
    end)
end

f:Toggle("Gems",function(bool)
    kVars.boolGems = bool
    if bool then fGems() end
end)
function fGems()
    spawn(function()
        while kVars.boolGems do
            wait()
            for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                if string.find(string.lower(v.Name), "gem") and v:FindFirstChild("Click") then
                    fireclickdetector(v.Click,1)
                end
            end
        end
    end)
end

f:Toggle("Viruses",function(bool)
    kVars.boolViruses = bool
    if bool then fViruses() end
end)
function fViruses()
    spawn(function()
        while kVars.boolViruses do
            wait() 
            if game:GetService("Workspace").ComputerDefence1.Enemies:FindFirstChild("EnemyCube") then
                fireclickdetector(game:GetService("Workspace").ComputerDefence1.Enemies:FindFirstChild("EnemyCube").ClickDetector,1)
            end
        end
    end)
end

f:Toggle("Green Ores",function(bool)
    kVars.boolMineGreenOres = bool
    if bool then fMineGreenOres() end
end)
function fMineGreenOres()
    spawn(function()
        while kVars.boolMineGreenOres do
            wait()
                fireclickdetector(game:GetService("Workspace").Ores:FindFirstChild("GiftOre").ClickDetector,1)
        end
    end)
end

f:Toggle("Yellow Ores",function(bool)
    kVars.boolMineYellowOres = bool
    if bool then fMineYellowOres() end
end)
function fMineYellowOres()
    spawn(function()
        while kVars.boolMineYellowOres do
            wait()
            fireclickdetector(game:GetService("Workspace").Ores:FindFirstChild("GiftOre2").ClickDetector,1)
        end
    end)
end

f:Toggle("Orange Ores",function(bool)
    kVars.boolMineOrangeOres = bool
    if bool then fMineOrangeOres() end
end)
function fMineOrangeOres()
    spawn(function()
        while kVars.boolMineOrangeOres do
            wait()
            fireclickdetector(game:GetService("Workspace").Ores:FindFirstChild("GiftOre3").ClickDetector,1)
        end
    end)
end

f:Toggle("Blue Ores",function(bool)
    kVars.boolMineBlueOres = bool
    if bool then fMineBlueOres() end
end)
function fMineYellowOres()
    spawn(function()
        while kVars.boolMineYellowOres do
            wait()
            fireclickdetector(game:GetService("Workspace").Ores:FindFirstChild("GiftOre4").ClickDetector,1)
        end
    end)
end

f:Toggle("Diamond Ores",function(bool)
    kVars.boolMineBlueOres = bool
    if bool then fMineBlueOres() end
end)
function fMineYellowOres()
    spawn(function()
        while kVars.boolMineYellowOres do
            wait()
            fireclickdetector(game:GetService("Workspace").Ores:FindFirstChild("GiftOre5").ClickDetector,1)
        end
    end)
end

b:Toggle("Power",function(bool)
    kVars.boolPower = bool
    if bool then fPower() end
end)
function fPower()
    spawn(function()
        while kVars.boolPower do
            wait()
            game:GetService("ReplicatedStorage").UpgradePower:FireServer()
        end
    end)
end

b:Toggle("Bag",function(bool)
    kVars.boolBag = bool
    if bool then fBag() end
end)
function fBag()
    spawn(function()
        while kVars.boolBag do
            wait()
            game:GetService("ReplicatedStorage").UpgradeBag:FireServer()
        end
    end)
end

b:Toggle("Rank",function(bool)
    kVars.boolRank = bool
    if bool then fRank() end
end)
function fRank()
    spawn(function()
        while kVars.boolRank do
            wait()
            game:GetService("ReplicatedStorage").UpgradeRank:FireServer()
        end
    end)
end

b:Toggle("Tier",function(bool)
    kVars.boolTier = bool
    if bool then fTier() end
end)
function fTier()
    spawn(function()
        while kVars.boolTier do
            wait()
            game:GetService("ReplicatedStorage").TierUp:FireServer()
        end
    end)
end

kVars.varWalkSpeed = 16
c:Slider("Slider",{
    min = 16; -- min value of the slider
    max = 200; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    kVars.varWalkSpeed = value
end)

spawn(function()
    while wait() do
        game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = kVars.varWalkSpeed
    end

end)

c:Toggle("Inf Jump",function(bool)
    kVars.boolInfJump = bool
end)

kVars.InfJump = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)


---- Closing ----
kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.windowName then
		kVars.closing = true
		wait(.1)
		table.clear(kVars)
        kVars.WalkSpeed:Disconnect()
        kVars.InfJump:Disconnect()
		kVars.closeing:Disconnect()
        wait(.01)
		script:Destroy()

	end
end)

--[[
b:Label("Pretty Useless NGL",{
    TextSize = 25; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
}) 

b:Button("Button",function()
    print("Elym Winning")
end)

b:Toggle("Toggle",function(bool)
    shared.toggle = bool
    print(shared.toggle)
end)

b:Slider("Slider",{
    min = 10; -- min value of the slider
    max = 50; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    print(value)
end)

b:Dropdown("Dropdown",{"A","B","C"},true,function(mob) --true/false, replaces the current title "Dropdown" with the option that t
    print(mob)
end)

b:Bind("Bind",Enum.KeyCode.C,function() --Default bind
    print("Yes")
end)

b:ColorPicker("ColorPicker",Color3.fromRGB(255,0,0),function(color) --Default color
    print(color)
end)

b:Box("Box","number",function(value) -- "number" or "string"
    print(value)
end)

b:DestroyGui()


How to refresh a dropdown:
1)Create the dropdown and save it in a variable
local yourvariable = b:Dropdown("Hi",yourtable,function(a)
    print(a)
end)
2)Refresh it using the function
yourvariable:Refresh(yourtable)
How to refresh a label:
1)Create your label and save it in a variable
local yourvariable = b:Label("Pretty Useless NGL",{
    TextSize = 25; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255);
    BgColor = Color3.fromRGB(69,69,69);
})
2)Refresh it using the function
yourvariable:Refresh("Hello") It will only change the text ofc
]]