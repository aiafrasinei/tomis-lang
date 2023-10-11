setup() {
    load 'test_helper/bats-support/load'
    load 'test_helper/bats-assert/load'

    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd )"
    # make executables in src/ visible to PATH
    PATH="$DIR/..:$PATH"
}

@test "addition" {
    run lua tomis.lua tests/inputs/math_ops/add
    assert_output "5"
}

@test "substraction" {
    run lua tomis.lua tests/inputs/math_ops/sub
    assert_output "-1"
}

@test "multiplication" {
    run lua tomis.lua tests/inputs/math_ops/mul
    assert_output "6"
}

@test "division" {
    run lua tomis.lua tests/inputs/math_ops/div
    assert_output "3.0"
}

@test "modulo" {
    run lua tomis.lua tests/inputs/math_ops/mod
    assert_output "0"
}

@test "rpn evaluation" {
    run lua tomis.lua tests/inputs/evals/re
    assert_output "3"
}

@test "dup" {
    run lua tomis.lua tests/inputs/stackops/dup
    assert_output "3"
}

@test "drop" {
    run lua tomis.lua tests/inputs/stackops/drop
    assert_output "3"
}

@test "over" {
    run lua tomis.lua tests/inputs/stackops/over
    assert_output "2"
}

@test "swap" {
    run lua tomis.lua tests/inputs/stackops/swap
    assert_output "2"
}

@test "tuck" {
    run lua tomis.lua tests/inputs/stackops/tuck
    assert_output "3 2 3"
}

@test "rot" {
    run lua tomis.lua tests/inputs/stackops/rot
    assert_output "3 1 2"
}

@test "minrot" {
    run lua tomis.lua tests/inputs/stackops/minrot
    assert_output "1 2 3"
}

@test "2drop" {
    run lua tomis.lua tests/inputs/stackops/2drop
    assert_output "0"
}

@test "2dup" {
    run lua tomis.lua tests/inputs/stackops/2dup
    assert_output "1 2 1 2"
}

@test "2swap" {
    run lua tomis.lua tests/inputs/stackops/2swap
    assert_output "3 4 1 2"
}

@test "2over" {
    run lua tomis.lua tests/inputs/stackops/2over
    assert_output "2 2 2 2 2 2"
}

@test "2rot" {
    run lua tomis.lua tests/inputs/stackops/2rot
    assert_output "4 3 5 6 1 2"
}

@test "2minrot" {
    run lua tomis.lua tests/inputs/stackops/2minrot
    assert_output "6 5 2 1 4 3"
}

@test "peek1" {
    run lua tomis.lua tests/inputs/stackops/peek1
    assert_output "1"
}

@test "peek2" {
    run lua tomis.lua tests/inputs/stackops/peek2
    assert_output "2"
}

@test "peek3" {
    run lua tomis.lua tests/inputs/stackops/peek3
    assert_output "2"
}

@test "peek4" {
    run lua tomis.lua tests/inputs/stackops/peek4
    assert_output "1"
}

@test "push" {
    run lua tomis.lua tests/inputs/stackops/push
    assert_output "1 2 3"
}

@test "pop" {
    run lua tomis.lua tests/inputs/stackops/pop
    assert_output "1 2"
}

@test "depth" {
    run lua tomis.lua tests/inputs/stackops/depth
    assert_output "3"
}

@test "suse" {
    run lua tomis.lua tests/inputs/stackapi/suse
    assert_output "first"
}

@test "stack remove" {
    run lua tomis.lua tests/inputs/stackapi/srm
    assert_output "\"alive\""
}

@test "stack replace" {
    run lua tomis.lua tests/inputs/stackapi/sreplace
    assert_output "1 2 3"
}

@test "sra" {
    run lua tomis.lua tests/inputs/stackapi/sra
    assert_output "0"
}

@test "snr" {
    run lua tomis.lua tests/inputs/stackapi/snr
    assert_output "2"
}

@test "sclear" {
    run lua tomis.lua tests/inputs/stackapi/sclear
    assert_output "2"
}

@test "sadd" {
    run lua tomis.lua tests/inputs/stackapi/sadd
    assert_output "2"
}

@test "print" {
    run lua tomis.lua tests/inputs/io/print
    assert_output "Hello World!"
}

@test "fpush" {
    run lua tomis.lua tests/inputs/stackops/fpush
    assert_output "test = 1"
}

@test "dot" {
    run lua tomis.lua tests/inputs/stackops/dot
    assert_output "1"
}

@test "comments" {
    run lua tomis.lua tests/inputs/comments/single
    assert_output ""
}

@test "dots" {
    run lua tomis.lua tests/inputs/stackops/dots
    assert_output "1 2 3"
}

@test "le" {
    run lua tomis.lua tests/inputs/evals/le
    assert_output "4"
}

@test "split" {
    run lua tomis.lua tests/inputs/stringops/split
    assert_output "6"
}

@test "merge" {
    run lua tomis.lua tests/inputs/stringops/merge
    assert_output "1 2 3"
}

@test "exec" {
    run lua tomis.lua tests/inputs/stringops/exec
    assert_output "2"
}

@test "execi" {
    run lua tomis.lua tests/inputs/stringops/execi
    assert_output "3"
}

@test "execa" {
    run lua tomis.lua tests/inputs/stringops/execa
    assert_output "1 2 3"
}

@test "simplebreak" {
    run lua tomis.lua tests/inputs/while/simplebreak
    assert_output "test3"
}

@test "simplebreakalt" {
    run lua tomis.lua tests/inputs/while/simplebreakalt
    assert_output "test2"
}

@test "specialbreak" {
    run lua tomis.lua tests/inputs/while/specialbreak
    assert_output "test1"
}

@test "printbeforewhile" {
    run lua tomis.lua tests/inputs/while/printbeforewhile
    assert_output "test"
}

@test "printafterwhile" {
    run lua tomis.lua tests/inputs/while/printafterwhile
    assert_output "test"
}

@test "2whilebreak" {
    run lua tomis.lua tests/inputs/while/2whilebreak
    assert_output "test"
}

@test "incr" {
    run lua tomis.lua tests/inputs/stackops/incr
    assert_output "2"
}

@test "decr" {
    run lua tomis.lua tests/inputs/stackops/decr
    assert_output "1"
}

@test "incr2" {
    run lua tomis.lua tests/inputs/stackops/incr2
    assert_output "3"
}

@test "decr2" {
    run lua tomis.lua tests/inputs/stackops/decr2
    assert_output "1"
}

@test "for" {
    run lua tomis.lua tests/inputs/while/for
    assert_output "test"
}

@test "forlessequal" {
    run lua tomis.lua tests/inputs/while/forlessequal
    assert_output "test"
}

@test "multipush" {
    run lua tomis.lua tests/inputs/stackops/multipush
    assert_output "2 3 4"
}