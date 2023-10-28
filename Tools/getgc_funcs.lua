local funcName = "startFireBonus"
local func
local nameList = {}
for i,v in pairs(getgc()) do
    if type(v) == 'function' and not is_synapse_function(v) and getinfo(v).name then
        if  getinfo(v).name ~= "" and nameList[getinfo(v).name] == nil then
            local tmpS = getinfo(v).name
            local tmpString2 = getinfo(v).name .. " : " .. tostring(getinfo(v).source)  .. " : " .. tostring(getinfo(v).linedefined)
            nameList[tmpS] = tmpString2
        end
    end
end

for i,v in pairs(nameList) do
    rconsolewarn(v)
end


