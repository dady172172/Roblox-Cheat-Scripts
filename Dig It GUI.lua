--[[
Game : https://www.roblox.com/games/6712319386/BOARDS-Dig-It?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
local w = library:CreateWindow("Dig It GUI by Keathunsar") -- Creates the window
local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

--------------------------------------- Farm ---------------------------------------
---- Auto Mine ----
local autoMineBool = false
b:Toggle("Auto Mine",function(bool)
	autoMineBool = bool
end)


--------------------------------------- Main Loop ---------------------------------------
local autoMineCoro = coroutine.create(function()
	while wait() do
		if autoMineBool then
			game:GetService("ReplicatedStorage").Events.DamageOre:FireServer()
		end
	end
end)
coroutine.resume(autoMineCoro)

---- Rebirth Button ----
b:Button("Rebirth",function()
    game:GetService("ReplicatedStorage").Events.CommitRebirth:InvokeServer()
end)
