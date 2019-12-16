--Game = https://www.roblox.com/games/4260821538/Jetpack-Universe
--more/contact https://github.com/dady172172/Roblox-Cheats

WS = game:GetService("Workspace")
RS = game:GetService("ReplicatedStorage")
LP = game:GetService("Players").LocalPlayer
fuel = LP.Stats.Fuel
maxfuel = LP.Stats.MaxFuel
jetpacklevel = LP.Stats.JetpackLevel
HRP = game.Players.LocalPlayer.Character.HumanoidRootPart
ARS = WS.AreaResourseSpawns
upgradejetpack = RS.CTS.UpgradeJetpack
upgradefueltank = RS.CTS.UpgradeFuelTank
sellspot = game:GetService("Workspace").SellingSpot.Collision
sellOrigCFrame = sellspot.CFrame

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

coal = false
batteries = false
wind = false
solar = false
oil = false
nuclear = false
corrodium = false
prestige = false
upgrade = false
sell = false
autofarm = false
autofarmgo = false

local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
	
local JetPackSimGUI = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='JetPackSimGUI', Parent=game.CoreGui})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.339563876, 0, 0.324749649, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 324, 0, 374),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = JetPackSimGUI})
local JPSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.DropShadow,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=0,ClipsDescendants=false,Draggable=true,Position=UDim2.new(-0.00012883544, 0, -0.00188835524, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 312, 0, 374),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=false,ZIndex=1,Name = 'JPSFrame',Parent = Frame})
local CoalBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coal',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157134, 0, 0.204689085, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='CoalBtn',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Jetpack Universe GUI',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.281272709, 0, -1.81552023e-05, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 128, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local BatteriesBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Batteries',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.332528532, 0, 0.204689085, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='BatteriesBtn',Parent = JPSFrame})
local WindBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Wind',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.659451663, 0, 0.204689085, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='WindBtn',Parent = JPSFrame})
local SolarBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Solar',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157357, 0, 0.311640948, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='SolarBtn',Parent = JPSFrame})
local OilBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Oil',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.332528561, 0, 0.311640948, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='OilBtn',Parent = JPSFrame})
local NuclearBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Nuclear',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.659451663, 0, 0.311640948, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='NuclearBtn',Parent = JPSFrame})
local CorrodiumBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Corrodium',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157134, 0, 0.418592811, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='CorrodiumBtn',Parent = JPSFrame})
local PrestigeBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Prestige',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157367, 0, 0.530892253, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='PrestigeBtn',Parent = JPSFrame})
local UpgradeBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Upgrade',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.332528561, 0, 0.530892253, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='UpgradeBtn',Parent = JPSFrame})
local SellBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Sell',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.659451783, 0, 0.530892253, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='SellBtn',Parent = JPSFrame})
local AutoFarmBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Auto Farm',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342924863, 0, 0.0890337229, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 83, 0, 22),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='AutoFarmBtn',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleports',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.126044244, 0, 0.638319254, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 218, 0, 18),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.188999996, 0, 0, -90),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.189269423, 0, 0.241655797, 0),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Farm',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.126044244, 0, 0.149014428, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 218, 0, 18),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local TpEarthBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Earth',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.00881058536, 0, 0.685972512, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpEarthBtn',Parent = JPSFrame})
local TpFloatingIslandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Floating Island',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.329323411, 0, 0.685972512, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpFloatingIslandBtn',Parent = JPSFrame})
local TpMoonBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Moon',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.656246543, 0, 0.685972512, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpMoonBtn',Parent = JPSFrame})
local TpCorroduisBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Corroduis',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.656246543, 0, 0.792924404, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpCorroduisBtn',Parent = JPSFrame})
local TpNeptuneBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Neptune',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.329323441, 0, 0.792924404, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpNeptuneBtn',Parent = JPSFrame})
local TpMarsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Mars',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.00881060772, 0, 0.792924404, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpMarsBtn',Parent = JPSFrame})
local TpUpgradeBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Upgrade',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.00881058536, 0, 0.899876237, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpUpgradeBtn',Parent = JPSFrame})
local ChestsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Chests',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.329323411, 0, 0.899876237, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='ChestsBtn',Parent = JPSFrame})
local OpenBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Close',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(1.36609697, 0, -0.609625518, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 73, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='OpenBtn',Parent = Frame})

OpenBtn.MouseButton1Click:connect(function()
    if JPSFrame.Visible == true then
        OpenBtn.Text = "Open"
        JPSFrame.Visible = false
    else
        OpenBtn.Text = "Close"
        JPSFrame.Visible = true
    end
end)

AutoFarmBtn.MouseButton1Click:connect(function()
    if autofarm == true then 
        autofarm = false 
        AutoFarmBtn.BackgroundColor3 = Color3.new(0, 0, 0)
        TurnOffBtns()
        sellspot.Transparency = .65
        sellspot.CFrame = sellOrigCFrame
    elseif autofarm == false then 
        autofarm = true
        AutoFarmBtn.BackgroundColor3 = Color3.new(0, 170, 0) 
        
    end
    AutoFarmFunc()
end)

CoalBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if coal == true then
        coal = false 
        CoalBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif coal == false then 
        coal = true 
        CoalBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Coal()
end)

BatteriesBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if batteries == true then 
        batteries = false 
        BatteriesBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif batteries == false then 
        batteries = true 
        BatteriesBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Batteries()
end)

SolarBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if solar == true then 
        solar = false 
        SolarBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif solar == false then 
        solar = true 
        SolarBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Solar()
end)

WindBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if wind == true then 
        wind = false 
        WindBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif wind == false then 
        wind = true 
        WindBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Wind()
end)

OilBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if oil == true then 
        oil = false 
        OilBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif oil == false then 
        oil = true 
        OilBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Oil()
end)

NuclearBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if nuclear == true then 
        nuclear = false 
        NuclearBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif nuclear == false then 
        nuclear = true 
        NuclearBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Nuclear()
end)

CorrodiumBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if corrodium == true then 
        corrodium = false 
        CorrodiumBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif corrodium == false then 
        corrodium = true 
        CorrodiumBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Corrodium()
end)

UpgradeBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if upgrade == true then 
        upgrade = false 
        UpgradeBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif upgrade == false then 
        upgrade = true 
        UpgradeBtn.BackgroundColor3 = Color3.new(0, 170, 0)        
    end
    Upgrade()
end)

SellBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if sell == true then 
        sell = false 
        SellBtn.BackgroundColor3 = Color3.new(0, 0, 0)        
    elseif sell == false then 
        sell = true 
        SellBtn.BackgroundColor3 = Color3.new(0, 170, 0)       
    end
    SellFunc()
end)

PrestigeBtn.MouseButton1Click:connect(function()
    if autofarm == true then return end
    if prestige == true then 
        prestige = false 
        PrestigeBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif prestige == false then 
        prestige = true 
        PrestigeBtn.BackgroundColor3 = Color3.new(0, 170, 0)
        game:GetService("ReplicatedStorage").ServerToClient.RequestPrestige:FireServer()
    end    
end)

TpEarthBtn.MouseButton1Click:connect(function()
    HRP.CFrame = WS.PortalSpawns.Earth.CFrame
end)

TpFloatingIslandBtn.MouseButton1Click:connect(function()
    HRP.CFrame = WS.PortalSpawns["Floating Island"].CFrame
end)

TpMoonBtn.MouseButton1Click:connect(function()
    HRP.CFrame = WS.PortalSpawns.Moon.CFrame
end)

TpMarsBtn.MouseButton1Click:connect(function()
    HRP.CFrame = WS.PortalSpawns.Mars.CFrame
end)

TpNeptuneBtn.MouseButton1Click:connect(function()
    HRP.CFrame = WS.PortalSpawns.Neptune.CFrame
end)

TpCorroduisBtn.MouseButton1Click:connect(function()
    HRP.CFrame = WS.PortalSpawns.Corrodius.CFrame
end)

TpUpgradeBtn.MouseButton1Click:connect(function()
    HRP.CFrame = WS.UpgradeSpot.Collision.CFrame
end)

ChestsBtn.MouseButton1Click:connect(function()
    for _,v in pairs(game:GetService("Workspace").DailyTreasures:GetChildren()) do 
        local g = v.Model:FindFirstChild("Collision")
        if g then 	
            HRP.CFrame = g.CFrame
            wait(.5)
        end
    end
end)

function SellFunc()   
    while sell == true do
        sellspot.Transparency = 1
        wait(.1)
        sellspot.CFrame = HRP.CFrame
        if sell == false then 
            sellspot.Transparency = .65
            sellspot.CFrame = sellOrigCFrame
        end
    end
end

function Upgrade()
    while upgrade == true do
        wait(.5)
        upgradejetpack:FireServer()
        upgradefueltank:FireServer()
    end
end

function Coal()
    while coal == true do
        bound = ARS.Earth.Coal.Coal:FindFirstChild("BOUNDS")
        wait()
        if bound then
            HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
        end        
    end
end

function Batteries()
    while batteries == true do       
        bound = ARS.Earth.Batteries.Batteries:FindFirstChild("BOUNDS")
        wait()
        if bound then
            HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
        end        
    end
end

function Wind()
    while wind == true do
        bound = ARS["Floating Island"]["Wind Turbine"]["Wind Turbine"]:FindFirstChild("BOUNDS")
        wait()
        if bound then
            HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
        end        
    end
end

function Solar()
    while solar == true do
        bound = ARS.Moon["Solar Panel"]["Solar Panel"]:FindFirstChild("BOUNDS")
        wait()
        if bound then
            HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
        end        
    end
end

function Oil()
    while oil == true do
        bound = ARS.Mars["Oil Barrel"]["Oil Barrel"]:FindFirstChild("BOUNDS")
        wait()
        if bound then
            HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
        end        
    end
end

function Nuclear()
    while nuclear == true do
        bound = ARS.Neptune["Nuclear Waste"]["Nuclear Waste"]:FindFirstChild("BOUNDS")
        wait()
        if bound then
            HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
        end        
    end
end

function Corrodium()
    while corrodium == true do
        bound = ARS.Corrodius["Corrodium"]["Corrodium"]:FindFirstChild("BOUNDS")
        wait()
        if bound then
            HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
        end        
    end
end

function AutoFarmFunc()      
    while autofarm == true do
        TurnOffBtns()
        local a = tonumber(jetpacklevel.Value)
        if autofarm == false then return end
        if a == 1 then --coal            
            bound = ARS.Earth.Coal.Coal:FindFirstChild("BOUNDS")
            wait()
            if bound then
                HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
            end            
        elseif  a == 2 then --batteries            
            bound = ARS.Earth.Batteries.Batteries:FindFirstChild("BOUNDS")
            wait()
            if bound then
                HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
            end            
        elseif  a == 3 then --wind           
            bound = ARS["Floating Island"]["Wind Turbine"]["Wind Turbine"]:FindFirstChild("BOUNDS")
            wait()
            if bound then
                HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
            end            
        elseif a == 4 then --solar            
            bound = ARS.Moon["Solar Panel"]["Solar Panel"]:FindFirstChild("BOUNDS")
            wait()
            if bound then
                HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
            end            
        elseif a == 5 then --oil           
            bound = ARS.Mars["Oil Barrel"]["Oil Barrel"]:FindFirstChild("BOUNDS")
            wait()
            if bound then
                HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
            end           
        elseif a == 6 then --nuclear   
            bound = ARS.Neptune["Nuclear Waste"]["Nuclear Waste"]:FindFirstChild("BOUNDS")
            wait()
            if bound then
                HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
            end            
        elseif a >= 7 then --corrodium           
            bound = ARS.Corrodius["Corrodium"]["Corrodium"]:FindFirstChild("BOUNDS")
            wait()
            if bound then
                HRP.CFrame = bound.CFrame + Vector3.new(0, 3, 0)
            end           
        else
            print("error in jetpack level")
            upgrade = false
            UpgradeBtn.BackgroundColor3 = Color3.new(0, 0, 0)                    
            sell = false
            SellBtn.BackgroundColor3 = Color3.new(0, 0, 0)
            wait()
        end
        upgradejetpack:FireServer()
        upgradefueltank:FireServer()
        sellspot.Transparency = 1
        sellspot.CFrame = HRP.CFrame    
    end
end

function TurnOffBtns()
    if coal == true then
        coal = false
        CoalBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if batteries == true then
        batteries = false
        BatteriesBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if wind == true then
        wind = false
        WindBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if solar == true then
        solar = false
        SolarBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if oil == true then
        oil = false
        OilBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if nuclear == true then
        nuclear = false
        NuclearBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if corrodium == true then
        corrodium = false
        CorrodiumBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if upgrade == true then
        upgrade = false
        UpgradeBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
    if sell == true then
        sell = false
        SellBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    end
end