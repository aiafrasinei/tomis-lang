# tomis-lang

Experiment, simple,
not supposed to be a full language.
Traspiler to lua.
Uses a stack to pass parameters to functions.

## Transpiler to lua

Transform tomis code to lua.

Example:

    lua tomis2lua.lua input.t output.lua

## Tests

Read docs/TESTS.md on how to run the tests

## StackApi

Language supports a stack api
Any number of stacks can be created (each having a name).
2 stacks are created at initialization: “default” and “temp”

Read docs/STACKAPI.md for more information
