--[[
Game : https://www.roblox.com/games/5943856429
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--

--- Anti AFK ---
local VirtualUser = game:service('VirtualUser')
game:service('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)


local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Knight Heroes GUI" -- Window Name here
kVars.RebirthNum = 1
script.Name = kVars.windowName
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local b = w:CreateFolder("Buy")
local c = w:CreateFolder("Character")

for i,v in pairs(game:GetService("ReplicatedStorage").Modules.ServiceLoader.NetworkService.Events.Objects:GetChildren()) do
    if i == 5 then
        kVars.SwingSwordObfiscation = v
    elseif i == 8 then
        kVars.RebirthObfiscation = v
    end
end
f:Toggle("Swing",function(bool)
    kVars.boolSwing = bool
    if bool then fSwing() end
end)

function fSwing()
    spawn(function()
        while kVars.boolSwing do
            wait()
            kVars.SwingSwordObfiscation:FireServer("SwingSword", "Home")
        end
    end)
end

f:Toggle("Sell",function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)

function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
            kVars.SwingSwordObfiscation:FireServer("SellPower", "Home")
        end
    end)
end

f:Box("Rebirth Number In Window","number",function(value) -- "number" or "string"
    kVars.RebirthNum = value
end)

f:Toggle("Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            kVars.RebirthObfiscation:FireServer("BuyRebirth", tonumber(kVars.RebirthNum))
        end
    end)
end

b:Toggle("Swords",function(bool)
    kVars.boolSwords = bool
    if bool then fSwords() end
end)

function fSwords()
    spawn(function()
        while kVars.boolSwords do
            wait()
            kVars.SwingSwordObfiscation:FireServer("BuyAllSwords", "Home")
        end
    end)
end

c:Toggle("Inf Jump",function(bool)
    kVars.boolInfJump = bool
end)

game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
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