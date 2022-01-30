--[[
Game : https://www.roblox.com/games/4926631744/Gem-Simulator
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.orgCFrame = game:GetService("Workspace").CashIn.CFrame
kVars.closing = false
kVars.windowName = "Gem Simulator GUI" -- Window Name here
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Collect") -- Creates the folder(U will put here your buttons,etc)
local w = w:CreateFolder("Misc")

b:Toggle("Gems",function(bool)
    kVars.varCollectGems = bool
    if bool then collectGems() end
end)

function collectGems()
    spawn(function()
        while kVars.varCollectGems do
            wait()
            for _,v in pairs(game:GetService("Workspace").Gems:GetChildren()) do
                wait()
                if kVars.varCollectGems == false then return end
                firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v, 0)
                wait(.01)
                firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, v, 1)
            end
        end
    end)
end


b:Toggle("Sell",function(bool)
    kVars.varSell = bool
    if bool then autoSell() end
end)

function autoSell()
    spawn(function()
        while kVars.varSell do
            wait()
            if kVars.varSell == false then return end
            firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").CashIn, 0)
            wait(.01)
            firetouchinterest(game.Players.LocalPlayer.Character.RightFoot, game:GetService("Workspace").CashIn, 1)
        end
    end)
end

---- inf jump ----
w:Toggle("Inf Jump",function(bool)
    kVars.varInfJump = bool
end)

game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.varInfJump then
		game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
	end
end)

---- Closing ----
game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.windowName then
		kVars.closing = true
		wait(.1)
		table.clear(kVars)
		kVars.closeing:Disconnect()
		script:Destroy()
	end
end)