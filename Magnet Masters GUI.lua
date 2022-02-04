--[[
Game : https://www.roblox.com/games/6507107360
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Magnet Masters" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Collect")
local t = w:CreateFolder("Teleport")
local p = w:CreateFolder("Player") -- Creates the folder(U will put here your buttons,etc)

--- collect ---
b:Toggle("Auto Collect",function(bool)
    kVars.varCollect = bool
    if bool then fCollect() end
end)

function fCollect()
    spawn(function()
        while kVars.varCollect == true do
            wait()
            for i,v in pairs(game:GetService("Workspace").CoinModels:GetChildren()) do
                if v.Name:sub(6) ~= nil then
                    local args = {
                        [1] = "Collect",
                        [2] = v.Name:sub(6)
                    }
                    game:GetService("ReplicatedStorage").Remote:FireServer(unpack(args))
                    wait()
                end
            end
            if kVars.varCollect == false then return end
        end
    end)
end

b:Bind("Bind",Enum.KeyCode.R,function() --Default bind
    kVars.varCollect = false
    wait(.01)
    kVars.varCollect = true
end)

--- teleport ---
t:Button("Spawn",function()
    game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Spawns.SpawnLocation.CFrame
end)

t:Button("Forest",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-166, 22, -496)
end)

t:Button("Ocean",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(97, 22, -505)
end)

t:Button("Snowy World",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(357, 22, -505)
end)

t:Button("Desert",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(581, 22, -491)
end)

t:Button("The Jungle",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(849, 22, -457)
end)

t:Button("Magma World",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1141, 22, -450)
end)

t:Button("The Beach",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1332, 21, -490)
end)

t:Button("The Moon", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1606, 22, -496)
end)

t:Button("Farm Land", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1880, 22, -502)
end)

t:Button("Glacier", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2389, 22, -484)
end)

t:Button("Dark Forest", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2631, 21, -497)
end)

t:Button("Heaven", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2854, 22, -491)
end)



--- player ---
p:Slider("Run Speed",{
    min = 10; -- min value of the slider
    max = 200; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    kVars.varRunspeed = value
end)

spawn(function()
    while true do
        wait()
        if kVars.closeing == true then return end 
        if kVars.varRunspeed then
            game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = kVars.varRunspeed
        end
    end
end)

---- Closing ----
kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.windowName then
		kVars.closing = true
		wait(.1)
		table.clear(kVars)
		kVars.closeing:Disconnect()
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