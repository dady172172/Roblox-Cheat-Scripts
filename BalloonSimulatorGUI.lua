
farm = false
coins = false
gems = false
buybest = false

local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
	
local BalloonSimulatorGUI = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='BalloonSimulatorGUI', Parent=game.CoreGui})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.339563876, 0, 0.324749649, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 324, 0, 374),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = BalloonSimulatorGUI})
local JPSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.DropShadow,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=0,ClipsDescendants=false,Draggable=true,Position=UDim2.new(-0.000128852, 0, -0.00188833638, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 312, 0, 284),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=-1,Name = 'JPSFrame',Parent = Frame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Balloon Simulator GUI',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.281272709, 0, -1.81552023e-05, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 128, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local FarmBalloonsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Farm Balloons',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0408619568, 0, 0.196445763, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmBalloonsBtn',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.188999996, 0, 0, -110),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local FarmGemsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Farm Gems',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.649836302, 0, 0.196445763, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmGemsBtn',Parent = JPSFrame})
local FarmCoinsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Farm Coin',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342143983, 0, 0.196445793, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='FarmCoinsBtn',Parent = JPSFrame})
local BuyBestBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Buy Best',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0408619568, 0, 0.307548434, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='BuyBestBtn',Parent = JPSFrame})
local RebirthBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Rebirth',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342143983, 0, 0.307548434, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='RebirthBtn',Parent = JPSFrame})
local TpChestsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Collect Chests',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.649836302, 0, 0.307548434, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpChestsBtn',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.188999996, 0, 0, -30),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ImageLabel',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleports',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.274862438, 0, 0.408432573, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 128, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TextLabel',Parent = JPSFrame})
local TpSkylandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Skyland',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0440670848, 0, 0.49926272, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpSkylandBtn',Parent = JPSFrame})
local TpTropicalParadiseBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Tropical Paradise',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.345349163, 0, 0.49926272, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpTropicalParadiseBtn',Parent = JPSFrame})
local TpAncientGreeceBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Ancient Greece',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.653041422, 0, 0.49926272, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpAncientGreeceBtn',Parent = JPSFrame})
local TpToyLandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Toyland',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.653041422, 0, 0.597854257, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpToyLandBtn',Parent = JPSFrame})
local TpArchervilleBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Archerville',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.345349163, 0, 0.597854257, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpArchervilleBtn',Parent = JPSFrame})
local TpCandylandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='CandyLand',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0440670848, 0, 0.597854257, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpCandylandBtn',Parent = JPSFrame})
local TpRobolandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Roboland',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.653041422, 0, 0.703487992, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpRobolandBtn',Parent = JPSFrame})
local TpDinolandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Dinoland',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.345349163, 0, 0.703488111, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpDinolandBtn',Parent = JPSFrame})
local TpAlienlandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Alienland',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0440670848, 0, 0.703487992, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpAlienlandBtn',Parent = JPSFrame})
local TpDragonworldBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Dragonworld',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0440670848, 0, 0.900671065, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpDragonworldBtn',Parent = JPSFrame})
local TpAqualandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Aqualand',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.345349163, 0, 0.809121907, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpAqualandBtn',Parent = JPSFrame})
local TpAquaWorldBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Aquaworld',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0440670848, 0, 0.809121788, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpAquaWorldBtn',Parent = JPSFrame})
local TpDragonlandBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Dragonland',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.345349163, 0, 0.900671184, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=2,Name='TpDragonlandBtn',Parent = JPSFrame})
local OpenBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Close',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(1.36609697, 0, -0.609625518, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 73, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='OpenBtn',Parent = Frame})


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

FarmCoinsBtn.MouseButton1Click:connect(function()
    if coins == true then coins = false print("Disabled")
        FarmCoinsBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif coins == false then coins = true print("Enabled")
        FarmCoinsBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    CoinsFunc()
end)

FarmGemsBtn.MouseButton1Click:connect(function()
    if gems == true then gems = false print("Disabled")
        FarmGemsBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif gems == false then gems = true print("Enabled")
        FarmGemsBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    GemsFunc()
end)

FarmBalloonsBtn.MouseButton1Click:connect(function()
    if farm == true then farm = false print("Disabled")
        FarmBalloonsBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif farm == false then farm = true print("Enabled")
        FarmBalloonsBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    BalloonFunc()
end)

BuyBestBtn.MouseButton1Click:connect(function()
    if buybest == true then buybest = false print("Disabled")
        BuyBestBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif buybest == false then buybest = true print("Enabled")
        BuyBestBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    BuyBestFunc()
end)

RebirthBtn.MouseButton1Click:connect(function()
    local v = CFrame.new(238.250473, 63362.6172, 1982.33765, -0.971987963, -9.69758247e-08, 0.235030681, -9.92992568e-08, 1, 1.94930538e-09, -0.235030681, -2.144367e-08, -0.971987963)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v
    wait(.00001)
    game:GetService("ReplicatedStorage").Rebirth:InvokeServer()
end)

TpChestsBtn.MouseButton1Click:connect(function()
    local PlrLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    for _,v in pairs(game:GetService("Workspace").Chests:GetChildren()) do
        wait(.1)
       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
    end
    wait(.1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
end)

TpTropicalParadiseBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Tropical Paradise"].CFrame
end)

TpCandylandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Candyland"].CFrame
end)

TpArchervilleBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Archerville"].CFrame
end)

TpAncientGreeceBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Ancient Greece"].CFrame
end)

TpSkylandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Skyland"].CFrame
end)

TpToyLandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Toyland"].CFrame
end)

TpAlienlandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Alienland"].CFrame
end)

TpDinolandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Dinoland"].CFrame
end)

TpRobolandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Roboland"].CFrame
end)

TpDragonworldBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations.Dragoworld.CFrame
end)

TpDragonlandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations.Dragoland.CFrame
end)

TpAquaWorldBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Aquaworld"].CFrame
end)

TpAqualandBtn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Destinations["Aqualand"].CFrame
end)

function CoinsFunc()
    while coins == true do
        for _,v in pairs(game:GetService("Workspace").Coins:GetChildren()) do	
            if coins == false then return end
            if v.Transparency == 0 then
                local LSave = v.CFrame
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait(.1)
                v.CFrame = LSave
                v.Transparency = 1
            else
            end
        end
    end
end


function GemsFunc()
    while gems == true do
        for _,v in pairs(game:GetService("Workspace").Gems:GetChildren()) do
            if gems == false then return end
            if v.Transparency == 0 then
                local LSave = v.CFrame
                v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait(.1)
                v.CFrame = LSave
                v.Transparency = 1
            else
            end
        end
    end
end

function BalloonFunc()
    while farm == true do
        wait()
        game.ReplicatedStorage.FillBalloon:FireServer()
        game.ReplicatedStorage.FillBalloon:FireServer()
        game.ReplicatedStorage.FillBalloon:FireServer()
        game.ReplicatedStorage.FillBalloon:FireServer()
        local v = Workspace.UITriggers.Sell
        game.ReplicatedStorage.Sell:FireServer(v)
    end
end

function BuyBestFunc()
    local plr = game.Players.LocalPlayer.Name
    while buybest == true do
        
        local found = game:GetService("Players")[plr].OwnedBalloons:FindFirstChild("Gumball")
        local found1 = game:GetService("Players")[plr].OwnedHelium:FindFirstChild("Bubblegum")
        if not found then
            game.ReplicatedStorage.BuyHelium:InvokeServer("Bubblegum")
            game.ReplicatedStorage.EquipHelium:FireServer("Bubblegum")
        end
        if not found1 then
            game.ReplicatedStorage.BuyBalloon:InvokeServer("Gumball")
            game.ReplicatedStorage.EquipBalloon:FireServer("Gumball")
        end
        wait(.1)
    end
end


function tpDestination(name)
    for _,v in pairs(game:GetService("Workspace").Destinations:GetChildren()) do
        if v.Name == name then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v[name].CFrame
            return
        end
    end
end


