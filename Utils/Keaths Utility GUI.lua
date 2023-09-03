--[[
Game : 
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--
---- vars ----
kVars = {}
kVars.WindowName = "Keaths Utility GUI"
kVars.lp = game:GetService('Players').LocalPlayer
kVars.vu = game:GetService('VirtualUser')
kVars.uis = game:GetService('UserInputService')
kVars.rs = game:GetService('ReplicatedStorage')
kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid')
kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart')

---- destroy old gui if exists ----
if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName) then
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
    wait(2)
end

---- antiAFK ----
kVars.connectAntiAfk = game:GetService('Players').LocalPlayer.Idled:connect(function()
    kVars.vu:CaptureController()
    kVars.vu:ClickButton2(Vector2.new())
 end)

---- gui build ----
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/teppyboy/RbxScripts/master/Misc/UI_Libraries/Zypher/Library.lua"))()
local Window = library:CreateMain({
    projName = kVars.WindowName,
    Resizable = true,
    MinSize = UDim2.new(0,400,0,400),
    MaxSize = UDim2.new(0,750,0,500),
})

local pageMain = Window:CreateCategory("Main")
local sectionClipBoard = pageMain:CreateSection("Clipboard")
local sectionScriptDump = pageMain:CreateSection("Script Dump")

local pageTeleport = Window:CreateCategory("Teleport")
local sectionTPToPlayer = pageTeleport:CreateSection("Teleport To Player")

local pageCharacter = Window:CreateCategory("Character")
local sectionCharacter = pageCharacter:CreateSection("Options")

local pageMisc = Window:CreateCategory("Misc")
local sectionKeybinds = pageMisc:CreateSection("KeyBinds")
local sectionWorld = pageMisc:CreateSection("World Options")
local sectionMisc = pageMisc:CreateSection("Options")

local pageCredits = Window:CreateCategory("Credits")
local sectionCreditsKeath = pageCredits:CreateSection("Coded by : Keathunsar")
local sectionCreditsAlex = pageCredits:CreateSection("UI-Lib by : xTheAlex14")

----========== page main ==========----
---- section clipboard ----
sectionClipBoard:Create("Button", "Player CFrame", function()
    local t = math.floor(kVars.hrp.CFrame.X) .. ", " .. math.floor(kVars.hrp.CFrame.Y) .. ", " .. math.floor(kVars.hrp.CFrame.Z)
    setclipboard(t)
end,{animated = true})

sectionClipBoard:Create("Button", "Player CFrame with new", function()
    local t = "CFrame.new(" .. math.floor(kVars.hrp.CFrame.X) .. ", " .. math.floor(kVars.hrp.CFrame.Y) .. ", " .. math.floor(kVars.hrp.CFrame.Z) .. ")"
    setclipboard(t)
end,{animated = true})

sectionClipBoard:Create("Button", "Player tp CFrame", function()
    local t = "game:GetService(\"Players\").LocalPlayer.Character:WaitForChild(\"HumanoidRootPart\").CFrame = CFrame.new(" .. math.floor(kVars.hrp.CFrame.X) .. ", " .. math.floor(kVars.hrp.CFrame.Y) .. ", " .. math.floor(kVars.hrp.CFrame.Z) .. ")"
    setclipboard(t)
end,{animated = true})

---- section scriptdump ----
sectionScriptDump:Create("Button", "Start", function()
    if not isfolder then 
        warn("Your injector does not support isfolder")
        return
    elseif not makefolder then 
        warn("Your injector does not support makefolder")
        return
    elseif not delfolder then
        warn("Your injector does not support delfolder")
        return
    elseif not writefile then
        warn("Your injector does not support writefile")
        return
    elseif not decompile then
        warn("Your injector does not support decompile")
        return
    end
    print("This may take a while, depending on the device your using.")
    local startTime = os.time()
    local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    if isfolder(gameName) then
        delfolder(gameName)
    end
    makefolder(gameName)
    for a,b in pairs(game:GetChildren()) do
        local dir = gameName .. "/" .. b.Name
        for i,v in pairs(b:GetDescendants()) do
            pcall(function()
                if v.ClassName == "LocalScript" or v.ClassName == "ModuleScript" then
                    if not isfolder(dir) then
                        makefolder(dir)
                    end
                    local a = decompile(v)
                    writefile(dir .. "/" .. v:GetFullName() .. ".lua", a)
                end
            end)
        end
    end
    print("Done : " .. tostring(os.time() - startTime))
    
end,{animated = true})

----========== page teleport ==========----
---- section teleport to player ----
kVars.SelectedTPToPlayer = kVars.lp.name
sectionTPToPlayer:Create("TextBox", "Enter Users Name", function(value)
    kVars.SelectedTPToPlayer = value
end,{text = "Enter Users Name"})

sectionTPToPlayer:Create("Button", "Teleport To Player", function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if kVars.SelectedTPToPlayer ~= nil and kVars.SelectedTPToPlayer ~= kVars.lp.name then
            if string.lower(v.DisplayName) == string.lower(kVars.SelectedTPToPlayer) then
                kVars.hrp.CFrame = v.Character.HumanoidRootPart.CFrame                
            end
        end
    end
end,{animated = true})


----========== page character ==========----
---- section Character ----
kVars.walkSpeed = kVars.humanoid.WalkSpeed
sectionCharacter:Create("Slider", "Walk Speed", function(value)
    kVars.walkSpeed = value
    kVars.humanoid.WalkSpeed = value
end,{min = 16, max = 500, default = kVars.humanoid.walkSpeed, precise = false, changablevalue = true})

kVars.jumpPower = kVars.humanoid.JumpPower
sectionCharacter:Create("Slider", "Jump Power", function(value)
    kVars.jumpPower = value
    kVars.humanoid.JumpPower = value
end,{min = 7.2, max = 500, default = kVars.humanoid.jumpPower, precise = true, changablevalue = true})

kVars.jumpHeight = kVars.humanoid.JumpHeight
sectionCharacter:Create("Slider", "Jump Height", function(value)
    kVars.jumpHeight = value
    kVars.humanoid.JumpHeight = value
end,{min = 7.2, max = 500, default = kVars.humanoid.jumpHeight, precise = true, changablevalue = true})


kVars.plrAdded = game.Players.LocalPlayer.CharacterAdded:Connect(function(child)
    kVars.humanoid = kVars.lp.Character:WaitForChild('Humanoid', 999999)
    kVars.hrp = kVars.lp.Character:WaitForChild('HumanoidRootPart', 999999)
    task.wait(1)
    kVars.humanoid.WalkSpeed = kVars.walkSpeed
    kVars.humanoid.JumpHeight = kVars.jumpHeight
    kVars.humanoid.JumpPower = kVars.jumpPower
end)

kVars.boolInfJump = false
sectionCharacter:Create("Toggle", "Inf Jump",function(bool)
    kVars.boolInfJump = bool
end,{default = kVars.boolInfJump})

kVars.connectJumpRequest = game:GetService("UserInputService").JumpRequest:Connect(function()
	if kVars.boolInfJump then
		kVars.humanoid:ChangeState("Jumping")
	end
end)

----========== page misc ==========----
---- section keybinds ----
kVars.OpenCloseMenuKey = Enum.KeyCode.F5
sectionKeybinds:Create("KeyBind", "Open Close Menu", function(key)
    kVars.OpenCloseMenuKey = key
end,{default = kVars.OpenCloseMenuKey})


kVars.connectInputBegan = kVars.uis.InputBegan:Connect(function(key)
    if key.UserInputType == Enum.UserInputType.Keyboard and key.KeyCode == kVars.OpenCloseMenuKey then
        if game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled then
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = false
        else
            game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Enabled = true
        end
    end
end)

---- section world ----
if game.Lighting.FogStart < 100 then
    kVars.boolFog = true
else
    kVars.boolFog = false
end
sectionWorld:Create("Toggle", "Fog",function(bool)
    kVars.boolFog = bool
    if bool then
        game.Lighting.FogStart = 0
    else
        game.Lighting.FogStart = math.huge
    end
end,{default = kVars.boolFog})

---- sections options ----
sectionMisc:Create("Button", "Destroy this GUI",function()
    game:GetService("CoreGui"):FindFirstChild(kVars.WindowName):Destroy()
end,{animated = true})

sectionMisc:Create("Toggle", "Purchase Prompt",function(bool)
    game:GetService("CoreGui").PurchasePrompt.Enabled = bool
end,{default = game:GetService("CoreGui").PurchasePrompt.Enabled})

kVars.Esp = {}
kVars.boolEsp = false
sectionMisc:Create("Toggle", "Player ESP",function(bool)
    kVars.boolEsp = bool
    if not bool then
        for i,v in pairs(game.Players:GetPlayers()) do
            if kVars.Esp[v.Name] then
                wait()
                kVars.Esp[v.Name].sq.Visible = false
                kVars.Esp[v.Name].txt.Visible = false 

                
            end
        end
        
    else
        fEsp()
    end
end,{default = kVars.boolEsp})

kVars.plrRemovingConnect = game:GetService("Players").PlayerRemoving:Connect(function(p)
    if kVars.Esp[p.Name] then
        wait()
        kVars.Esp[p.Name].sq.Visible = false
        kVars.Esp[p.Name].txt.Visible = false
        table.remove(kVars.Esp[p.Name])
    end
end)

function mean(t)
    local add = 0
    for i,v in pairs(t) do
        add = add + v
    end
    return add / #t
end

function fEsp()
    spawn(function()
        while kVars.boolEsp do
            task.wait()
            pcall(function()
                for i,v in pairs(game.Players:GetChildren()) do
                    if not kVars.boolEsp then break end
                    task.wait()
                    if v.Character and v.Character:FindFirstChild("Head") then
                        local pHead = v.Character:WaitForChild("Head")
                        local pHrp = v.Character:WaitForChild("HumanoidRootPart") 
                        
                        if v.Name ~= kVars.lp.Name then
                            if not kVars.Esp[v.Name] then
                                kVars.Esp[v.Name] = {}
                                -- esp square
                                kVars.Esp[v.Name].sq = Drawing.new("Square")
                                kVars.Esp[v.Name].sq.Visible = false
                                kVars.Esp[v.Name].sq.Thickness = 1
                                kVars.Esp[v.Name].sq.Size = Vector2.new(10,10)
                                kVars.Esp[v.Name].sq.Filled = false
                                kVars.Esp[v.Name].sq.Color = Color3.fromRGB(0, 255, 60)
                                local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pHead.Position)
                                kVars.Esp[v.Name].sq.Position = Vector2.new(vector.x, vector.y)
                                -- esp text
                                kVars.Esp[v.Name].txt = Drawing.new("Text")
                                kVars.Esp[v.Name].txt.Visible = false
                                kVars.Esp[v.Name].txt.Size = 16
                                kVars.Esp[v.Name].txt.Color = Color3.fromRGB(0, 255, 60)
                                kVars.Esp[v.Name].txt.Transparency = 1
                                kVars.Esp[v.Name].txt.ZIndex = 1
                                kVars.Esp[v.Name].txt.Center = true
                                kVars.Esp[v.Name].txt.Font = 3
                                kVars.Esp[v.Name].txt.Outline = true
                                kVars.Esp[v.Name].txt.OutlineColor = Color3.fromRGB(0, 0, 0)
                                kVars.Esp[v.Name].txt.Text = v.Name
                            end
                            local vector1, onScreen1 = game.Workspace.CurrentCamera:WorldToViewportPoint(pHead.Position)

                            if onScreen1 then
                                local distBetHeadHrp = Vector3.new(mean({pHead.Position.x, pHrp.Position.x}),mean({pHead.Position.y, pHrp.Position.y}),mean({pHead.Position.z, pHrp.Position.z}))
                                local screenDistBetHeadHrp, onscreenDistBetHeadHrp = game.Workspace.CurrentCamera:WorldToViewportPoint(distBetHeadHrp)
                                local screenPosHead, onscreenPosHead = game.Workspace.CurrentCamera:WorldToViewportPoint(pHead.Position)
                                local screenPosHrp, onscreenPosHrp = game.Workspace.CurrentCamera:WorldToViewportPoint(pHrp.Position)
                                local diffScreen = (screenPosHead - screenPosHrp).Magnitude
                                kVars.Esp[v.Name].sq.Visible = true
                                kVars.Esp[v.Name].sq.Position = Vector2.new((screenDistBetHeadHrp.x - diffScreen), (screenDistBetHeadHrp.y - diffScreen)) 
                                kVars.Esp[v.Name].sq.Size = Vector2.new(diffScreen * 2, diffScreen * 3)
                                kVars.Esp[v.Name].txt.Visible = true
                                kVars.Esp[v.Name].txt.Position = Vector2.new((screenPosHead.x), (kVars.Esp[v.Name].sq.Position.y - diffScreen))
            
                            else
                                kVars.Esp[v.Name].sq.Visible = false
                                kVars.Esp[v.Name].txt.Visible = false
            
                            end
                            
                        end
                    end
                end
            end)
            
        end
    end)
end


----========== page credits ==========----
---- keaths ----
sectionCreditsKeath:Create("Button", "https://github.com/dady172172/Roblox-Cheats", function()
    setclipboard('https://github.com/dady172172/Roblox-Cheats')
end,{animated = true})

sectionCreditsKeath:Create("Button", "https://discord.gg/MhMB3c2CBn", function()
    setclipboard('https://discord.gg/MhMB3c2CBn')
end,{animated = true})

---- alex ----
sectionCreditsAlex:Create("Button", "https://teppyboy.github.io/", function()
    setclipboard('https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/main.html')
end,{animated = true})

----========== set window size after load ==========----
game:GetService("CoreGui"):FindFirstChild(kVars.WindowName).Motherframe.Size = UDim2.new(0, 495, 0, 400)

----========== delete script if re-injecting ==========----

kVars.cR = game:GetService("CoreGui").ChildRemoved:Connect(function(child)
    if child.name == kVars.WindowName then
        for i,v in pairs(kVars) do
            if type(v) == "boolean" then
                kVars[i] = false
            end
        end
        kVars.connectAntiAfk:Disconnect()
        kVars.connectInputBegan:Disconnect()
        kVars.connectJumpRequest:Disconnect()
        kVars.plrAdded:Disconnect()
        kVars.plrRemovingConnect:Disconnect()
        wait(1)
        script:Destroy()
        kVars.cR:Disconnect()
    end
end)



--[[
    ---- Toggle ----
sectionFarm:Create("Toggle", "",function(bool)
    kVars.bool = bool
    if bool then
        f()
    end
end,{default = kVars.bool})

function f()
    spawn(function()
        while kVars.bool do
            wait()
            
        end
    end)
end
    ---- Button ----
section:Create("Button", "", function()

end,{animated = true})
    ---- DropDown ----
section:Create("DropDown", "", function(value)

end,{options = kVars., default = kVars.[1], search = true})
    ---- Slider ----
section:Create("Slider", "", function(value)

end,{min = 0, max = 5, default = 2, precise = false, changablevalue = true})
    ---- Textbox ----
section:Create("TextBox", "", function(value)

end,{text = "I am texty"})
    ---- KeyBind ----
section:Create("KeyBind", "", function()

end,{default = Enum.KeyCode.k})
    ---- ColorPicker ----
section:Create("ColorPicker", "", function(color)

end,{default = Color3.fromRGB(255,255,255)})
    ---- Label ----
section:Create("Textlabel","Suck It")

]]