# stackapi

Language supports a stack api

Any number of stacks can be created (each having a name).

2 stacks are created at initialization: “default” and “temp”

Basic stack operations:

    _ element            : push a string or number
    _                    : pop
    F_ $filename        : push the content of the file on top of stack
    @ index              : peek index (number or TOS, BOS)
    DEPTH                : push the depth of the stack

Accesing the stack:

    stack_index
    
    stack name is optional (_index access to the current stack)
    top of stack notations: _1

API to create stacks:

    SUSE name       : change the current stack
    SADD name       : add stack
    SRM name        : stack remove
    SREP name       : stack replace
    SCLEAR name    : stack clear
    SRA             : remove all stacks
    SNR             : number of stacks
