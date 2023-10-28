local OldNameCall 
OldNameCall = hookmetamethod(game, "__namecall", function(...) 
    local Self, Args = (...), ({select(2, ...)})
    if getnamecallmethod() == "Kick" and Self == game:GetService('Players').LocalPlayer then 
        return
    end
    return OldNameCall(...)
end)