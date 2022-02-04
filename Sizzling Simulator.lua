--[[
Game : https://www.roblox.com/games/4572547530/Sizzling-Simulator
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
]]--

-------
--drop off meat and collect goins "loop"
-------
_G.dropCollect = true
while _G.dropCollect == true do
	wait(1)
	game.ReplicatedStorage.RemoteEvent:FireServer("Drop Off Meat")
	game.ReplicatedStorage.RemoteEvent:FireServer("Collect Grill Coins")
end