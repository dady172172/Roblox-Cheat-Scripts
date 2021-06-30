local library = loadstring(game:HttpGet("https://pastebin.com/raw/7Z6TzFnv", true))()
local example = library:CreateWindow({
  text = "Example"
})

local credits = library:CreateWindow({text='Credits'})
credits:AddLabel("Credits\nInori: Dragging\nwally: UI\n")

example:AddBox("WalkSpeed", function(object, focus)
  if focus then
      game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(object.Text) or 16
  end
end)

example:AddButton("Reset", function()
  game:GetService("Players").LocalPlayer.Character.Humanoid.Health = 0;
end)

example:AddToggle("Super Jump", function(state)
  game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = (state and 100 or 50)
end)

example:AddLabel("Now isnt that epic?");

local dropdown;
dropdown = example:AddDropdown({'Synapse', 'ProtoSmasher', 'Elysian', 'SirHurt', 'Visenya', 'Sk8r', 'JJSploit', 'Axon', 'Axon Infinite', 'Venyx', 'Game Ended', 'Ventura', 'Proxo', 'P4.0'}, function(a)
if a == 'Elysian' then
dropdown:Refresh({'A', 'B', 'C'})
end
end)