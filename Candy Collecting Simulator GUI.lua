--[[
Game : https://www.roblox.com/games/3963432370
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
kVars.windowName = "Candy Collecting Simulator GUI" -- Window Name here
script.Name = kVars.windowName
kVars.candyHandler = require(game:GetService("ReplicatedStorage").Modules["Candy_Handler"])
kVars.NetworkHandler = require(game.ReplicatedStorage.Modules.Network_Module)
local w = library:CreateWindow(kVars.windowName) -- Creates the window
local b = w:CreateFolder("Farm") -- Creates the folder(U will put here your buttons,etc)
local t = w:CreateFolder("Teleport")
local c = w:CreateFolder("Character")

b:Toggle("Candy",function(bool)
    kVars.boolCandy = bool
    if bool then fCandy() end
end)

function fCandy()
    spawn(function()
        while kVars.boolCandy do
            wait()
            for _,g in pairs(Workspace.CandySpawns:GetChildren()) do
                if kVars.boolCandy == false then break end          
                for _,v in pairs(g:GetChildren()) do
                    if kVars.boolCandy == false then break end             
                    if (v.Name ~= "Center") then
                        v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    end
                end   
            end
        end
    end)
end

b:Toggle("Sell",function(bool)
    kVars.boolSell = bool
    if bool then fSell() end
end)

kVars.orgPosSell = game:GetService("Workspace").Interaction.SellPad.SellPart.Position
function fSell()
    spawn(function()
        while kVars.boolSell do
            wait()
            kVars.candyHandler:SellCandy()
        end
    end)
end

b:Toggle("Rebirth",function(bool)
    kVars.boolRebirth = bool
    if bool then fRebirth() end
end)
function fRebirth()
    spawn(function()
        while kVars.boolRebirth do
            task.wait()   
            kVars.NetworkHandler:FireServer("Rebirth")
        end
    end)
end

b:Button("Remove Gates",function()
    game:GetService("Workspace").Interaction.Gates:Remove()
    game:GetService("Workspace").Interaction.UnderworldGates:Remove()
end)

------------------ teleport ------------------
locations = {
    [1] = {name = "Spawn", cf = game:GetService("Workspace").SpawnLocation.CFrame},
    [2] = {name = "Sell", cf = CFrame.new(-240, 17, -80)},
    [3] = {name = "Quest", cf = CFrame.new(-194.065475, 15.2254839, -45.8244705)},
    [4] = {name = "Cash Board", cf = CFrame.new(-43.8323669, 17.9404984, 48.1946449)},
    [5] = {name = "Rebirth", cf = CFrame.new(2606.0144, 66.6354828, 158.644135)},
    [6] = {name = "Zone 18 Best Candy", cf = CFrame.new(2604.05469, 118.70636, 533.31427)},
    [7] = {name = "Underworld", cf = CFrame.new(-2269.2002, 37.1693993, 318.820831)},
    [8] = {name = "Heaven", cf = CFrame.new(2671.22632, 65.1063309, -266.440155)}
}

for _,v in ipairs(locations) do
    t:Button(v.name,function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.cf
    end)
end

c:Slider("Walk SPeed",{
    min = 16; -- min value of the slider
    max = 500; -- max value of the slider
    precise = false; -- max 2 decimals
},function(value)
    game:GetService('Players').LocalPlayer.Character.Humanoid.WalkSpeed = value
end)