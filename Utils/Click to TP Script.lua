kVars = {}
kVars.mouseTP = {}
kVars.mouse = game.Players.LocalPlayer:GetMouse()
kVars.character = game.Players.LocalPlayer.Character
kVars.mouse.KeyDown:connect(function(key)
	if key == "f" then
		if kVars.mouse.Target then
			local plrHeightHalf = (kVars.character.Head.Position - kVars.character.LeftFoot.Position).magnitude/2
			kVars.character.HumanoidRootPart.CFrame = CFrame.new(kVars.mouse.Hit.x, kVars.mouse.Hit.y + plrHeightHalf, kVars.mouse.hit.z)
		end
	end
end)
