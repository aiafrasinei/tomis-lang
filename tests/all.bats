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
    run lua ti.lua tests/inputs/math_ops/add
    assert_output "5"
}

@test "substraction" {
    run lua ti.lua tests/inputs/math_ops/sub
    assert_output "-1"
}

@test "multiplication" {
    run lua ti.lua tests/inputs/math_ops/mul
    assert_output "6"
}

@test "division" {
    run lua ti.lua tests/inputs/math_ops/div
    assert_output "3.0"
}

@test "modulo" {
    run lua ti.lua tests/inputs/math_ops/mod
    assert_output "0"
}

@test "rpn evaluation" {
    run lua ti.lua tests/inputs/evals/re
    assert_output "3"
}

@test "dup" {
    run lua ti.lua tests/inputs/stackops/dup
    assert_output "3"
}

@test "drop" {
    run lua ti.lua tests/inputs/stackops/drop
    assert_output "3"
}

@test "over" {
    run lua ti.lua tests/inputs/stackops/over
    assert_output "2"
}

@test "swap" {
    run lua ti.lua tests/inputs/stackops/swap
    assert_output "2"
}

@test "tuck" {
    run lua ti.lua tests/inputs/stackops/tuck
    assert_output "3 2 3"
}

@test "rot" {
    run lua ti.lua tests/inputs/stackops/rot
    assert_output "3 1 2"
}

@test "minrot" {
    run lua ti.lua tests/inputs/stackops/minrot
    assert_output "1 2 3"
}

@test "2drop" {
    run lua ti.lua tests/inputs/stackops/2drop
    assert_output "0"
}

@test "2dup" {
    run lua ti.lua tests/inputs/stackops/2dup
    assert_output "1 2 1 2"
}

@test "2swap" {
    run lua ti.lua tests/inputs/stackops/2swap
    assert_output "3 4 1 2"
}

@test "2over" {
    run lua ti.lua tests/inputs/stackops/2over
    assert_output "2 2 2 2 2 2"
}

@test "2rot" {
    run lua ti.lua tests/inputs/stackops/2rot
    assert_output "4 3 5 6 1 2"
}

@test "2minrot" {
    run lua ti.lua tests/inputs/stackops/2minrot
    assert_output "6 5 2 1 4 3"
}

@test "peek1" {
    run lua ti.lua tests/inputs/stackops/peek1
    assert_output "1"
}

@test "peek2" {
    run lua ti.lua tests/inputs/stackops/peek2
    assert_output "2"
}

@test "peek3" {
    run lua ti.lua tests/inputs/stackops/peek3
    assert_output "2"
}

@test "peek4" {
    run lua ti.lua tests/inputs/stackops/peek4
    assert_output "1"
}

@test "push" {
    run lua ti.lua tests/inputs/stackops/push
    assert_output "1 2 3"
}

@test "pop" {
    run lua ti.lua tests/inputs/stackops/pop
    assert_output "1 2"
}

@test "depth" {
    run lua ti.lua tests/inputs/stackops/depth
    assert_output "3"
}

@test "suse" {
    run lua ti.lua tests/inputs/stackapi/suse
    assert_output "first"
}

@test "stack remove" {
    run lua ti.lua tests/inputs/stackapi/srm
    assert_output "\"alive\""
}

@test "stack replace" {
    run lua ti.lua tests/inputs/stackapi/sreplace
    assert_output "1 2 3"
}

@test "sra" {
    run lua ti.lua tests/inputs/stackapi/sra
    assert_output "0"
}

@test "snr" {
    run lua ti.lua tests/inputs/stackapi/snr
    assert_output "2"
}

@test "sclear" {
    run lua ti.lua tests/inputs/stackapi/sclear
    assert_output "2"
}

@test "sadd" {
    run lua ti.lua tests/inputs/stackapi/sadd
    assert_output "2"
}

@test "print" {
    run lua ti.lua tests/inputs/io/print
    assert_output "Hello World!"
}

@test "fpush" {
    run lua ti.lua tests/inputs/stackops/fpush
    assert_output "test = 1"
}

@test "dot" {
    run lua ti.lua tests/inputs/stackops/dot
    assert_output "1"
}

@test "comments" {
    run lua ti.lua tests/inputs/comments/single
    assert_output ""
}

@test "dots" {
    run lua ti.lua tests/inputs/stackops/dots
    assert_output "1 2 3"
}

@test "le" {
    run lua ti.lua tests/inputs/evals/le
    assert_output "4"
}

@test "split" {
    run lua ti.lua tests/inputs/stringops/split
    assert_output "6"
}

@test "merge" {
    run lua ti.lua tests/inputs/stringops/merge
    assert_output "1 2 3"
}

@test "exec" {
    run lua ti.lua tests/inputs/stringops/exec
    assert_output "2"
}

@test "execi" {
    run lua ti.lua tests/inputs/stringops/execi
    assert_output "3"
}

@test "execa" {
    run lua ti.lua tests/inputs/stringops/execa
    assert_output "1 2 3"
}

@test "simplebreak" {
    run lua ti.lua tests/inputs/while/simplebreak
    assert_output "test3"
}

@test "simplebreakalt" {
    run lua ti.lua tests/inputs/while/simplebreakalt
    assert_output "test2"
}

@test "specialbreak" {
    run lua ti.lua tests/inputs/while/specialbreak
    assert_output "test1"
}

@test "printbeforewhile" {
    run lua ti.lua tests/inputs/while/printbeforewhile
    assert_output "test"
}

@test "printafterwhile" {
    run lua ti.lua tests/inputs/while/printafterwhile
    assert_output "test"
}

@test "2whilebreak" {
    run lua ti.lua tests/inputs/while/2whilebreak
    assert_output "test"
}