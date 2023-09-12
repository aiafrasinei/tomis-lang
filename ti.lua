-- tomis lang interpreter

require "stackapi"
local pt = require "pt"
local utils = require "utils"
local handlers = require "handlers"

local VERSION = "0.1.2"

local sapi = StackApi:new()
_G.current_stack = "default";
local input = ""

local op, param

function tokandrun(lines, i, sapi, op, param)
    if not utils.isempty(lines[i]) then
        op, param = utils.get_tokens(lines[i])
        handlers.run(sapi, op, param)
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
    -- { while index, end index, break present }
    local whileinfos = {}

    local lines = utils.lines_from(arg[1])

    for i = 1, #lines do
        if not utils.isempty(lines[i]) then
            op, param = utils.get_tokens(lines[i])
            if op == "WHILE" then
                table.insert(whileinfos, { i, 0, 0 })
            elseif op == "BREAK" then
                whileinfos[#whileinfos][3] = 1
            elseif op == "END" then
                if whileinfos[#whileinfos][2] == 0 then
                    whileinfos[#whileinfos][2] = i
                end
                if i == #lines then
                    whileinfos[1][2] = i
                end
            end
        end
    end

    if #whileinfos == 0 then
        for i = 1, #lines do
            tokandrun(lines, i, sapi, op, param)
        end
    else
        --print(pt.pt(whileinfos))
        --os.exit(1)

        for i = 1, whileinfos[1][1] do
            tokandrun(lines, i, sapi, op, param)
        end

        while true do
            for i = 1, #whileinfos do
                if whileinfos[i][3] == 1 then
                    for j = whileinfos[i][1], whileinfos[i][2] do
                        if lines[j] ~= nil then
                            if op == "BREAK" then
                                breaked = true

                                for k = whileinfos[i][2], #lines do
                                    op, param = utils.get_tokens(lines[k])
                                    handlers.run(sapi, op, param)
                                end

                                break
                            end
                            op, param = utils.get_tokens(lines[j])
                            handlers.run(sapi, op, param)
                        end
                    end

                    if breaked then
                        break
                    end
                else
                    for l = 2, #whileinfos do
                        for j = whileinfos[#whileinfos][1], whileinfos[#whileinfos][2] do
                            lines[j] = nil
                        end
                        table.remove(whileinfos)
                    end

                    while true do
                        for k = whileinfos[#whileinfos][1], whileinfos[#whileinfos][2] do
                            tokandrun(lines, k, sapi, op, param)
                        end
                    end
                end
            end

            if breaked then
                break
            end
        end
    end
end
