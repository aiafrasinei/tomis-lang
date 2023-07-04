require "stack"

StackApi = {}
StackApi.__index = StackApi

function StackApi:new()
    local self = setmetatable({}, StackApi)

    self.stacks = {}
    self.stacks["default"] = Stack:new()
    self.stacks["temp"] = Stack:new()

    return self
end

--add
function StackApi:add(name, stack)
    self.stacks[name] = stack
end

function StackApi:adde(name)
    self.stacks[name] = Stack:new()
end

--remove
function StackApi:remove(name)
    self.stacks[name] = nil
end

--replace
function StackApi:replace(name, stack)
    self.stacks[name] = stack
end

function StackApi:copy(current, new)
    self.stacks[current] = self.stacks[new]
end

--removeall
function StackApi:removeall()
    for k, v in pairs(self.stacks) do
        self.stacks[k] = nil
    end
end

--clear
function StackApi:clear(name)
    self.stacks[name]:clear()
end

function StackApi:getStack(name)
    return self.stacks[name]
end

function StackApi:getDefaultStack()
    return self.stacks["default"]
end

function StackApi:getTempStack()
    return self.stacks["temp"]
end

function StackApi:getNrStacks()
    local counter = 0
    if self.stacks ~= nil then
        for k, v in pairs(self.stacks) do
            counter = counter + 1
        end
    end

    return counter
end
