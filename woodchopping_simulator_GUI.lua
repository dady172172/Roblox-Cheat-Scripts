--https://github.com/dady172172/Roblox-Cheats
--Counted 12 (objects this time!!!)
local CurLocation = "Nothing"
local function CreateInstance(cls,props)
local inst = Instance.new(cls)
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
	
local WoodchoppingSimulatorGui = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='WoodchoppingSimulatorGui', Parent=game.CoreGui})
local WCSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=true,Position=UDim2.new(0.800623059, 0, 0.587982833, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 272),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'WCSFrame',Parent = WoodchoppingSimulatorGui})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size24,Text='Woodchopping Simulator GUI',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=20,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0.666667, 0.666667),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 34),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = WCSFrame})
local ItemsBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Items/Tools',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.161484554, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='ItemsBtn',Parent = WCSFrame})
local GiveCargoShipBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Give Cargo Ship',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.233575702, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='GiveCargoShipBtn',Parent = WCSFrame})
local GiveDumpTruckBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Give Dump Truck',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.305666655, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='GiveDumpTruckBtn',Parent = WCSFrame})
local TeleSellBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleport to sell area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.377758443, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TeleSellBtn',Parent = WCSFrame})
local TeleChestSellBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleport to chest then sell area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.449849516, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TeleChestSellBtn',Parent = WCSFrame})
local TeleChests = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleport to chests',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.673476636, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TeleChests',Parent = WCSFrame})
local TeleSpawnBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleport Spawn/Town',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.59403187, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TeleSpawnBtn',Parent = WCSFrame})
local TeleTreesBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleport to best trees',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.521941483, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TeleTreesBtn',Parent = WCSFrame})
local TeleBackBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Teleport back',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.749244273, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TeleBackBtn',Parent = WCSFrame})
local WalkBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Walk Speed 30',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.822773695, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='WalkBtn',Parent = WCSFrame})

ItemsBtn.MouseButton1Click:connect(function()
    --BACKPACK
    local backpack = "Backpack6"
    local price= 0
    local Event = game:GetService("ReplicatedStorage").GlobalEvents.BackpackBuy
    Event:FireServer(backpack, price)
    Wait(1)

    --TOOL
    local tool = "Katana"
    local price= 0
    local Event = game:GetService("ReplicatedStorage").GlobalEvents.ToolBuy
    Event:FireServer(tool, price)
    Wait(1)

    --PET
    local Pet = "Pet11"
    local price= 0
    local Event = game:GetService("ReplicatedStorage").GlobalEvents.PetBuy
    Event:FireServer(Pet, price)
end)
GiveCargoShipBtn.MouseButton1Click:connect(function()
    local Vehicle = "Cargo Ship"
    local price= 0
    local Event = game:GetService("ReplicatedStorage").GlobalEvents.BoatBuy
    Event:FireServer(Vehicle, price)
end)
GiveDumpTruckBtn.MouseButton1Click:connect(function()
    local Vehicle = "Dump Truck"
    local price= 0
    local Event = game:GetService("ReplicatedStorage").GlobalEvents.VehicleBuy
    Event:FireServer(Vehicle, price)
end)
TeleSellBtn.MouseButton1Click:connect(function()
CurLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").SellTP.CFrame
end)
TeleChestSellBtn.MouseButton1Click:connect(function()
CurLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    for _,g in pairs(Workspace:GetChildren()) do
        if string.match(g.Name, "Chest") then 
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = g.Top.CFrame
        end
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").SellTP.CFrame
end)
TeleChests.MouseButton1Click:connect(function()
CurLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    for _,g in pairs(Workspace:GetChildren()) do
        if string.match(g.Name, "Chest") then 
            wait(1)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = g.Top.CFrame
        end
    end
end)
TeleSpawnBtn.MouseButton1Click:connect(function()
CurLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
 game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Misc.SpawnLocation.CFrame
end)
TeleTreesBtn.MouseButton1Click:connect(function()
    CurLocation = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local tp = CFrame.new(3132.77, 19.84, 923.94, -0.44, 1.68828596e-08, -0.89, -2.83619244e-08, 1, 3.27091385e-08, 0.89, 3.98654691e-08, -0.44)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = tp
end)
TeleBackBtn.MouseButton1Click:connect(function()
    if (CurLocation ~= "Nothing") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CurLocation    
    end
end)
WalkBtn.MouseButton1Click:connect(function()
	local plr = game.Players.LocalPlayer.Name
	game:GetService("Workspace")[plr].Humanoid.WalkSpeed = 30
end)