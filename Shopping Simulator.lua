--[[
Game : https://www.roblox.com/games/4271116169
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Shopping Simulator") -- Creates the window
kVars = {}
local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Menus")
local e = w:CreateFolder("Msc")

local upgradeFrame = game:GetService("Players").LocalPlayer.PlayerGui.UpgradeShop.Frame
local shopFrame = game:GetService("Players").LocalPlayer.PlayerGui.CardShop.Frame
---:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)

b:Toggle("Swipe",function(bool)
	kVars.boolSwipe = bool
	if bool then fSwipe() end
end)
function fSwipe()
	spawn(function()
		while kVars.boolSwipe do
            wait()
           game:GetService("ReplicatedStorage").Events.Swipe:FireServer()
        end
	end)
end

b:Toggle("Sell",function(bool)
	kVars.boolSell = bool
	if bool then fSell() end
end)
function fSell()
	spawn(function()
		while kVars.boolSell do
            wait()
            for i,v in pairs(game:GetService("Workspace").MainBuildings.Bank.Pad:GetChildren()) do
                if v.Name == "Sell" and v:FindFirstChild("TouchInterest") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v,0)
                    wait()
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v,1)
                end
            end
        end
	end)
end


b:Toggle("Coin/Gold",function(bool)
	kVars.boolCoins = bool
	if bool then fCoins() end
end)
function fCoins()
	spawn(function()
		while kVars.boolCoins do
            wait() --game:GetService("Workspace").CoinSpawns.Part.Coin.Hitbox
            for i,v in pairs(game:GetService("Workspace").CoinSpawns:getChildren()) do
                if v:FindFirstChild('Coin') and v.Coin:FindFirstChild("Hitbox") then
                    firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Coin.Hitbox, 0)
                end
            end
        end
	end) 
end

b:Toggle("Safe Crack",function(bool)
	kVars.boolSafeCrack = bool
	if bool then fSafeCrack() end
end)
function fSafeCrack()
	spawn(function()
		while kVars.boolSafeCrack do
            wait() 
            local hint = game:GetService("Workspace").MapItems.CrackTheCodeSafe.HINT.SurfaceGui.Prize.Text
            local fn = string.sub(hint, 1, 1)
            local sn = string.sub(hint, 8, 8)

            if fn == "4" and sn == "1" then
                num = "4321"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(num)
                snum = "4231"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(snum)
            elseif fn == "4" and sn == "2" then
                num = "4132"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(num)
            elseif fn == "3" and sn == "2" then
                num = "3412"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(num)
                snum = "3142"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(snum)
            elseif fn == "3" and sn == "4" then
                num = "3214"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(num)
            elseif fn == "2" and sn == "4" then
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(num)
            elseif fn == "1" and sn == "3" then
                num = "1423"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(num)
                snum = "1243"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(snum)
            elseif fn == "1" and sn == "4" then
                num = "1234"
                game:GetService("ReplicatedStorage").Events.CrackCode:FireServer(num)
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

e:Slider("Walk Speed",{
    min = 16; -- min value of the slider
    max = 200; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

e:Toggle("Inf Jump",function(bool)
	kVars.boolInfJump = bool
end)

game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump then
		game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)

e:Button("Delete Screen Spam", function(bool)
    if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("SellEffect") then
        game:GetService("Players").LocalPlayer.PlayerGui.SellEffect:Destroy()
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