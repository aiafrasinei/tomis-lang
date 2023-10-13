# fizz buzz

_ 1 51
WHILE
    INCR
    IF % 2 == 0 AND % 3 == 0
        PRINT fizzbuzz
    ELSEIF % 3 == 0
        PRINT fizz
    ELSEIF % 2 == 0
        PRINT buzz
    ELSE
        @ TOS
    ;
;
