--[[
Game : https://www.roblox.com/games/6048603509
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.Character = game:GetService("Players").LocalPlayer.Character
kVars.hrp = kVars.Character.HumanoidRootPart
kVars.windowName = "Blademaster GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Character")

f:Toggle("Swing",function(bool)
    kVars.boolSwing = bool
    if bool then fSwing() end
end)
function fSwing()
    spawn(function()
        while kVars.boolSwing do
            wait()
            if kVars.Character:FindFirstChildOfClass("Tool") ~= nil then
                local currentTool = kVars.Character:FindFirstChildOfClass("Tool").Name
                game:GetService("ReplicatedStorage").Remotes.WeaponSwing:FireServer(kVars.Character:FindFirstChild(currentTool))
            end
        end
    end)
end

f:Toggle("Hit",function(bool)
    kVars.boolHit = bool
    if bool then fHit() end
end)
kVars.varNearestEnemy = nil
kVars.varLastEnemy = math.huge
spawn(function()
    while wait() do
        for i,v in pairs(game:GetService("Workspace").EnemiesFolder:GetChildren()) do
            local enemyRootPart = v.HumanoidRootPart
            local enemyHealth = v.Humanoid.Health 
            if enemyRootPart == nil or enemyHealth == nil then return end
            local distance = (kVars.hrp.Position - enemyRootPart.Position).magnitude
            if distance == nil or kVars.last == nil then return end
            if distance < kVars.varLastEnemy then
                kVars.varLastEnemy = distance
				kVars.varNearestEnemy = v.Humanoid
            end
        end
    end
end)

function fHit()
    spawn(function()
        while kVars.boolHit do
            wait()
            if kVars.varNearestEnemy ~= nil and kVars.varNearestEnemy.Health > 0 and kVars.Character:FindFirstChildOfClass("Tool") then
                local tool = kVars.Character:FindFirstChildOfClass("Tool").Name
                game:GetService("ReplicatedStorage").Remotes.WeaponHit:FireServer(kVars.Character:FindFirstChild(tool), kVars.varNearestEnemy)
            end
        end
    end)
end

c:Toggle("Inf Jump",function(bool)
    kVars.boolInfJump = bool
end)
kVars.InfJumpRequest = game:GetService("UserInputService").JumpRequest:connect(function()
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
        kVars.InfJumpRequest:Disconnect()
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