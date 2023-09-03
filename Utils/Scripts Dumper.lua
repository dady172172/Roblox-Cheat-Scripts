if not isfolder then 
    warn("Your injector does not support isfolder")
    return
elseif not makefolder then 
    warn("Your injector does not support makefolder")
    return
elseif not delfolder then
    warn("Your injector does not support delfolder")
    return
elseif not writefile then
    warn("Your injector does not support writefile")
    return
elseif not decompile then
    warn("Your injector does not support decompile")
    return
end
print("This may take a while, depending on the device your using.")
local startTime = os.time()
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
if isfolder(gameName) then
    delfolder(gameName)
end
makefolder(gameName)
for a,b in pairs(game:GetChildren()) do
    local dir = gameName .. "/" .. b.Name
    for i,v in pairs(b:GetDescendants()) do
        pcall(function()
            if v.ClassName == "LocalScript" or v.ClassName == "ModuleScript" then
                if not isfolder(dir) then
                    makefolder(dir)
                end
                local a = decompile(v)
                writefile(dir .. "/" .. v:GetFullName() .. ".lua", a)
            end
        end)
    end
end
print("Done : " .. tostring(os.time() - startTime))