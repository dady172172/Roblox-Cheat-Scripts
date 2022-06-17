--[[
Game : https://www.roblox.com/games/2610716991
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : https://v3rmillion.net/member.php?action=profile&uid=507120
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1040650
]]--
if game:GetService("CoreGui"):FindFirstChild("Lollipop Simulator GUI") then
    wait(1)
end

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3'))()
kVars = {}
kVars.closing = false
kVars.windowName = "Lollipop Simulator GUI" -- Window Name here
kVars.RS = game:GetService("ReplicatedStorage")

local w = library:CreateWindow(kVars.windowName) -- Creates the window
local f = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local b = w:CreateFolder("Buy")
local menus = w:CreateFolder("Menus")
local m = w:CreateFolder("Misc")

--- anti afk ---
local VirtualUser = game:GetService('VirtualUser')
kVars.AntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

--- quick sell ---
f:Button("Sell",function()
    local plr = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local oldCFrame = plr.CFrame
    plr.CFrame = CFrame.new(-174, 26, 150)
    wait(.6)
    plr.CFrame = oldCFrame
end)

--- lick ---
f:Toggle("Lick",function(bool)
    kVars.boolLick = bool
    if bool then fLick() end
end)
function fLick()
    spawn(function()
        while kVars.boolLick do
            wait()
            if kVars.closing then return end
            if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Lollipop") then
                kVars.RS.Lick:InvokeServer(game:GetService("Players").LocalPlayer.Character.Lollipop)
            end
        end
    end)
end

--- collect rewards ---
f:Toggle("Rewards",function(bool)
    kVars.boolRewards = bool
    if bool then fRewards() end
end)
function fRewards()
    spawn(function()
        while kVars.boolRewards do
            if kVars.closing then return end
            wait(3)
            kVars.RS.Events:FindFirstChild(""):FireServer("Lick")
            kVars.RS.Events:FindFirstChild(""):FireServer("Coin")
            kVars.RS.Events:FindFirstChild(""):FireServer("Chest")
        end
    end)
end

--- Coins/Gems ---
f:Toggle("Coins/Gems",function(bool)
    kVars.boolCoins = bool
    if bool then fCoins() end
end)
kVars.varCoinFolder = nil
for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
    if string.find(v.Name,"Coins") then
        kVars.varCoinFolder = v
    end
end
function fCoins()
    spawn(function()
        while kVars.boolCoins do
            wait()
            if kVars.closing then break end 
            for i,v in pairs(kVars.varCoinFolder:GetChildren()) do
                kVars.varAreaOfPlr = game:GetService("Players").LocalPlayer.Data.Temp.Area.Value 
                if kVars.varAreaOfPlr == v.Area.Value and v.Transparency == 0 then
                    local origCframe = v.CFrame
                    v.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
                    if kVars.closing then break end
                    wait(3) --- you need this wait or else you get kicked for collecting to fast
                    v.CFrame = origCframe
                    if kVars.boolCoins == false then break end
                end
            end
        end
    end)
end

--- Rebirth ---
f:Toggle("Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)
function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            wait()
            kVars.RS.Events:FindFirstChild(""):InvokeServer(3)
        end
    end)
end

--- buy next lollipop
b:Toggle("Lollipop",function(bool)
    kVars.boolBuyLollipop = bool
    if bool then fBuyLollipop() end
end)
function fBuyLollipop()
    spawn(function()
        while kVars.boolBuyLollipop do
            wait()
            if kVars.closing then return end
            kVars.RS.Events[""]:InvokeServer(1)
        end
    end)
end

--- buy next max size ---
b:Toggle("Max Size",function(bool)
    kVars.boolBuyMaxSize = bool
    if bool then fBuyMaxSize() end
end)
function fBuyMaxSize()
    spawn(function()
        while kVars.boolBuyMaxSize do
            wait()
            if kVars.closing then return end
            kVars.RS.Events[""]:InvokeServer(2)
        end
    end)
end

--- Inventory ---
menus:Button("Inventory",function()
    game:GetService("Players").LocalPlayer.PlayerGui.Hud.Inventory:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)

--- Rewards ---
menus:Button("Rewards",function()
    game:GetService("Players").LocalPlayer.PlayerGui.Hud.Awards:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)

--- Rebirth ---
menus:Button("Rebirth",function()
    game:GetService("Players").LocalPlayer.PlayerGui.Hud.Rebirth:TweenPosition(UDim2.new(0.5, 0, 0.5, 0), nil, nil, 0.3, true)
end)

---- purchase prompt toggle ----
m:Toggle("Purchase Prompt",function(bool)
    if bool then
        bool = false
    else
        bool = true
    end
    kVars.boolPurchasePrompt = bool
    game:GetService("CoreGui").PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.Visible = bool
end)

---- inf jump ----
m:Toggle("Inf Jump",function(bool)
    kVars.boolInfJump = bool
end)
kVars.InfJump = game:GetService("UserInputService").JumpRequest:connect(function()
	if kVars.boolInfJump then
		game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
	end
end)

---- Closing ----
kVars.closeing = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
	if child.Name == kVars.windowName then
		kVars.closing = true
        if kVars.boolPurchasePrompt == false then game:GetService("CoreGui").PurchasePrompt.ProductPurchaseContainer.Animator.Prompt.Visible = true end
		wait(.1)
		table.clear(kVars)
        kVars.InfJump:Disconnect()
        kVars.AntiAfk:Disconnect()
		kVars.closeing:Disconnect()
		script:Destroy()

	end
end)