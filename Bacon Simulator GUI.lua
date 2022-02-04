--[[
Game : https://www.roblox.com/games/6090639744
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Bacon Simulator GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Collect") -- Creates the folder(U will put here your buttons,etc)
local t = w:CreateFolder("Teleport")
local z = w:CreateFolder("Extra")
b:Toggle("Auto Eat", function(bool)
    kVars.varAutoEat = bool
    if bool then autoEat() end
end)

function autoEat()
    spawn(function()
        while kVars.varAutoEat do
            wait()
            game:GetService("ReplicatedStorage").Events.EatEvent:FireServer()
        end
    end)
end

b:Toggle("Sell", function(bool)
    kVars.varSell = bool
    if bool then autoSell() end
end)

function autoSell()
    spawn(function()
        while kVars.varSell do
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").Triggers.JungleSell.Trigger,0)
            wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,game:GetService("Workspace").Triggers.JungleSell.Trigger,1)
        end
    end)
end

b:Toggle("Hoops",function(bool)
    kVars.varHoops = bool
    if bool then collectHoops() end
end)

function collectHoops()
    spawn(function()
        while kVars.varHoops do
            wait()
            for a,b in pairs(game:GetService("Workspace").Islands.Hops:GetChildren()) do --spawnpart
                for c,d in pairs(b:GetChildren()) do -- gemhop
                    for e,f in pairs(d:GetChildren()) do --mainpart
                        
                        if f.Name == "MainPart" then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,f,0)
                            wait()
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,f,1)
                        end
                    end
                end
            end
        end
    end)

end

b:Toggle("Gems",function(bool)
    kVars.varGems = bool
    if bool then collectGems() end
end)

function collectGems()
    spawn(function()
        while kVars.varGems do
            wait()
            for a,b in pairs(game:GetService("Workspace").GemsHolder:GetChildren()) do
                
                for c,d in pairs(b:GetChildren()) do
                    
                    for e,f in pairs(d:GetChildren()) do
                        
                        if f.Name == "Gem" then
                            wait(.1)
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = f.CFrame
                           --[[
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, f, 0)
                                wait(.01)
                                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, f, 1)
                                if kVars.varGems == false then return end
                            ]]--

                            if kVars.varGems == false then return end
                        end
                        if kVars.varGems == false then return end
                    end
                    if kVars.varGems == false then return end
                end
                if kVars.varGems == false then return end
            end
            if kVars.varGems == false then return end
        end
    end)
end

b:Button("Unlock all islands",function()
    local a = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    for i,v in pairs(game:GetService("Workspace").Islands.Triggers:GetChildren()) do
        wait()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(98, 24472, 51)
    wait(.3)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a
end)


--- teleport ---
t:Button("Spawn",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(95, -4, 199)
end)

t:Button("Home",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-182, -1, 108)
end)

t:Button("Grassland",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10, 602, -11)
end)

t:Button("Desert",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10, 1390, -11)
end)

t:Button("Tundra",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-30, 2398, -23)
end)

t:Button("Atlantis",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6, 3422, -33)
end)

t:Button("Lava",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-35, 4833, -53)
end)

t:Button("Candyland",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(8, 6738, 15)
end)

t:Button("Cyber",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16, 9223, 29)
end)

t:Button("Alien",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-16, 11909, 29)
end)

t:Button("Pizza",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11, 13445, 30)
end)

t:Button("Cookie",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(11, 15945, 36)
end)

t:Button("Diamond",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(11, 18876, 36)
end)

t:Button("Youtube",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(13, 21228, 35)
end)

t:Button("Jungle",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(13, 24486, 35)
end)

z:Slider("Speed",{
    min = 10; -- min value of the slider
    max = 2000; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    kVars.varSpeed = value
end)

spawn(function()
    while true do
        wait()
        if kVars.Closing then return end
        if kVars.varSpeed ~= nil then
            game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = kVars.varSpeed
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