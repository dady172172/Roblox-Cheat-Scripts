--[[
Game : https://www.roblox.com/games/6284583030
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Pet Simulator X GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Collect") -- Creates the folder(U will put here your buttons,etc)
local t = w:CreateFolder("Teleport")
local z = w:CreateFolder("Extra")

b:Toggle("Orbs",function(bool)
    kVars.varOrbs = bool
    if bool then collectOrbs() end
end)

function collectOrbs()
    spawn(function()
        while kVars.varOrbs do
            wait()
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Orbs:GetChildren()) do
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                if kVars.varOrbs == false then return end
            end
        end
    end)
end

b:Toggle("Loot Bags",function(bool)
    kVars.varLootBags = bool
    if bool then collectLootBags() end
end)

function collectLootBags()
    spawn(function()
        while kVars.varLootBags do
            wait()
            for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end)
end

t:Button("Spawn",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(265, 105, 239)
end)



z:Slider("Speed",{
    min = 10; -- min value of the slider
    max = 200; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    kVars.varSpeed = value
end)

z:Slider("Jump",{
    min = 10; -- min value of the slider
    max = 200; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    kVars.varJump = value
end)

spawn(function()
    while true do
        wait()
        if kVars.Closing then return end
        if kVars.varSpeed ~= nil then
            game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = kVars.varSpeed
        end
        if kVars.varJump ~= nil then
            game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = kVars.varJump
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