--[[
Game : https://www.roblox.com/games/4271116169/Shopping-Simulator?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Shopping Simulator") -- Creates the window

local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Menus")
local e = w:CreateFolder("Msc")

local upgradeFrame = game:GetService("Players").LocalPlayer.PlayerGui.UpgradeShop.Frame
local shopFrame = game:GetService("Players").keathunsar.PlayerGui.CardShop.Frame
---:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
local swipeBool = false
b:Toggle("Swipe",function(bool)
	swipeBool = bool
	if bool then swipeFunc() end
end)
function swipeFunc()
	spawn(function()
		while swipeBool do
            wait()
           game:GetService("ReplicatedStorage").Events.Swipe:FireServer()
        end
	end)
end

local coinBool = false
b:Toggle("Coin/Gold",function(bool)
	coinBool = bool
	if bool then coinFunc() end
end)
function coinFunc()
	spawn(function()
		while coinBool do
            wait()
            for i,v in pairs(game:GetService("Workspace").CoinSpawns:getChildren()) do
                if v:FindFirstChild('Coin') then
                    firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Coin.Hitbox, 0)
                end
            end
        end
	end)
end

c:Button("Upgrade",function()
    upgradeFrame.Visible = true
    upgradeFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)
c:Button("Shop",function()
    shopFrame.Visible = true
    shopFrame:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)

local frameSpamBool = false
e:Button("Delete Screen Spam", function(bool)
    frameSpamBool = bool
    local alert = ame:GetService("Players").LocalPlayer.PlayerGui.Alert.Alert
    if alert ~= nil then
        alert:Remove()
    end
    local SellEffect = game:GetService("Players").LocalPlayer.PlayerGui.SellEffect.LocalScript.ImageLabel
    if SellEffect ~= nil then
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.SellEffect:getChildren()) do
            if v.Name == 'LocalScript' then
                v.LocalScript.ImageLabel:Remove()
            end
        end
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