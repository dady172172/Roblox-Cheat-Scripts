--[[
Game : https://www.roblox.com/games/5535087806
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
kVars.windowName = "Tapping Mania GUI" -- Window Name here
script.Name = kVars.windowName
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
kVars.varRebirthSelected = 1
kVars.varRebirthList = {}
for i=1,50 do
    table.insert(kVars.varRebirthList,i)
end

f:Toggle("Tap",function(bool)
    kVars.boolTap = bool
    if bool then fTap() end
end)

function fTap()
    spawn(function()
        while kVars.boolTap do
            wait()
            game:GetService("ReplicatedStorage").RemoteEvents.Click:FireServer()
        end
    end)
end

f:Dropdown("Dropdown",kVars.varRebirthList,true,function(num)
    kVars.varRebirthSelected = num
end)

f:Toggle("Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)

function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            game:GetService("ReplicatedStorage").RemoteEvents.Rebirth:FireServer(tonumber(kVars.varRebirthSelected))

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
            for a,z in pairs(game:GetService("Workspace").GemsYes:GetChildren()) do
                for s,x in pairs(z:GetChildren()) do
                    if x.Name == "Gems" then
                        for d,c in pairs(x:GetChildren()) do
                            if c.Name == "Gem" and c.Transparency == 0 then
                                c.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                            end
                        end
                    end
                end
            end
        end
    end)
end


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