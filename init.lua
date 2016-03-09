--Gets install path.
local myDir = shell.getRunningProgram():gsub("/init.lua", ""):gsub("/init", "")

for k, fileName in ipairs(fs.list(myDir .. "/apis")) do
    loadAPI(myDir .. "/apis/" .. fileName)
end

--Implements pipes
function pipe(onlyIfSuccess, to, from)
    local input = {pcall(to)}
    local success = input[1]
    table.remove(input, 1)
    if (#input > 0) or (not onlyIfSuccess) then
        local data = {pcall(function() from(unpack(input)) end)}
        local endSuccess = data[1]
        table.remove(data, 1)
        return unpack(endSuccess and data)
    end
end
