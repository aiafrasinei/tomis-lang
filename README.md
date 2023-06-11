# tomis-lang

## Interpreter

## Tests


## StackApi

Language supports a stack api
Any number of stacks can be created (each having a name).
2 stacks are created at initialization: “default” and “temp”

API as language statements:

    stack operations:
    PUSH  element            : push a string or number
    FPUSH "filename"         : push the content of the file on top of stack
    POP, DEPTH, PRINT
    PEEK index               : index: number or TOS

Stack juggling:
notation meaning ( initial stack - after operation stack)

    DROP     : ( n - )
    DUP      : ( n - n n )
    SWAP     : ( n1 n2 - n2 n1 )
    OVER     : ( n1 n2 - n1 n2 n1 )
    TUCK     : ( n1 n2 - n2 n1 n2 )
    ROT      : ( n1 n2 n3 - n2 n3 n1 )
    MINROT   : ( n1 n2 n3 - n3 n1 n2 )
    2DROP    : ( n1 n2 - )
    2DUP     : ( n1 n2 - n1 n2 n1 n2 )
    2SWAP    : ( n1 n2 n3 n4 - n3 n4 n1 n2 )
    2OVER    : ( n1 n2 n3 n4 - n1 n2 n3 n4 n1 n2 )
    2ROT     : ( n1 n2 n3 n4 n5 n6 - n3 n4 n5 n6 n1 n2 )
    2MINROT  : ( n1 n2 n3 n4 n5 n6 - n5 n6 n1 n2 n3 n4 )

API to create stacks:

    SUSE “name”     - change the current stack
    SADD “name”     - add stack
    SRM “name”      - stack remove
    SREP “name”     - stack replace
    SCLEAR “name”   - stack clear
    SRA             - remove all stacks

Arithmetics:

Expects 2 elements on the current stack, pops the 2 elements and push the result.

    + - addition        - ( n1 n2 — sum )
    - - substraction    - ( n1 n2 — diff )
    * - multiplication  - ( n1 n2 — prod )
    / - division        - ( n1 n2 — quot )
    % - mod             - ( n1 n2 — rem )

Can be used as a reverse polish notation calculator.

    RPNEVAL "rpn_ops"    - reverse polish notation evaluation
    Expects a rpn expression (applies all the arithmetic ops using the current stack)
    example: RPNEVAL "1 2 + 3 +" will leave the result 6 at the top
