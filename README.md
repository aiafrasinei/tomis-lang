# tomis-lang

## Interpreter

The interpreter is implemented in lua.

To run an input file:

    lua ti.lua input.t

Interactive mode:

    lua ti.lua

## Tests

Read docs/TESTS.md on how to run the tests

## StackApi

Language supports a stack api
Any number of stacks can be created (each having a name).
2 stacks are created at initialization: “default” and “temp”

Read docs/STACKAPI.md for more information
