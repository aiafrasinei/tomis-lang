# cristina lang interpreter

require "stackapi"
local pt = require "pt"
local utils = require "utils"


local sapi = StackApi:new()
current_stack = "default";
input = ""

local function run(sapi, op, param)
    local cs = sapi:getStack(current_stack)

    if op == "PUSH" then
        cs:push(param)
    elseif op == "POP" then
        cs:pop()
    elseif op == "DEPTH" then
        cs:push(cs:depth())
    elseif op == "PEEK" then
        if param == "TOS" then
            local s = cs:peekLast()
            local res = tonumber(s)
            if res ~= nil then
                print(res)
            else
                print(string.sub(s, 2, string.len(s) - 1))
            end
        else
            print(cs:peek(tonumber(param)))
        end
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
        cs:dup()
        cs:dup()
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
        cs:pop()
        print(cs:peekLast())
    elseif op == "SPRINT" then
        print(cs:printData())
    elseif op == "INPUT" then
        local ins = io.read()
        cs:push(ins)
    elseif op == "FPUSH" then
        local fname = cs:peekLast():gsub('"', '')
        local f = io.open(fname, "rb")
        local data = f:read("*all")
        f:close()
        cs:push(data)
    elseif op == "SUSE" then
        current_stack = cs:peekLast():gsub('"', '')
    elseif op == "SADD" then
        sapi:adde(cs:peekLast():gsub('"', ''))
    elseif op == "SRM" then
        sapi:remove(cs:peekLast():gsub('"', ''))
    elseif op == "SREP" then
        sapi:copy(current_stack, cs:peekLast())
    elseif op == "SCLEAR" then
        sapi:clear(cs:peekLast():gsub('"', ''))
    elseif op == "SRA" then
        sapi:removeall()
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
        local params = sapi:getStack(current_stack):peekLast()
        sapi:getStack(current_stack):pop()
        local fs = load(sapi:getStack(current_stack):peekLast():gsub('"', ''))(params)
        sapi:getStack(current_stack):pop()
        sapi:getStack(current_stack):push(fs)
    else
        print("ERR: op " .. op .. " not recognized")
    end
end

local op, param, input
if arg[1] == "-i" then
    while true do
        input = io.read("*l")

        op, param = utils.get_tokens(input)
        run(sapi, op, param)
    end
else
    local lines = utils.lines_from(arg[1])

    for i = 1, #lines do
        op, param = utils.get_tokens(lines[i])
        run(sapi, op, param)
    end
end
