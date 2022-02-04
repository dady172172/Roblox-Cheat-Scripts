--[[
Game : https://www.roblox.com/games/1097288251
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Snow Resort" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Collect") -- Creates the folder(U will put here your buttons,etc)

b:Toggle("collect Crystals/Snow Flakes",function(bool)
    kVars.varCollect = bool
    if bool then 
        kCollect() 
    end
end)

function kCollect()
    spawn(function()
        while kVars.varCollect == true do
            wait()
            if kVars.varCollect == false then return end
            for i,v in pairs(game:GetService("Workspace").ActiveSnowflakes:GetChildren()) do
                for g,h in pairs(v:GetChildren()) do
                    if h.Name == "Part" then
                        firetouchinterest(game:GetService('Players').LocalPlayer.Character.RightFoot, h, 0)
                        wait()
                        firetouchinterest(game:GetService('Players').LocalPlayer.Character.RightFoot, h, 1)
                    end
                end
            end
            for i,v in pairs(game:GetService("Workspace").ActiveCrystals:GetChildren()) do
                for g,h in pairs(v:GetChildren()) do
                    if h.Name == "Part" then
                        firetouchinterest(game:GetService('Players').LocalPlayer.Character.RightFoot, h, 0)
                        wait()
                        firetouchinterest(game:GetService('Players').LocalPlayer.Character.RightFoot, h, 1)
                    end
                end
                
            end
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