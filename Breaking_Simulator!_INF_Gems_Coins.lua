--https://www.roblox.com/games/3289941263/CODE-100K-Breaking-Simulator
--https://github.com/dady172172/Roblox-Cheats
--Sane Studios is dumb

_G.infCoins = true
_G.infGems = true
_G.removeGates = true

while _G.infCoins == true do
	wait()
	game.ReplicatedStorage.Events.GivePlayerItem:FireServer("Coins", 999999999999999999999999999999999999999999999999999999999999999999999999)
end

while infGems == true do
	wait()
	local a = game:GetService("Players").keathunsar.stats.Gems.Value
	game:GetService("Players").keathunsar.stats.Gems.Value = a + 999999999999999999999999999999999999999999999999999999999999999999999999
end

if _G.removeGates == true then
    game:GetService("Workspace").Gates:Remove()
end