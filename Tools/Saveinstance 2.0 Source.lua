--// Save Instance GUI by logre (211438916023222273) 

--// Originally written in February 2019 (very nasty code)

local exploit = ""

if proto_execute then exploit = "proto" elseif syn then exploit = "syn" elseif VISENYA_LOADED then exploit = "visenya" else exploit = "n/a" end

if exploit == "n/a" then game:GetService("Players").LocalPlayer:Kick() end

local version = "2.4.1-EOL"

function out(text)
    if printoutput and exploit == 'proto' then
        printoutput(text,Color3.fromRGB(85, 255, 127))
    end
end

out("SaveInstance GUI version "..version.." loading...")

-- begin gui creation

local MainGui = Instance.new("ScreenGui")
local MainWindow = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local TitleLabel2 = Instance.new("TextLabel")
local DiscordLink = Instance.new("TextLabel")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local FileName = Instance.new("TextBox")
local DecompileScripts = Instance.new("TextButton")
local DecompileLabel = Instance.new("TextLabel")
local InfoLabel = Instance.new("TextLabel")
local CopyGame = Instance.new("TextButton")
local TempFolder = Instance.new("Folder",MainWindow)
TempFolder.Name = "TempFolder"
MainWindow.Parent = game:GetService("CoreGui").RobloxGui
MainGui:Destroy()

MainWindow.Name = "MainWindow"
MainWindow.BackgroundColor3 = Color3.new(0.152941, 0.152941, 0.152941)
MainWindow.BorderSizePixel = 0
MainWindow.Size = UDim2.new(0, 350, 0, 270)

--if exploit ~='proto' then
    ps = MainWindow.Size
    total = workspace.CurrentCamera.ViewportSize.X
    total2 = workspace.CurrentCamera.ViewportSize.Y
    MainWindow.Position = UDim2.new(0,(total-ps.X.Offset)/2,0,(total2-ps.Y.Offset)/2)
--else
   -- MainWindow.Position = UDim2.new(0.5,0,0.5,0)
--end

TitleBar.Name = "TitleBar"
TitleBar.Parent = MainWindow
TitleBar.BackgroundColor3 = Color3.new(0.333333, 1, 0.498039)
TitleBar.BorderSizePixel = 0
TitleBar.Size = UDim2.new(1, 0, -0.0320512839, 42)

TitleLabel.Name = "TitleLabel"
TitleLabel.Parent = TitleBar
TitleLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TitleLabel.BackgroundTransparency = 1
TitleLabel.BorderSizePixel = 0
TitleLabel.Position = UDim2.new(0.0138339922, 0, 0, 0)
TitleLabel.Size = UDim2.new(0, 188, 0, 32)
TitleLabel.Font = Enum.Font.Gotham
TitleLabel.Text = "Save Instance GUI"
TitleLabel.TextColor3 = Color3.new(0, 0, 0)
TitleLabel.TextSize = 20
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

TitleLabel2.Name = "TitleLabel2"
TitleLabel2.Parent = TitleBar
TitleLabel2.BackgroundColor3 = Color3.new(1, 1, 1)
TitleLabel2.BackgroundTransparency = 1
TitleLabel2.BorderSizePixel = 0
TitleLabel2.Position = UDim2.new(0.501903057, 0, 0.25, 0)
TitleLabel2.Size = UDim2.new(0, 99, 0, 16)
TitleLabel2.Font = Enum.Font.Gotham
TitleLabel2.Text = "by logre#2373"
TitleLabel2.TextColor3 = Color3.new(0, 0, 0)
TitleLabel2.TextSize = 14
TitleLabel2.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel2.TextYAlignment = Enum.TextYAlignment.Bottom

DiscordLink.Name = "DiscordLink"
DiscordLink.Parent = TitleBar
DiscordLink.BackgroundColor3 = Color3.new(1, 1, 1)
DiscordLink.BackgroundTransparency = 1
DiscordLink.BorderSizePixel = 0
DiscordLink.Position = UDim2.new(0.679045916, 0, 7.59717464, 0)
DiscordLink.Size = UDim2.new(0, 112, 0, 16)
DiscordLink.Font = Enum.Font.SourceSans
DiscordLink.Text = "discord.io/longscripts  "
DiscordLink.TextColor3 = Color3.new(1, 1, 1)
DiscordLink.TextSize = 14
DiscordLink.TextXAlignment = Enum.TextXAlignment.Right
DiscordLink.TextYAlignment = Enum.TextYAlignment.Bottom

ScrollingFrame.Parent = MainWindow
ScrollingFrame.BackgroundColor3 = Color3.new(1, 1, 1)
ScrollingFrame.BackgroundTransparency = 0.98000001907349
ScrollingFrame.Position = UDim2.new(0.0395256542, 0, 0.158781365, 0)
ScrollingFrame.Size = UDim2.new(0, 161, 0, 214)
ScrollingFrame.ScrollBarThickness = 0
ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left

UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 3)

FileName.Name = "FileName"
FileName.Parent = MainWindow
FileName.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
FileName.BorderSizePixel = 0
FileName.Position = UDim2.new(0.518355727, 0, 0.158781379, 0)
FileName.Size = UDim2.new(0, 163, 0, 19)
FileName.Font = Enum.Font.SourceSans
FileName.PlaceholderText = "File name"
FileName.Text = ""
FileName.TextColor3 = Color3.new(1, 1, 1)
FileName.TextSize = 14

DecompileScripts.Name = "DecompileScripts"
DecompileScripts.Parent = MainWindow
DecompileScripts.BackgroundColor3 = Color3.new(1, 0.411765, 0.411765)
DecompileScripts.BorderSizePixel = 0
DecompileScripts.Position = UDim2.new(0, 181, 0, 71)
DecompileScripts.Size = UDim2.new(0, 20, 0, 20)
DecompileScripts.Font = Enum.Font.GothamSemibold
DecompileScripts.Text = ""
DecompileScripts.TextColor3 = Color3.new(0, 0, 0)
DecompileScripts.TextScaled = true
DecompileScripts.TextSize = 2
DecompileScripts.TextWrapped = true

DecompileLabel.Name = "DecompileLabel"
DecompileLabel.Parent = MainWindow
DecompileLabel.BackgroundColor3 = Color3.new(1, 1, 1)
DecompileLabel.BackgroundTransparency = 1
DecompileLabel.Position = UDim2.new(0.584232688, 0, 0.262213916, 0)
DecompileLabel.Size = UDim2.new(0, 116, 0, 20)
DecompileLabel.Font = Enum.Font.SourceSans
DecompileLabel.Text = " Decompile scripts?"
DecompileLabel.TextColor3 = Color3.new(1, 1, 1)
DecompileLabel.TextSize = 15
DecompileLabel.TextXAlignment = Enum.TextXAlignment.Left

InfoLabel.Name = "InfoLabel"
InfoLabel.Parent = MainWindow
InfoLabel.BackgroundColor3 = Color3.new(1, 1, 1)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Position = UDim2.new(0.518355727, 0, 0.377028733, 0)
InfoLabel.Size = UDim2.new(0, 163, 0, 96)
InfoLabel.Font = Enum.Font.SourceSans

local proto_msg = [[After saving, the output file will be in the "saved" folder in the workspace folder.

If you need help, read the faq in the server or open a ticket.]]
local other_msg = [[After saving, the .rbxl file will be in your workspace folder.

If there is no file, the save failed.]]

if exploit == 'proto' then
    InfoLabel.Text = proto_msg
else
    InfoLabel.Text = other_msg
end
InfoLabel.TextColor3 = Color3.new(1, 1, 1)
InfoLabel.TextSize = 15
InfoLabel.TextWrapped = true
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.TextYAlignment = Enum.TextYAlignment.Top

CopyGame.Name = "CopyGame"
CopyGame.Parent = MainWindow
CopyGame.BackgroundColor3 = Color3.new(1, 1, 1)
CopyGame.BackgroundTransparency = 0.98000001907349
CopyGame.BorderSizePixel = 0
CopyGame.Position = UDim2.new(0.516043901, 0, 0.829430401, 0)
CopyGame.Size = UDim2.new(0, 163, 0, 29)
CopyGame.Font = Enum.Font.SourceSans
CopyGame.Text = "Copy Game"
CopyGame.TextColor3 = Color3.new(1, 1, 1)
CopyGame.TextSize = 17

local copyTable = {
    Workspace = false;
    Lighting = false;
    ReplicatedStorage = false;
    StarterGui = false;
    StarterPack = false;
    PlayerScripts = false;
    CoreGui = false;
    Nil = false
}

if exploit == 'proto' then
    for i,v in pairs(copyTable) do
        local Frame = Instance.new("Frame")
        local TextButton = Instance.new("TextButton")
        local TextLabel = Instance.new("TextLabel")
        Frame.Parent = ScrollingFrame
        Frame.BackgroundColor3 = Color3.new(0.133333, 0.133333, 0.133333)
        Frame.BorderSizePixel = 0
        Frame.Size = UDim2.new(1, 0, 0, 20)
        TextButton.Parent = Frame
        TextButton.BackgroundColor3 = Color3.new(1, 0.411765, 0.411765)
        TextButton.BorderSizePixel = 0
        TextButton.Size = UDim2.new(0, 20, 0, 20)
        TextButton.Font = Enum.Font.GothamSemibold
        TextButton.Text = ""
        TextButton.TextColor3 = Color3.new(0, 0, 0)
        TextButton.TextScaled = true
        TextButton.TextSize = 2
        TextButton.TextWrapped = true
        TextLabel.Parent = Frame
        TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0.161490679, 0, 0, 0)
        TextLabel.Size = UDim2.new(0, 135, 0, 20)
        TextLabel.Text = i
        TextLabel.Font = Enum.Font.SourceSans
        TextLabel.TextColor3 = Color3.new(1, 1, 1)
        TextLabel.TextSize = 15
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextButton.MouseButton1Click:Connect(function()
            copyTable[i] = not copyTable[i]
            if copyTable[i] then
                TextButton.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
            else
                TextButton.BackgroundColor3 = Color3.new(1, 0.411765, 0.411765)
            end
        end)
    end
else
    local img_frame = Instance.new("ImageLabel",ScrollingFrame.Parent)
    img_frame.Position = ScrollingFrame.Position
    img_frame.Size = ScrollingFrame.Size
    img_frame.BackgroundTransparency = 1
    img_frame.Image = 'rbxassetid://32348995'
    ScrollingFrame:Destroy()
    FileName:Destroy()
end
-- gui created, begin connecting functions

local UserInputService = game:GetService("UserInputService") --// rip .Draggable :pensive:
local sgui = MainWindow
local dragging
local dragInput
local dragStart
local startPos
local function update(input)
	local delta = input.Position - dragStart
	sgui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
sgui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = sgui.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
sgui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

local frame = ScrollingFrame
local layout = UIListLayout
local frameSizeY = frame.AbsoluteSize.Y
local ySize = 20
local yPadding = 5
local rows = #ScrollingFrame:GetChildren()-1
local pixels = rows*ySize + (rows-1)*yPadding
frame.CanvasSize = UDim2.new(0, 0, 0, pixels)

if exploit == 'proto' then
    local configfolder = Instance.new("Folder",TempFolder)
    configfolder.Name = "Configuration"
    local svalue = Instance.new("StringValue",TempFolder)
    svalue.Name = "LoaderScript"
    svalue.Value = [[local n=game.Lighting:FindFirstChildOfClass("Folder")local i=n.Configuration
    local function e(e,a,r)xpcall(function()a[e]=r
    end,function(e)print("Failed to set property: "..tostring(e))end)end
    local r=i.CopiedTerrain:FindFirstChildOfClass("TerrainRegion")local o=-math.floor(r.SizeInCells.X*.5)local t=-math.floor(r.SizeInCells.Y*.5)local a=-math.floor(r.SizeInCells.Z*.5)local t=Vector3int16.new(o,t,a)local a=r:FindFirstChild("WaterProperties")e("WaterColor",workspace.Terrain,a:FindFirstChild('WaterColor').Value)e("WaterReflectance",workspace.Terrain,a:FindFirstChild('WaterReflectance').Value)e("WaterTransparency",workspace.Terrain,a:FindFirstChild('WaterTransparency').Value)e("WaterWaveSize",workspace.Terrain,a:FindFirstChild('WaterWaveSize').Value)e("WaterWaveSpeed",workspace.Terrain,a:FindFirstChild('WaterWaveSpeed').Value)game.Workspace.Terrain:PasteRegion(r,t,true)for a,r in pairs(i.LightingProperties:GetChildren())do
    e(r.Name,game.Lighting,r.Value)end
    i.LightingProperties:Destroy()print("Lighting properties loaded.")i:Destroy()for r,e in pairs(n:GetChildren())do
    if e:IsA("Folder")and game:FindFirstChild(e.Name)and e.Name~="CoreGui"and e.Name~="Workspace" and e.Name~="PlayerScripts"then
    for a,r in pairs(e:GetChildren())do
    if#e:GetChildren()==0 then e:Destroy()else
    r.Parent=game[e.Name]end
    end
    e:Destroy()elseif e.Name=="CoreGui"or e.Name=="Workspace"or e.Name=="Nil"then
    e.Parent=workspace
    end
    end
    print("Objects placed.")n:Destroy()]]
    local lightprops = Instance.new("Folder",configfolder)
    lightprops.Name = "LightingProperties"
    local terfolder = Instance.new("Folder",configfolder)
    terfolder.Name = "CopiedTerrain"
    local termsg = Instance.new("Hint",TempFolder)
    termsg.Name = "deleteme"
    termsg.Text = "TO LOAD PROPERTIES AND TERRAIN, PASTE THE SCRIPT IN THE STRINGVALUE INTO THE COMMAND BAR"
end

local services = {
    Workspace = game:GetService("Workspace");
    Lighting = game:GetService("Lighting");
    ReplicatedStorage = game:GetService("ReplicatedStorage");
    StarterGui = game:GetService("StarterGui");
    StarterPack = game:GetService("StarterPack");
    PlayerScripts = game:GetService("Players").LocalPlayer.PlayerScripts;
    CoreGui = game:GetService("CoreGui");
    Nil = get_nil_instances()
}

local lightingproperties = {
    Ambient = "Color3";
    Brightness = "Float";
    ClockTime = "Float";
    ColorShift_Bottom = "Color3";
    ColorShift_Top = "Color3";
    FogColor = "Color3";
    FogEnd = "Float";
    FogStart = "Float";
    GeographicLatitude = "Float";
    GlobalShadows = "Boolean";
    OutdoorAmbient = "Color3";
    Outlines = "Boolean";
    TimeOfDay = "String"
}

for i,v in pairs(services) do
    local newf = Instance.new("Folder",TempFolder)
    newf.Name = i
end --end save template

function setLightingProperties()
    for i,v in pairs(lightingproperties) do
        if v == "Color3" then
            local value = Instance.new("Color3Value")
            value.Name = i
            value.Parent = lightprops
            value.Value = Color3.new(game.Lighting[i].r,game.Lighting[i].g,game.Lighting[i].b)
        elseif v == "String" then
            local value = Instance.new("StringValue")
            value.Name = i
            value.Parent = lightprops
            value.Value = game.Lighting[i]
        elseif v == "Boolean" then
            local value = Instance.new("BoolValue")
            value.Name = i
            value.Parent = lightprops
            value.Value = game.Lighting[i]
        elseif v == "Float" then
            local value = Instance.new("IntValue")
            value.Name = i
            value.Parent = lightprops
            value.Value = game.Lighting[i]
        end
    end
end

function copyTerrain(terrain)
    local tr = terrain:CopyRegion(terrain.MaxExtents)
	tr.Name = "SavedTerrain"
	tr.Parent = nil
	local waterProps = Instance.new("Configuration", tr)
	waterProps.Name = "WaterProperties"
	local function SaveProperty(class, name)
		local p = Instance.new(class, waterProps)
		p.Name = name
		xpcall(function()
			p.Value = terrain[name]
		end, function(err)
			out("Failed to get property: " .. tostring(err))
		end)
	end
	SaveProperty("Color3Value", "WaterColor")
	SaveProperty("NumberValue", "WaterReflectance")
	SaveProperty("NumberValue", "WaterTransparency")
	SaveProperty("NumberValue", "WaterWaveSize")
	SaveProperty("NumberValue", "WaterWaveSpeed")
	return tr
end

function copyTemplate()
    local terrainCopied = copyTerrain(workspace:FindFirstChildOfClass("Terrain"))
    setLightingProperties()
    terrainCopied.Parent = TempFolder.Configuration.CopiedTerrain
    return TempFolder
end

decomp = false

function stealGame(objs,filename,scripts)
    if exploit == 'proto' then
        local time = os.time()
        local folder = copyTemplate()
        folder.Parent = get_hidden_gui()
        for i,v in pairs(objs) do
            if v then
                if typeof(services[i]) == 'Instance' then
                    if pcall(function() return services[i]:GetChildren() end) then
                        for _,obj in pairs(services[i]:GetChildren()) do
                            local can,clone = pcall(function() return obj:Clone() end)
                            if can and typeof(clone) == "Instance" then
                                clone.Parent = folder[i]
                            end
                        end
                    end
                elseif typeof(services[i]) == 'table' then
                    for _,obj in pairs(services[i]) do
                        local can,clone = pcall(function() return obj:Clone() end)
                        if can and typeof(clone) == "Instance" then
                            clone.Parent = folder[i]
                        end
                    end
                end
            else
                folder[i]:Destroy()
            end
        end
        saveinstance(folder,filename,scripts)
        folder:Destroy()
        MainWindow:Destroy()
        out("Save complete! Time taken: "..os.time()-time)
    elseif exploit == 'syn' then
        saveinstance({noscripts = not decomp})
        MainWindow:Destroy()
    elseif exploit == 'visenya' then
        saveinstance({'full',decomp})
        MainWindow:Destroy()
    end
end

DecompileScripts.MouseButton1Click:Connect(function()
    decomp = not decomp
    if decomp then
        DecompileScripts.BackgroundColor3 = Color3.fromRGB(85, 255, 127)
    else
        DecompileScripts.BackgroundColor3 = Color3.new(1, 0.411765, 0.411765)
    end
end)

CopyGame.MouseButton1Click:Connect(function()
    if FileName.Text ~= "" and exploit == 'proto' then
        stealGame(copyTable,FileName.Text,decomp)
    elseif exploit ~= 'proto' then
        stealGame()
    end
end)

out("Loaded!")

while wait() do
    for hue = 0, 1, 1/75 do
        TitleBar.BackgroundColor3 = Color3.fromHSV(hue, 0.6, 1)
        wait()
     end
     for hue = 1, 0, -1/75 do
        TitleBar.BackgroundColor3 = Color3.fromHSV(hue, 0.6, 1)
        wait()
     end
end