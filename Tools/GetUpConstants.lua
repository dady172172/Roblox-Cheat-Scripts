local modd = require()
local func = modd.
Print("---- UPVALUES ----")
for i,v in pairs(getupvalues(func)) do
    print(i,v)
end
print("----------")
print("---- CONSTNATS ----")
for i,v in pairs(getconstants(func)) do
    print(i,v)
end
    