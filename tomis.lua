-- tomis lang interpreter

require "stackapi"
local pt = require "pt"
local utils = require "utils"
local handlers = require "interpreter_handlers"

local VERSION = "0.1.2"

local sapi = StackApi:new()
_G.current_stack = "default";
local input = ""

local op, param

function runtokens(lines, i, sapi, op, param, whileinfos)
    if not utils.isempty(lines[i]) then
        op, param = utils.get_tokens(lines[i])
        handlers.run(sapi, op, param, whileinfos)
    end
end

if #arg == 0 then
    -- print("Tomis " .. VERSION)

    while true do
        input = io.read("*l")

        op, param = utils.get_tokens(input)
        handlers.run(sapi, op, param)
    end
else
    -- { while index, end index, break present, top element in stack ,params }
    local whileinfos = {}

    local lines = utils.lines_from(arg[1])

    for i = 1, #lines do
        if not utils.isempty(lines[i]) then
            op, param = utils.get_tokens(lines[i])
            if op == "WHILE" then
                table.insert(whileinfos, { i, 0, 0, 0, 0 })

                local wops = utils.split_string(param, " ")
                if wops == nil then
                    wops = {}
                end
                whileinfos[#whileinfos][5] = wops
            elseif op == "BREAK" then
                whileinfos[#whileinfos][3] = 1
            elseif op == "END" then
                if whileinfos[#whileinfos][2] == 0 then
                    whileinfos[#whileinfos][2] = i
                end
                if i == #lines then
                    if whileinfos[1][2] == 0 then
                        whileinfos[1][2] = i
                    end
                end
            end
        end
    end

    if #whileinfos == 0 then
        for i = 1, #lines do
            runtokens(lines, i, sapi, op, param, whileinfos)
        end
    else
        --print(pt.pt(whileinfos))
        --os.exit(1)

        for i = 1, whileinfos[1][1] do
            runtokens(lines, i, sapi, op, param, whileinfos)
        end

        if whileinfos[1][4] == nil or whileinfos[1][4] == 0 then
            while true do
                breaked = handlers.while_handler(handlers, whileinfos, lines, sapi, op, param)

                if breaked then
                    break
                end
            end
        else
            for i = 1, #whileinfos do
                local start = whileinfos[i][4]
                local fin = whileinfos[i][5][2] - 1
                if whileinfos[i][5][1] == "<=" then
                    fin = whileinfos[i][5][2]
                end

                for i = start, fin do
                    breaked = handlers.while_handler(handlers, whileinfos, lines, sapi, op, param)

                    if breaked then
                        break
                    end
                end
            end
        end
    end
end
