--[[
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Info : Auto Clicker Script for Roblox. Simply press f key to turn on and off the auto clicker. Clicks where ever the mouse is.
]]--

getgenv().boolAutoClicker = false
game:GetService("UserInputService").InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.F then
		if boolAutoClicker then 
			getgenv().boolAutoClicker = false
		else
			getgenv().boolAutoClicker = true
			fAutoClicker()
		end
	end
end)

function fAutoClicker()
	spawn(function()
		while boolAutoClicker do
			wait()
			mouse1click()
		end
	end)
end