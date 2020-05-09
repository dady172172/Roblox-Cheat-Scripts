--== Made by Kurokku/Rebug REX ==--

--[[
Note: Things are still being made as this is only the starting version. Bugs are expected

Compatible For:
-Protosmasher
-Synapse
-Veil
-QTX
-RC7
-Elysian
-Seraph (Might crash though)
-Prob some other exploits too, but I could be wrong.

Clipboard Works For:
-Protosmasher
-Veil
-Synapse
-Elysian
-More in the future
--]]

--== Creation Functions ==--

function BreakCode()
script:Destroy()
end

local service = setmetatable({}, {
   __index = function(t, k)
       return game:GetService(k)
   end
})

if service.Players.LocalPlayer.PlayerGui:FindFirstChild("Mr.Spy - Rebug REX/Kurokku") then
service.Players.LocalPlayer.PlayerGui:FindFirstChild("Mr.Spy - Rebug REX/Kurokku"):Destroy() --You're dumb if you don't know what this does
end

function Create(cls,props)
   local inst = Instance.new(cls)
   for i,v in pairs(props) do
if i == "ZIndex" then
inst[i] = v+10000000
else
inst[i] = v
end
   end
   return inst
end

_G.Exploit = (function()
local writeable = pcall(function() make_writeable(getrawmetatable(game)) end)
local setwrite = pcall(function() setreadonly(getrawmetatable(game), false) end)
local synapse = Synapse or false
local backup = pcall(function() getrawmetatable(game) end)

return (
       (writeable and "Writeable") or
       (setwrite and "SetWrite") or
       (synapse and "Synapse") or
       (backup and "BackUp") or
       "Unknown Exploit"
   )
end)()

function GetType(item)
   if type(item) == "string" then
       return "\""..item.."\""
   elseif type(item) == "table" then
local str = "{"
local max = 0
local numb = 1
       for i,v in pairs(item) do
           max = max+1
       end
       for i,v in pairs(item) do
           if numb == max then
               str = str.."["..GetType(i).."] = "..GetType(v)
           else
               str = str.."["..GetType(i).."] = "..GetType(v)..", "
           end
           numb = numb + 1
       end
       str = str.."}"
       return str
   elseif type(item) == "userdata" then
      local a,b = pcall(function()
      return item.ClassName 
       end)
       if a then
           return item:GetFullName()
       else
           if tostring(b):match("not a valid member of %w+") then
               local c, d = tostring(b):match("not a valid member of %w+"):find("of ")
               local class = tostring(b):match("not a valid member of %w+"):sub(d+1)
               return class..".new(".. tostring(item) ..")"
           end
       end
   else
       return tostring(item)
   end
end

function ReturnArgs(Namecall, Object, ...)
   local args = {...}
   local list = "Namecall: ".. tostring(Namecall) .." | Args: ["
   local max = 0
   local numb = 1
   for i,v in pairs(args) do
       max = max + 1
   end
   for i,v in pairs(args) do
       if numb == max then
           list = list..GetType(v)
       else
           list = list..GetType(v)..", "
       end
       numb = numb + 1
   end
list=list.."]"
   return list
end

function MakeShadow(UI,Index,Amnt,Sizey,starty)
local tab = {}
for i = 1,Amnt do
    tab[i] = Create("Frame",{Name="Shadow",Parent=UI,Size=UDim2.new(1,0,Sizey,0),ZIndex=Index,Position=UDim2.new(0,i,starty,i),BackgroundColor3=Color3.fromRGB(0,0,0),BorderSizePixel=0,Transparency=0.9})
end
return tab
end

--== End ==--

--== Variables ==--

local plr = service.Players.LocalPlayer
local mouse = plr:GetMouse()
local colSize = 14
local SpyArgs = {}
local Indexs = {
["BadgeService"] = 76;
["Humanoid"] = 10;
["GuiService"] = 48;
["CylinderHandleAdornment"] = 55;
["BallSocketConstraint"] = 90;
["BrickColorValue"] = 5;
["Accoutrement"] = 33;
["AdService"] = 74;
["AssetService"] = 73;
["GuiMain"] = 48;
["ImageButton"] = 53;
["HapticService"] = 85;
["DialogChoice"] = 64;
["Handles"] = 54;
["ReflectionMetadataClasses"] = 87;
["JointInstance"] = 35;
["AnimationController"] = 61;
["RemoteEvent"] = 81;
["CollectionService"] = 31;
["Smoke"] = 60;
["Configuration"] = 59;
["KeyframeSequenceProvider"] = 61;
["Accessory"] = 33;
["SelectionPointLasso"] = 58;
["GamePassService"] = 20;
["CFrameValue"] = 5;
["TextureTrail"] = 5;
["ImageLabel"] = 50;
["ReflectionMetadataMember"] = 87;
["Animation"] = 61;
["IntConstrainedValue"] = 5;
["HttpService"] = 77;
["PointLight"] = 14;
["Model"] = 3;
["DoubleConstrainedValue"] = 5;
["Snap"] = 35;
["BodyAngularVelocity"] = 15;
["VelocityMotor"] = 35;
["RocketPropulsion"] = 15;
["SurfaceSelection"] = 56;
["CoreGui"] = 47;
["Part"] = 2;
["ReplicatedFirst"] = 73;
["BindableEvent"] = 68;
["SelectionPartLasso"] = 58;
["NegateOperation"] = 79;
["PyramidPart"] = 2;
["ArcHandles"] = 57;
["Hint"] = 34;
["Players"] = 22;
["Script"] = 7;
["ParallelRampPart"] = 2;
["RayValue"] = 5;
["LineHandleAdornment"] = 55;
["Camera"] = 6;
["RunService"] = 67;
["BodyForce"] = 15;
["KeyframeSequence"] = 61;
["ServerScriptService"] = 1;
["BillboardGui"] = 65;
["BodyThrust"] = 15;
["RemoteFunction"] = 80;
["Team"] = 25;
["Sound"] = 12;
["GuiButton"] = 53;
["Workspace"] = 20;
["Lighting"] = 14;
["JointsService"] = 35;
["BlurEffect"] = 91;
["WedgePart"] = 2;
["BloomEffect"] = 91;
["ReflectionMetadata"] = 87;
["Vector3Value"] = 5;
["PointsService"] = 84;
["UserInputService"] = 85;
["Sparkles"] = 43;
["BodyGyro"] = 15;
["Rotate"] = 35;
["HopperBin"] = 23;
["ForceField"] = 38;
["Tool"] = 18;
["Texture"] = 11;
["Teams"] = 24;
["ReflectionMetadataFunctions"] = 87;
["RodConstraint"] = 90;
["Folder"] = 71;
["BodyVelocity"] = 15;
["Shirt"] = 44;
["SlidingBallConstraint"] = 90;
["Animator"] = 61;
["TextButton"] = 52;
["Color3Value"] = 5;
["TextBox"] = 52;
["NetworkReplicator"] = 30;
["Platform"] = 36;
["TerrainRegion"] = 66;
["SkateboardPlatform"] = 36;
["Seat"] = 36;
["Terrain"] = 66;
["Explosion"] = 37;
["BlockMesh"] = 9;
["TeleportService"] = 82;
["PlayerGui"] = 47;
["TextLabel"] = 51;
["SurfaceLight"] = 14;
["SurfaceGui"] = 65;
["Debris"] = 31;
["FlagStand"] = 40;
["StarterPack"] = 21;
["BindableFunction"] = 67;
["ReflectionMetadataCallbacks"] = 87;
["NetworkClient"] = 17;
["ModuleScript"] = 72;
["Flag"] = 39;
["Status"] = 3;
["ParticleEmitter"] = 70;
["StarterPlayer"] = 89;
["StringValue"] = 5;
["ObjectValue"] = 5;
["CharacterMesh"] = 61;
["StarterGui"] = 47;
["ReplicatedStorage"] = 73;
["StarterCharacterScripts"] = 83;
["NetworkServer"] = 16;
["Backpack"] = 21;
["ReflectionMetadataEnum"] = 87;
["StarterPlayerScripts"] = 83;
["SpotLight"] = 14;
["CustomEventReceiver"] = 5;
["SphereHandleAdornment"] = 55;
["SoundService"] = 32;
["SpecialMesh"] = 9;
["SpawnLocation"] = 26;
["PlayerScripts"] = 83;
["PartPairLasso"] = 58;
["ColorCorrectionEffect"] = 91;
["UnionOperation"] = 78;
["Sky"] = 29;
["MoveToConstraint"] = 90;
["RopeConstraint"] = 90;
["RightAngleRampPart"] = 2;
["ShirtGraphic"] = 41;
["ScreenGui"] = 48;
["SelectionSphere"] = 55;
["RotateV"] = 35;
["SelectionBox"] = 55;
["VehicleSeat"] = 36;
["CustomEvent"] = 5;
["Chat"] = 34;
["ServerStorage"] = 75;
["Selection"] = 56;
["IntValue"] = 5;
["RotateP"] = 35;
["FloorWire"] = 5;
["TrussPart"] = 2;
["StarterGear"] = 21;
["ReflectionMetadataYieldFunctions"] = 87;
["ReflectionMetadataProperties"] = 87;
["ReflectionMetadataEvents"] = 87;
["ReflectionMetadataEnums"] = 87;
["ReflectionMetadataEnumItem"] = 87;
["ReflectionMetadataClass"] = 87;
["PrismPart"] = 2;
["BinaryStringValue"] = 5;
["Glue"] = 35;
["PrismaticConstraint"] = 90;
["TouchTransmitter"] = 38;
["CornerWedgePart"] = 2;
["PathfindingService"] = 38;
["SpringConstraint"] = 90;
["Fire"] = 62;
["Pants"] = 45;
["NumberValue"] = 5;
["TestService"] = 69;
["Motor6D"] = 35;
["Motor"] = 35;
["CylindricalConstraint"] = 90;
["MarketplaceService"] = 47;
["CoreScript"] = 19;
["CylinderMesh"] = 9;
["ConeHandleAdornment"] = 55;
["SunRaysEffect"] = 91;
["LocalScript"] = 19;
["Weld"] = 35;
["Attachment"] = 35;
["BoolValue"] = 5;
["Dialog"] = 63;
["Pose"] = 61;
["Decal"] = 8;
["Hat"] = 46;
["AnimationTrack"] = 61;
["ClickDetector"] = 42;
["Frame"] = 49;
["LogService"] = 88;
["FileMesh"] = 9;
["InsertService"] = 73;
["HingeConstraint"] = 90;
["Message"] = 34;
["Player"] = 13;
["ContextActionService"] = 42;
["ContentProvider"] = 73;
["BodyPosition"] = 15;
["BoxHandleAdornment"] = 55;
["ScrollingFrame"] = 49;
["Keyframe"] = 61;
}

--== End ==--

--== Make UIs ==--

local Main = Create("ScreenGui", {Parent=service.Players.LocalPlayer.PlayerGui,Name="Mr.Spy - Rebug REX/Kurokku",ResetOnSpawn=false})
local Hub = Create("TextButton", {Name="Hub",Visible=false,Size=UDim2.new(0,600,0,50),Position=UDim2.new(0.5,-300,0.5,-200),Draggable=true,BackgroundTransparency=1,Text="",Parent=Main,ZIndex=1})
local RealUI = Create("Frame", {Name="Main",Size=UDim2.new(1,0,7,0),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(200,200,200),BackgroundTransparency=1,BorderSizePixel=0,Parent=Hub,ZIndex=2})
local TextureHolder = Create("Frame", {Name="Holder",ClipsDescendants=true,Size=UDim2.new(1,0,1,0),Parent=RealUI,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3})
local Texture1 = Create("ImageLabel", {Name="BG",Size=UDim2.new(2,0,2,0),ScaleType="Tile",TileSize=UDim2.new(0,100,0,100),ImageColor3=Color3.fromRGB(44, 44, 44),Image="rbxassetid://585867512",Parent=TextureHolder,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3})
local Bar = Create("Frame", {Name="Bar",Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),BackgroundColor3=Color3.fromRGB(63, 63, 63),BackgroundTransparency=0,BorderSizePixel=0,Parent=Hub,ZIndex=6})
local Credits = Create("TextLabel",{Parent=Bar,ZIndex=7,Font="SourceSansBold",TextSize=20,Size=UDim2.new(.5,0,1,0),Position=UDim2.new(0,10,0,0),TextStrokeTransparency=1,Text="Mr.Spy - Rebug REX/Kurokku",TextColor3=Color3.fromRGB(230,230,230),BackgroundTransparency=1,TextXAlignment="Left",BorderSizePixel=0})
local Exit = Create("TextButton", {Name="Exit",Size=UDim2.new(0.1,0,.8,0),Position=UDim2.new(0.9,0,0.1,0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(255,255,255),TextWrapped=true,TextScaled=true,Text="x",Parent=Bar,ZIndex=8})
local Minimize = Create("TextButton", {Name="Minimize",Size=UDim2.new(0.1,0,1,0),Position=UDim2.new(0.8,0,0,0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(255,255,255),TextWrapped=true,TextScaled=true,Text="-",Parent=Bar,ZIndex=8})
local Open = Create("TextButton", {Name="Open",Font="SourceSansLight",AutoButtonColor=false,Size=UDim2.new(0,60,0,20),ZIndex=2,BackgroundColor3=Color3.fromRGB(63, 63, 63),Position=UDim2.new(.5,-30,.9,-10),BackgroundTransparency=0,BorderSizePixel=0,TextColor3=Color3.fromRGB(255,255,255),TextWrapped=true,TextScaled=true,Text=" Open ",Parent=Main})
local IconFrame = Create("Frame", {Name="MapHolder",Size=UDim2.new(0,16,0,16),BackgroundTransparency=1,ClipsDescendants=true,ZIndex=100,Parent=nil})
local IconMap = Create("ImageLabel", {Name="IconMap",Size=UDim2.new(0,256,0,256),Image="rbxassetid://483448923",Parent=IconFrame,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=100})
local Scroller = Create("ScrollingFrame", {Name="Remotes",Size=UDim2.new(1,0,1,0),CanvasSize=UDim2.new(0,0,0,0),Parent=RealUI,ZIndex=5,BackgroundTransparency=1,BorderSizePixel=0,TopImage="rbxasset://textures/ui/Scroll/scroll-middle.png",BottomImage="rbxasset://textures/ui/Scroll/scroll-middle.png"})
local RemoteTemplate = Create("Frame",{Name="Template",Size=UDim2.new(1,0,0,40),Parent=nil,ZIndex=6,BackgroundTransparency=1})
local RemoteName = Create("TextLabel",{Name="RemoteName",Parent=RemoteTemplate,TextColor3=Color3.fromRGB(230,230,230),BackgroundTransparency=1,ZIndex=7,Size=UDim2.new(1,-26,1,0),Position=UDim2.new(0,30,0,0),TextXAlignment="Left"})
local SpyButton = Create("TextButton", {Name="SpyRemote",Parent=RemoteTemplate,TextColor3=Color3.fromRGB(230,230,230),AutoButtonColor=false,BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(63, 63, 63),Size=UDim2.new(0.075,0,0.45,0),ZIndex=9,Text="Spy"})
local PathButton = Create("TextButton", {Name="PathButton",Parent=RemoteTemplate,TextColor3=Color3.fromRGB(230,230,230),AutoButtonColor=false,BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(63, 63, 63),Size=UDim2.new(0.1,0,0.45,0),ZIndex=9,Text="Get Path"})
local OpenSpy = Create("TextButton", {Name="OpenButton",Parent=RemoteTemplate,TextColor3=Color3.fromRGB(230,230,230),AutoButtonColor=false,BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(63, 63, 63),Size=UDim2.new(0.18,0,0.45,0),ZIndex=9,Text="Copy to Clipboard"})
local spyAll = Create("TextButton", {Name="SpyAll",Parent=RealUI,TextColor3=Color3.fromRGB(230,230,230),AutoButtonColor=false,BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(63, 63, 63),Size=UDim2.new(0.2,0,0.075,0),Position=UDim2.new(0.05,0,1.05,0),ZIndex=9,Text="Spy all Remotes"})
local UnspyAll = Create("TextButton", {Name="UnSpyAll",Parent=RealUI,TextColor3=Color3.fromRGB(230,230,230),AutoButtonColor=false,BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(63, 63, 63),Size=UDim2.new(0.2,0,0.075,0),Position=UDim2.new(0.3,0,1.05,0),ZIndex=9,Text="Unspy all Remotes"})

local ExplorerWindow = Create("TextButton", {Name="Explorer",Visible=false,Size=UDim2.new(0,200,0,50),Position=UDim2.new(0.8,-75,0.5,-200),Draggable=true,BackgroundTransparency=1,Text="",Parent=Main,ZIndex=1})
local Bar2 = Create("Frame", {Name="Bar",Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),BackgroundColor3=Color3.fromRGB(63, 63, 63),BackgroundTransparency=0,BorderSizePixel=0,Parent=ExplorerWindow,ZIndex=6})
local ExplorerName = Create("TextLabel",{Parent=Bar2,ZIndex=7,Font="SourceSansBold",TextSize=20,Size=UDim2.new(.5,0,1,0),Position=UDim2.new(0,10,0,0),TextStrokeTransparency=1,Text="Explorer",TextColor3=Color3.fromRGB(230,230,230),BackgroundTransparency=1,TextXAlignment="Left",BorderSizePixel=0})
local Minimize2 = Create("TextButton", {Name="Minimize",Size=UDim2.new(0.1,0,1,0),Position=UDim2.new(0.85,0,0,0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(255,255,255),TextWrapped=true,TextScaled=true,Text="-",Parent=Bar2,ZIndex=8})
local RealExUI = Create("Frame", {Name="ExMain",Size=UDim2.new(1,0,7,0),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(200,200,200),BackgroundTransparency=1,BorderSizePixel=0,Parent=ExplorerWindow,ZIndex=2})
local TextureHolder2 = Create("Frame", {Name="Holder",ClipsDescendants=true,Size=UDim2.new(1,0,1,0),Parent=RealExUI,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3})
local Texture2 = Create("ImageLabel", {Name="BG",Size=UDim2.new(2,0,2,0),ScaleType="Tile",TileSize=UDim2.new(0,100,0,100),ImageColor3=Color3.fromRGB(44, 44, 44),Image="rbxassetid://585867512",Parent=TextureHolder2,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3})
local Scroller2 = Create("ScrollingFrame", {Name="Path",Size=UDim2.new(1,0,1,0),CanvasSize=UDim2.new(0,0,0,0),Parent=RealExUI,ZIndex=500,BackgroundTransparency=1,BorderSizePixel=0,TopImage="rbxasset://textures/ui/Scroll/scroll-middle.png",BottomImage="rbxasset://textures/ui/Scroll/scroll-middle.png"})
local PathTemplate = Create("Frame",{Name="PathTemplate",Size=UDim2.new(1,0,0,20),Parent=nil,ZIndex=6,BackgroundTransparency=1})
local PathName = Create("TextLabel",{Name="PathName",Parent=PathTemplate,TextColor3=Color3.fromRGB(230,230,230),BackgroundTransparency=1,ZIndex=7,Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,20,0,0),TextXAlignment="Left"})
local IconModeFrame = Create("Frame", {Name="Mode",Size=UDim2.new(0,16,0,16),BackgroundTransparency=1,ClipsDescendants=true,ZIndex=100,Parent=nil})
local IconModeMap = Create("ImageLabel", {Name="IconMap",Size=UDim2.new(0,256,0,256),Image="rbxassetid://483448923",Parent=IconModeFrame,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=100})
local ModeBtn = Create("TextButton", {Name="Button",Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Text="",ZIndex=101,Parent=IconModeFrame})
local HoverFrame = Create("Frame", {Name="HoverFrame",Size=UDim2.new(1000,0,1,0),Parent=PathTemplate,ZIndex=102,BackgroundTransparency=1,BorderSizePixel=0,BackgroundColor3=Color3.fromRGB(255,255,255)})

local LogWindow = Create("TextButton", {Name="Logs",Visible=false,Size=UDim2.new(0,300,0,50),Position=UDim2.new(0.16,-175,0.5,-200),Draggable=true,BackgroundTransparency=1,Text="",Parent=Main,ZIndex=1})
local Bar3 = Create("Frame", {Name="Bar",Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,0,0,0),BackgroundColor3=Color3.fromRGB(63, 63, 63),BackgroundTransparency=0,BorderSizePixel=0,Parent=LogWindow,ZIndex=6})
local LogName = Create("TextLabel",{Parent=Bar3,ZIndex=7,Font="SourceSansBold",TextSize=20,Size=UDim2.new(.5,0,1,0),Position=UDim2.new(0,10,0,0),TextStrokeTransparency=1,Text="Event Logs",TextColor3=Color3.fromRGB(230,230,230),BackgroundTransparency=1,TextXAlignment="Left",BorderSizePixel=0})
local Minimize3 = Create("TextButton", {Name="Minimize",Size=UDim2.new(0.1,0,1,0),Position=UDim2.new(0.85,0,0,0),BackgroundTransparency=1,TextColor3=Color3.fromRGB(255,255,255),TextWrapped=true,TextScaled=true,Text="-",Parent=Bar3,ZIndex=8})
local RealLogUI = Create("Frame", {Name="LMain",Size=UDim2.new(1,0,7,0),Position=UDim2.new(0,0,1,0),BackgroundColor3=Color3.fromRGB(200,200,200),BackgroundTransparency=1,BorderSizePixel=0,Parent=LogWindow,ZIndex=2})
local TextureHolder3 = Create("Frame", {Name="Holder",ClipsDescendants=true,Size=UDim2.new(1,0,1,0),Parent=RealLogUI,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3})
local Texture3 = Create("ImageLabel", {Name="BG",Size=UDim2.new(2,0,2,0),ScaleType="Tile",TileSize=UDim2.new(0,100,0,100),ImageColor3=Color3.fromRGB(44, 44, 44),Image="rbxassetid://585867512",Parent=TextureHolder3,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=3})
local Scroller3 = Create("ScrollingFrame", {Name="Logs",Size=UDim2.new(1,0,1,0),CanvasSize=UDim2.new(0,0,0,0),Parent=RealLogUI,ZIndex=500,BackgroundTransparency=1,BorderSizePixel=0,TopImage="rbxasset://textures/ui/Scroll/scroll-middle.png",BottomImage="rbxasset://textures/ui/Scroll/scroll-middle.png"})
local LogTemplate = Create("Frame",{Name="LogTemplate",Size=UDim2.new(1,0,0,20),Parent=nil,ZIndex=6,BackgroundTransparency=1})
local LogName = Create("TextLabel",{Name="LogName",Parent=LogTemplate,TextColor3=Color3.fromRGB(230,230,230),BackgroundTransparency=1,ZIndex=7,Size=UDim2.new(1,0,1,0),Position=UDim2.new(0,20,0,0),TextXAlignment="Left"})

local Removed = false
Main.ChildRemoved:Connect(function()
if not Removed then
Removed = true
BreakCode()
end
end)

--MakeShadows--
local HubShadows = MakeShadow(Hub,1,3,7,1)
MakeShadow(Bar,5,3,1,0)
MakeShadow(Bar2,5,3,1,0)
MakeShadow(Open,1,3,1,0)
MakeShadow(Bar3,5,3,1,0)
MakeShadow(SpyButton,8,3,1,0)
MakeShadow(PathButton,8,3,1,0)
MakeShadow(OpenSpy,8,3,1,0)
MakeShadow(spyAll,8,3,1,0)
local ExplorerShadows = MakeShadow(ExplorerWindow,1,3,7,1)
local LogShadows = MakeShadow(LogWindow,1,3,7,1)
--== End ==--

--== UI Functions ==--

function LoadIcon(service, frame, numb)
if Indexs[service] or numb then
local row = 1
local col = 0
if numb then
for i = 1,numb do
if i > colSize*row then
col = 1
row = row+1
else
col = col+1
end
end
else
for i = 1,Indexs[service] do
if i > colSize*row then
col = 1
row = row+1
else
col = col+1
end
end
end
frame.IconMap.Position = UDim2.new(0,(-3+(-18*col))+18,0,(-3+(-18*row))+18)
end
end

spawn(function()
local suc,er = pcall(function()
while true do
Texture1:TweenPosition(UDim2.new(-1,0,-1,0),"Out","Linear",30,true)
wait(30)
Texture1.Position = UDim2.new(0,0,0,0)
end
end)
end)

spawn(function()
local suc,er = pcall(function()
while true do
Texture2:TweenPosition(UDim2.new(-1,0,-1,0),"Out","Linear",30,true)
wait(30)
Texture2.Position = UDim2.new(0,0,0,0)
end
end)
end)

spawn(function()
local suc,er = pcall(function()
while true do
Texture3:TweenPosition(UDim2.new(-1,0,-1,0),"Out","Linear",30,true)
wait(30)
Texture3.Position = UDim2.new(0,0,0,0)
end
end)
end)

local ExitDB=false

Open.MouseButton1Down:Connect(function()
if not ExitDB then
ExitDB = true
Hub.Position = UDim2.new(0,-600,0.5,-200)
ExplorerWindow.Position = UDim2.new(0.875,-75,-0.35,-200)
LogWindow.Position = UDim2.new(0.16,-175,1,200)
Hub.Visible = true
ExplorerWindow.Visible = true
LogWindow.Visible = true
Open.Visible = false
Hub:TweenPosition(UDim2.new(0.535,-300,0.5,-200),"Out","Elastic",0.5,true)
wait(0.15)
ExplorerWindow:TweenPosition(UDim2.new(0.875,-75,0.5,-200),"Out","Elastic",0.5,true)
wait(0.15)
LogWindow:TweenPosition(UDim2.new(0.16,-175,0.5,-200),"Out","Elastic",0.5,true)
wait()
game:GetService("TweenService"):Create(Open,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
ExitDB = false
end
end)

Bar.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Bar,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

Bar.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Bar,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Bar2.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Bar2,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

Bar2.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Bar2,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Bar3.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Bar3,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

Bar3.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Bar3,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Open.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Open,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

Open.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Open,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

spyAll.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(spyAll,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

spyAll.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(spyAll,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

UnspyAll.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(UnspyAll,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

UnspyAll.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(UnspyAll,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Exit.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Exit,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(170, 46, 46);}):Play()
wait()
game:GetService("TweenService"):Create(Bar,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Exit.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Exit,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
game:GetService("TweenService"):Create(Bar,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

Minimize.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Minimize,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(150, 150, 150);}):Play()
wait()
game:GetService("TweenService"):Create(Bar,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Minimize.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Minimize,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
game:GetService("TweenService"):Create(Bar,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

Minimize2.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Minimize2,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(150, 150, 150);}):Play()
wait()
game:GetService("TweenService"):Create(Bar2,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Minimize2.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Minimize2,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
game:GetService("TweenService"):Create(Bar2,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

Minimize3.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(Minimize3,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(150, 150, 150);}):Play()
wait()
game:GetService("TweenService"):Create(Bar3,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)

Minimize3.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(Minimize3,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
game:GetService("TweenService"):Create(Bar3,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)

local minDB1 = false
Minimize.MouseButton1Down:Connect(function()
if not minDB1 then
minDB1 = true
if RealUI.Visible then
RealUI.Visible = false
for i,v in pairs(HubShadows) do
v.Visible = false
end
else
RealUI.Visible = true
for i,v in pairs(HubShadows) do
v.Visible = true
end
end
minDB1 = false
end
end)

local minDB2 = false
Minimize2.MouseButton1Down:Connect(function()
if not minDB2 then
minDB2 = true
if RealExUI.Visible then
RealExUI.Visible = false
for i,v in pairs(ExplorerShadows) do
v.Visible = false
end
else
RealExUI.Visible = true
for i,v in pairs(ExplorerShadows) do
v.Visible = true
end
end
minDB2 = false
end
end)

local minDB3 = false
Minimize3.MouseButton1Down:Connect(function()
if not minDB3 then
minDB3 = true
if RealLogUI.Visible then
RealLogUI.Visible = false
for i,v in pairs(LogShadows) do
v.Visible = false
end
else
RealLogUI.Visible = true
for i,v in pairs(LogShadows) do
v.Visible = true
end
end
minDB3 = false
end
end)

Exit.MouseButton1Down:Connect(function()
if not ExitDB then
ExitDB = true
Open.Visible = true
Hub:TweenPosition(UDim2.new(-0.2,-600,-1,0),"In","Quart",0.5,true)
wait(0.15)
ExplorerWindow:TweenPosition(UDim2.new(1,200,-1,0),"In","Quart",0.5,true)
wait(0.15)
LogWindow:TweenPosition(UDim2.new(-0.5,-300,1,0),"In","Quart",0.5,true)
wait(0.5)
game:GetService("TweenService"):Create(Bar,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
game:GetService("TweenService"):Create(Minimize,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
game:GetService("TweenService"):Create(Exit,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
Hub.Visible = false
ExplorerWindow.Visible = false
LogWindow.Visible = false
Open.Visible = true
ExitDB = false
end
end)

local classMethods = {
BindableEvent = "Fire";
BindableFunction = "Invoke";
RemoteEvent = "FireServer";
RemoteFunction = "InvokeServer";
}

local realMethods = {}
local pseudoEnv = {}

local Spying = {}
local SpyedNumb = 1

for i,v in pairs(classMethods) do
realMethods[v] = Instance.new(i)[classMethods[i]]
end
local BiggestX = 0
function AddUI(args)
local NewUI = LogTemplate:Clone()
local mapp = IconFrame:Clone()
LoadIcon(args[1].ClassName, mapp)
mapp.Position = UDim2.new(0,0,0.5,-8)
NewUI.LogName.Text = "Name: \""..args[1].Name .. "\" | "..args[2]
NewUI.Position = UDim2.new(0,0,0,SpyedNumb*20)
NewUI.Parent = Scroller3
mapp.Parent = NewUI
SpyedNumb = SpyedNumb + 1
if BiggestX < NewUI.LogName.TextBounds.X then
BiggestX = NewUI.LogName.TextBounds.X
end
Scroller3.CanvasSize = UDim2.new(0,BiggestX+20,0,20*#Scroller3:GetChildren()+20)
end

function GetNameCall(obj)
if obj.ClassName == "RemoteEvent" then
return "FireServer"
elseif obj.ClassName == "RemoteFunction" then
return "InvokeServer"
elseif obj.ClassName == "BindableEvent" then
return "Fire"
elseif obj.ClassName == "BindabledFunction" then
return "Invoke"
end
end

function LoadRemoteSpy()
if tostring(_G.Exploit) == "Synapse" then
local function hook(methodname, self, ...)
   local args = {...}
   local ret = {realMethods[methodname](self,...)}
if not realMethods[methodname] then return unpack(ret) end
if not Spying[self] then return unpack(ret) end
   SpyArgs[SpyedNumb] = {self,ReturnArgs(GetNameCall(self),self,...)}
AddUI(SpyArgs[SpyedNumb])
   return unpack(ret)
end
Synapse:SetNamecallHook("FireServer", function(self, ...)
   if self:IsA("RemoteEvent") then
       hook(GetNameCall(self), self, ...)
   end
end)
Synapse:SetNamecallHook("InvokeServer", function(self, ...)
   if self:IsA("RemoteFunction") then
       hook(GetNameCall(self), self, ...)
   end
end)
Synapse:SetNamecallHook("Fire", function(self, ...)
   if self:IsA("BindableEvent") then
       hook(GetNameCall(self), self, ...)
   end
end)
Synapse:SetNamecallHook("Invoke", function(self, ...)
   if self:IsA("BindableFunction") then
       hook(GetNameCall(self), self, ...)
   end
end)
elseif tostring(_G.Exploit) == "SetWrite" then
setreadonly(getrawmetatable(game), false)
local pseudoEnv = {}
local gameMeta = getrawmetatable(game)
for key, value in next, gameMeta do pseudoEnv[key] = value end
gameMeta.__index, gameMeta.__namecall = function(self, key)
if not realMethods[key] then return pseudoEnv.__index(self, key) end
if not Spying[self] then return pseudoEnv.__index(self, key) end
return function(_, ...)
local returnValues = {realMethods[key](self, ...)}
SpyArgs[SpyedNumb] = {self,ReturnArgs(GetNameCall(self),self,...)}
AddUI(SpyArgs[SpyedNumb])
return unpack(returnValues)
end
end
elseif tostring(_G.Exploit) == "Writeable" then
make_writeable(getrawmetatable(game))
local pseudoEnv = {}
local gameMeta = getrawmetatable(game)
for key, value in next, gameMeta do pseudoEnv[key] = value end
gameMeta.__index, gameMeta.__namecall = function(self, key)
if not realMethods[key] then return pseudoEnv.__index(self, key) end
if not Spying[self] then return pseudoEnv.__index(self, key) end
return function(_, ...)
local returnValues = {realMethods[key](self, ...)}
SpyArgs[SpyedNumb] = {self,ReturnArgs(GetNameCall(self),self,...)}
AddUI(SpyArgs[SpyedNumb])
return unpack(returnValues)
end
end
elseif tostring(_G.Exploit) == "BackUp" then
local pseudoEnv = {}
local gameMeta = getrawmetatable(game)
for key, value in next, gameMeta do pseudoEnv[key] = value end
gameMeta.__index, gameMeta.__namecall = function(self, key)
if not realMethods[key] then return pseudoEnv.__index(self, key) end
if not Spying[self] then return pseudoEnv.__index(self, key) end
return function(_, ...)
local returnValues = {realMethods[key](self, ...)}
SpyArgs[SpyedNumb] = {self,ReturnArgs(GetNameCall(self),self,...)}
AddUI(SpyArgs[SpyedNumb])
return unpack(returnValues)
end
end
else
print("Mr.Spy does not support your script executer due to it might not have a way to run \"getrawmetatable\"")
end
end
LoadRemoteSpy()

local RemoteIgnores = {
["CharacterSoundEvent"] = true;
["MovementUpdate"] = true;
["FollowRelationshipChange"] = true;
["OnMessageDoneFiltering"] = true;
["SendNotification"] = true;
["SetDialogInUse"] = true;
["OnUnmuted"] = true;
["MutePlayerRequested"] = true;
["OnChannelJoined"] = true;
["OnNewMessage"] = true;
["SendNotificationInfo"] = true;
["GetFollowRelationships"] = true;
["GuiInsetChanged"] = true;
["NewFollower"] = true;
["OnNewSystemMessage"] = true;
["GetServerVersion"] = true;
["GetInitDataRequest"] = true;
["OnMainChannelSet"] = true;
["DefaultServerSoundEvent"] = true;
["ChannelNameColorUpdated"] = true;
["UnMutePlayerRequest"] = true;
["OnChannelLeft"] = true;
["SayMessageRequest"] = true;
["SetBlockedUserIdsRequest"] = true;
["FollowRelationshipChanged"] = true;
["GamepadNotifications"] = true;
["OnMuted"] = true;
["MutePlayerRequest"] = true;
}

function StartSpy()
local Remotes = {}
local function MakeItem(v,pos)
local temp = RemoteTemplate:Clone()
local map = IconFrame:Clone()
v[2] = temp
LoadIcon(v[1].ClassName,map)
map.Position = UDim2.new(0,10,0.5,-8)
map.Parent = temp
temp.Name = pos/40
temp.RemoteName.Text = v[1].Name
temp.Parent = Scroller
temp.Position = UDim2.new(0,0,0,pos)
temp.SpyRemote.TextColor3 = Color3.fromRGB(170, 46, 46)
temp.SpyRemote.Position = UDim2.new(0,20+temp.RemoteName.TextBounds.X+15,0.225,0)
temp.PathButton.Position = UDim2.new(temp.PathButton.Size.X.Scale,20+temp.RemoteName.TextBounds.X+15,0.225,0)
temp.OpenButton.Position = UDim2.new(temp.OpenButton.Size.X.Scale+temp.PathButton.Size.X.Scale,temp.RemoteName.TextBounds.X,0.225,0)
if Spying[v[1]] then
temp.SpyRemote.TextColor3 = Color3.fromRGB(0, 170, 127)
else
temp.SpyRemote.TextColor3 = Color3.fromRGB(170, 46, 46)
end
temp.SpyRemote.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(temp.SpyRemote,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)
temp.SpyRemote.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(temp.SpyRemote,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)
temp.SpyRemote.MouseButton1Down:Connect(function()
if not Spying[v[1]] then
Spying[v[1]] = v[1]
game:GetService("TweenService"):Create(temp.SpyRemote,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(0, 170, 127);}):Play()
else
Spying[v[1]] = nil
game:GetService("TweenService"):Create(temp.SpyRemote,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(170, 46, 46);}):Play()
end
end)
temp.PathButton.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(temp.PathButton,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)
temp.PathButton.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(temp.PathButton,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)
temp.OpenButton.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(temp.OpenButton,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(80, 80, 80);}):Play()
end)
temp.OpenButton.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(temp.OpenButton,TweenInfo.new(0.25),{BackgroundColor3=Color3.fromRGB(63, 63, 63);}):Play()
end)
temp.OpenButton.MouseButton1Down:Connect(function()
local suc,er = pcall(function() setclipboard("game."..v[1]:GetFullName()) end)
local suc,er = pcall(function() toclipboard("game."..v[1]:GetFullName()) end)
local suc,er = pcall(function() Synapse:CopyString("game."..v[1]:GetFullName()) end)
local suc,er = pcall(function() Clipboard.set("game."..v[1]:GetFullName()) end)
game:GetService("TweenService"):Create(temp.OpenButton,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(200, 200, 200);}):Play()
wait(0.1)
game:GetService("TweenService"):Create(temp.OpenButton,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
end)
local recurNumb = 1
local path = {}
local Numb = 0
temp.PathButton.MouseButton1Down:Connect(function()
recurNumb = 1
Numb = 0
local function Recur(obj)
if obj == game then
return
else
path[recurNumb] = obj
end
recurNumb = recurNumb + 1
Recur(obj.Parent)
end
Recur(v[1])
Scroller2:ClearAllChildren()
local OGParent
local maxTextX = 0
for ii = #path,1,-1 do
local obj = path[ii]
local UI = PathTemplate:Clone()
local Icon = IconFrame:Clone()
local mode = IconModeFrame:Clone()
if ii > 1 then
mode.Parent = UI
mode.Position = UDim2.new(0,-20,0.5,-8)
LoadIcon(nil,mode,167)
end
LoadIcon(obj.ClassName,Icon)
Icon.Position = UDim2.new(0,0,0.5,-8)
Icon.Parent = UI
UI.Name = "OBJ"
UI.PathName.Text = obj.Name
UI.Position = UDim2.new(0,20,0,21)
UI.Size = UDim2.new(0,100,0,20)
Numb = Numb+1
local opened = true
mode.MouseEnter:Connect(function()
if not opened then
LoadIcon(nil,mode,180)
else
LoadIcon(nil,mode,181)
end
end)
mode.MouseLeave:Connect(function()
if not opened then
LoadIcon(nil,mode,166)
else
LoadIcon(nil,mode,167)
end
end)
mode.Button.MouseButton1Down:Connect(function()
if not opened then
opened = true
LoadIcon(nil,mode,181)
UI.OBJ.Visible = true
else
opened = false
LoadIcon(nil,mode,180)
UI.OBJ.Visible = false
end
end)
UI.HoverFrame.MouseEnter:Connect(function()
game:GetService("TweenService"):Create(UI.HoverFrame,TweenInfo.new(0.25),{["BackgroundTransparency"] = 0.9;}):Play()
end)
UI.HoverFrame.MouseLeave:Connect(function()
game:GetService("TweenService"):Create(UI.HoverFrame,TweenInfo.new(0.25),{["BackgroundTransparency"] = 1;}):Play()
end)
if not OGParent then
UI.Position = UDim2.new(0,22,0,4)
UI.Parent = Scroller2
OGParent = UI
else
UI.Parent = OGParent
OGParent = UI
end
if maxTextX < UI.PathName.TextBounds.X then
maxTextX = UI.PathName.TextBounds.X
end
end
Scroller2.CanvasSize = UDim2.new(0,(maxTextX+(#path*20))+10,0,(Numb*21)+4)
game:GetService("TweenService"):Create(temp.PathButton,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(200, 200, 200);}):Play()
wait(0.1)
game:GetService("TweenService"):Create(temp.PathButton,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
end)
end
local function LoadUI()
Scroller:ClearAllChildren()
local pos = 0
for i,v in pairs(Remotes) do
if v then
MakeItem(v, pos)
pos = pos+40
end
end
Scroller.CanvasSize = UDim2.new(0,0,0,pos)
end
local function GetRemotes()
local function Recursion(obj)
for i,v in pairs(obj:GetChildren()) do
local succ,err = pcall(function()
if not RemoteIgnores[v.Name] then
if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") or v:IsA("BindableEvent") or v:IsA("BindableFunction") then
Remotes[v] = {v}
end
end
end)
local suc,er = pcall(function()
v:GetChildren()
end)
if suc and #v:GetChildren() > 0 then
Recursion(v)
end
end
end
Recursion(game)
end
GetRemotes()
LoadUI()
for i,v in pairs(game:GetChildren()) do
local suc, er = pcall(function()
v:GetChildren()
end)
if suc then
v.DescendantAdded:Connect(function(obj)
wait(1)
if not RemoteIgnores[obj.Name] then
if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") or obj:IsA("BindableEvent") or obj:IsA("BindableFunction") then
Remotes[obj] = {obj}
MakeItem(Remotes[obj],((#Scroller:GetChildren())*40))
Scroller.CanvasSize = UDim2.new(0,0,0,Scroller.CanvasSize.Y.Offset+40)
end
end
end)
v.DescendantRemoving:Connect(function(obj)
if not RemoteIgnores[obj.Name] then
if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") or obj:IsA("BindableEvent") or obj:IsA("BindableFunction") then
if Remotes[obj] then
for ii = tonumber(Remotes[obj][2].Name),#Scroller:GetChildren() do
if ii ~= tonumber(Remotes[obj][2].Name) then
local it = Scroller:FindFirstChild(ii)
if it then
it.Position = UDim2.new(0,0,0,it.Position.Y.Offset-40)
it.Name = tonumber(it.Name) - 1
end
end
end
Scroller.CanvasSize = UDim2.new(0,0,0,Scroller.CanvasSize.Y.Offset-40)
Remotes[obj][2]:Destroy()
Remotes[obj] = nil
end
end
end
end)
end
end
spyAll.MouseButton1Down:Connect(function()
spawn(function()
game:GetService("TweenService"):Create(spyAll,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(200, 200, 200);}):Play()
wait(0.1)
game:GetService("TweenService"):Create(spyAll,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
end)
for i,v in pairs(Remotes) do
game:GetService("TweenService"):Create(v[2].SpyRemote,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(0, 170, 127);}):Play()
Spying[v[1]] = v[1]
end
end)
UnspyAll.MouseButton1Down:Connect(function()
spawn(function()
game:GetService("TweenService"):Create(UnspyAll,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(200, 200, 200);}):Play()
wait(0.1)
game:GetService("TweenService"):Create(UnspyAll,TweenInfo.new(0.1),{TextColor3=Color3.fromRGB(255, 255, 255);}):Play()
end)
for i,v in pairs(Remotes) do
game:GetService("TweenService"):Create(v[2].SpyRemote,TweenInfo.new(0.25),{TextColor3=Color3.fromRGB(170, 46, 46);}):Play()
Spying[v[1]] = nil
end
end)
end
StartSpy()

--== End ==--