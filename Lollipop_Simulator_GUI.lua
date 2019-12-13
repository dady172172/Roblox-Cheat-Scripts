--[[
game https://www.roblox.com/games/2610716991/Lollipop-Simulator
more https://github.com/dady172172/Roblox-Cheats
]]--

lick = false
buy = false
coin1 = false
coin2 = false
coin3 = false
coin4 = false
gems = false
isfarming = nil

RS = game:GetService("ReplicatedStorage")
WS = game:GetService("Workspace")
Localplayer = game:GetService("Players").LocalPlayer
plr = Localplayer.Name
HRP = Localplayer.Character.HumanoidRootPart
Events = RS.Events
tel = WS["_Teles"]

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
	
local LollipopSimulatorGUI = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='LollipopSimulatorGUI', Parent=game.CoreGui})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.339563876, 0, 0.324749649, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 324, 0, 374),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = LollipopSimulatorGUI})
local JPSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.DropShadow,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=0,ClipsDescendants=false,Draggable=false,Position=UDim2.new(-0.000128852, 0, -0.00188833638, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 312, 0, 284),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=-1,Name = 'JPSFrame',Parent = Frame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Lollipop Simulator GUI',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.21659264, 0, 0.0230447501, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 168, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local FarmLicksBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Lick',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0472722128, 0, 0.178840131, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmLicksBtn',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.188999996, 0, 0, -110),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local FarmCoinsArea1Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coins Spawn',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0472722165, 0, 0.291516244, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmCoinsArea1Btn',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.188999996, 0, 0, 0),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleports',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.281272709, 0, 0.514066398, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 128, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local TPSpawnBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Spawn',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.037656825, 0, 0.604896486, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPSpawnBtn',Parent = JPSFrame})
local TPVillageBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Village',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342144042, 0, 0.604896486, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPVillageBtn',Parent = JPSFrame})
local TPMoonBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Moon',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.646579623, 0, 0.603554904, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPMoonBtn',Parent = JPSFrame})
local TPSellAreaBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Sell Area',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0376568213, 0, 0.81968528, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPSellAreaBtn',Parent = JPSFrame})
local BuyBestBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Buy Best',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.646631181, 0, 0.17884016, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='BuyBestBtn',Parent = JPSFrame})
local FarmCoinsArea2Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coins Village',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.348554283, 0, 0.291516244, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmCoinsArea2Btn',Parent = JPSFrame})
local FarmCoinsArea3Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coins Moon',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.646631181, 0, 0.291516244, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmCoinsArea3Btn',Parent = JPSFrame})
local QuickSellBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Quick Sell',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.348554254, 0, 0.17884016, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='QuickSellBtn',Parent = JPSFrame})
local FarmCoinsArea4Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coins Ruins',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0472722165, 0, 0.39715004, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmCoinsArea4Btn',Parent = JPSFrame})
local FarmGemsArea5Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Gems Military',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.348554283, 0, 0.39715004, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmGemsArea5Btn',Parent = JPSFrame})
local TPRuinsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Ruins',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.037656825, 0, 0.710530281, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPRuinsBtn',Parent = JPSFrame})
local TPMilitaryBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Military',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342144042, 0, 0.710530281, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPMilitaryBtn',Parent = JPSFrame})
local TPChestsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Chests',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.345297575, 0, 0.821864784, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TPChestsBtn',Parent = JPSFrame})
local OpenBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Close',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.61728394, -36, -0.652406454, -15),Rotation=0,Selectable=true,Size=UDim2.new(0, 73, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='OpenBtn',Parent = Frame})


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


FarmLicksBtn.MouseButton1Click:connect(function()
    if lick == true then lick = false 
        FarmLicksBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif lick == false then lick = true 
        FarmLicksBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    LickFunc()
end)

FarmCoinsArea1Btn.MouseButton1Click:connect(function()
    if isfarming == "Area1" or isfarming == nil then
        if coin1 == true then coin1 = false 
            FarmCoinsArea1Btn.BackgroundColor3 = Color3.new(0, 0, 0)
            isfarming = nil
        elseif coin1 == false then coin1 = true 
            FarmCoinsArea1Btn.BackgroundColor3 = Color3.new(0, 170, 0)
            isfarming = "Area1"
        end
        CollectCoins("Area1")
    end
end)

FarmCoinsArea2Btn.MouseButton1Click:connect(function()
    if isfarming == "Area2" or isfarming == nil then 
        if coin2 == true then coin2 = false 
            FarmCoinsArea2Btn.BackgroundColor3 = Color3.new(0, 0, 0)
            isfarming = nil
        elseif coin2 == false then coin2 = true 
            FarmCoinsArea2Btn.BackgroundColor3 = Color3.new(0, 170, 0)
            isfarming = "Area2"
        end
        CollectCoins("Area2")
    end
end)

FarmCoinsArea3Btn.MouseButton1Click:connect(function()
    if isfarming == "Area3" or isfarming == nil then
        if coin3 == true then coin3 = false 
            FarmCoinsArea3Btn.BackgroundColor3 = Color3.new(0, 0, 0)
            isfarming = nil
        elseif coin3 == false then coin3 = true 
            FarmCoinsArea3Btn.BackgroundColor3 = Color3.new(0, 170, 0)
            isfarming = "Area3"
        end
        CollectCoins("Area3")
    end
end)

FarmCoinsArea4Btn.MouseButton1Click:connect(function()
    if isfarming == "Area4" or isfarming == nil then
        if coin4 == true then coin4 = false 
            FarmCoinsArea4Btn.BackgroundColor3 = Color3.new(0, 0, 0)
            isfarming = nil
        elseif coin4 == false then coin4 = true 
            FarmCoinsArea4Btn.BackgroundColor3 = Color3.new(0, 170, 0)
            isfarming = "Area4"
        end
        CollectCoins("Area4")
    end
end)

FarmGemsArea5Btn.MouseButton1Click:connect(function()
    if isfarming == "Area5" or isfarming == nil then
        if gems == true then gems = false 
            FarmGemsArea5Btn.BackgroundColor3 = Color3.new(0, 0, 0)
            isfarming = nil
        elseif gems == false then gems = true 
            FarmGemsArea5Btn.BackgroundColor3 = Color3.new(0, 170, 0)
            isfarming = "Area5"
        end
        CollectCoins("Area5")
    end
end)

BuyBestBtn.MouseButton1Click:connect(function()
    if buy == true then buy = false 
        BuyBestBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif buy == false then buy = true 
        BuyBestBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    BuyFunc()
end)

TPSpawnBtn.MouseButton1Click:connect(function()
    HRP.CFrame = tel.Area1.CFrame
end)

TPVillageBtn.MouseButton1Click:connect(function()
    HRP.CFrame = tel.Area2.CFrame
end)

TPMoonBtn.MouseButton1Click:connect(function()
    HRP.CFrame = tel.Area3.CFrame
end)

TPRuinsBtn.MouseButton1Click:connect(function()
    HRP.CFrame = tel.Area4.CFrame
end)

TPMilitaryBtn.MouseButton1Click:connect(function()
    HRP.CFrame = tel.Area5.CFrame
end)

TPSellAreaBtn.MouseButton1Click:connect(function()
    HRP.CFrame = CFrame.new(-166.513916, 25.6278648, 149.04068, 0.99925369, -1.58751607e-08, 0.0386269316, 1.97436183e-08, 1, -9.97677532e-08, -0.0386269316, 1.00455935e-07, 0.99925369)
end)

TPChestsBtn.MouseButton1Click:connect(function()
    for _,g in pairs(game:GetService("Workspace")["_Daily"]:GetChildren()) do 
        for _,v in pairs(g:GetChildren()) do 
            if string.match(v.Name, "Act") then 
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end
end)

QuickSellBtn.MouseButton1Click:connect(function()
    local save = HRP.CFrame
    wait(.000000001)
    HRP.CFrame = CFrame.new(-166.513916, 25.6278648, 149.04068, 0.99925369, -1.58751607e-08, 0.0386269316, 1.97436183e-08, 1, -9.97677532e-08, -0.0386269316, 1.00455935e-07, 0.99925369)
    wait(.6)
    HRP.CFrame = save
end)

function LickFunc()
    while lick == true do
        wait() 
        game.ReplicatedStorage.Lick:InvokeServer(Workspace.keathunsar.Lollipop)
    end
end

function CollectCoins(AreaName)
    while isfarming == AreaName do 
        if AreaName == "Area5" then --if area 5 farm gems
            for _,g in pairs(WS:GetChildren()) do 
                if isfarming ~= AreaName then return end
                if string.match(g.Name, "Coins") then                
                    for _,v in pairs(g:GetChildren()) do                    
                        if isfarming ~= AreaName or isfarming == nil then return end
                        if tostring(v.Area.Value) == AreaName and v.Transparency == 0 then
                            local OrigPOS = v.CFrame
                            wait(1)
                            v.CFrame = HRP.CFrame
                            wait(.1)
                            v.CFrame = OrigPOS
                        else
                            if not tostring(v.Name, "Coin") then                           
                            wait(.1)
                            else
                            wait()
                            end
                        end
                    end
                end
            end
        else   
            for _,g in pairs(WS:GetChildren()) do --if areas 1-4 farm coins
                if isfarming ~= AreaName then return end
                if string.match(g.Name, "Coins") then 
                    for _,v in pairs(g:GetChildren()) do 
                        if isfarming ~= AreaName or isfarming == nil then return end
                        if tostring(v.Area.Value) == AreaName and v.Transparency == 0 then
                            local OrigPOS = v.CFrame
                            wait(1)
                            v.CFrame = HRP.CFrame
                            wait(.1)
                            v.CFrame = OrigPOS
                        else
                            wait(.1)
                        end
                    end
                end
            end
        end
    end
end

function BuyFunc()
    while buy == true do
        wait(1)
        game.ReplicatedStorage.Events[""]:InvokeServer(1) --lollipop
        game.ReplicatedStorage.Events[""]:InvokeServer(2) --Max   
    end
end

function QuestFunc()
    while quest == true do
        wait(1)
        game.ReplicatedStorage.Events[""]:FireServer("Lick")
        game.ReplicatedStorage.Events[""]:FireServer("Coin")
        game.ReplicatedStorage.Events[""]:FireServer("Chest")
    end
end