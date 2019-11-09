-- Originally written by Autumn
-- Amended by asd & 3dsboy08

-- There's no reason to support Protosmasher, as it doesn't support newcclosure()

local enabled = {
    -- Set any of these objects to false to stop logging them
    BindableEvent = false,
    BindableFunction = false,
    RemoteEvent = true,
    RemoteFunction = true,
    CharacterSoundEvent = false,
    GetSetting = false,
    wear = false
    
}

local ignore = {
    CharacterSoundEvent = true
    --[[ -- I'd personally recommend keeping this commented out, as game scripts can name their remotes these
    GetSetting = true,
    GetSelection = true,
    SelectionChanged = true,
    GetAwaiting = true
    --]]
}

local metatable = assert(getrawmetatable, "needs access to function 'getrawmetatable'")(game)
if setreadonly then
    setreadonly(metatable, false)
end

local function CountTable(t)
    local count, key = 0
    repeat
        key = next(t, key)
        if key ~= nil then
            count = count + 1
        end
    until key == nil
    return count
end

local PrintTable
local function ParseObject(object, spacing, scope, checkedTables)
    local objectType = type(object)
    if objectType == "string" then
        return spacing .. string.format("%q", object)
    elseif objectType == "nil" then
        return spacing .. "nil"
    elseif objectType == "table" then
        if checkedTables[object] then
            return spacing .. tostring(object) .. " [recursive table]"
        else
            checkedTables[object] = true
            return spacing .. PrintTable(object, scope + 1, checkedTables)
        end
    elseif objectType == "userdata" then
        if typeof(object) == "userdata" then
            return spacing .. "userdata"
        else
            return spacing .. tostring(object)
        end
    else -- userdata, function, boolean, thread, number
        return spacing .. tostring(object)
    end
end
function PrintTable(t, scope, checkedTables)
    local mt = getrawmetatable(t)
    local backup = {}
    if mt and mt ~= t then
        for i, v in pairs(mt) do
            rawset(backup, i, v)
            rawset(mt, i, nil)
        end
    end

    checkedTables = checkedTables or {}
    scope = scope or 1
    local result = (checkedTables and "{" or "") .. "\n"
    local spacing = string.rep("\t", scope)
    local function parse(index, value)
        result = result .. ParseObject(index, spacing, scope, checkedTables) .. " : " .. ParseObject(value, "", scope, checkedTables) .. "\n"
    end
    if CountTable(t) ~= #t then
        table.foreach(t, parse) -- I'm very aware this is a deprecated function
    else
        for index = 1, select("#", unpack(t)) do
            parse(index, t[index])
        end
    end

    if mt and mt ~= t then
        for i, v in pairs(mt) do
            rawset(mt, rawget(backup, i), v)
        end
    end

    return result .. string.sub(spacing, 1, #spacing - 1) .. (checkedTables and "}" or "")
end

local methods = {
    BindableEvent = "Fire",
    BindableFunction = "Invoke",
    RemoteEvent = "FireServer",
    RemoteFunction = "InvokeServer"
}

local __namecall = __namecall or metatable.__namecall
local __index = __index or metatable.__index
if getgenv then
    if removeSpy then
        removeSpy()
    end
    getgenv().__namecall = __namecall
    getgenv().__index = __index
    getgenv().removeSpy = function()
        getgenv().removeSpy = nil
        metatable.__namecall = __namecall
        metatable.__index = __index
    end
end

local function RemoteCallback(self, ...)
    if typeof(self) ~= "Instance" then
        return error(select(2, pcall(__index, self))) -- magic
    end
    local arguments = {...}    
    local result = {}
    local callerScript = rawget(getfenv(0), "script")
    callerScript = typeof(callerScript) == "Instance" and callerScript or nil
    print(string.format(
        "%s called!\nFrom Script: %s\nPath: %s\nArguments: %s\nReturn: %s",
        self.ClassName,
        tostring(not callerScript and "Not Found" or callerScript:GetFullName()),
        (not self.Parent and "[NIL]: " or "") .. self:GetFullName(),
        CountTable(arguments) == 0 and "None!" or PrintTable(arguments),
        CountTable(result) == 0 and "None!" or PrintTable(result)
    ))
    return unpack({methods[self.ClassName](self, ...)})
end
RemoteCallback = newcclosure(RemoteCallback)

methods.BindableEvent = hookfunc(Instance.new("BindableEvent").Fire, RemoteCallback)
methods.BindableFunction = hookfunc(Instance.new("BindableFunction").Invoke, RemoteCallback)
methods.RemoteEvent = hookfunc(Instance.new("RemoteEvent").FireServer, RemoteCallback)
methods.RemoteFunction = hookfunc(Instance.new("RemoteFunction").InvokeServer, RemoteCallback)

local function IsAuthorized(self, index)
    return (index == "Fire" or index == "Invoke" or index == "FireServer" or index == "InvokeServer") and (enabled[self.ClassName] and not ignore[self.Name])
end

function metatable:__namecall(...)
    local arguments = {...}
    local index = table.remove(arguments)
    --local remote = table.remove(arguments, 1)
    if IsAuthorized(self, index) then
        return RemoteCallback(self, unpack(arguments))
    end
    return __namecall(self, ...)
end
metatable.__namecall = newcclosure(metatable.__namecall)