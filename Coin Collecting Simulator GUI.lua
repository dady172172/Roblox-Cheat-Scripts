--[[
Game : https://www.roblox.com/games/2484088625
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
]]--
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
local player = game.Players.LocalPlayer
player.CameraMaxZoomDistance = 600
player.CameraMinZoomDistance = 10
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Coin Collecting Simulator") -- Creates the window

local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

local farmCoinsBool = false
b:Toggle("Auto Farm Coins", function(bool)
	farmCoinsBool = bool
end)

local buyMultiplierBool = false
b:Toggle("Buy Multiplier", function(bool)
	buyMultiplierBool = bool
end)

local buyRebirthBool = false
b:Toggle("Buy Rebirth", function(bool)
	buyRebirthBool = bool
end)

local ws = game:GetService("Workspace")
spawn(function()
	while wait() do
		if farmCoinsBool then
			repeat
				wait()
				local fire = ws:FindFirstChild('Coin')
				local fire2 = ws:FindFirstChild('Coin2')
				local fire3 = ws:FindFirstChild('Coin3')
				local fire4 = ws:FindFirstChild('Coin4')
				if fire then fireclickdetector(fire.ClickDetector) end
				if fire2 then fireclickdetector(fire2.ClickDetector) end
				if fire3 then fireclickdetector(fire3.ClickDetector) end
				if fire4 then fireclickdetector(fire4.ClickDetector) end			
			until farmCoinsBool == false
			
		end
	end	
end)

spawn(function()
	while wait() do
		if buyMultiplierBool then
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Multiplier Button"].Head, 0)
			wait(.2)
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Multiplier Button"].Head, 1)
		end
		if buyRebirthBool then
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Rebirth  Button"].Head, 0)
			wait(.2)
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace")["Rebirth  Button"].Head, 1)
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