local mt = getrawmetatable(game)
local backupnamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
	local method = getnamecallmethod()
	local args = {...}
	if string.lower(method) == "kick" then
		return nil
	end
	return backupnamecall(...)
end)
setreadonly(mt, true)