local CCPGui = Instance.new("ScreenGui")

local MainFrame = Instance.new("Frame")
local CopyCurrentPositionButton = Instance.new("TextButton")

CCPGui.Name = "CCPGui"
CCPGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = CCPGui
MainFrame.BackgroundColor3 = Color3.new(1, 1, 1)
MainFrame.BorderSizePixel = 2
MainFrame.Position = UDim2.new(0.25, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Active = true
MainFrame.Draggable = true

CopyCurrentPositionButton.Name = "CopyCurrentPositionButton"
CopyCurrentPositionButton.Parent = MainFrame
CopyCurrentPositionButton.BackgroundColor3 = Color3.new(1, 1, 1)
CopyCurrentPositionButton.BorderSizePixel = 2
CopyCurrentPositionButton.Position = UDim2.new(0.05, 0, 0.15, 0)
CopyCurrentPositionButton.Size = UDim2.new(0.9, 0, 0.7, 0)
CopyCurrentPositionButton.Font = Enum.Font.SourceSansBold
CopyCurrentPositionButton.FontSize = Enum.FontSize.Size14
CopyCurrentPositionButton.Text = "Copy Current Position"
CopyCurrentPositionButton.TextScaled = true
CopyCurrentPositionButton.TextSize = 14
CopyCurrentPositionButton.TextWrapped = true

local function RoundNumber(Number, Divider)
Divider = Divider or 1
return (math.floor((Number/Divider)+0.5)*Divider)
end

CopyCurrentPositionButton.MouseButton1Down:connect(function()
syn.write_clipboard("game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(" .. tostring(Vector3.new(RoundNumber(game.Players.LocalPlayer.Character.Head.Position.X,1),RoundNumber(game.Players.LocalPlayer.Character.Head.Position.Y-1.5,1),RoundNumber(game.Players.LocalPlayer.Character.Head.Position.Z,1))) .. ")")
end)