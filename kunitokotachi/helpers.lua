--files helpers
function around(value)
    return tonumber(string.format("%.0f", value))
end
function file_exist(filePath)
    local exist = love.filesystem.exists(filePath)
    return exist
end
--read file and give key values back
function keys_and_values_from_file(filePath)
    local table =
    {
        ["key"] = {},
        ["value"] = {}
    }
    if file_exist(filePath) then
        for line in love.filesystem.lines(filePath) do
            table["key"][#table["key"] + 1] = string.sub(line, 1, string.find(line, ":")-1)
            table["value"][#table["value"] + 1] = string.sub(line, string.find(line, ":")+1, #line)
        end
    end
    return table
end
function close_game()
    love.event.quit(0)
end