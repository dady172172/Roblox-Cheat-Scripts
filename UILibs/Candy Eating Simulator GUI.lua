--[[
Game : https://www.roblox.com/games/7277614831
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--

--- Anti AFK ---
local VirtualUser = game:service('VirtualUser')
game:service('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Candy Eating Simulator GUI" -- Window Name here
script.Name = kVars.windowName
kVars.network = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Network"))
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

f:Toggle("Collect Candy",function(bool)
    kVars.boolCollectCandy = bool
    if bool then fCollectCandy() end
end)

function fCollectCandy()
    spawn(function()
        while kVars.boolCollectCandy do
            wait()
            if game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool") then
                kVars.network:FireServer("Candy", game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool").Name)
            end
        end
    end)
end

f:Toggle("Sell",function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)

function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
            firetouchinterest(game.Players.LocalPlayer.Character.LeftFoot,game:GetService("Workspace").Activations.SpawnSell.Touch,0)
            firetouchinterest(game.Players.LocalPlayer.Character.LeftFoot,game:GetService("Workspace").Activations.SpawnSell.Touch,1)
        end
    end)
end