--https://www.roblox.com/games/2533391464/Snowman-Simulator
--https://github.com/dady172172/Roblox-Cheats
local function CreateInstance(cls,props)
local inst = Instance.new(cls)
local back = 0
farm1 = false
for i,v in pairs(props) do
	inst[i] = v
end
return inst
end
	
local SnowManSimGUI = CreateInstance('ScreenGui',{DisplayOrder=0,Enabled=true,ResetOnSpawn=true,Name='SnowManSimGUI', Parent=game.CoreGui})
local SMSFrame = CreateInstance('Frame',{Style=Enum.FrameStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=2,ClipsDescendants=false,Draggable=true,Position=UDim2.new(0.800623059, 0, 0.587982833, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 272),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name = 'SMSFrame',Parent = SnowManSimGUI})
local TextLabel = CreateInstance('TextLabel',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size24,Text='SnowMan Simulator',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=20,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,Active=false,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0.666667, 0.666667),BackgroundTransparency=0,BorderColor3=Color3.new(1, 1, 1),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0, 0, 0, 0),Rotation=0,Selectable=false,Size=UDim2.new(0, 235, 0, 34),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TextLabel',Parent = SMSFrame})
local CollectCanesBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='Collect Canes',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.161484554, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='CollectCanesBtn',Parent = SMSFrame})
local TPHomeBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Home',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.233575702, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPHome',Parent = SMSFrame})
local TPBuySleighBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Buy Sleigh',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.305666655, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPBuySleighBtn',Parent = SMSFrame})
local TPBuyPetBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Buy Pet',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.377758443, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPBuyPetBtn',Parent = SMSFrame})
local TPBackBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Back',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.524817288, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPBackBtn',Parent = SMSFrame})
local TPSellAreaBtn = CreateInstance('TextButton',{Font=Enum.Font.SourceSans,FontSize=Enum.FontSize.Size14,Text='TP Sell Area',TextColor3=Color3.new(0, 0, 0),TextScaled=false,TextSize=14,TextStrokeColor3=Color3.new(0, 0, 0),TextStrokeTransparency=1,TextTransparency=0,TextWrapped=false,TextXAlignment=Enum.TextXAlignment.Center,TextYAlignment=Enum.TextYAlignment.Center,AutoButtonColor=true,Modal=false,Selected=false,Style=Enum.ButtonStyle.Custom,Active=true,AnchorPoint=Vector2.new(0, 0),BackgroundColor3=Color3.new(0.666667, 0, 0),BackgroundTransparency=0,BorderColor3=Color3.new(0.105882, 0.164706, 0.207843),BorderSizePixel=1,ClipsDescendants=false,Draggable=false,Position=UDim2.new(0.049843125, 0, 0.451287866, 0),Rotation=0,Selectable=true,Size=UDim2.new(0, 210, 0, 20),SizeConstraint=Enum.SizeConstraint.RelativeXY,Visible=true,ZIndex=1,Name='TPSellAreaBtn',Parent = SMSFrame})

CollectCanesBtn.MouseButton1Click:connect(function()
if farm1 == true then farm1 = false print("Disabled")
CollectCanesBtn.BackgroundColor3 = Color3.new(.5, 0, 0)
elseif
farm1 == false then farm1 = true print("Enabled")
CollectCanesBtn.BackgroundColor3 = Color3.new(0, .5, 0)
back = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
wait(.1)
end
Farm()
end)

TPHomeBtn.MouseButton1Click:connect(function()
    --back = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    --game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").snowmanBases.LandPlot.SpawnLocation.CFrame
end)

TPBuySleighBtn.MouseButton1Click:connect(function()
    back = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1618.90869, 2.40753317, 208.135468, -0.137600899, -0.000434440677, -0.990487874, -5.55218467e-05, 0.999999881, -0.000430899556, 0.990487993, -4.29840884e-06, -0.137600899)
end)

TPBuyPetBtn.MouseButton1Click:connect(function()
    back = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").presentPedestals["5"].touchPart.CFrame
end)

TPBackBtn.MouseButton1Click:connect(function()
    if back ~= 0 then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = back
    end
end)

TPSellAreaBtn.MouseButton1Click:connect(function()
    back = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1914.34546, 2.40753317, 50.3735161, -0.0111546488, 3.13418234e-08, 0.999937773, 8.83934537e-10, 1, -3.13339115e-08, -0.999937773, 5.34360722e-10, -0.0111546488)
end)

function Farm()
    
    while farm1 == true do
        if game:GetService("Workspace").snowmanBases.LandPlot.Snowman.steps then
            for _,u in pairs(game:GetService("Workspace").snowmanBases.LandPlot.Snowman.steps:GetChildren()) do
                if u.Name == "goldStepSpot" then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = u.CFrame
                end
            end
        end
        for _,g in pairs(game:GetService("Workspace").gameCandyCanes:GetChildren()) do 
            for _,v in pairs(g:GetChildren()) do 
                wait(.1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            end
        end
        for _,g in pairs(game:GetService("Workspace").smallObby:GetChildren()) do 
            for _,v in pairs(g:GetChildren()) do 
                if (v.Name == "cane") then 
                    wait(.1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                end
            end
        end
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").singleCaneSpawners.goldCaneSpawnObbyEnd.CFrame
    end
end