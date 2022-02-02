--[[
Game : https://www.roblox.com/games/2845217850
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
kVars.windowName = "Hat Simulator GUI" -- Window Name here
script.Name = kVars.windowName
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

f:Toggle("Hats",function(bool)
    kVars.boolHats = bool
    if bool then fHats() end
end)

function fHats()
    spawn(function()
        while kVars.boolHats do
            wait()
            game:GetService("ReplicatedStorage").Wear:FireServer()
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
            v = game:GetService("Workspace").ScriptedParts.SellHats.Touch
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v,0)
            wait()
            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v,1)
        end
    end)
end

f:Toggle("Coins",function(bool)
    kVars.boolCoins = bool
    if bool then fCoins() end
end)

function fCoins()
    spawn(function()
        while kVars.boolCoins do
            wait()
            for i,v in pairs(game:GetService("Workspace").CoinAndGems:GetChildren()) do
                if kVars.boolCoins == false then return end
                if v:FindFirstChild("Coin") and v.Coin:FindFirstChild("TouchInterest") and v.Coin.Transparency == 0 then
                    Wait() 
                    v.Coin.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                end
            end
        end
    end)
end

f:Toggle("Gems",function(bool)
    kVars.boolGems = bool
    if bool then fGems() end
end)

function fGems()
    spawn(function()
        while kVars.boolGems do
            wait()
            for i,v in pairs(game:GetService("Workspace").CoinAndGems:GetChildren()) do
                if kVars.boolGems == false then return end
                if v.Name == "Gem" and v:FindFirstChild("TouchInterest") and v.Transparency == 0 then
                    Wait()    
                    v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                end
            end
        end
    end)
end