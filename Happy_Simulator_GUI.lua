--[[
Game : https://www.roblox.com/games/6849418972/UPDATE-Happy-Simulator-2?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow("Happy Simulator 2") -- Creates the window

local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local d = w:CreateFolder("Eggs")
local c = w:CreateFolder("Teleport")


local localPlayer = game.Players.LocalPlayer.Name
local TeleTable = {}
TeleTable[1] = {name = "Spawn", cf = game:GetService("Workspace").Map.Spawns.SpawnLocation.CFrame}
TeleTable[2] = {name = "Egypt", cf = CFrame.new(711, 893, -1163)}
TeleTable[3] = {name = "Atlantis", cf = CFrame.new(720, 1837, -1182)}
TeleTable[4] = {name = "Nature", cf = CFrame.new(760, 2683, -1173)}
TeleTable[5] = {name = "Ninja", cf = CFrame.new(720, 3510, -1182)}
TeleTable[6] = {name = "Candy", cf = CFrame.new(760, 4112, -1173)}
TeleTable[7] = {name = "Premium Island", cf = CFrame.new(-2419, 459, -1648)}
TeleTable[8] = {name = "VIP Island", cf = CFrame.new(-2370, 459, -964)}

local autoSwingBool = false
b:Toggle("Auto Swing", function(bool)
	autoSwingBool = bool
end)

local autoSellBool = false
b:Toggle("Auto Sell", function(bool)
	autoSellBool = bool
end)

local autoBuyToolBool = false
b:Toggle("Auto Buy Tool", function(bool)
	autoBuyToolBool = bool
end)

local autoBuyBackpackBool = false
b:Toggle("Auto Buy Backpack", function(bool)
	autoBuyBackpackBool = bool
end)

local collectCoinsBool = false
b:Toggle("Collect Coins", function(bool)
	collectCoinsBool = bool
end)

local collectGemsBool = false
b:Toggle("Collect Gems", function(bool)
	collectGemsBool = bool
end)

local clamFlagsBool = false
b:Toggle("Clam Flags", function(bool)
	clamFlagsBool = bool
end)

b:Button("Collect Chests",function()
    for i,v in pairs(game:GetService("Workspace").CollectableChests:getChildren()) do
		if v.Touch then
			wait()
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Touch, 0)
		end
	end
end)

b:Button("Unlock All Areas",function()
    for i,v in pairs(game:GetService("Players").LoaclPlayer.Zones:getChildren()) do
		v.Value = true
	end
end)

b:Button("Unlock All Gamepasses",function()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Gamepasses:getChildren()) do
		v.Value = true
	end
end)

local eggList = {"Starter Egg","Claw Egg","Emojis Egg","Premium Egg","Egypt Egg","Vip Egg","Atlantis Egg","Ninja Egg","Candy Egg","Blob Egg"}
local eggSelection = eggList[1]
d:Dropdown(eggSelection,eggList,true,function(selection)
    eggSelection = selection
end)

local eggAmmount = "Buy1"
d:Dropdown("Buy1",{"Buy1", "Buy3"},true,function(selection)
    eggAmmount = selection
end)

local openEggs = false
d:Toggle("Open Eggs",function(bool)
    openEggs = bool
end)

for i,v in pairs(TeleTable) do
	c:Button(v['name'], function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v['cf']
	end)
end

local myTool = nil
local myToolTable = {}
spawn(function()
    while wait() do
		while #myToolTable ~= 0 do rawset(myToolTable, #myToolTable, nil) end
		for i,v in pairs(game:GetService("Players").keathunsar.Swords:getChildren()) do
			myToolTable[i] = v
		end
		myTool = myToolTable[#myToolTable].Name		
    end
end)
spawn(function()
    while wait() do
		if autoSwingBool and myTool ~= nil then
			game:GetService("ReplicatedStorage").Modules.Events.Sword:FireServer(myTool)
		end
		wait()
		if autoSellBool then
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Sells["Sell-Island_3"].Touch, 0)
			wait(.2)
			firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").Sells["Sell-Island_3"].Touch, 1)
		end
		if autoBuyToolBool then
			game:GetService("ReplicatedStorage").Modules.Events.BuyItem:InvokeServer("Sword", "Sword", "BuyAll")
		end
		if autoBuyBackpackBool then
			game:GetService("ReplicatedStorage").Modules.Events.BuyItem:InvokeServer("Backpack", "Backpack", "BuyAll")
		end
	end
end)

local noClipie = false -- true = on, false = off
spawn(function()
	while wait() do
		if collectCoinsBool or collectGemsBool or clamFlagsBool and noClipie == false then
			noClipie = true
			for i,v in pairs(game.workspace:getChildren()) do
				if v.Name == "Part" then
					v.CanCollide = false
				end
			end
		elseif collectCoinsBool == false and collectGemsBool == false and clamFlagsBool == false and noClipie == true then
			noClipie = false
			for i,v in pairs(game.workspace:getChildren()) do
				if v.Name == "Part" then
					v.CanCollide = true
				end
			end
		end
		if collectGemsBool then 
			for i,v in pairs(game:GetService("Workspace").Coins.Locations:getChildren()) do
				if collectGemsBool == false then break end
				if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Gem") then
					repeat
						wait()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
					until string.match(v.Name, "Spawn") or collectGemsBool == false
				end
            end
			for i,v in pairs(game:GetService("Workspace").Coins.Spawned:getChildren()) do
				if collectGemsBool == false then break end
				if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Gem") then
					repeat
						wait()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
					until string.match(v.Name, "Spawn") or collectGemsBool == false
				end
            end	
        end
		if collectCoinsBool then
			for i,v in pairs(game:GetService("Workspace").Coins.Locations:getChildren()) do
				if collectCoinsBool == false then break end
				if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Coin") then
					repeat
						wait()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
					until string.match(v.Name, "Spawn") or collectCoinsBool == false
				end
            end
			for i,v in pairs(game:GetService("Workspace").Coins.Spawned:getChildren()) do
				if collectCoinsBool == false then break end
				if v:FindFirstChild('TouchInterest') and string.match(v.Name, "Coin") then
					repeat
						wait()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
					until string.match(v.Name, "Spawn") or collectCoinsBool == false
				end
            end
        end
    end
end)
spawn(function()
	while wait() do
		if clamFlagsBool then
			for i,v in pairs(game:GetService("Workspace").Flags:getChildren()) do
			wait()
				if clamFlagsBool == false then break end
				if v.Name == "Flag" and v:IsA('Model') and v.Config.Owner.Value ~= localPlayer then
					local nx, ny, nz, r00, r01, r02, r10, r11, r12, r20, r21, r22 = v.Zone.Touch.CFrame:components()
					repeat
						wait()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(nx+3,ny-8,nz)
					until v.Config.Owner.Value == localPlayer or clamFlagsBool == false
					wait(5)
				end
			end
		end
	end
end)

spawn(function()
    while wait() do
        if openEggs then
            game:GetService("ReplicatedStorage").Modules.Events.EggBuy:InvokeServer(eggSelection, eggAmmount)
        end
		if deletePetBool then
			for i,v in pairs(game:GetService("Players").keathunsar.Pets.OwnedPets:getChildren()) do
				for p,l in pairs(deletePetNamesList) do
					local args = {
						[1] = "Delete",
						[2] = {
							["PetId"] = v.Name,
							["PetName"] = v.PetName.Value
						}
					}
					game:GetService("ReplicatedStorage").Modules.Events.PetHandler:InvokeServer(unpack(args))
				end
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