--https://www.roblox.com/games/3329474278/FISHING-SIMULATOR
--https://github.com/dady172172/Roblox-Cheats

local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)
	
local JetPackSimGUI = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='JetPackSimGUI', Parent=game.CoreGui})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.339563876, 0, 0.324749649, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 324, 0, 374),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = JetPackSimGUI})
local JPSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.DropShadow,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=0,ClipsDescendants=false,Draggable=true,Position=UDim2.new(-0.000128852, 0, -0.00188833638, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 312, 0, 243),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=-1,Name = 'JPSFrame',Parent = Frame})
local AutoFishBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Auto Fish',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.149836227, 0, 0.324030638, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='AutoFishBtn',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Fishing Simulator GUI',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.281272709, 0, -1.81552023e-05, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 128, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local TPRodShopBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Rod Shop',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120158009, 0, 0.745742321, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPRodShopBtn',Parent = JPSFrame})
local TeleFishingSpotBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Fishing Spot',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.547272205, 0, 0.324030638, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TeleFishingSpotBtn',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleports',TextColor3=Color3.new(1, 1, 1),TextScaled=true,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0328920782, 0, 0.523357153, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 273, 0, 21),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.188999996, 0, 0, -90),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.188999996, 0, -0.0199999996, 0),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local TPBackpackShopBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Backpack Shop',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342143983, 0, 0.745742321, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPBackpackShopBtn',Parent = JPSFrame})
local TPBaitShopBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Bait Shop',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675477326, 0, 0.745742321, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPBaitShopBtn',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Auto Fishing',TextColor3=Color3.new(1, 1, 1),TextScaled=true,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0360972062, 0, 0.173562914, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 273, 0, 21),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local OpenBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Close',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(1.36609697, 0, -0.609625518, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 73, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='OpenBtn',Parent = Frame})

local farm = false

OpenBtn.MouseButton1Click:connect(function()
    if OpenBtn.Text == "Close" then
        OpenBtn.Text = "Open"
        JPSFrame.Visible = false
        print("Menu Closed")
    elseif OpenBtn.Text == "Open" then
        OpenBtn.Text = "Close"
        JPSFrame.Visible = true
        print("Menu Opened")       
    end
end)

AutoFishBtn.MouseButton1Click:connect(function()
    if farm == true then farm = false print("Disabled")
        AutoFishBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif farm == false then farm = true print("Enabled")
        AutoFishBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Farm1()
end)

TeleFishingSpotBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(42.998703, 23.2405891, -109.095413, 0.999971092, 0.000536165724, -0.00758176111, 1.85827957e-05, 0.997333407, 0.0729801804, 0.00760067254, -0.0729782134, 0.997304559)
end)

TPRodShopBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(61.4394646, 23.7404995, -3.16035247, 0.99981761, 2.13915197e-09, 0.0190984588, -3.58946761e-09, 1, 7.59046017e-08, -0.0190984588, -7.59593064e-08, 0.99981761)
end)

TPBackpackShopBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(162.87558, 23.9404984, 4.88811255, 0.998929322, -3.96258292e-06, 0.0462644696, 7.00406099e-06, 1, -6.5579261e-05, -0.0462644696, 6.58330828e-05, 0.998929322)
end)

TPBaitShopBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(104.379425, 23.9404984, 6.82347536, 0.0466753654, 8.20849166e-08, -0.998910129, -6.10665083e-08, 1, 7.93210688e-08, 0.998910129, 5.72976155e-08, 0.0466753654)
end)

function Farm1()
    while farm == true do
        local baitAmount = tonumber(string.match(game:GetService("Players").keathunsar.PlayerGui.ScreenGui.SideBait.Counter.text, "%d+"))
        if (baitAmount <= 2) then
            game.ReplicatedStorage.Connections.FishingPurchaseBait:InvokeServer()
        end
        game.ReplicatedStorage.Connections.FishingCast:InvokeServer()
        game.ReplicatedStorage.Connections.FishingSellAll:InvokeServer()
    end
end