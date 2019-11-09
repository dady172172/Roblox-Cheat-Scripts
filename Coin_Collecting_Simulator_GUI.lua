-- Game https://www.roblox.com/games/2484088625/Coin-Collecting-Simulator
-- Image https://prnt.sc/puagll
-- more at https://github.com/dady172172/Roblox-Cheats
-- Made by dady172172

coincheat1 = false
coincheat2 = false
coincheat3 = false
coincheat4 = false
buymult = false
buygem = false
rebirth = false
multpos = game:GetService("Workspace")["Multiplier Button"].Head.CFrame
gempos = game:GetService("Workspace")["Gems  Button"].Head.CFrame
rebirthpos = game:GetService("Workspace")["Rebirth  Button"].Head.CFrame

local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
	
local CoinSimGui = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='CoinSimGui', Parent=game.CoreGui})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.339563876, 0, 0.324749649, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 324, 0, 374),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = CoinSimGui})
local CoinsimFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.DropShadow,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=0,ClipsDescendants=false,Draggable=true,Position=UDim2.new(0.0276489258, 0, 0.000785460463, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 312, 0, 188),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'CoinsimFrame',Parent = Frame})
local CoinBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coin 1',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157134, 0, 0.295114607, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='CoinBtn',Parent = CoinsimFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coin Collecting Simulator',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.281272709, 0, -1.81552023e-05, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 128, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = CoinsimFrame})
local Coin2Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coin 2',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342143923, 0, 0.295114607, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Coin2Btn',Parent = CoinsimFrame})
local RebirthBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Rebirth',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.672272146, 0, 0.75256151, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='RebirthBtn',Parent = CoinsimFrame})
local Coin3Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coin 3',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157367, 0, 0.52440697, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Coin3Btn',Parent = CoinsimFrame})
local Coin4Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coin 4',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342143953, 0, 0.519087791, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Coin4Btn',Parent = CoinsimFrame})
local GemBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Buy Gems',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342143953, 0, 0.753130376, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='GemBtn',Parent = CoinsimFrame})
local MultiplyerBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Buy Bultiplyer',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157134, 0, 0.753699183, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='MultiplyerBtn',Parent = CoinsimFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.327077389, 0, -0.661985755, 0),Rotation=90,Selectable=false,Size=UDim2.new(0, 100, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = CoinsimFrame})
local OpenBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Close',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(1.36609697, 0, -0.609625518, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 73, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='OpenBtn',Parent = Frame})

OpenBtn.MouseButton1Click:connect(function()
    if OpenBtn.Text == "Close" then
        OpenBtn.Text = "Open"
        CoinsimFrame.Visible = false
        print("Menu Closed")
    elseif OpenBtn.Text == "Open" then
        OpenBtn.Text = "Close"
        CoinsimFrame.Visible = true
        print("Menu Opened")       
    end
end)

CoinBtn.MouseButton1Click:connect(function()
    if coincheat1 == true then coincheat1 = false print("Disabled")
        CoinBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        coincheat1 == false then coincheat1 = true print("Enabled")
        CoinBtn.BackgroundColor3 = Color3.new(0, 170, 0)
        coin1func()
    end  
end)

function coin1func()
    for _,v in pairs(game:GetService("Workspace"):GetChildren()) do 
        if v.Name == "Coin" then 
            if v.Reward then
                
                v.CanCollide = false
                v.Anchored = true
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait()
                if coincheat1 == false then return end
            end
        end
    end
    CoinBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    coincheat1 = false
end

Coin2Btn.MouseButton1Click:connect(function()
    if coincheat2 == true then coincheat2 = false print("Disabled")
        Coin2Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        coincheat2 == false then coincheat2 = true print("Enabled")
        Coin2Btn.BackgroundColor3 = Color3.new(0, 170, 0)
        coin2func()
    end
end)

function coin2func()
    for _,v in pairs(game:GetService("Workspace"):GetChildren()) do 
        if v.Name == "Coin2" then 
            if v.Reward then
                wait()
                v.CanCollide = false
                v.Anchored = true
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                if coincheat2 == false then return end
            end
        end
    end
    Coin2Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    coincheat2 = false
end

Coin3Btn.MouseButton1Click:connect(function()
    if coincheat3 == true then coincheat3 = false print("Disabled")
        Coin3Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        coincheat3 == false then coincheat3 = true print("Enabled")
        Coin3Btn.BackgroundColor3 = Color3.new(0, 170, 0)
        coin3func()
    end
end)

function coin3func()
    for _,v in pairs(game:GetService("Workspace"):GetChildren()) do 
        if v.Name == "Coin3" then 
            if v.Reward then
                wait()
                v.CanCollide = false
                v.Anchored = true
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                if coin3 == false then return end
            end
        end
    end
    Coin3Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    coincheat3 = false  
end

Coin4Btn.MouseButton1Click:connect(function()
    if coincheat4 == true then coincheat4 = false print("Disabled")
        Coin4Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        coincheat4 == false then coincheat4 = true print("Enabled")
        Coin4Btn.BackgroundColor3 = Color3.new(0, 170, 0)
        coin4func()
    end
end)

function coin4func()
    for _,v in pairs(game:GetService("Workspace"):GetChildren()) do         
        if v.Name == "Coin4" then 
            if v.Reward then
                wait()
                v.CanCollide = false
                v.Anchored = true
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                if coincheat4 == false then return end
            end
        end
    end
    Coin4Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    coincheat4 = false
end

MultiplyerBtn.MouseButton1Click:connect(function()
    if buymult == true then buymult = false print("Disabled")
        MultiplyerBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        buymult == false then buymult = true print("Enabled")
        MultiplyerBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Buymult()
end)

GemBtn.MouseButton1Click:connect(function()
    if buygem == true then buygem = false print("Disabled")
        GemBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        buygem == false then buygem = true print("Enabled")
        GemBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Buygem()
end)

RebirthBtn.MouseButton1Click:connect(function()
    if rebirth == true then rebirth = false print("Disabled")
        RebirthBtn.BackgroundColor3 = Color3.new(0, 0, 0)
        stopRebirth()
    elseif
        rebirth == false then rebirth = true print("Enabled")
        RebirthBtn.BackgroundColor3 = Color3.new(0, 170, 0)
        startRebirth()
    end
end)

function Buymult()
    while buymult == true do
        local v = game:GetService("Workspace")["Multiplier Button"].Head.CFrame
        game:GetService("Workspace")["Multiplier Button"].Head.CanCollide = false
        game:GetService("Workspace")["Multiplier Button"].Head.Transparency = 1
        game:GetService("Workspace")["Multiplier Button"].Head.Text.TextLabel.Visible = false
        game:GetService("Workspace")["Multiplier Button"].Head.CFrame = game.Players.LocalPlayer.Character.RightFoot.CFrame
        wait()
        if buymult == false then
            game:GetService("Workspace")["Multiplier Button"].Head.CFrame = multpos
            game:GetService("Workspace")["Multiplier Button"].Head.Text.TextLabel.Visible = true
            game:GetService("Workspace")["Multiplier Button"].Head.Transparency = 0
            return
        end
    end   
end

function Buygem()
    while buygem == true do
        local v = game:GetService("Workspace")["Gems  Button"].Head.CFrame
        game:GetService("Workspace")["Gems  Button"].Head.CanCollide = false
        game:GetService("Workspace")["Gems  Button"].Head.Transparency = 1
        game:GetService("Workspace")["Gems  Button"].Head.Text.TextLabel.Visible = false
        v = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        wait()
        if buygem == false then
            game:GetService("Workspace")["Gems  Button"].Head.Transparency = 0
            game:GetService("Workspace")["Gems  Button"].Head.Text.TextLabel.Visible = true
            game:GetService("Workspace")["Gems  Button"].Head.CFrame = gempos
            return
        end
    end
    
end

function startRebirth()
    while rebirth == true do
        local v = game:GetService("Workspace")["Rebirth  Button"].Head.CFrame        
        game:GetService("Workspace")["Rebirth  Button"].Head.CFrame = game.Players.LocalPlayer.Character.RightFoot.CFrame
        game:GetService("Workspace")["Rebirth  Button"].Head.CanCollide = false
        game:GetService("Workspace")["Rebirth  Button"].Head.Transparency = 1
        game:GetService("Workspace")["Rebirth  Button"].Head.Text.TextLabel.Visible = false
        wait()
    end
    stopRebirth()
end

function stopRebirth()
    game:GetService("Workspace")["Rebirth  Button"].Head.CFrame = rebirthpos
    game:GetService("Workspace")["Rebirth  Button"].Head.Text.TextLabel.Visible = true
    game:GetService("Workspace")["Rebirth  Button"].Head.Transparency = 0
end

