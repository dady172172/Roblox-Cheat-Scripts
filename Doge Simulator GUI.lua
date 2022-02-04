--[[
Game : https://www.roblox.com/games/3072491551
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
load string in case you want it ===  loadstring(game:HttpGet("https://pastebin.com/raw/bPFJrgK6", true))()
]]--
local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)


zone1 = false
zone2 = false
zone3 = false
zone4 = false
zone5 = false
zone6 = false
zone7 = false
zone8 = false
zone9 = false
zone10 = false
space1 = false
space2 = false
rebirthfarm = false
autoquest = false
farmbarks = true
	
local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
	
	
local DogeSimGUI = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='DogeSimGUI', Parent=game.CoreGui})
local DogeSimFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0.15000000596046,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.689893484, 0, 0.639526188, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 398, 0, 227),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'DogeSimFrame',Parent = DogeSimGUI})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, -0.104803495, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 398, 0, 24),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = DogeSimFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Doge Simulator',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.324120611, 0, -0.131004363, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 140, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = DogeSimFrame})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0.99999994, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 398, 0, 24),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = DogeSimFrame})
local FarmZoneBtn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -9, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='FarmZoneBtn',Parent = Frame})
local FarmRebirthsBtn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Rebiths',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -7.25, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='FarmRebirthsBtn',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -3.66666627, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local AutoClaimQuesetsBtn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Auto Claim Quests',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -5.41666651, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='AutoClaimQuesetsBtn',Parent = Frame})
local TPSpawnBtn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='TP Spawn',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -1.95833313, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPSpawnBtn',Parent = Frame})
local FarmBarksBtn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Barks',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -8.91666698, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='FarmBarksBtn',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -7.16666651, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -3.58333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -5.33333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local RunSpeed100Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Run Speed 100',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -1.87499976, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='RunSpeed100Btn',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -8.91666698, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -7.16666651, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -3.58333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local empty = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='empty',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -5.33333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='empty',Parent = Frame})
local TextButton = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Script',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0.0980392, 0.117647),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -1.87499976, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextButton',Parent = Frame})
local FarmZoneFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0.15000000596046,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.689893484, 0, 0.639526188, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 398, 0, 227),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=false,ZIndex=1,Name = 'FarmZoneFrame',Parent = DogeSimGUI})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, -0.104803495, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 398, 0, 24),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = FarmZoneFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.324120611, 0, -0.131004363, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 140, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = FarmZoneFrame})
local Frame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 0, 0),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0.99999994, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 398, 0, 24),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'Frame',Parent = FarmZoneFrame})
local Zone1Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 1',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -9, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone1Btn',Parent = Frame})
local Zone4Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 4',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -7.25, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone4Btn',Parent = Frame})
local Zone10Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 10',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -3.66666627, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone10Btn',Parent = Frame})
local Zone7Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 7',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -5.41666651, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone7Btn',Parent = Frame})
local TPSpawn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='TP Spawn',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0351758786, 0, -1.95833313, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPSpawn',Parent = Frame})
local Zone2Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 2',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -8.91666698, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone2Btn',Parent = Frame})
local Zone5Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 5',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -7.16666651, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone5Btn',Parent = Frame})
local SpaceZone1Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm space 1',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -3.58333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='SpaceZone1Btn',Parent = Frame})
local Zone8Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 8',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -5.33333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone8Btn',Parent = Frame})
local RunSpeed100Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Run Speed 100',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.356783926, 0, -1.87499976, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='RunSpeed100Btn',Parent = Frame})
local Zone3Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 3',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -8.91666698, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone3Btn',Parent = Frame})
local Zone6Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 6',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -7.16666651, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone6Btn',Parent = Frame})
local SpaceZone2Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Space 2',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -3.58333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='SpaceZone2Btn',Parent = Frame})
local Zone9Btn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Farm Zone 9',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -5.33333302, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Zone9Btn',Parent = Frame})
local BackBtn = CreateInstance('TextButton',{Font=Enum.Font.SciFi,FontSize=Enum.FontSize.Size14,Text='Back',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0.0980392, 0.117647),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.675879359, 0, -1.87499976, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 115, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='BackBtn',Parent = Frame})




Zone1Btn.MouseButton1Click:connect(function()
    if zone1 == true then zone1 = false print("Disabled")
        Zone1Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone1 == false then zone1 = true print("Enabled")
        Zone1Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone1func(game:GetService("Workspace").Coins.Coin1)
end)

Zone2Btn.MouseButton1Click:connect(function()
    if zone2 == true then zone2 = false print("Disabled")
        Zone2Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone2 == false then zone2 = true print("Enabled")
        Zone2Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone2func(game:GetService("Workspace").Coins.Coin2)
end)


Zone3Btn.MouseButton1Click:connect(function()
    if zone3 == true then zone3 = false print("Disabled")
        Zone3Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone3 == false then zone3 = true print("Enabled")
        Zone3Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone3func(game:GetService("Workspace").Coins.Coin3)
end)

Zone4Btn.MouseButton1Click:connect(function()
    if zone4 == true then zone4 = false print("Disabled")
        Zone4Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone4 == false then zone4 = true print("Enabled")
        Zone4Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone4func(game:GetService("Workspace").Coins.Coin4)
end)

Zone5Btn.MouseButton1Click:connect(function()
    if zone5 == true then zone5 = false print("Disabled")
        Zone5Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone5 == false then zone5 = true print("Enabled")
        Zone5Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone5func(game:GetService("Workspace").Coins.Chest1F, game:GetService("Workspace").Coins.Chest1)
end)

Zone6Btn.MouseButton1Click:connect(function()
    if zone6 == true then zone6 = false print("Disabled")
        Zone6Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone6 == false then zone6 = true print("Enabled")
        Zone6Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone6func(game:GetService("Workspace").Coins.Chest2)
end)

Zone7Btn.MouseButton1Click:connect(function()
    if zone7 == true then zone7 = false print("Disabled")
        Zone7Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone7 == false then zone7 = true print("Enabled")
        Zone7Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone7func(game:GetService("Workspace").Coins.Chest3)
end)

Zone8Btn.MouseButton1Click:connect(function()
    if zone8 == true then zone8 = false print("Disabled")
        Zone8Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone8 == false then zone8 = true print("Enabled")
        Zone8Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone8func(game:GetService("Workspace").Coins.Diamond1)
end)

Zone9Btn.MouseButton1Click:connect(function()
    if zone9 == true then zone9 = false print("Disabled")
        Zone9Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone9 == false then zone9 = true print("Enabled")
        Zone9Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone9func(game:GetService("Workspace").Coins.Diamond2)
end)

Zone10Btn.MouseButton1Click:connect(function()
    if zone10 == true then zone10 = false print("Disabled")
        Zone10Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        zone10 == false then zone10 = true print("Enabled")
        Zone10Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    zone10func(game:GetService("Workspace").Coins.Diamond3)
end)

SpaceZone1Btn.MouseButton1Click:connect(function()
    if space1 == true then space1 = false print("Disabled")
        SpaceZone1Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        space1 == false then space1 = true print("Enabled")
        SpaceZone1Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end
    space1func(game:GetService("Workspace").Coins.Space1)
end)

SpaceZone2Btn.MouseButton1Click:connect(function()
    if space2 == true then space2 = false print("Disabled")
        SpaceZone2Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        space2 == false then space2 = true print("Enabled")
        SpaceZone2Btn.BackgroundColor3 = Color3.new(0, 200, 200)
    end    
    space2func(game:GetService("Workspace").Coins.Space2)  
end)

TPSpawn.MouseButton1Click:connect(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").SpawnLocation.CFrame
end)

RunSpeed100Btn.MouseButton1Click:connect(function()
    local plr = game.Players.LocalPlayer.Name
    game:GetService("Workspace")[plr].Humanoid.WalkSpeed = 100
end)

FarmZoneBtn.MouseButton1Click:connect(function()
    game:GetService("CoreGui").DogeSimGUI.DogeSimFrame.Visible = false
    game:GetService("CoreGui").DogeSimGUI.FarmZoneFrame.Visible = true
end)

BackBtn.MouseButton1Click:connect(function()
    game:GetService("CoreGui").DogeSimGUI.DogeSimFrame.Visible = true
    game:GetService("CoreGui").DogeSimGUI.FarmZoneFrame.Visible = false
end)

FarmRebirthsBtn.MouseButton1Click:connect(function()
    if rebirthfarm == true then rebirthfarm = false print("Disabled")
        FarmRebirthsBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        rebirthfarm == false then rebirthfarm = true print("Enabled")
        FarmRebirthsBtn.BackgroundColor3 = Color3.new(0, 200, 200)
    end 
    rebirthFarm()
end)

AutoClaimQuesetsBtn.MouseButton1Click:connect(function()
    if autoquest == true then autoquest = false print("Disabled")
        AutoClaimQuesetsBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        autoquest == false then autoquest = true print("Enabled")
        AutoClaimQuesetsBtn.BackgroundColor3 = Color3.new(0, 200, 200)
    end 
    autoQuest()
end)

FarmBarksBtn.MouseButton1Click:connect(function()
    if farmbarks == true then farmbarks = false print("Disabled")
        FarmBarksBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        farmbarks == false then farmbarks = true print("Enabled")
        FarmBarksBtn.BackgroundColor3 = Color3.new(0, 200, 200)
    end 
    farmBarks()
end)



function zone1func(path)
    while zone1 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone2func(path)
    while zone2 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone3func(path)
    while zone3 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone4func(path)
    while zone4 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone5func(path, path2)
    while zone5 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
        if path2 ~= nil then
            for _,v in pairs(path2:GetChildren()) do
                wait(.1)
                if stop == true then
                    return
                end
                v.CanCollide = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
    end
end

function zone6func(path)
    while zone6 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone7func(path)
    while zone7 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone8func(path)
    while zone8 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone9func(path)
    while zone9 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function zone10func(path)
    while zone10 == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function space1func(path)
    while zone == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function space2func(path)
    while zone == true do
        for _,v in pairs(path:GetChildren()) do
            wait(.1)
            if stop == true then
                return
            end
            v.CanCollide = false
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
        end
    end
end

function rebirthFarm()
    
    while rebirthfarm == true do       
        wait(.8)
        local virtualUser = game:GetService('VirtualUser')
        virtualUser:CaptureController()
        wait(0.116159)
        virtualUser:SetKeyUp('0x11a')
        wait(0.399961)
        virtualUser:Button1Down(Vector2.new(-0.0, -0.0), CFrame.new(-0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0))
        virtualUser:SetKeyDown('0x11a')   
        local plr = game.Players.LocalPlayer.Name
        local barks = game:GetService("Players")[plr].leaderstats.Barks.Value
        local str = game:GetService("Players")[plr].PlayerGui.Rebirth.Frame.Frame.Frame.TextLabel.Text
        local rebirthForAmount = string.match(str, "%d+")
        if tonumber(barks) >= tonumber(rebirthForAmount) then
            game:GetService("ReplicatedStorage").RebirthEvent:FireServer()
        end
    end
    
end

function autoQuest()
    while autoquest == true do
		wait(.8)
		game.ReplicatedStorage.Award1:FireServer()
		game.ReplicatedStorage.Award2:FireServer()
		game.ReplicatedStorage.Award3:FireServer()
	end
    
end

function farmBarks()
    while farmbarks == true do
        wait(.8)
        local virtualUser = game:GetService('VirtualUser')
        virtualUser:CaptureController()
        wait(0.116159)
        virtualUser:SetKeyUp('0x11a')
        wait(0.399961)
        virtualUser:Button1Down(Vector2.new(-0.0, -0.0), CFrame.new(-0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0))
        virtualUser:SetKeyDown('0x11a')
    end
end