local interpreter_handlers = {}

local utils = require "utils"
local pt = require "pt"

function merge_handler(cs)
    local str = cs:getData()[1]
    for i = 2, #cs:getData() do
        str = str .. " " .. cs:getData()[i]
    end
    cs:clear()
    cs:push(str)
end

function split_handler(cs)
    local tos = cs:peekLast()
    cs:pop()
    local arr = utils.split_string(tos, " ")
    for i = 1, #arr do
        cs:push(arr[i])
    end
end

function interpreter_handlers.while_handler(handlers, whileinfos, lines, sapi, op, param)
    for i = 1, #whileinfos do
        if whileinfos[i][3] == 1 then
            for j = whileinfos[i][1], whileinfos[i][2] do
                if lines[j] ~= nil then
                    if op == "BREAK" then
                        breaked = true

                        for k = whileinfos[i][2], #lines do
                            op, param = utils.get_tokens(lines[k])
                            handlers.run(sapi, op, param, whileinfos)
                        end

                        break
                    end
                    op, param = utils.get_tokens(lines[j])
                    handlers.run(sapi, op, param, whileinfos)
                end
            end

            if breaked then
                return true
            end
        else
            for l = 2, #whileinfos do
                for j = whileinfos[#whileinfos][1], whileinfos[#whileinfos][2] do
                    lines[j] = nil
                end
                table.remove(whileinfos)
            end

            if whileinfos[#whileinfos][4] ~= "" then
                for j = whileinfos[#whileinfos][1] + 1, whileinfos[#whileinfos][2] do
                    runtokens(lines, j, sapi, op, param, whileinfos)
                end
            else
                while true do
                    for j = whileinfos[#whileinfos][1] + 1, whileinfos[#whileinfos][2] do
                        runtokens(lines, j, sapi, op, param, whileinfos)
                    end
                end
            end
        end
    end

    return false
end

function interpreter_handlers.run(sapi, op, param, whileinfos)
    local cs = sapi:getStack(_G.current_stack)

    if op == "_" then
        local params = utils.split_string(param, " ")
        if param ~= "" then
            if #params == 1 then
                cs:push(param)
            else
                for i = 1, #params do
                    cs:push(params[i])
                end
            end
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
        elseif param == "BOS" then
            if cs:depth() > 0 then
                local s = cs:peek(1)
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
        split_handler(cs)
    elseif op == "MERGE" then
        merge_handler(cs)
    elseif op == "EXEC" then
        merge_handler(cs)
        opn, paramn = utils.get_tokens(cs:peekLast())
        cs:pop()
        interpreter_handlers.run(sapi, opn, paramn, whileinfos)
    elseif op == "EXECI" then
        index = tonumber(param)
        opn, paramn = utils.get_tokens(cs:getData()[index])
        table.remove(cs:getData(), index)
        interpreter_handlers.run(sapi, opn, paramn, whileinfos)
    elseif op == "EXECA" then
        local cp = { table.unpack(cs:getData()) }
        cs:clear()
        for i = 1, #cp do
            interpreter_handlers.run(sapi, cp[i], cp[i + 1])
        end
    elseif op == "LINK" then
        -- TODO
        _G.current_stack = param
        cs = sapi:getStack(_G.current_stack)
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
    elseif op == "INCR" then
        if param == "" then
            cs:increment(1)
        else
            cs:increment(tonumber(param))
        end
    elseif op == "DECR" then
        if param == "" then
            cs:decrement(1)
        else
            cs:decrement(tonumber(param))
        end
    elseif op == "SPRINT" or op == ".s" then
        print(cs:printData())
    elseif op == "INPUT" then
        local ins = io.read()
        cs:push(ins)
    elseif op == "PRINT" then
        print(param)
    elseif op == "F_" then
        local f = io.open(param, "rb")
        local data = f:read("*all")
        f:close()
        cs:push(data)
    elseif op == "SUSE" then
        _G.current_stack = param
        cs = sapi:getStack(_G.current_stack)
    elseif op == "SADD" then
        sapi:adde(param)
    elseif op == "SRM" then
        sapi:remove(param)
    elseif op == "SREP" then
        sapi:copy(_G.current_stack, param)
    elseif op == "SCLEAR" then
        sapi:clear(param)
    elseif op == "SRA" then
        sapi:removeall()
    elseif op == "SNR" then
        print(sapi:getNrStacks())
    elseif op == "RPNEVAL" then
        merge_handler(cs)
        local rpnops = utils.split_string(cs:peekLast(), " ")
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
    elseif op == "WHILE" then
        if param == "" then
            local comp = cs:peek(cs:depth() - 2)
            if comp ~= nil then
                if comp == "<" or comp == ">" or comp == ">=" or comp == "<=" then
                else
                    print("ERR: WHILE comparator not recognized");
                end
            end

            if cs:peek(cs:depth() - 3) == cs:peek(cs:depth() - 1) then
                op = "BREAK"
            end
        else
            print("ERR: WHILE ivalid usage, parameters expected on the stack")
        end
        whileinfos[#whileinfos][4] = cs
    elseif op == "END" then
    elseif op == "BREAK" then
    else
        if tonumber(op) == nil then
            print("ERR: op " .. op .. " not recognized")
        end
    end
end

return interpreter_handlers
