--[[
Game https://www.roblox.com/games/3165431732/Crystal-Gem-Simulator
contact https://github.com/dady172172/Roblox-Cheats
]]--

_G.autocollect = true -- true to auto collect gems. false to stop auto collect
while _G.autocollect and wait() do
    -- Special Gems auto collect
    for _,t in pairs(game:GetService("Workspace").DropContainers.EnchantedGems:GetChildren()) do
       for _,u in pairs(t:GetChildren()) do
           wait()
		    u.CanCollide = false
		    u.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
    end
    
    -- Normal Gems Auto Collect
    for _,i in pairs(game:GetService("Workspace").DropContainers.Gems:GetChildren()) do		
    	for _,v in pairs(i:GetChildren()) do
    	    wait()
    		v.CanCollide = false
    		v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    	end
    end
end