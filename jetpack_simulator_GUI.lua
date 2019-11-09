--Game = https://www.roblox.com/games/2662100821/Jetpack-Simulator
--Image = https://prnt.sc/pu27iu
--Updated = 11-8-19
--Creator = dady172172
--https://github.com/dady172172/Roblox-Cheats

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

coal = false
battery = false
solar = false
wind = false
nuclear = false
plasma = false
aetherium = false
corrodium = false
element99 = false
galacticium = false
magmatium = false
lightningorb = false
prestige = false
jetpackupgrade = false
fuelupgrade = false
autofarm = false

game:GetService("Players").keathunsar.PlayerGui.MainGUI.FullFuelFrame.Visible = false
game:GetService("Players").keathunsar.PlayerGui.MainGUI.NotEnoughMoneyFrame.Visible = false
game:GetService("Players").keathunsar.PlayerGui.MainGUI.PrestigeFrame.Visible = false

local jpData = game.ReplicatedStorage.DataFolder:WaitForChild(game.Players.LocalPlayer.Name):WaitForChild("JetpackData")
local mf = jpData.MaxFuel
_G.MaxSize = mf.Value .. "/" .. mf.Value --Change this to your max fuel inventory/size

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
local CoalBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Coal',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157134, 0, 0.204689085, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='CoalBtn',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Jet Pack Simulator GUI',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.281272709, 0, -1.81552023e-05, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 128, 0, 25),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = JPSFrame})
local BatteryBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Battery',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.332528532, 0, 0.204689085, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='BatteryBtn',Parent = JPSFrame})
local SolarBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Solar',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.659451663, 0, 0.204689085, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='SolarBtn',Parent = JPSFrame})
local WindBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Wind',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157357, 0, 0.311640948, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='WindBtn',Parent = JPSFrame})
local NuclearBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Nuclear',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.332528561, 0, 0.311640948, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='NuclearBtn',Parent = JPSFrame})
local PlasmaBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Plasma',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.659451663, 0, 0.311640948, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='PlasmaBtn',Parent = JPSFrame})
local Element99Btn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Element 99',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.659451723, 0, 0.418592811, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='Element99Btn',Parent = JPSFrame})
local CorrodiumBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Corrodium',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.335733682, 0, 0.418592811, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='CorrodiumBtn',Parent = JPSFrame})
local AetheriumBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Aetherium',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157134, 0, 0.418592811, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='AetheriumBtn',Parent = JPSFrame})
local GalacticiumBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Galacticium',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0120157357, 0, 0.525544703, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='GalacticiumBtn',Parent = JPSFrame})
local MagmatiumBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Magmatium',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.335733682, 0, 0.525544703, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='MagmatiumBtn',Parent = JPSFrame})
local LightningOrbBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Lightning Orb',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.659451723, 0, 0.525544703, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='LightningOrbBtn',Parent = JPSFrame})
local PrestigeBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Prestige',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0248362496, 0, 0.798271954, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='PrestigeBtn',Parent = JPSFrame})
local FuelUpgradeBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Fuel Upgrade',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.348554194, 0, 0.798271954, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='FuelUpgradeBtn',Parent = JPSFrame})
local JetpackUpgradeBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Jetpack Upgrade',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.672272265, 0, 0.798271954, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 89, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='JetpackUpgradeBtn',Parent = JPSFrame})
local AutoFarmBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Auto Farm',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.342924863, 0, 0.0890337229, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 83, 0, 22),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='AutoFarmBtn',Parent = JPSFrame})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='These only work while above is active and one time on activation.',TextColor3=Color3.new(1, 1, 1),TextScaled=true,TextSize=14,TextStrokeColor3=Color3.new(1, 1, 1),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.0346699283, 0, 0.709321856, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 273, 0, 31),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.176358148, 0, -0.249885708, 0),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=0,Name='ImageLabel',Parent = JPSFrame})
local ImageLabel = CreateInstance('ImageLabel',{Image='rbxassetid://38727848',ImageColor3=Color3.new(1, 1, 1),ImageRectOffset=Vector2.new(0, 0),ImageRectSize=Vector2.new(0, 0),ImageTransparency=0,ScaleType=Enum.ScaleType.Crop,SliceCenter=Rect.new(0, 0, 0, 0),Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(1, 1, 1),BackgroundTransparency=1,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.189269423, 0, 0.241655797, 0),Rotation=90,Selectable=false,Size=UDim2.new(0, 183, 0, 303),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=0,Name='ImageLabel',Parent = JPSFrame})
local OpenBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Open',TextColor3=Color3.new(1, 1, 1),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(1.36609697, 0, -0.609625518, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 73, 0, 30),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='OpenBtn',Parent = Frame})

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
    if autofarm == true then autofarm = false print("Disabled")
        AutoFarmBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        autofarm == false then autofarm = true print("Enabled")
        AutoFarmBtn.BackgroundColor3 = Color3.new(0, 170, 0)
        AutoFarmFunc()
    end
end)

CoalBtn.MouseButton1Click:connect(function()
    if coal == true then coal = false print("Disabled")
        CoalBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        coal == false then coal = true print("Enabled")
        CoalBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Coal()
end)

BatteryBtn.MouseButton1Click:connect(function()
    if battery == true then battery = false print("Disabled")
        BatteryBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        battery == false then battery = true print("Enabled")
        BatteryBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Battery()
end)

SolarBtn.MouseButton1Click:connect(function()
    if solar == true then solar = false print("Disabled")
        SolarBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        solar == false then solar = true print("Enabled")
        SolarBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Solar()
end)

WindBtn.MouseButton1Click:connect(function()
    if wind == true then wind = false print("Disabled")
        WindBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        wind == false then wind = true print("Enabled")
        WindBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Wind()
end)

NuclearBtn.MouseButton1Click:connect(function()
    if nuclear == true then nuclear = false print("Disabled")
        NuclearBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        nuclear == false then nuclear = true print("Enabled")
        NuclearBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Nuclear()
end)

PlasmaBtn.MouseButton1Click:connect(function()
    if plasma == true then plasma = false print("Disabled")
        PlasmaBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        plasma == false then plasma = true print("Enabled")
        PlasmaBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Plasma()
end)

AetheriumBtn.MouseButton1Click:connect(function()
    if aetherium == true then aetherium = false print("Disabled")
        AetheriumBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        aetherium == false then aetherium = true print("Enabled")
        AetheriumBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Aetherium()
end)

CorrodiumBtn.MouseButton1Click:connect(function()
    if corrodium == true then corrodium = false print("Disabled")
        CorrodiumBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        corrodium == false then corrodium = true print("Enabled")
        CorrodiumBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Corrodium()
end)

Element99Btn.MouseButton1Click:connect(function()
    if element99 == true then element99 = false print("Disabled")
        Element99Btn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        element99 == false then element99 = true print("Enabled")
        Element99Btn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Element99()
end)

GalacticiumBtn.MouseButton1Click:connect(function()
    if galacticium == true then galacticium = false print("Disabled")
        GalacticiumBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        galacticium == false then galacticium = true print("Enabled")
        GalacticiumBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Galacticium()
end)

MagmatiumBtn.MouseButton1Click:connect(function()
    if magmatium == true then magmatium = false print("Disabled")
        MagmatiumBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        magmatium == false then magmatium = true print("Enabled")
        MagmatiumBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    Magmatium()
end)

LightningOrbBtn.MouseButton1Click:connect(function()
    if lightningorb == true then lightningorb = false print("Disabled")
        LightningOrbBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        lightningorb == false then lightningorb = true print("Enabled")
        LightningOrbBtn.BackgroundColor3 = Color3.new(0, 170, 0)
    end
    LightningOrb()
end)

FuelUpgradeBtn.MouseButton1Click:connect(function()
    if fuelupgrade == true then fuelupgrade = false print("Disabled")
        FuelUpgradeBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        fuelupgrade == false then fuelupgrade = true print("Enabled")
        FuelUpgradeBtn.BackgroundColor3 = Color3.new(0, 170, 0)
        game:GetService("ReplicatedStorage").ClientToServer.PurchaseFuelUpgrade:FireServer()
    end
    FuelUpgrade()
end)

JetpackUpgradeBtn.MouseButton1Click:connect(function()
    if jetpackupgrade == true then jetpackupgrade = false print("Disabled")
        JetpackUpgradeBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        jetpackupgrade == false then jetpackupgrade = true print("Enabled")
        JetpackUpgradeBtn.BackgroundColor3 = Color3.new(0, 170, 0)
        game:GetService("ReplicatedStorage").ClientToServer.PurchaseJetpackUpgrade:FireServer()
    end
    JetpackUpgrade()
end)

PrestigeBtn.MouseButton1Click:connect(function()
    if prestige == true then prestige = false print("Disabled")
        PrestigeBtn.BackgroundColor3 = Color3.new(0, 0, 0)
    elseif
        prestige == false then prestige = true print("Enabled")
        PrestigeBtn.BackgroundColor3 = Color3.new(0, 170, 0)
        game:GetService("ReplicatedStorage").ServerToClient.RequestPrestige:FireServer()
    end
    
end)

function update()
	_G.MaxSize = mf.Value .. "/" .. mf.Value
end

function sell()
    if game.Players.LocalPlayer.PlayerGui.MainGUI.FuelDisplay.TextLabel.Text == _G.MaxSize then 
       wait(.1)
       game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.2047, 3.32, -3.3)
       wait(.8)
       if prestige == true then game:GetService("ReplicatedStorage").ServerToClient.RequestPrestige:FireServer() end
    end
end

function Upgrade()
    if jetpackupgrade == true then game:GetService("ReplicatedStorage").ClientToServer.PurchaseJetpackUpgrade:FireServer() end
    if fuelupgrade == true then game:GetService("ReplicatedStorage").ClientToServer.PurchaseFuelUpgrade:FireServer() end
end

function Coal()
    while coal == true do
        update()
        wait()
        local coalarea = game.workspace.Areas.Area1:FindFirstChild("Coal")
        if coalarea then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = coalarea.Coal.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Battery()
    while battery == true do
        update()
        wait()
        local batteryarea = game.workspace.Areas.Area2:FindFirstChild("Battery")
        if batteryarea then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = batteryarea.Battery.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Solar()
    while solar == true do
        update()
        wait()
        local v = game.workspace.Areas.Area2:FindFirstChild("Solar")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Solar.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Wind()
    while wind == true do
        update()
        wait()
        local v = game.workspace.Areas.Area4:FindFirstChild("Wind")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Wind.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Nuclear()
    while nuclear == true do
        update()
        wait()
        local v = game.workspace.Areas.Area7:FindFirstChild("Nuclear")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Nuclear.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Plasma()
    while plasma == true do
        update()
        wait()
        local v = game.workspace.Areas.Area7:FindFirstChild("Plasma")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Plasma.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Aetherium()
    while aetherium == true do
        update()
        wait()
        local v = game.workspace.Areas.Area11:FindFirstChild("Aetherium")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Aetherium.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Corrodium()
    while corrodium == true do
        update()
        wait()
        local v = game.workspace.Areas.Area13:FindFirstChild("Corrodium")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Corrodium.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Element99()
    while element99 == true do
        update()
        wait()
        local v = game.workspace.Areas.Area13:FindFirstChild("Element 99")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v["Element 99"].HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Galacticium()
    while galacticium == true do
        update()
        wait()
        local v = game.workspace.Areas.Area15:FindFirstChild("Galacticium")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Galacticium.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function Magmatium()
    while magmatium == true do
        update()
        wait()
        local v = game.workspace.Areas.Area17:FindFirstChild("Magmatium")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Magmatium.HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end

function LightningOrb()
    while lightningorb == true do
        update()
        wait()
        local v = game.workspace.Areas.Area19:FindFirstChild("Lightning Orb")
        if v then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v["Lightning Orb"].HitPart.CFrame
        end
        sell()
        Upgrade()
    end
end


function AutoFarmFunc()
    while autofarm == true do
        local a = game:GetService("ReplicatedStorage").DataFolder.keathunsar.JetpackData.EnergyLevel.Value
        if a == 1 then
            update()
            wait()
            local coalarea = game.workspace.Areas.Area1:FindFirstChild("Coal")
            if coalarea then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = coalarea.Coal.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif  a == 2 then 
            update()
            wait()
            local batteryarea = game.workspace.Areas.Area2:FindFirstChild("Battery")
            if batteryarea then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = batteryarea.Battery.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif  a == 3 then
            update()
            wait()
            local v = game.workspace.Areas.Area2:FindFirstChild("Solar")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Solar.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 4 then
            update()
            wait()
            local v = game.workspace.Areas.Area4:FindFirstChild("Wind")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Wind.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 5 then
            update()
            wait()
            local v = game.workspace.Areas.Area7:FindFirstChild("Nuclear")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Nuclear.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 6 then
            update()
            wait()
            local v = game.workspace.Areas.Area7:FindFirstChild("Plasma")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Plasma.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 7 then
            update()
            wait()
            local v = game.workspace.Areas.Area11:FindFirstChild("Aetherium")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Aetherium.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 8 then
            update()
            wait()
            local v = game.workspace.Areas.Area13:FindFirstChild("Corrodium")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Corrodium.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 9 then
            update()
            wait()
            local v = game.workspace.Areas.Area13:FindFirstChild("Element 99")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v["Element 99"].HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 10 then
            update()
            wait()
            local v = game.workspace.Areas.Area15:FindFirstChild("Galacticium")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Galacticium.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 11 then
            update()
            wait()
            local v = game.workspace.Areas.Area17:FindFirstChild("Magmatium")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Magmatium.HitPart.CFrame
            end
            sell()
            Upgrade()
        elseif a == 12 then
            update()
            wait()
            local v = game.workspace.Areas.Area19:FindFirstChild("Lightning Orb")
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v["Lightning Orb"].HitPart.CFrame
            end
            sell()
            Upgrade()
        else
            print("error in jetpack level")
            return
        end
    end
end