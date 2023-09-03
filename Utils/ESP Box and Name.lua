getgenv().boolEsp = true
kVars = {}
kVars.lp = game.Players.LocalPlayer
kVars.Esp = {}
kVars.ConnectPlayerRemoving = game.Players.PlayerRemoving:Connect(function(player)
    if kVars.Esp[player.Name] then
        kVars.Esp[player.Name].sq:Remove()
        kVars.Esp[player.Name].txt:Remove()
    end

end)

function mean(t)
    local add = 0
    for i,v in pairs(t) do
        add = add + v
    end
    return add / #t
end
while boolEsp do
    task.wait()
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Character and v.Character:FindFirstChild("Head") then
            if v.Name ~= kVars.lp.Name then
                if not kVars.Esp[v.Name] then
                    kVars.Esp[v.Name] = {}
                    local pHead = v.Character.Head
                    local pHrp = v.Character.HumanoidRootPart 
                    -- esp square
                    kVars.Esp[v.Name].sq = Drawing.new("Square")
                    kVars.Esp[v.Name].sq.Visible = false
                    kVars.Esp[v.Name].sq.Thickness = 1
                    kVars.Esp[v.Name].sq.Size = Vector2.new(10,10)
                    kVars.Esp[v.Name].sq.Filled = false
                    local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(pHead.Position)
                    kVars.Esp[v.Name].sq.Position = Vector2.new(vector.x, vector.y)
                    -- esp text
                    kVars.Esp[v.Name].txt = Drawing.new("Text")
                    kVars.Esp[v.Name].txt.Visible = false
                    kVars.Esp[v.Name].txt.Size = 16
                    kVars.Esp[v.Name].txt.Color = Color3.fromRGB(0, 255, 60)
                    kVars.Esp[v.Name].txt.Transparency = 1
                    kVars.Esp[v.Name].txt.ZIndex = 1
                    kVars.Esp[v.Name].txt.Center = true
                    kVars.Esp[v.Name].txt.Font = 3
                    kVars.Esp[v.Name].txt.Outline = true
                    kVars.Esp[v.Name].txt.OutlineColor = Color3.fromRGB(0, 0, 0)
                    kVars.Esp[v.Name].txt.Text = v.Name
                end
                local vector, onScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(v.Character.Head.Position)                
                if onScreen then
                    local tHead = v.Character.Head
                    local tHrp = v.Character.HumanoidRootPart
                    local distBetHeadHrp = Vector3.new(mean({tHead.Position.x, tHrp.Position.x}),mean({tHead.Position.y, tHrp.Position.y}),mean({tHead.Position.z, tHrp.Position.z}))
                    local screenDistBetHeadHrp, onscreenDistBetHeadHrp = game.Workspace.CurrentCamera:WorldToViewportPoint(distBetHeadHrp)
                    local screenPosHead, onscreenPosHead = game.Workspace.CurrentCamera:WorldToViewportPoint(tHead.Position)
                    local screenPosHrp, onscreenPosHrp = game.Workspace.CurrentCamera:WorldToViewportPoint(tHrp.Position)
                    local diffScreen = (screenPosHead - screenPosHrp).Magnitude
                    kVars.Esp[v.Name].sq.Visible = true
                    kVars.Esp[v.Name].sq.Position = Vector2.new((screenDistBetHeadHrp.x - diffScreen), (screenDistBetHeadHrp.y - diffScreen)) 
                    kVars.Esp[v.Name].sq.Size = Vector2.new(diffScreen * 2, diffScreen * 3)
                    kVars.Esp[v.Name].txt.Visible = true
                    kVars.Esp[v.Name].txt.Position = Vector2.new((screenPosHead.x), (kVars.Esp[v.Name].sq.Position.y - diffScreen))

                else
                    kVars.Esp[v.Name].sq.Visible = false
                    kVars.Esp[v.Name].txt.Visible = false

                end
            end
        end
    end

end

kVars.ConnectPlayerRemoving:Disconnect()
script:Destroy()
return
        