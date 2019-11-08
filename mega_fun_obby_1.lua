--https://www.roblox.com/games/12996397/Mega-Fun-Obby-2030-Stages
--https://github.com/dady172172/Roblox-Cheats

local VirtualUser=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
VirtualUser:CaptureController()
VirtualUser:ClickButton2(Vector2.new())
end)


while wait() do
    wait(.08)
    local CurStage = game.Players.LocalPlayer.leaderstats.Stage.Value
    local NextStage = CurStage + 1    
    if (NextStage == 2021) then
        game.ReplicatedStorage.ntw.RE:FireServer("prestige")
        break
    else
		local NextStagePos = Workspace.stages[NextStage].CFrame
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = NextStagePos
    end
end