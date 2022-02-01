--[[
Game : https://www.roblox.com/games/4972091010
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.closing = false
kVars.varAimbot = true
kVars.varAiming = false
_G.closestZombie = nil
kVars.windowName = "Zombie Uprising GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("AimBot") -- Creates the folder(U will put here your buttons,etc)

b:Toggle("Toggle",function(bool)
    kVars.varAimbot = bool
    if bool then fAimbot() end
end)
function fAimbot()
    spawn(function()
        while kVars.varAimbot do
            wait()
            if kVars.closing then return end
            local closestDistance = math.huge
            for i,v in pairs(game:GetService("Workspace").Zombies:GetChildren()) do
                local castPoints = {game:GetService("Workspace").CurrentCamera.CFrame.Position, v.Head.CFrame.Position}
                local ignoreList = {}
                local obscured = workspace.CurrentCamera:GetPartsObscuringTarget(castPoints, ignoreList)
                if type(next(obscured)) == "nil" then
                    if v:FindFirstChild("Head") and  v.Humanoid.Health ~= 0 then   
                        local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Head.Position).magnitude
                            if distance < closestDistance then
                                closestDistance = distance
                                _G.closestZombie = v
                            end   
                    end
                end 
            end
        end
    end)
end

kVars.UIS =  game:GetService("UserInputService").InputBegan:Connect(function(input)
    if game:GetService("Workspace").Ignore:FindFirstChild("Map") then 
        for i,v in pairs(game:GetService("Workspace").Ignore.Map:GetChildren()) do
            v:Destroy()
        end
        game:GetService("Workspace").Ignore.Map:Destroy()
    end
    if game:GetService("Workspace").Map:FindFirstChild("Boundaries") then
        for i,v in pairs(game:GetService("Workspace").Map.Boundaries:GetChildren()) do
            v:Destroy()
        end
    end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.LeftShift and kVars.varShiftRun then 
            game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = 30 
        end
        if input.KeyCode == Enum.KeyCode.LeftControl then    
            if kVars.varAimbot then
                game.Players.LocalPlayer.CameraMode = "LockFirstPerson"
                kVars.varAiming = true
                local closest = nil
                while wait() do
                    game:GetService("Workspace").CurrentCamera.CameraType = "Custom"
                    if _G.closestZombie ~= nil and _G.closestZombie:FindFirstChild("Head") then
                        game:GetService("Workspace").CurrentCamera.CFrame = CFrame.lookAt(game:GetService("Workspace").CurrentCamera.CFrame.Position, _G.closestZombie.Head.CFrame.Position)
                    end   
                    if kVars.varAiming == false then return end
                end
            end
        end
    end
end)

kVars.UISEnd = game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.LeftShift then 
            game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = 16 
        end
        if input.KeyCode == Enum.KeyCode.LeftControl then
            kVars.varAiming = false
        end
    end
end)

b:Toggle("Power up vacuum",function(bool)
    kVars.varPowerUpVacuum = bool
end)

kVars.PowerUpsVacuum = game:GetService("Workspace").PowerUps.ChildAdded:Connect(function()
    if kVars.varPowerUpVacuum then
        for i,v in pairs(game:GetService("Workspace").PowerUps:GetChildren()) do
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
            wait(.01)
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
        end
    end
end)

b:Toggle("Shift = Run",function(bool)
    kVars.varShiftRun = bool
end)


---- Closing ----
kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.windowName then
		kVars.closing = true
		wait(.1)
		table.clear(kVars)
        kVars.UIS:Disconnect()
        KVars.UISEnd:Disconnect()
        kVars.PowerUpsVacuum:Disconnect()
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