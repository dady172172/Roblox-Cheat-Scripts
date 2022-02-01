--[[
Game : https://www.roblox.com/games/1509515037
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Metal Detecting Simulator GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

--- anti afk ---
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

--- Dig ---
f:Toggle("Dig",function(bool)
    kVars.boolDig = bool
    if bool then fDig() end
end)
function fDig()
    spawn(function()
        while kVars.boolDig do
            wait()
            game.Workspace.__REMOTES.Dig:FireServer("Stop", "AntiMatter",math.huge)
        end
    end)
end

--- Sell ---
f:Toggle("Sell",function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)
function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
            game.Workspace.__REMOTES.Sell:FireServer()
        end
    end)
end

--- rebirth ---
f:Toggle("Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)
function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            if game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats") and game:GetService("Players").LocalPlayer.leaderstats:FindFirstChild("Level") then
                local level = game:GetService("Players").keathunsar.leaderstats.Level.Value
                if (level >= 125) then
                    game.Workspace.__REMOTES.Rebirth:InvokeServer()
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