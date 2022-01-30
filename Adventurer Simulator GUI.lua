--[[
Game : https://www.roblox.com/games/5932564241
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Adventurer Simulator GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local b = w:CreateFolder("Buy")
local c = w:CreateFolder("Character")

f:Toggle("Attack",function(bool)
    kVars.attackBool = bool
    if bool then fAttack() end
end)

function fAttack()
    spawn(function()
        while kVars.attackBool do
            wait()
            game:GetService("ReplicatedStorage").Remotes.Events.Weapon:FireServer({["Action"] = "Attack"})
        end
    end)
end

f:Toggle("Sell",function(bool)
    kVars.sellBool = bool
    if bool then fSell() end
end)

function fSell()
    spawn(function()
        while kVars.sellBool do
            wait()
            game.ReplicatedStorage.Remotes.Events.Shop:FireServer({["Action"] = "Sell",["Request"] = "Sell"})
        end
    end)
end

f:Toggle("Collect Coins/Gems",function(bool)
    kVars.collectBool = bool
    if bool then fCollect() end
end)

function fCollect()
    spawn(function()
        while kVars.collectBool do
            wait()
            for j,h in pairs(game:GetService("Workspace").Client.Worlds:GetChildren()) do
                if h:FindFirstChild("Collectables") then
                    for i,v in pairs(h.Collectables.Projectiles:GetChildren()) do
                        if v:FindFirstChild("Core") and v.Core:FindFirstChild("TouchInterest") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Core, 0)
                            wait(.01)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Core, 1)
                        elseif v:FindFirstChild("Part") and v.Part:FindFirstChild("TouchInterest") then
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Part, 0)
                            wait(.01)
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Part, 1)
                        end
                    end
                end
            end
        end
    end)
end

f:Toggle("Boss",function(bool)
    kVars.bossBool = bool
    if bool then
        game:GetService("Workspace").Gravity = 0
        fBoss()
    else
        game:GetService("Workspace").Gravity = 196.2
    end
end)


kVars.tableBossNames = {}
kVars.varWorld = nil
for i,v in pairs(game:GetService("ReplicatedStorage").Bosses:GetChildren()) do
    table.insert(kVars.tableBossNames, v.Name)
end
function fBoss()
    spawn(function()
        kVars.Boss = nil
        if kVars.attackBool == false then
            print("Must have Attack on!!")
            return
        end
        for i,v in pairs(game:GetService("Workspace").Client.Worlds:GetChildren()) do
            kVars.varWorld = v.Name
        end
        if game:GetService("Workspace").Client.Worlds:FindFirstChild(kVars.varWorld) then
            local bossFolder = game:GetService("Workspace").Client.Worlds[kVars.varWorld].Boss
            for i,v in pairs(bossFolder:GetChildren()) do
                if table.find(kVars.tableBossNames, v.Name) then
                    kVars.Boss = v.Head
                end
            end
        end
        game:GetService("Workspace").Gravity = 0
        while kVars.bossBool do
            wait()
            if kVars.Boss ~= nil then
                cfBoss2 = CFrame.new(kVars.Boss.CFrame.x,kVars.Boss.CFrame.y + 1,kVars.Boss.CFrame.z)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cfBoss2
            else
                wait()
            end
        end
    end)
end

b:Toggle("Weapon",function(bool)
    kVars.buyWeaponBool = bool
    if bool then fBuyWeapon() end
end)

function fBuyWeapon()
    spawn(function()
        while kVars.buyWeaponBool do
            wait()
            game.ReplicatedStorage.Remotes.Events.Shop:FireServer({["Action"] = "Buy All",["Category"] = "Weapons"})
        end
    end)
end

b:Toggle("Genetics",function(bool)
    kVars.buyGeneticsBool = bool
    if bool then fBuyGenetics() end
end)

function fBuyGenetics()
    spawn(function()
        while kVars.buyGeneticsBool do
            wait()
            game.ReplicatedStorage.Remotes.Events.Shop:FireServer({["Action"] = "Buy All",["Category"] = "Genetics"})
        end
    end)
end

c:Toggle("Inf Jump",function(bool)
    kVars.infJumpBool = bool
end)

kVars.infJumpService = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.infJumpBool then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)

---- Closing ----
kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.windowName then
		kVars.closing = true
		wait(.1)
		table.clear(kVars)
        kVars.infJumpService:Disconnect()
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