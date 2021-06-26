--[[
Game : https://www.roblox.com/games/3329474278/FISHING-SIMULATOR?
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.windowName = "Fishing Simulator GUI"
local mainWindow = library:CreateWindow(kVars.windowName) -- Creates the window
local sectionFarm = mainWindow:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)

---- Cast ----
sectionFarm:Toggle("Cast",function(bool)
    kVars.castBool = bool
    if bool then castFunc() end
end)
function castFunc()
    spawn(function()
        while kVars.castBool do
            wait()
            game.ReplicatedStorage.Connections.FishingCast:InvokeServer()
        end
    end)
end

---- Sell ----
sectionFarm:Toggle("Sell",function(bool)
    kVars.sellBool = bool
    if bool then sellFunc() end
end)
function sellFunc()
    spawn(function()
        while kVars.sellBool do
            game.ReplicatedStorage.Connections.FishingSellAll:InvokeServer()
        end
    end)
end

---- refill bait ----
sectionFarm:Toggle("Refill Bait",function(bool)
    kVars.refillBaitBool = bool
    if bool then refillBaitFunc() end
end)
function refillBaitFunc()
    spawn(function()
        while kVars.refillBaitBool do
            wait()
            local baitAmount = tonumber(string.match(game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.SideBait.Counter.text, "%d+"))
            if (baitAmount <= 2) then
                game.ReplicatedStorage.Connections.FishingPurchaseBait:InvokeServer()
            end
        end
    end)
end

---- walkspeed ----
kVars.walkspeedBool = true
kVars.walkspeedValue = game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed
sectionFarm:Slider("Walk Speed",{
    min = 10; -- min value of the slider
    max = 300; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    kVars.walkspeedValue = value
end)
---- Jump Hight ----
kVars.jumpHightValue = game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower
sectionFarm:Slider("Jump Hight",{
    min = 10; -- min value of the slider
    max = 300; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    kVars.jumpHightValue = value
end)

---- walk/jump loop
spawn(function()
    while kVars.walkspeedBool do
        wait()
        game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = kVars.walkspeedValue
        game:GetService('Players').LocalPlayer.Character.Humanoid.JumpPower = kVars.jumpHightValue
    end
end)

---- closing/cleanup ----
kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.windowName then
		kVars.closing = true
		wait(.1)
		table.clear(kVars)
		kVars.closeing:Disconnect()
		script:Destroy()

	end
end)