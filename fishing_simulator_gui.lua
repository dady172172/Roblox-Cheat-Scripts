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
	
local FishingSimulatorGUI  = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='FishingSimulatorGUI ', Parent=game.CoreGui})
local FSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=true,Position=UDim2.new(0.800623059, 0, 0.587982833, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 272),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'FSFrame',Parent = FishingSimulatorGUI })
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size24,Text='Fishing Simulator GUI',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=20,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0.666667, 0.666667),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 34),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = FSFrame})
local AutoFishBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Auto Fish',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.161484554, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='AutoFishBtn',Parent = FSFrame})
local TeleFishingSpotBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Fishing Area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.233575702, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TeleFishingSpotBtn',Parent = FSFrame})
local TPRodShopBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Rod Shop',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.305666655, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPRodShopBtn',Parent = FSFrame})
local TPBackpackShopBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP BackpackShopBtn',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.377758443, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPBackpackShopBtn',Parent = FSFrame})
local farm = false
AutoFishBtn.MouseButton1Click:connect(function()
    if farm == true then farm = false print("Disabled")
        AutoFishBtn.BackgroundColor3 = Color3.new(.5, 0, 0)
    elseif farm == false then farm = true print("Enabled")
        AutoFishBtn.BackgroundColor3 = Color3.new(0, .5, 0)
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