--[[
Game https://www.roblox.com/games/4186060228/UPDATE-2-Pickaxe-Simulator
contact/more https://github.com/dady172172/Roblox-Cheats
]]--

--auto harvest and sell from rock in spawn. must be near rock in spawn
_G.shit = true
while _G.shit == true do
    wait(.1)
    game.ReplicatedStorage.Events.Server.Sell:FireServer()
    game.ReplicatedStorage.Events.Server.OreNodes.PickaxeStrike:FireServer(Workspace.Resources.OreSpawners["100"])
end

--teleports you to gems on the map
for _,v in pairs(game:GetService("Workspace").Resources.Pickups:GetChildren()) do
   if string.match(v.Name, "Gems") then
       Wait(1)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
   end
end

--teleports to all islands for pickaxe and bag unlock
for _,v in pairs(game:GetService("Workspace").Resources.Islands:getChildren()) do
	wait()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
end