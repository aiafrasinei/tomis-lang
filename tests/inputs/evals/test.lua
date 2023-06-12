function countDigits(arg)
    local count = 0
    local nr = arg[1]

    while math.floor(nr) ~= 0 do
        count = count + 1
        nr = nr / 10
    end

    return count
end

local arg = { ... }
return countDigits(arg)
