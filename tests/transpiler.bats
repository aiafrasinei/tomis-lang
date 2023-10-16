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
    run lua tomis2lua.lua tests/inputs/math_ops/add output.lua
    run lua output.lua
    assert_output "5"
}

@test "substraction" {
    run lua tomis2lua.lua tests/inputs/math_ops/sub output.lua
    run lua output.lua
    assert_output "-1"
}

@test "multiplication" {
    run lua tomis2lua.lua tests/inputs/math_ops/mul output.lua
    run lua output.lua
    assert_output "6"
}

@test "division" {
    run lua tomis2lua.lua tests/inputs/math_ops/div output.lua
    run lua output.lua
    assert_output "3.0"
}

@test "modulo" {
    run lua tomis2lua.lua tests/inputs/math_ops/mod output.lua
    run lua output.lua
    assert_output "0"
}

#@test "rpn evaluation" {
#    run lua tomis2lua.lua tests/inputs/evals/re output.lua
#    run lua output.lua
#    assert_output "3"
#}

@test "dup" {
    run lua tomis2lua.lua tests/inputs/stackops/dup output.lua
    run lua output.lua
    assert_output "3"
}

@test "drop" {
    run lua tomis2lua.lua tests/inputs/stackops/drop output.lua
    run lua output.lua
    assert_output "3"
}

@test "over" {
    run lua tomis2lua.lua tests/inputs/stackops/over output.lua
    run lua output.lua
    assert_output "2"
}

@test "swap" {
    run lua tomis2lua.lua tests/inputs/stackops/swap output.lua
    run lua output.lua
    assert_output "2"
}

@test "tuck" {
    run lua tomis2lua.lua tests/inputs/stackops/tuck output.lua
    run lua output.lua
    assert_output "3 2 3"
}

@test "rot" {
    run lua tomis2lua.lua tests/inputs/stackops/rot output.lua
    run lua output.lua
    assert_output "3 1 2"
}

@test "minrot" {
    run lua tomis2lua.lua tests/inputs/stackops/minrot output.lua
    run lua output.lua
    assert_output "1 2 3"
}

@test "2drop" {
    run lua tomis2lua.lua tests/inputs/stackops/2drop output.lua
    run lua output.lua
    assert_output "0"
}

@test "2dup" {
    run lua tomis2lua.lua tests/inputs/stackops/2dup output.lua
    run lua output.lua
    assert_output "1 2 1 2"
}

@test "2swap" {
    run lua tomis2lua.lua tests/inputs/stackops/2swap output.lua
    run lua output.lua
    assert_output "3 4 1 2"
}

@test "2over" {
    run lua tomis2lua.lua tests/inputs/stackops/2over output.lua
    run lua output.lua
    assert_output "2 2 2 2 2 2"
}

@test "2rot" {
    run lua tomis2lua.lua tests/inputs/stackops/2rot output.lua
    run lua output.lua
    assert_output "4 3 5 6 1 2"
}

@test "2minrot" {
    run lua tomis2lua.lua tests/inputs/stackops/2minrot output.lua
    run lua output.lua
    assert_output "6 5 2 1 4 3"
}

@test "peek1" {
    run lua tomis2lua.lua tests/inputs/stackops/peek1 output.lua
    run lua output.lua
    assert_output "1"
}

@test "peek2" {
    run lua tomis2lua.lua tests/inputs/stackops/peek2 output.lua
    run lua output.lua
    assert_output "2"
}

@test "peek3" {
    run lua tomis2lua.lua tests/inputs/stackops/peek3 output.lua
    run lua output.lua
    assert_output "2"
}

@test "peek4" {
    run lua tomis2lua.lua tests/inputs/stackops/peek4 output.lua
    run lua output.lua
    assert_output "1"
}

@test "push" {
    run lua tomis2lua.lua tests/inputs/stackops/push output.lua
    run lua output.lua
    assert_output "1 2 3"
}

@test "pop" {
    run lua tomis2lua.lua tests/inputs/stackops/pop output.lua
    run lua output.lua
    assert_output "1 2"
}

@test "depth" {
    run lua tomis2lua.lua tests/inputs/stackops/depth output.lua
    run lua output.lua
    assert_output "3"
}

@test "suse" {
    run lua tomis2lua.lua tests/inputs/stackapi/suse output.lua
    run lua output.lua
    assert_output 1
}

@test "stack remove" {
    run lua tomis2lua.lua tests/inputs/stackapi/srm output.lua
    run lua output.lua
    assert_output "alive"
}

#@test "stack replace" {
#    run lua tomis2lua.lua tests/inputs/stackapi/sreplace output.lua
#    run lua output.lua
#    assert_output "1 2 3"
#}

@test "sra" {
    run lua tomis2lua.lua tests/inputs/stackapi/sra output.lua
    run lua output.lua
    assert_output "0"
}

@test "snr" {
    run lua tomis2lua.lua tests/inputs/stackapi/snr output.lua
    run lua output.lua
    assert_output "2"
}

@test "sclear" {
    run lua tomis2lua.lua tests/inputs/stackapi/sclear output.lua
    run lua output.lua
    assert_output "2"
}

@test "sadd" {
    run lua tomis2lua.lua tests/inputs/stackapi/sadd output.lua
    run lua output.lua
    assert_output "2"
}

@test "print" {
    run lua tomis2lua.lua tests/inputs/io/print output.lua
    run lua output.lua
    assert_output "Hello World!"
}

@test "fpush" {
    run lua tomis2lua.lua tests/inputs/stackops/fpush output.lua
    run lua output.lua
    assert_output "test = 1"
}

@test "dot" {
    run lua tomis2lua.lua tests/inputs/stackops/dot output.lua
    run lua output.lua
    assert_output "1"
}

@test "comments" {
    run lua tomis2lua.lua tests/inputs/comments/single output.lua
    run lua output.lua
    assert_output ""
}

@test "dots" {
    run lua tomis2lua.lua tests/inputs/stackops/dots output.lua
    run lua output.lua
    assert_output "1 2 3"
}

@test "le" {
    run lua tomis2lua.lua tests/inputs/evals/le output.lua
    run lua output.lua
    assert_output "4"
}

@test "split" {
    run lua tomis2lua.lua tests/inputs/stringops/split output.lua
    run lua output.lua
    assert_output "6"
}

@test "merge" {
    run lua tomis2lua.lua tests/inputs/stringops/merge output.lua
    run lua output.lua
    assert_output "1 2 3"
}

@test "simplebreak" {
    run lua tomis2lua.lua tests/inputs/while/simplebreak output.lua
    run lua output.lua
    assert_output "test3"
}

@test "simplebreakalt" {
    run lua tomis2lua.lua tests/inputs/while/simplebreakalt output.lua
    run lua output.lua
    assert_output "test2"
}

@test "specialbreak" {
    run lua tomis2lua.lua tests/inputs/while/specialbreak output.lua
    run lua output.lua
    assert_output "test1"
}

@test "printbeforewhile" {
    run lua tomis2lua.lua tests/inputs/while/printbeforewhile output.lua
    run lua output.lua
    assert_output "test"
}

@test "printafterwhile" {
    run lua tomis2lua.lua tests/inputs/while/printafterwhile output.lua
    run lua output.lua
    assert_output "test"
}

@test "2whilebreak" {
    run lua tomis2lua.lua tests/inputs/while/2whilebreak output.lua
    run lua output.lua
    assert_output "test"
}

@test "incr" {
    run lua tomis2lua.lua tests/inputs/stackops/incr output.lua
    run lua output.lua
    assert_output "2"
}

@test "decr" {
    run lua tomis2lua.lua tests/inputs/stackops/decr output.lua
    run lua output.lua
    assert_output "1"
}

@test "incr2" {
    run lua tomis2lua.lua tests/inputs/stackops/incr2 output.lua
    run lua output.lua
    assert_output "3"
}

@test "decr2" {
    run lua tomis2lua.lua tests/inputs/stackops/decr2 output.lua
    run lua output.lua
    assert_output "1"
}