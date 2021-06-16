--[[
Game : https://www.roblox.com/games/4934958405/SALE-Fruit-Collecting-Simulator
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Fruit Collecting Simulator") -- Creates the window

local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local localPlayer = game:GetService("Players").LocalPlayer

local farmFoodBool = false
b:Toggle("Food", function(bool)
	farmFoodBool = bool
end)

local sellBackpack = false
b:Toggle("Sell", function(bool)
	sellBackpack = bool
end)

local buyNextBackpackBool = false
b:Toggle("Buy Next Backpack", function(bool)
	buyNextBackpackBool = bool
end)



local unlockNextAreaBool = false
b:Toggle("Unlock Next Area", function(bool)
	unlockNextAreaBool = bool
end)

local rebirthBool = false
b:Toggle("Rebirth", function(bool)
	rebirthBool = bool
end)


local foodToCollect = "Apple"

spawn(function()
	while wait() do
		local toolsList = game:GetService("Players").LocalPlayer.Tools:getChildren()
		local toolName = toolsList[#toolsList]
		if farmFoodBool then
			game:GetService("ReplicatedStorage").Events.Collect:FireServer(foodToCollect, toolName)
		end
		if sellBackpack then
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").MapFolder.TouchParts.SellPart, 0)
			wait(.1)
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").MapFolder.TouchParts.SellPart, 1)
		end		
		if rebirthBool then
			game:GetService("ReplicatedStorage").Events.Rebirth:FireServer("Rebirth", game:GetService("Players").LocalPlayer)
		end
	end
end)

spawn(function()
	while wait() do
		if farmFoodBool then
			if localPlayer.Areas:FindFirstChild("Toy Paradise") then
				foodToCollect = "Cherry"
			elseif localPlayer.Areas:FindFirstChild("Food Heaven") then
				foodToCollect = "Lime"
			elseif localPlayer.Areas:FindFirstChild("Moon") then
				foodToCollect = "Orange"
			elseif localPlayer.Areas:FindFirstChild("Volcano") then
				foodToCollect = "Pineapple"
			elseif localPlayer.Areas:FindFirstChild("Candyland") then
				foodToCollect = "Pear"
			elseif localPlayer.Areas:FindFirstChild("Beach") then
				foodToCollect = "Watermelon"
			elseif localPlayer.Areas:FindFirstChild("Desert") then
				foodToCollect = "Banana"
			elseif localPlayer.Areas:FindFirstChild("Winter") then
				foodToCollect = "StrawBerry"
			else
				foodToCollect = "Apple"
			end
			
		end
	end


end)

--- unlock next area
local unlockNextArea = {"Winter", "Desert", "Beach", "Candyland", "Volcano", "Moon", "Food Heaven", "Toy Paradise"}
spawn(function()
	while wait() do
		if unlockNextAreaBool and game.Players.LocalPlayer.Areas then
			for i,v in pairs(unlockNextArea) do
				wait(1)
				game:GetService("ReplicatedStorage").Events.Server:InvokeServer("UnlockArea", v)
			end
			
		end
	end
end)


---- buy next backpack
local backpackTable = {"Starter Backpack","Shoulder Backpack","Drawstring Backpack","Balloon Backpack","Phoenix Backpack","Unicorn Backpack","Dragon Hatchling Backpack","Playful Puppy Backpack","Robot Backpack","Red 8-Bit Backpack","Green 8-Bit Backpack","Black 8-Bit Backpack","Glowing Neon Backpack","Cookie Jar Backpack","Milk Carton Backpack","Upcycled Backpack","Beach Bucket Backpack","LifeGuard Backpack","Chocolate Backpack","Lollipop Backpack","Lava Drawstring Backpack","Lava 8-Bit Backpack","UFO Backpack","Spaceship Backpack","Red Sailor Duffel Bag","Medic Bag","Ninja Backpack","Ninja Shuriken","Apple Juice Box","XXL Fries To-Go","Jar O' Stars","Boombox"}
spawn(function()
	local nextBackpackToBuy = "Shoulder Backpack"
	while wait() do
		if buyNextBackpackBool then
			local curentBackpack = game:GetService("Players").LocalPlayer.CurrentBackpackEquipped.Value
			for i,v in pairs(backpackTable) do
				if v == curentBackpack  and i ~= #backpackTable then
					nextBackpackToBuy = backpackTable[i+1]
				end
			end
			game:GetService("ReplicatedStorage").Events.Server:InvokeServer("PurchaseBackpack", nextBackpackToBuy)
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