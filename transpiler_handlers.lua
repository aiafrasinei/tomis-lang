local transpiler_handlers = {}

local utils = require "utils"

local function replaceStackAccess(param)
    local start = 1
    local fin = 1
    while start ~= nil do
        start = param:find("_", fin)
        fin = param:find(" ", start)
        if start ~= nil then
            if fin ~= nil then
                param = param:gsub(string.sub(param, start, fin - 1),
                    "cs:peek(" .. string.sub(param, start + 1, fin - 1) .. ")")
            else
                fin = #param
                param = param:gsub(string.sub(param, start, fin),
                    "cs:peek(" .. string.sub(param, start + 1, fin) .. ")")
            end
        end
    end

    return param
end

Whiletotem = false
Whileincr = 1

function transpiler_handlers.run(of, op, param)
    if op == "_" then
        if param ~= "" then
            local tokens = utils.split_string(param, " ")
            for i = 1, #tokens do
                of:write("cs:push(" .. tokens[i] .. ")\n")
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
        if param == nil or param == "" then
            of:write("cs:add()\n")
        else
            of:write("cs:push(tonumber(" .. param .. "))\n")
            of:write("cs:add()\n")
        end
    elseif op == "-" then
        if param == nil or param == "" then
            of:write("cs:substract()\n")
        else
            of:write("cs:push(tonumber(" .. param .. "))\n")
            of:write("cs:substract()\n")
        end
    elseif op == "*" then
        if param == nil or param == "" then
            of:write("cs:multiply()\n")
        else
            of:write("cs:push(tonumber(" .. param .. "))\n")
            of:write("cs:multiply()\n")
        end
    elseif op == "/" then
        if param == nil or param == "" then
            of:write("cs:division()\n")
        else
            of:write("cs:push(tonumber(" .. param .. "))\n")
            of:write("cs:division()\n")
        end
    elseif op == "%" then
        if param == nil or param == "" then
            of:write("cs:modulo()\n")
        else
            of:write("cs:push(tonumber(" .. param .. "))\n")
            of:write("cs:modulo()\n")
        end
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
        param = replaceStackAccess(param)
        of:write("print(" .. param .. ")\n");
    elseif op == "F_" then
        of:write("local f = io.open(\"" .. param .. "\", \"rb\")\n")
        of:write("local data = f:read(\"*all\")\n")
        of:write("f:close()\n")
        of:write("cs:push(data)\n")
    elseif op == "SUSE" then
        of:write("_G.current_stack = \"" .. param .. "\"\n")
        of:write("cs = sapi:getStack(_G.current_stack)\n")
    elseif op == "SADD" then
        of:write("sapi:adde(\"" .. param .. "\")\n")
    elseif op == "SRM" then
        of:write("sapi:remove(\"" .. param .. "\")\n")
    elseif op == "SREP" then
        of:write("sapi:copy(_G.current_stack, \"" .. param .. "\")\n")
    elseif op == "SCLEAR" then
        of:write("sapi:clear(\"" .. param .. "\")\n")
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
        if param == "" then
            of:write("while(true) do\n")
        else
            param = replaceStackAccess(param)
            local tokens = utils.split_string(param, " ")
            if utils.allnr(tokens) then
                of:write("cs:push(" .. tokens[1] .. ")\n")
                Whiletotem = true
                if #tokens == 3 then
                    of:write("for i=" .. tokens[1] .. ", " .. tokens[2] .. ", " .. tokens[3] .. " do\n")
                    Whileincr = tokens[3]
                elseif #tokens == 2 then
                    of:write("for i=" .. tokens[1] .. ", " .. tokens[2] .. ", 1 do\n")
                end
            else
                of:write("while " .. param .. " do\n")
            end
        end
    elseif op == ";" then
        of:write("end\n")
        if Whiletotem then
            of:write("cs:increment(" .. Whileincr .. ")\n")
            Whiletotem = false
        end
    elseif op == "BREAK" then
        of:write("break\n")
    elseif op == "IF" then
        param = replaceStackAccess(param)
        of:write("if " .. param .. " then\n")
    elseif op == "ELSEIF" then
        param = replaceStackAccess(param)
        of:write("elseif " .. param .. " then\n")
    elseif op == "ELSE" then
        of:write("else\n")
    else
        if op ~= "" then
            print("ERR: op " .. op .. " not recognized")
        end
    end
end

return transpiler_handlers
