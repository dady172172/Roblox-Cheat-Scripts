--[[
Game https://www.roblox.com/games/2329123383
Codded by : Keathunsar : https://github.com/dady172172/Roblox-Cheats
]]--
if 2329123383 ~= game.PlaceId then 
    warn("#### - This Script is not for this game. - ####")
    script:Destroy()
    return 
end
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local ws = game:GetService("Workspace")
local stage = lp:WaitForChild("leaderstats").Stage
repeat
    task.wait()
    firetouchinterest(hrp, ws[tostring(stage.Value + 1)], 0)
until stage.Value >= 249
hrp.CFrame = ws["250"].CFrame

