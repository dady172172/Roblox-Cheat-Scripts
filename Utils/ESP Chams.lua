
local sides = {Enum.NormalId.Top, Enum.NormalId.Bottom, Enum.NormalId.Left, Enum.NormalId.Right, Enum.NormalId.Front, Enum.NormalId.Back}

function EspChar()
    --pcall(function()
        local players = game:GetService("Players")
        for i,v in pairs(players:GetChildren()) do
            local char = v.Character or v.CharacterAdded:Wait()
            if v.Name ~= game.Players.LocalPlayer.Name then
                for _,a in pairs(char:GetChildren()) do
                    if not a:FindFirstChild("ESP") then
                        if a.ClassName == "MeshPart" or a.ClassName == "Part" then
                            for _,y in pairs(sides) do
                                local sg = Instance.new("SurfaceGui")
                                sg.Name = "ESP"
                                sg.Face = y
                                sg.Adornee = a
                                sg.Parent = a
                                sg.AlwaysOnTop = true
                                sg.MaxDistance = math.huge
                                sg.LightInfluence = 0
                                sg.Brightness = 1000
                                sg.ZOffset = 1
                                local fr = Instance.new("Frame")
                                fr.Name = "ESP"
                                fr.Parent = sg
                                fr.Size = UDim2.new(1,0,1,0)
                                fr.BackgroundColor3 = Color3.new(0, 1, 0)
                                fr.Transparency = 0.3
                            end
                        end
                    end
                end
            end
        end
    --end)
end

local connectPlayerAdded = game:GetService("Players").PlayerAdded:Connect(function(player) ---- player joins game
    local connectCharacterAdded = player.CharacterAdded:Connect(function(char) ---- Character is added to workspace
        if player.Name ~= game.Players.LocalPlayer.name then
            repeat
                task.wait(.2)
            until player.Character and player.Character.Humanoid and player.Character.HumanoidRootPart
            task.wait(1)
            EspChar()
        end
    end)  
end)


EspChar()


    