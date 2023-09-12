local lp = game:GetService("Players").LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local pfs = game:GetService("PathfindingService")
local path = pfs:CreatePath()

local function followPath(destination)
    local success, errorMessage = pcall(function()
        path:ComputeAsync(hrp.Position, destination)
    end)
    if success then
        for i,v in pairs(path:GetWaypoints()) do
            hum:MoveTo(v.Position)
            hum.MoveToFinished:Wait()
        end
    else
        print(errorMessage)
    end
end

--followPath(game:GetService("Workspace"):GetChildren()[138]["Meshes/the wood (2)"].Position)
--print("done")