--https://www.roblox.com/games/1509515037/Metal-Detecting-Simulator
--https://github.com/dady172172/Roblox-Cheats
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

--part of menu
local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
local farm1 = false
local farm2 = false
local MetalDetectingSimGUI = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='MetalDetectingSimGUI', Parent=game.CoreGui})
local MDSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=true,Position=UDim2.new(0.800623059, 0, 0.587982833, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 272),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'MDSFrame',Parent = MetalDetectingSimGUI})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size24,Text='Metal Detecting Simulator',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=20,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0.666667, 0.666667),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 34),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = MDSFrame})
local FarmMoneyBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Farm Money',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.161484554, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='FarmMoneyBtn',Parent = MDSFrame})
local FarmRebirthsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Farm Rebirths',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.233575702, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='FarmRebirthsBtn',Parent = MDSFrame})
local RemBerriersBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Remove Barriers',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.305666655, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='RemBerriersBtn',Parent = MDSFrame})
local TPShopBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Shop',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.377758443, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPShopBtn',Parent = MDSFrame})
local TPVIPBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Vip Area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.451287866, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPVIPBtn',Parent = MDSFrame})
local TP65Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP 65+ Area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.524817288, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TP65Btn',Parent = MDSFrame})
local TP25Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP 25+ Area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.59834671, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TP25Btn',Parent = MDSFrame})
local TPBeachBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Beach Area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.671876132, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPBeachBtn',Parent = MDSFrame})

FarmMoneyBtn.MouseButton1Click:connect(function()
    if farm1 == true then farm1 = false print("Disabled")
        FarmMoneyBtn.BackgroundColor3 = Color3.new(170, 0, 0)
    elseif
        farm1 == false then farm1 = true print("Enabled")
        FarmMoneyBtn.BackgroundColor3 = Color3.new(0, .5, 0)
    end
    Farm1()
end)
FarmRebirthsBtn.MouseButton1Click:connect(function()
    if farm2 == true then farm2 = false print("Disabled")
        FarmRebirthsBtn.BackgroundColor3 = Color3.new(170, 0, 0)
    elseif
        farm2 == false then farm2 = true print("Enabled")
        FarmRebirthsBtn.BackgroundColor3 = Color3.new(0, .5, 0)
    end
    Farm2()
end)
RemBerriersBtn.MouseButton1Click:connect(function()
    game:GetService("Workspace").Landmarks.Barriers:Remove()
    game:GetService("Workspace").Map.Barriers:Remove()
    game:GetService("Workspace").Landmarks.PremiumBarriers:Remove()
end)
TPShopBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-247.036804, 72.4449692, 361.071899, 0.944977105, 1.01820568e-07, 0.327136546, -8.93565613e-08, 1, -5.31296962e-08, -0.327136546, 2.09745501e-08, 0.944977105)
end)
TPVIPBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-188.257797, 71.2100143, 401.75769, -0.050115224, -4.645231e-06, -0.998743236, -1.10072342e-05, 1, -4.09875111e-06, 0.998743236, 1.07879878e-05, -0.050115224)
end)
TP65Btn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-951.002136, 71.207901, 414.705139, 0.0144705633, 2.90570004e-08, 0.999895275, -6.83269974e-08, 1, -2.80712094e-08, -0.999895275, -6.79136392e-08, 0.0144705633)
end)
TP25Btn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-614.664429, 71.207901, 414.368805, -0.0163676869, 0.000102562837, 0.99986589, -0.000266010698, 0.99999994, -0.000106931191, -0.999865651, -0.000267725467, -0.0163676329)
end)
TPBeachBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50.4996338, 29.5232887, 659.210571, 0.791724503, 6.05643393e-08, -0.610878289, -1.00802147e-07, 1, -3.15008535e-08, 0.610878289, 8.65178436e-08, 0.791724503)
end)


function Farm1()
    while farm1 == true do
        wait(.02)
        game.Workspace.__REMOTES.Dig:FireServer("Stop", "Halo Treasure Chest","99999999999999999999")
        game.Workspace.__REMOTES.Sell:FireServer()
    end
end
function Farm2()
    while farm2 == true do
        wait(.02)
        local level = game:GetService("Players").keathunsar.leaderstats.Level.Value
        if (level >= 125) then
            game.Workspace.__REMOTES.Rebirth:InvokeServer()
        end
        game.Workspace.__REMOTES.Dig:FireServer("Stop", "Halo Treasure Chest","9999999999999999999999")
        game.Workspace.__REMOTES.Sell:FireServer()
    end
end