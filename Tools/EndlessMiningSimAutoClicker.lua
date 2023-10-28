_G.Farm = true -- set to true to activate

while _G.Farm and wait() do
game:GetService("ReplicatedStorage").GameSystem.PlayerClick:FireServer()
end