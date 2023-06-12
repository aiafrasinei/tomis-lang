# tomis lang interpreter

require "impls.lua.stackapi"
local pt = require "impls.lua.pt"
local utils = require "impls.lua.utils"


local VERSION = "0.1.0"

local sapi = StackApi:new()
current_stack = "default";
input = ""

local function run(sapi, op, param)
    local cs = sapi:getStack(current_stack)

    if op == "_" then
        if param ~= "" then
            cs:push(param)
        else
            cs:pop()
        end
    elseif op == "DEPTH" then
        cs:push(cs:depth())
    elseif op == "@" then
        if param == "TOS" then
            if cs:depth() > 0 then
                local s = cs:peekLast()
                local res = tonumber(s)
                if res ~= nil then
                    print(res)
                else
                    print(string.sub(s, 2, string.len(s) - 1))
                end
            end
        else
            print(cs:peek(tonumber(param)))
        end
    elseif op == "SPLIT" then
        local tos = cs:peekLast():gsub('"', '')
        cs:pop()
        local arr = utils.split_string(tos, " ")
        for i = 1, #arr do
            cs:push(arr[i])
        end
    elseif op == "MERGE" then
        local str = cs:getData()[1]
        for i = 2, #cs:getData() do
            str = str .. " " .. cs:getData()[i]
        end
        cs:clear()
        cs:push(str)
    elseif op == "DROP" then
        cs:pop()
    elseif op == "DUP" then
        cs:dup()
    elseif op == "SWAP" then
        cs:swap()
    elseif op == "OVER" then
        cs:over()
    elseif op == "ROT" then
        cs:rot()
    elseif op == "MINROT" then
        cs:minrot()
    elseif op == "2DROP" then
        cs:twodrop()
    elseif op == "2SWAP" then
        cs:twoswap()
    elseif op == "2DUP" then
        cs:twodup()
    elseif op == "2OVER" then
        cs:twoover()
    elseif op == "TUCK" then
        cs:tuck()
    elseif op == "2ROT" then
        cs:tworot()
    elseif op == "2MINROT" then
        cs:twominrot()
    elseif op == "+" then
        cs:add()
    elseif op == "-" then
        cs:substract()
    elseif op == "*" then
        cs:multiply()
    elseif op == "/" then
        cs:division()
    elseif op == "%" then
        cs:modulo()
    elseif op == "." then
        print(cs:peekLast())
        cs:pop()
    elseif op == "SPRINT" or op == ".s" then
        print(cs:printData())
    elseif op == "INPUT" then
        local ins = io.read()
        cs:push(ins)
    elseif op == "PRINT" then
        print(param)
    elseif op == "FPUSH" then
        local fname = param:gsub('"', '')
        local f = io.open(fname, "rb")
        local data = f:read("*all")
        f:close()
        cs:push(data)
    elseif op == "SUSE" then
        current_stack = param:gsub('"', '')
        cs = sapi:getStack(current_stack)
    elseif op == "SADD" then
        sapi:adde(param:gsub('"', ''))
    elseif op == "SRM" then
        sapi:remove(param:gsub('"', ''))
    elseif op == "SREP" then
        sapi:copy(current_stack, param:gsub('"', ''))
    elseif op == "SCLEAR" then
        sapi:clear(param:gsub('"', ''))
    elseif op == "SRA" then
        sapi:removeall()
    elseif op == "SNR" then
        print(sapi:getNrStacks())
    elseif op == "RPNEVAL" then
        local rpnops = utils.split_string(cs:peekLast():gsub('"', ''), " ")
        cs:pop()
        for i = 1, #rpnops do
            if type(tonumber(rpnops[i])) == "number" then
                cs:push(rpnops[i])
            end
            if rpnops[i] == "+" then
                cs:add()
            elseif rpnops[i] == "-" then
                cs:substract()
            elseif rpnops[i] == "*" then
                cs:multiply()
            elseif rpnops[i] == "/" then
                cs:division()
            elseif rpnops[i] == "%" then
                cs:modulo()
            end
        end
    elseif op == "LUAEVAL" then
        local params = cs:peekLast()
        cs:pop()
        local fs = load(cs:peekLast():gsub('"', ''))(params)
        cs:pop()
        cs:push(fs)
    elseif op == "#" then
    else
        print("ERR: op " .. op .. " not recognized")
    end
end

local op, param, input
if arg[1] == "-i" then
    -- print("Tomis " .. VERSION)

    while true do
        input = io.read("*l")

        op, param = utils.get_tokens(input)
        run(sapi, op, param)
    end
else
    local lines = utils.lines_from(arg[1])

    for i = 1, #lines do
        if not utils.isempty(lines[i]) then
            op, param = utils.get_tokens(lines[i])
            run(sapi, op, param)
        end
    end
end
