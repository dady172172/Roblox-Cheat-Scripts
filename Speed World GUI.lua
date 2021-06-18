--[[
Game : https://www.roblox.com/games/3191992205/Speed-World-BETA?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch for GUI creator, release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)


local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()

local w = library:CreateWindow("Speed World") -- Creates the window

local farm = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

local shared = {}
farm:Toggle("Bolts", function(bool)
	shared.BoltsBool = bool
end)
farm:Toggle("Drink", function(bool)
	shared.drinkBool = bool
end)


farm:Slider("Gravity",{
    min = -100; -- min value of the slider
    max = 196.2; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    game:GetService("Workspace").Gravity = value
end)
spawn(function()
	while wait() do
		if shared.BoltsBool then
			for i,v in pairs(game:GetService("Workspace").Bolts:getChildren()) do
				if v:FindFirstChild('Radius') then
					if v.Radius:FindFirstChild('TouchInterest') then
						firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Radius, 0)
						wait()
						firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Radius, 1)
					end
				end
			end
			for i,v in pairs(game:GetService("Workspace")["B_Spawner"]:getChildren()) do
				if v:FindFirstChild('Radius') then
					if v.Radius:FindFirstChild('TouchInterest') then
						firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Radius, 0)
						wait()
						firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v.Radius, 1)
					end
				end
			end
		end
		if shared.drinkBool then
			VirtualUser:ClickButton1(Vector2.new())
		end

	end
	
end)


