-- tomis lang translator to lua

require "stackapi"
local pt = require "pt"
local utils = require "utils"
local handlers = require "transpiler_handlers"

local input = ""

if #arg == 0 then
    print("ERR - no input file")
else
    if utils.isempty(arg[2]) then
        print("ERR - no output file name")
    end

    local of = io.open(arg[2], "w")

    if of ~= nil then
        of:write("require \"stackapi\"\n")
        of:write("local utils = require \"utils\"")
        of:write("\n\n")
        of:write("local sapi = StackApi:new()")
        of:write("\n")
        of:write("_G.current_stack = \"default\"")
        of:write("\n")
        of:write("local cs = sapi:getStack(_G.current_stack)\n")
        of:write("\n")

        local lines = utils.lines_from(arg[1])

        for i = 1, #lines do
            if not utils.isempty(lines[i]) then
                local ins = utils.trim_ws_front(lines[i])
                local op, param = utils.get_tokens(ins)
                if op ~= "" then
                    handlers.run(of, op, param)
                end
            end
        end
    else
        print("ERR - output file open failed")
    end
end
