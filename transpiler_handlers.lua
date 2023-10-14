local transpiler_handlers = {}

local utils = require "utils"


function transpiler_handlers.run(of, op, param)
    if op == "_" then
        local params = utils.split_string(param, " ")
        if param ~= "" then
            if #params == 1 then
                of:write("cs:push(" .. params[1] .. ")\n")
            else
                for i = 1, #params do
                    of:write("cs:push(" .. params[i] .. ")\n")
                end
            end
        else
            of:write("cs:pop()\n")
        end
    elseif op == "DEPTH" then
        of:write("cs:push(cs:depth())\n")
    elseif op == "@" then
        if param == "TOS" then
            of:write("if cs:depth() > 0 then\n")
            of:write("local s = cs:peekLast()\n")
            of:write("local res = tonumber(s)\n")
            of:write("if res ~= nil then\n")
            of:write("print(res)\n")
            of:write("else\n")
            of:write("print(string.sub(s, 2, string.len(s) - 1))\n")
            of:write("end\n")
            of:write("end\n")
        elseif param == "BOS" then
            of:write("if cs:depth() > 0 then\n")
            of:write("local s = cs:peek(1)\n")
            of:write("local res = tonumber(s)\n")
            of:write("if res ~= nil then\n")
            of:write("print(res)\n")
            of:write("else\n")
            of:write("print(string.sub(s, 2, string.len(s) - 1))\n")
            of:write("end\n")
            of:write("end\n")
        else
            of:write("print(cs:peek(tonumber(" .. param .. ")))\n")
        end
    elseif op == "SPLIT" then
        of:write("local tos = cs:peekLast()\n")
        of:write("cs:pop()\n")
        of:write("local arr = utils.split_string(tos, \" \")\n")
        of:write("for i = 1, #arr do\n")
        of:write("cs:push(arr[i])\n")
        of:write("end\n")
    elseif op == "MERGE" then
        of:write("local str = cs:getData()[1]\n")
        of:write("for i = 2, #cs:getData() do\n")
        of:write("str = str .. \" \" .. cs:getData()[i]\n")
        of:write("end\n")
        of:write("cs:clear()\n")
        of:write("cs:push(str)\n")
    elseif op == "EXEC" then

    elseif op == "EXECI" then

    elseif op == "EXECA" then

    elseif op == "LINK" then
        --TODO
    elseif op == "DROP" then
        of:write("cs:pop()\n")
    elseif op == "DUP" then
        of:write("cs:dup()\n")
    elseif op == "SWAP" then
        of:write("cs:swap()\n")
    elseif op == "OVER" then
        of:write("cs:over()\n")
    elseif op == "ROT" then
        of:write("cs:rot()\n")
    elseif op == "MINROT" then
        of:write("cs:minrot()\n")
    elseif op == "2DROP" then
        of:write("cs:twodrop()\n")
    elseif op == "2SWAP" then
        of:write("cs:twoswap()\n")
    elseif op == "2DUP" then
        of:write("cs:twodup()\n")
    elseif op == "2OVER" then
        of:write("cs:twoover()\n")
    elseif op == "TUCK" then
        of:write("cs:tuck()\n")
    elseif op == "2ROT" then
        of:write("cs:tworot()\n")
    elseif op == "2MINROT" then
        of:write("cs:twominrot()\n")
    elseif op == "+" then
        of:write("cs:add()\n")
    elseif op == "-" then
        of:write("cs:substract()\n")
    elseif op == "*" then
        of:write("cs:multiply()\n")
    elseif op == "/" then
        of:write("cs:division()\n")
    elseif op == "%" then
        of:write("cs:modulo()\n")
    elseif op == "INCR" then
        if param == nil or param == "" then
            of:write("cs:increment(1)\n")
        else
            of:write("if " .. param .. " == \"\" then\n")
            of:write("cs:increment(1)\n")
            of:write("else\n")
            of:write("cs:increment(tonumber(" .. param .. "))\n")
            of:write("end\n")
        end
    elseif op == "DECR" then
        if param == nil or param == "" then
            of:write("cs:decrement(1)\n")
        else
            of:write("if " .. param .. " == \"\" then\n")
            of:write("cs:decrement(1)\n")
            of:write("else\n")
            of:write("cs:decrement(tonumber(" .. param .. "))\n")
            of:write("end\n")
        end
    elseif op == "." then
        of:write("print(cs:peekLast())\n")
        of:write("cs:pop()\n")
    elseif op == "SPRINT" or op == ".s" then
        of:write("print(cs:printData())\n")
    elseif op == "INPUT" then
        of:write("local ins = io.read()\n")
        of:write("cs:push(ins)\n")
    elseif op == "PRINT" then
        of:write("print(\"" .. param .. "\")\n");
    elseif op == "F_" then
        of:write("local f = io.open(\"" .. param .. "\", \"rb\")\n")
        of:write("local data = f:read(\"*all\")\n")
        of:write("f:close()\n")
        of:write("cs:push(data)\n")
    elseif op == "SUSE" then
        of:write("_G.current_stack = " .. param .. "\n")
        of:write("cs = sapi:getStack(_G.current_stack)\n")
    elseif op == "SADD" then
        of:write("sapi:adde(" .. param .. ")\n")
    elseif op == "SRM" then
        of:write("sapi:remove(" .. param .. ")\n")
    elseif op == "SREP" then
        -- TODO ALEX
    elseif op == "SCLEAR" then
        of:write("sapi:clear(" .. param .. ")\n")
    elseif op == "SRA" then
        of:write("sapi:removeall()\n")
    elseif op == "SNR" then
        of:write("print(sapi:getNrStacks())\n")
    elseif op == "RPNEVAL" then
        of:write("local rpnops = utils.split_string(cs:peekLast(), \" \")\n")
        of:write("cs:pop()\n")
        of:write("for i = 1, #rpnops do\n")
        of:write("if type(tonumber(rpnops[i])) == \"number\" then\n")
        of:write("cs:push(rpnops[i])\n")
        of:write("end\n")
        of:write("if rpnops[i] == \"+\" then\n")
        of:write("cs:add()\n")
        of:write("elseif rpnops[i] == \"-\" then\n")
        of:write("cs:substract()\n")
        of:write("elseif rpnops[i] == \"*\" then\n")
        of:write("cs:multiply()\n")
        of:write("elseif rpnops[i] == \"/\" then\n")
        of:write("cs:division()\n")
        of:write("elseif rpnops[i] == \"%\" then\n")
        of:write("cs:modulo()\n")
        of:write("end\n")
        of:write("end\n")
    elseif op == "LUAEVAL" then
        of:write("local params = cs:peekLast()\n")
        of:write("cs:pop()\n")
        of:write("local fs = load(cs:peekLast():gsub('\"', ''))(params)\n")
        of:write("cs:pop()\n")
        of:write("cs:push(fs)\n")
    elseif op == "#" then
        of:write("-- " .. param .. "\n")
    elseif op == "WHILE" then
        of:write("while(true) do\n")
    elseif op == ";" then
        of:write("end\n")
    elseif op == "BREAK" then
        of:write("break\n")
    else
        print("ERR: op " .. op .. " not recognized")
    end
end

return transpiler_handlers
