--[[
Game : https://www.roblox.com/games/11166344460
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats : https://discord.gg/MhMB3c2CBn
GUI Made by : xTheAlex14 : https://teppyboy.github.io/Mirrors/Documentations/Zypher_UI/zypher.wtf/docs/uilibdocs.html
]]--

-- game name = Easy Stud Jumps Obby
-- true/false = start/stop
getgenv().farm = true
while getgenv().farm do
    local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
    hrp.CFrame = game:GetService("Workspace").Checkpoints.Spawn[60].CFrame
    wait(.3)
    hrp.CFrame = CFrame.new(199, 1267, -988)
    wait(.1)
    keypress(0x45)
    wait(1.5)
    keyrelease(0x45)
    wait(1)
end