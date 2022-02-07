--[[
Game : https://www.roblox.com/games/8554378337
Coded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
Gui made by : FungBert : https://v3rmillion.net/member.php?action=profile&uid=1078854
Go vouch release thread : https://v3rmillion.net/showthread.php?tid=1023761
]]--

---- "Weapon Fighting Simulator"
---- moves the all drops to your position
while wait() do
    for i,v in pairs(game:GetService("Workspace").Rewards:GetChildren()) do
        if v:IsA("Part") then
            v.Position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
        end
    end
end