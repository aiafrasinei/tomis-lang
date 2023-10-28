# stackops

Stack ops:
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

    INCR     : ( n - (n+1) )
    INCR nr  : ( n - (n+nr) )
    DECR     : ( n - (n-1) )
    DECR nr  : ( n - (n-nr) )

Stack ops for strings:

    SPLIT    : split the string from tos using space separator and push the elements
    MERGE    : pop and merge all stack elements in a string and push it at the top
    EXEC     : execute the string on the tos
    EXECI    : execute the string at index
    EXECA    : execute all the strings on the stack

Input/Output:

    PRINT string    : print the param
    INPUT           : get the input from stdin and push the value on the tos

Evaluations:

    Can be used as a reverse polish notation calculator.

    RPNEVAL rpn_ops      : reverse polish notation evaluation
    Expects a rpn expression (applies all the arithmetic ops using the current stack)
    example: RPNEVAL 1 2 + 3 + will leave the result 6 at the top

    Evaluate lua code on the stack

    LUAEVAL lua code     : evaluate lua code on the top of stack
    Expects a valid lua code on the current stack
    Execute the code and push the result at the top

Links:

    LINK "stack name" : change the current stack, 
