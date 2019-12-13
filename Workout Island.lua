--[[
Game https://www.roblox.com/games/4032944086/PETS-Workout-Island
More https://github.com/dady172172/Roblox-Cheats
]]--

--lift weight
_G.lw = true
while _G.lw == true do
    wait(.1)
    game.ReplicatedStorage.Remotes.LiftWeight:FireServer()
end


--collect coins

_G.coin = true
while _G.coin == true do  
    for _,v in pairs(game:GetService("Workspace"):GetChildren()) do
		if _G.coin == false then return end
        if v.Name == "CoinModel" then
            wait(.0000001)			
            local save = v.CFrame
            v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            wait(.0000001)
            v.CFrame = save
        end
    end
end