--[[
Game : https://www.roblox.com/games/2726456994
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Click To Grow GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

b:Toggle("Points",function(bool)
    kVars.boolPoints = bool
    if bool then fPoints() end
end)

function fPoints()
    spawn(function()
        while kVars.boolPoints do
            wait()
            workspace.Events.AddPoints:FireServer()
        end
    end)
end

b:Toggle("Prestige",function(bool)
    kVars.boolPrestige = bool
    if bool then
        fPrestige() end
end)

function fPrestige()
    spawn(function()
        while kVars.boolPrestige do
            wait()
            workspace.Events.Prestige:FireServer()
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