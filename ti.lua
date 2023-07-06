-- tomis lang interpreter

require "stackapi"
local pt = require "pt"
local utils = require "utils"
local handlers = require "handlers"

local VERSION = "0.1.1"

local sapi = StackApi:new()
_G.current_stack = "default";
input = ""

local op, param, input
if #arg == 0 then
    -- print("Tomis " .. VERSION)

    while true do
        input = io.read("*l")

        op, param = utils.get_tokens(input)
        handlers.run(sapi, op, param)
    end
else
    local lines = utils.lines_from(arg[1])

    for i = 1, #lines do
        if not utils.isempty(lines[i]) then
            op, param = utils.get_tokens(lines[i])
            handlers.run(sapi, op, param)
        end
    end
end
