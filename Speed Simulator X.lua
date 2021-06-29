--https://www.roblox.com/games/3011079475/THE-KEY-QUEST-Speed-Simulator-X
--https://github.com/dady172172/Roblox-Cheats
_G.AutoClicker = false
_G.AutoRebirth = false
_G.Collecter = true 

--Collect coins and energy
while _G.Collecter == true do
	Wait(.01)
	local coin = game:GetService("Workspace"):FindFirstChild("Coin")
	local energy = game:GetService("Workspace"):FindFirstChild("Energy")
	if coin ~= nil then
		local coinMainWorld = coin:FindFirstChild("Coin")
        if coinMainWorld ~= nil then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = coin.Coin.CFrame
        else
			for _,v in pairs(game:GetService("Workspace"):GetChildren()) do
				if _G.Collecter == false then return end
				if v.Name == "Coin" then
					wait()
            		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
				end
			end
        end
	end
	if energy ~= nil then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = energy.HitBox.CFrame
	end   
end


--clicker

while _G.AutoClicker == true do 
	local virtualUser = game:GetService('VirtualUser')
	virtualUser:CaptureController()
	wait(0.116159)
	virtualUser:SetKeyUp('0x11a')
	wait(0.399961)
	virtualUser:Button1Down(Vector2.new(-0.0, -0.0), CFrame.new(-0.0, 0.0, -0.0, -0.0, 0.0, 0.0, 0.0))
	virtualUser:SetKeyDown('0x11a')
end

while _G.AutoRebirth == true do 
	wait(1)
	game:GetService("ReplicatedStorage").RemoteEvents.Rebirth:FireServer()
end