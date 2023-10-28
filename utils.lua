local utils = {}

function utils.split_string(str, delimiter)
    local result = {}
    local str = str .. delimiter
    for slice in string.gmatch(str, "(.-)" .. delimiter) do
        table.insert(result, slice)
    end
    return result
end

function utils.file_exists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function utils.lines_from(file)
    if not utils.file_exists(file) then
        print 'ERR - File doesnt exist, or access problem\n'
        return {}
    end
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines
end

function utils.get_tokens(input)
    local op, param
    local sepi = string.find(input, " ")
    if sepi ~= nil then
        op = string.sub(input, 1, sepi - 1)
        param = string.sub(input, sepi + 1, #input)
    else
        op = string.sub(input, 1, #input)
        param = ""
    end

    return op, param
end

function utils.isempty(s)
    return s == nil or s == ""
end

function utils.fatalerr(text, errcode)
    print(text)
    os.exit(errcode)
end

function utils.trim_ws_front(input)
    local lasti = 1
    for i = 1, #input do
        if input:byte(i) ~= 32 then
            lasti = i
            break
        end
    end

    return string.sub(input, lasti, #input)
end

function utils.allnr(table)
    for i = 1, #table do
        if tonumber(table[i]) == nil then
            return false
        end
    end

    return true
end

return utils
