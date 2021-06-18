--[[
Game : https://www.roblox.com/games/6512923934/x100000-Clicks-Ultra-Clickers-4?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Ultra Clickers 4") 

local farm = w:CreateFolder("Farm")
local eggs = w:CreateFolder("Eggs")
local tele = w:CreateFolder("Teleport")

local shared = {}
farm:Toggle("Click", function(bool)
	shared.clickBool = bool
end)

farm:Button("Rebirth Buttons", function()
	for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.MainFrame.RebithsShop.ScrollingFrame:getChildren()) do
		game:GetService("Players").LocalPlayer.PlayerGui.Main.MainFrame.RebithsShop.ScrollingFrame[tostring(i)].Visible = true
	end
end)

spawn(function()
	while wait() do
		if shared.clickBool then
			workspace.Events.AddClick:FireServer()
		end
	end

end)

local eggTable = {}
local teleTable = {}
local teleNames = {}
for i,v in pairs(game:GetService("Workspace").Eggs:getChildren()) do
	table.insert(eggTable, tostring(v))
	if i == 1 then
		table.insert(teleTable,{name = "1Spawn1", cf = game:GetService("Workspace").SpawnLocation.CFrame})
		table.insert(teleNames, "1Spawn1")
	end
	table.insert(teleTable,{name = tostring(v), cf = v.UIanchor.CFrame})
	table.insert(teleNames, tostring(v))
end
table.sort(eggTable)
table.sort(teleNames)

shared.selectedTele = teleTable[1]['name']
tele:Dropdown(teleTable[1]['name'], teleNames, true, function(value)
	shared.selectedTele = value
end)
tele:Button("Teleport",function()
	for i,v in pairs(teleTable) do
		if v['name'] == shared.selectedTele then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v['cf']
			break
		end
	end
end)


shared.eggSelected = eggTable[1]
eggs:Dropdown(eggTable[1], eggTable, true, function(value)
	shared.eggSelected = value
end)

eggs:Toggle("Open", function(bool)
	shared.openEggBool = bool
end)


spawn(function()
	while wait() do
		if shared.openEggBool then
			game:GetService("ReplicatedStorage").RemoteEvents.EggOpened:InvokeServer(shared.eggSelected,"Single")
			wait(4)
		end
	end
end) 
