for _, v in	pairs(game.CoreGui:GetChildren()) do
	if v.Name == "HealyUI" then
		v:Destroy()
	end
end

local Mouse = game.Players.LocalPlayer:GetMouse()
local uis = game:GetService("UserInputService")

local HealyUI = Instance.new("ScreenGui")

HealyUI.Name = "HealyUI"
HealyUI.Parent = game.CoreGui

local function getNextWindowPos()
	local biggest = 0;
	local ok = nil;
	for i, v in pairs(HealyUI:GetChildren()) do
		if v.Position.X.Offset > biggest then
			biggest = v.Position.X.Offset
			ok = v;
		end
	end
	if biggest == 0 then
		biggest = biggest + 5;
	else
		biggest = biggest + ok.Size.X.Offset + 5;
	end
	
	return biggest;
end

local Library = {}

function Library:Window(title)
	local Window = Instance.new("ImageLabel")
	local Body = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local Back = Instance.new("Frame")
	local BottomRound = Instance.new("ImageLabel")
	local BottomBack = Instance.new("Frame")
	local Title = Instance.new("TextLabel")

	Window.Name = "Window"
	Window.Parent = HealyUI
	Window.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Window.BackgroundTransparency = 1.000
	Window.Position = UDim2.new(0, getNextWindowPos() + 10, 0, 10)
	Window.Size = UDim2.new(0, 125, 0, 31)
	Window.ZIndex = 4
	Window.Image = "rbxassetid://3570695787"
	Window.ImageColor3 = Color3.fromRGB(43, 43, 43)
	Window.ScaleType = Enum.ScaleType.Slice
	Window.SliceCenter = Rect.new(100, 100, 100, 100)
	Window.SliceScale = 0.120
	Window.Active = true
	Window.Draggable = true

	Body.Name = "Body"
	Body.Parent = Window
	Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Body.BackgroundTransparency = 1.000
	Body.Size = UDim2.new(1, 0, 1, 0)
	Body.ZIndex = 3

	UIListLayout.Parent = Body
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UIPadding.Parent = Body
	UIPadding.PaddingTop = UDim.new(0, 15)

	Back.Name = "Back"
	Back.Parent = Body
	Back.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	Back.BorderSizePixel = 0
	Back.Size = UDim2.new(1, 0, 0, 16)

	BottomRound.Name = "BottomRound"
	BottomRound.Parent = Body
	BottomRound.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BottomRound.BackgroundTransparency = 1.000
	BottomRound.Size = UDim2.new(1, 0, 0, 10)
	BottomRound.Image = "rbxassetid://3570695787"
	BottomRound.ImageColor3 = Color3.fromRGB(43, 43, 43)
	BottomRound.ScaleType = Enum.ScaleType.Slice
	BottomRound.SliceCenter = Rect.new(100, 100, 100, 100)
	BottomRound.SliceScale = 0.120
	BottomRound.LayoutOrder = 2

	BottomBack.Name = "BottomBack"
	BottomBack.Parent = BottomRound
	BottomBack.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	BottomBack.BorderSizePixel = 0
	BottomBack.Size = UDim2.new(1, 0, 0, 5)

	Title.Name = "Title"
	Title.Parent = Window
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Size = UDim2.new(1, 0, 1, 0)
	Title.ZIndex = 4
	Title.Text = title
	Title.Font = Enum.Font.SourceSans
	Title.TextColor3 = Color3.fromRGB(234, 234, 234)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true

	local Lib = {}

	function Lib:Button(name, callback)
		local ButtonContainer = Instance.new("Frame")
		local Button = Instance.new("TextButton")

		ButtonContainer.Name = "ButtonContainer"
		ButtonContainer.Parent = Body
		ButtonContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
		ButtonContainer.BorderSizePixel = 0
		ButtonContainer.Size = UDim2.new(1, 0, 0, 31)

		Button.Name = "Button"
		Button.Parent = ButtonContainer
		Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		Button.BorderSizePixel = 0
		Button.Position = UDim2.new(0.0599999987, 0, 0.129032254, 0)
		Button.Size = UDim2.new(0.870000005, 0, 0.709677398, 0)
		Button.Font = Enum.Font.SourceSans
		Button.Text = name
		Button.TextColor3 = Color3.fromRGB(234, 234, 234)
		Button.TextScaled = true
		Button.TextSize = 14.000
		Button.TextWrapped = true
		Button.ClipsDescendants = true

		Button.MouseButton1Down:connect(function()
			callback()
		end)

		Button.MouseButton1Down:connect(function()
			local c = Instance.new("ImageLabel", Button)
			c.BackgroundTransparency = 1
			c.Image = "rbxassetid://3570695787"
			c.ImageTransparency = 0.6
			c.Position = UDim2.new(0, (Mouse.X - c.AbsolutePosition.X), 0, (Mouse.Y - c.AbsolutePosition.Y))
			c.ScaleType = "Slice"
			c.SliceCenter = Rect.new(100, 100, 100, 100)
			c.SliceScale = 1
			local Size = 0
			if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
				Size = Button.AbsoluteSize.X * 1.5
			elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
				Size = Button.AbsoluteSize.Y * 1.5
			elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then
				Size = Button.AbsoluteSize.X * 1.5
			end
			c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(.5, -Size / 2, .5, -Size / 2), "Out", "Linear", .5)
			Button.MouseButton1Up:Connect(function()
				while c.ImageTransparency ~= 1 do
					wait()
					c.ImageTransparency = c.ImageTransparency + 0.02
					if c.ImageTransparency == 1 then
						c:Destroy()
					end
				end
			end)
		end)

	end

	function Lib:Toggle(name, callback)
		local Enabled = false
		local ToggleContainer = Instance.new("Frame")
		local ToggleLabel = Instance.new("TextLabel")
		local Toggle = Instance.new("TextButton")

		ToggleContainer.Name = "ToggleContainer"
		ToggleContainer.Parent = Body
		ToggleContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
		ToggleContainer.BorderSizePixel = 0
		ToggleContainer.Size = UDim2.new(1, 0, 0, 31)

		ToggleLabel.Name = "ToggleLabel"
		ToggleLabel.Parent = ToggleContainer
		ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleLabel.BackgroundTransparency = 1.000
		ToggleLabel.Position = UDim2.new(0.0599999987, 0, 0.128999993, 0)
		ToggleLabel.Size = UDim2.new(0.870000005, 0, 0.709999979, 0)
		ToggleLabel.Font = Enum.Font.SourceSans
		ToggleLabel.Text = name
		ToggleLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
		ToggleLabel.TextScaled = true
		ToggleLabel.TextSize = 14.000
		ToggleLabel.TextWrapped = true
		ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

		Toggle.Name = "Toggle"
		Toggle.Parent = ToggleContainer
		Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		Toggle.BorderSizePixel = 0
		Toggle.Position = UDim2.new(0.750000119, 0, 0.225806445, 0)
		Toggle.Size = UDim2.new(0.180000022, 0, 0.484161377, 0)
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = ""
		Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
		Toggle.TextSize = 14.000
		Toggle.ClipsDescendants = true

		Toggle.MouseButton1Down:connect(function()
			Enabled = not Enabled
			if Enabled == true then
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 140, 45)
			else
				Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
			end
			callback(Enabled)
		end)

		Toggle.MouseButton1Down:connect(function()
			local c = Instance.new("ImageLabel", Toggle)
			c.BackgroundTransparency = 1
			c.Image = "rbxassetid://3570695787"
			c.ImageTransparency = 0.6
			c.Position = UDim2.new(0, (Mouse.X - c.AbsolutePosition.X), 0, (Mouse.Y - c.AbsolutePosition.Y))
			c.ScaleType = "Slice"
			c.SliceCenter = Rect.new(100, 100, 100, 100)
			c.SliceScale = 1
			local Size = 0
			if Toggle.AbsoluteSize.X > Toggle.AbsoluteSize.Y then
				Size = Toggle.AbsoluteSize.X * 1.5
			elseif Toggle.AbsoluteSize.X < Toggle.AbsoluteSize.Y then
				Size = Toggle.AbsoluteSize.Y * 1.5
			elseif Toggle.AbsoluteSize.X == Toggle.AbsoluteSize.Y then
				Size = Toggle.AbsoluteSize.X * 1.5
			end
			c:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(.5, -Size / 2, .5, -Size / 2), "Out", "Linear", .5)
			Toggle.MouseButton1Up:Connect(function()
				while c.ImageTransparency ~= 1 do
					wait()
					c.ImageTransparency = c.ImageTransparency + 0.02
					if c.ImageTransparency == 1 then
						c:Destroy()
					end
				end
			end)
		end)

	end

	function Lib:Dropdown(name, list, callback)
		local DropdownContainer = Instance.new("Frame")
		local Opened = false
		local Dropdown = Instance.new("TextButton")
		local DropdownLabel = Instance.new("TextLabel")
		local Arrow2 = Instance.new("TextLabel")
		local Arrow1 = Instance.new("TextLabel")
		local DropdownBody = Instance.new("Frame")
		local DropdownUIListLayout = Instance.new("UIListLayout")
		local DropdownUIPadding = Instance.new("UIPadding")

		DropdownContainer.Name = "DropdownContainer"
		DropdownContainer.Parent = Body
		DropdownContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
		DropdownContainer.BorderSizePixel = 0
		DropdownContainer.Size = UDim2.new(1, 0, 0, 31)

		Dropdown.Name = "Dropdown"
		Dropdown.Parent = DropdownContainer
		Dropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		Dropdown.BorderSizePixel = 0
		Dropdown.Position = UDim2.new(0.0599999987, 0, 0.128999993, 0)
		Dropdown.Size = UDim2.new(0.870000005, 0, 0.709999979, 0)
		Dropdown.ZIndex = 3
		Dropdown.Font = Enum.Font.SourceSans
		Dropdown.Text = ""
		Dropdown.TextColor3 = Color3.fromRGB(234, 234, 234)
		Dropdown.TextScaled = true
		Dropdown.TextSize = 14.000
		Dropdown.TextWrapped = true

		DropdownLabel.Name = "DropdownLabel"
		DropdownLabel.Parent = Dropdown
		DropdownLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownLabel.BackgroundTransparency = 1.000
		DropdownLabel.Position = UDim2.new(0.172413886, 0, -3.46633101e-07, 0)
		DropdownLabel.Size = UDim2.new(0.643678069, 0, 0.954111993, 0)
		DropdownLabel.ZIndex = 3
		DropdownLabel.Font = Enum.Font.SourceSans
		DropdownLabel.Text = name
		DropdownLabel.TextColor3 = Color3.fromRGB(234, 234, 234)
		DropdownLabel.TextScaled = true
		DropdownLabel.TextSize = 14.000
		DropdownLabel.TextWrapped = true

		Arrow2.Name = "Arrow2"
		Arrow2.Parent = Dropdown
		Arrow2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Arrow2.BackgroundTransparency = 1.000
		Arrow2.Position = UDim2.new(-0.0109999999, 0, -0.022830531, 0)
		Arrow2.Rotation = 180.000
		Arrow2.Size = UDim2.new(0, 16, 0, 21)
		Arrow2.ZIndex = 3
		Arrow2.Font = Enum.Font.SourceSans
		Arrow2.Text = "^"
		Arrow2.TextColor3 = Color3.fromRGB(234, 234, 234)
		Arrow2.TextScaled = true
		Arrow2.TextSize = 14.000
		Arrow2.TextWrapped = true

		Arrow1.Name = "Arrow1"
		Arrow1.Parent = Dropdown
		Arrow1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Arrow1.BackgroundTransparency = 1.000
		Arrow1.Position = UDim2.new(0.815999985, 0, -0.022830531, 0)
		Arrow1.Rotation = 180.000
		Arrow1.Size = UDim2.new(0, 16, 0, 21)
		Arrow1.ZIndex = 3
		Arrow1.Font = Enum.Font.SourceSans
		Arrow1.Text = "^"
		Arrow1.TextColor3 = Color3.fromRGB(234, 234, 234)
		Arrow1.TextScaled = true
		Arrow1.TextSize = 14.000
		Arrow1.TextWrapped = true

		DropdownBody.Name = "DropdownBody"
		DropdownBody.Parent = Dropdown
		DropdownBody.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		DropdownBody.BackgroundTransparency = 1.000
		DropdownBody.Size = UDim2.new(1, 0, 0, 0)
		DropdownBody.Visible = false
		DropdownBody.ZIndex = 2

		DropdownUIListLayout.Name = "DropdownUIListLayout"
		DropdownUIListLayout.Parent = DropdownBody
		DropdownUIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

		DropdownUIPadding.Name = "DropdownUIPadding"
		DropdownUIPadding.Parent = DropdownBody
		DropdownUIPadding.PaddingTop = UDim.new(0, 22)

		Dropdown.MouseButton1Down:connect(function()
			if Opened == true then
				DropdownBody:TweenSize(UDim2.fromScale(1, 0))
				game:GetService("TweenService"):Create(DropdownBody, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.fromScale(1, 0)
				}):Play();
				for _, v in pairs(DropdownBody:GetChildren()) do
					if v:IsA("TextButton") then
						v:TweenSize(UDim2.new(1, 0, 0, 0))
					end
				end
				wait(0.5)
				DropdownBody.Visible = false
				Opened = false
				Dropdown.ZIndex = 3
				Arrow1.ZIndex = 3
				Arrow2.ZIndex = 3
				DropdownLabel.ZIndex = 3
				for _, v in pairs(DropdownBody:GetChildren()) do
					if v:IsA("TextButton") then
						v.ZIndex = 2
					end
				end
			else
				if Opened == false then
					game:GetService("TweenService"):Create(DropdownBody, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.fromScale(1, 1)
					}):Play();
					for _, v in pairs(DropdownBody:GetChildren()) do
						if v:IsA("TextButton") then
							v:TweenSize(UDim2.new(1, 0, 0, 22))
							v.ZIndex = 4
						end
					end
					Dropdown.ZIndex = 5
					Arrow1.ZIndex = 5
					Arrow2.ZIndex = 5
					DropdownLabel.ZIndex = 5
					DropdownBody.Visible = true
					Opened = true
				end
			end
		end)

		for _, v in pairs(list) do
			local DropdownOption = Instance.new("TextButton")
	
			DropdownOption.Name = "DropdownOption"
			DropdownOption.Parent = DropdownBody
			DropdownOption.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
			DropdownOption.BorderSizePixel = 0
			DropdownOption.Size = UDim2.new(1, 0, 0, 0)
			DropdownOption.ZIndex = 2
			DropdownOption.Text = v
			DropdownOption.Font = Enum.Font.SourceSans
			DropdownOption.TextColor3 = Color3.fromRGB(234, 234, 234)
			DropdownOption.TextScaled = true
			DropdownOption.TextSize = 14.000
			DropdownOption.TextWrapped = true

			DropdownOption.MouseButton1Down:connect(function()
				DropdownBody:TweenSize(UDim2.fromScale(1, 0))
				game:GetService("TweenService"):Create(DropdownBody, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Size = UDim2.fromScale(1, 0)
				}):Play();
				for _, v in pairs(DropdownBody:GetChildren()) do
					if v:IsA("TextButton") then
						v:TweenSize(UDim2.new(1, 0, 0, 0))
					end
				end
				wait(0.5)
				DropdownBody.Visible = false
				Opened = false
				Dropdown.ZIndex = 3
				Arrow1.ZIndex = 3
				Arrow2.ZIndex = 3
				DropdownLabel.ZIndex = 3
				for _, v in pairs(DropdownBody:GetChildren()) do
					if v:IsA("TextButton") then
						v.ZIndex = 2
					end
				end
				callback(v)
	
			end)

		end
	end

	return Lib 

end

return Library