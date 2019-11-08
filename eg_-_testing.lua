--https://www.roblox.com/games/2747834912/HALLOWEEN-eg-testing
--https://github.com/dady172172/Roblox-Cheats
local array1 = {
"mountaincoins",
"desertcoins",
"oceancoins",
"autumncoins",
"forestcoins",
"plainscoins",
"icecoins",
"cavecoins",
"skyislandcoins",
"thiefcoins",
"secretcoins",
"abysscoins",
}

while wait() do
	
	for _,i in ipairs(array1) do
		print(i)
		
		for _,v in pairs(game:GetService("Workspace").coinspawns[i]:GetChildren()) do 
			for _,g in pairs(v:GetChildren()) do 
				if string.match(g.Name, "coin") then
					print(g.Name)
					wait(.2)
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = g.CFrame
				end
			end
		end
		
	end
end