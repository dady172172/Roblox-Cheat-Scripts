local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local function TweenTo(v, t)
	local p = v
	if typeof(v) == "Vector3" then
		p = v
	elseif typeof(v) == "CFrame" then
			p = Vector3.new(v.X, v.Y, v.Z)
	elseif typeof(v) == "Instance" then
		if v.ClassName == "MeshPart" then
			local objHeight = v:GetExtentsSize().Y
			local pos = v.Position
			p = Vector3.new(pos.X, pos.Y + (objHeight / 2), pos.Z)
		elseif v.ClassName == "Part" then
			local objHeight = v.Size.Y
			local pos = v.Position
			p = Vector3.new(pos.X, pos.Y + (objHeight / 2), pos.Z)
		end
	else
		warn("Could not find a CFrame or Position to tween to.")
		return
	end
	
	local canCollideSave = {}
	for i,v in pairs(char:GetChildren()) do
		if typeof(v) == "MeshPart" or typeof(v) == "Part" then
			if v.CanCollide then
				table.insert(canCollideSave, v)
				v.CanCollide = false
			end
		end
	end
	hrp.Anchored = true
	hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
	

	local ts = game:GetService("TweenService")
	local time = (hrp.Position - p).Magnitude / hum.WalkSpeed
	if t ~= nil then
		time = (hrp.Position - p).Magnitude / t
	end
	
	local ti = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
	local cf = Instance.new("CFrameValue")
	cf.Value = char:GetPrimaryPartCFrame()
	cf:GetPropertyChangedSignal("Value"):Connect(function()
		char:SetPrimaryPartCFrame(cf.Value)
	end)
	local c = CFrame.new(p.X, p.Y + (char:GetExtentsSize().Y / 3), p.Z)
	local tween = ts:Create(cf, ti, {Value = c})
	tween:Play()
	tween.Completed:Wait()
	
	for i,v in pairs(canCollideSave) do
		if v.CanCollide then			
			v.CanCollide = true
		end
	end
	hrp.Anchored = false
	hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
end

TweenTo(game.Workspace.TestPart)