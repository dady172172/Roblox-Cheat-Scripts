--[[
Game https://www.roblox.com/games/2146413442/Longest-Obby-in-Roblox-2060
More https://github.com/dady172172/Roblox-Cheats
]]--

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)

_G.stop = false --set this to true to stop the loop
for i=1,2060 do
    if _G.stop == true then return end
	wait(1.1)
	pad = game:GetService("Workspace").BasicPartExists:FindFirstChild(i)
	if pad then
		padCframe = pad.CFrame	
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = padCframe
	end
end