--[[
Game : https://www.roblox.com/games/3207803206/UPDATE-2-OM-NOM-SIMULATOR?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "OM NOM Simulator GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

---- eat ----
b:Toggle("Eat",function(bool)
    kVars.eatBool = bool
    if bool then eatFunc() end
end)
function eatFunc()
    spawn(function()
        while kVars.eatBool do
            wait()
            game:GetService("Players").LocalPlayer.Character.Food.E:FireServer()
        end
    end)
end

---- sell ----
b:Toggle("Sell",function(bool)
    kVars.sellBool = bool
    if bool then sellFunc() end
end)
function sellFunc()
    spawn(function()
        while kVars.sellBool do
            firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Sell.Sell.Sell, 0)
            wait()
            firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Sell.Sell.Sell, 1)
        end
    end)
end

---- collect coins from ground ----
b:Toggle("Coins",function(bool)
    kVars.coinsBool = bool
    if bool then coinsFunc() end
end)
function coinsFunc()
    spawn(function()
        while kVars.coinsBool do
            wait()
            for i,v in pairs(game:GetService("Workspace").Coins:GetChildren()) do
                firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v, 0)
                wait()
                firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v, 1)
            end
        end
    end)
end

---- upgrade back ----
b:Toggle("Upgrade Backpack",function(bool)
    kVars.uBackBool = bool
    if bool then uBackFunc() end
end)
function uBackFunc()
    spawn(function()
        while kVars.uBackBool do
            wait()
            game:GetService("ReplicatedStorage").Events.BuyEquipBackpack:FireServer(game:GetService("Players").keathunsar.otherstats.EquippedBackpackRef.Value + 1)
        end
    end)
end

---- upgrade weapon ----
b:Toggle("Upgrade Food",function(bool)
    kVars.uFoodBool = bool
    if bool then uFoodFunc() end
end)
function uFoodFunc()
    spawn(function()
        while kVars.uFoodBool do
            wait()
            game:GetService("ReplicatedStorage").Events.BuyEquipFood:FireServer(game:GetService("Players").keathunsar.otherstats.EquippedFoodRef.Value + 1)
        end
    end)
end

---- rebirth ----
b:Toggle("Rebirth",function(bool)
    kVars.rebirthBool = bool
    if bool then rebirthFunc() end
end)
function rebirthFunc()
    spawn(function()
        while kVars.rebirthBool do
            wait()
            game:GetService("ReplicatedStorage").Events.Rebirth:FireServer()
        end
    end)
end


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